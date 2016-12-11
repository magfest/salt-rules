#!/usr/bin/env python
import os
import sys
import json
import flask
import jinja2
import random
import string
import os.path
import requests
from flask import request
from collections import namedtuple

TESTING = False

if len(sys.argv) > 1:
    if sys.argv[1].lower() == "test":
        TESTING = True

Model = namedtuple('Model', ['label', 'desc', 'template', 'chan'])

jenv = jinja2.Environment(loader=jinja2.FileSystemLoader('./data/templates' if TESTING else '/etc/voip-provision/templates'))

APP = flask.Flask(__name__)

ASTERISK_URL = "http://asterisk:8080/"
USERS_FILE = 'users.json' if TESTING else "/etc/voip-provision/users.json"
EXTENS_FILE = 'depts.json' if TESTING else "/etc/voip-provision/extens.json"

INDEX_TEMPLATE = "index.html.jinja"

USERS_TEMPLATE = "ast_sip.jinja"
SKINNY_TEMPLATE = "ast_skinny.jinja"
EXTENS_TEMPLATE = "ast_extens.jinja"

CISCO_TEMPLATE = "cisco_SIP.cnf.jinja"
POLYCOM_TEMPLATE = "phoneMAC.cfg.jinja"
CISCO_7902_TEMPLATE = "cisco_SEP_7902.cnf.jinja"
YEALINK_TEMPLATE = "yealink.cfg"

TFTP_DIR = "./tftpdir" if TESTING else "/srv/tftp"

MODEL_C7940 = "c7940"
MODEL_C7940G = "c7940g"
MODEL_C7960 = "c7960"
MODEL_C7960G = "c7960g"
MODEL_P335 = 'p335'
MODEL_C7902 = 'c7902'
MODEL_YT26P = 'yt26p'

MODELS = {
    MODEL_C7940: Model(MODEL_C7940, 'Cisco 7940', 'CTLSEP{umac}.tlv', 'SIP'),
    MODEL_C7940G: Model(MODEL_C7940G, 'Cisco 7940G', 'CTLSEP{umac}.tlv', 'SIP'),
    MODEL_C7960: Model(MODEL_C7960, 'Cisco 7960', 'CTLSEP{umac}.tlv', 'SIP'),
    MODEL_P335: Model(MODEL_P335, 'Polycom 335', 'phone{umac}.cfg', 'SIP'),
    MODEL_C7902: Model(MODEL_C7902, 'Cisco 7902', 'ff{umac}', 'Skinny'),
    MODEL_YT26P: Model(MODEL_YT26P, 'Yealink T26P', '{umac}.cfg', 'SIP'),
}

MODEL_GROUPS = {
    "Cisco 7960/7940": [MODEL_C7940, MODEL_C7940G, MODEL_C7960],
    "Cisco 7902": [MODEL_C7902],
    "Polycom 335": [MODEL_P335],
    "Yealink T26P ": [MODEL_YT26P],
}

def pretty_model(model):
    if model in MODELS:
        return MODELS[model].desc
    else:
        return model

jenv.filters['pretty_model'] = pretty_model

def gen_username(exten, mac):
    return exten + "-" + mac[-6:]

def gen_password(length=16):
    return ''.join([random.choice(string.ascii_letters + string.digits) for _ in range(length)])

def get_extens():
    with open(EXTENS_FILE) as extens_file:
        return json.load(extens_file)

def get_users():
    try:
        with open(USERS_FILE) as user_file:
            return json.load(user_file)
    except OSError:
        return []

def get_user(exten, mac, model):
    users = get_users()

    res = None

    for user in users:
        if user.get('mac', None) == mac:
            user['exten'] = exten
            user['model'] = model
            user['chan'] = MODELS[model].chan
            res = user
            break
    else:
        res = {
            'mac': mac,
            'exten': exten,
            'model': model,
            'username': gen_username(exten, mac),
            'password': gen_password(),
            'chan': MODELS[model].chan,
        }
        users.append(res)

    if MODELS[model].chan == 'Skinny':
        user['chan_address'] = 'Skinny/line-{username}@{username}'

    extens = get_extens()
    if exten in extens:
        res['callerid'] = extens[exten].get('cid', exten)
        res['desc'] = extens[exten].get('desc', exten)

    with open(USERS_FILE, 'w') as user_file:
        json.dump(users, user_file)

    return res

def create_config(exten, mac, model, user):
    if model in (MODEL_C7960,
                 MODEL_C7960G,
                 MODEL_C7940,
                 MODEL_C7940G):
        template = jenv.get_template(CISCO_TEMPLATE)

        with open(os.path.join(TFTP_DIR, 'SIP{}.cnf'.format(mac.upper())), 'w') as target:
            target.write(template.render(
                username=user['username'],
                cid=user.get('callerid', exten),
                password=user['password'],
                desc=user.get('desc', exten)))

        with open(os.path.join(TFTP_DIR, 'CTLSEP{}.tlv'.format(mac.upper())), 'w') as target:
            target.write('')

        with open(os.path.join(TFTP_DIR, 'SEP{}.cnf.xml'.format(mac.upper())), 'w') as target:
            target.write('<device>\n<loadInformation model="IP Phone 7960">P0S3-08-11-00</loadInformation>\n</device>\n')

    elif model == MODEL_P335:
        template = jenv.get_template(POLYCOM_TEMPLATE)

        with open(os.path.join(TFTP_DIR, '{}-phone.cfg'.format(mac.lower())), 'w') as target:
            target.write(template.render(
                mac=mac.lower(),
                username=user['username'],
                callerid=user.get('callerid', exten),
                password=user['password'],
                desc=user.get('desc', exten)))
    elif model == MODEL_C7902:
        template = jenv.get_template(CISCO_7902_TEMPLATE)

        with open(os.path.join(TFTP_DIR, 'SEP{}.cnf.xml'.format(mac.upper())), 'w') as target:
            target.write(template.render(
                username=user['username'],
                cid=user.get('callerid', exten),
                desc=user.get('desc', exten)))
        with open(os.path.join(TFTP_DIR, 'ff{}'.format(mac.lower())), 'w') as target:
            target.write('#txt\nDomain:magfe.st\n')

    elif model == MODEL_YT26P:
        template = jenv.get_template(YEALINK_TEMPLATE)

        with open(os.path.join(TFTP_DIR, '{}.cfg'.format(mac.lower())), 'w') as target:
            target.write(template.render(
                username=user['username'],
                cid=user.get('callerid', exten),
                desc=user.get('desc', exten),
                password=user['password'],
                extensions=enumerate(sorted(list(get_extens().items())))
            ))

def reload_asterisk():
    requests.post(ASTERISK_URL)

@APP.route('/')
def index():
    template = jenv.get_template(INDEX_TEMPLATE)

    users = get_users()
    extens = get_extens()
    for exten, thing in extens.items():
        thing['num_users'] = len([u for u in users if u.get('exten','') == exten])

    return template.render(users=users, models=sorted(MODEL_GROUPS.items()),
                           extens=sorted(extens.items(), key=lambda a:int(a[0])))

@APP.route('/enroll', methods=['POST'])
def enroll():
    mac = request.form.get('mac')
    exten = request.form.get('exten')
    model = request.form.get('model')
    print(request.args)

    if model not in MODELS:
        raise ValueError("Model {} not found".format(model))

    if not mac or not exten or not model:
        raise ValueError("Missing/empty arguments! Bad!!!")

    mac = mac.lower().replace(':', '')

    user = get_user(exten, mac, model)

    create_config(exten, mac, model, user)

    try:
        reload_asterisk()
    except Exception as e:
        print(e)

    return flask.redirect('/')

@APP.route('/asterisk_users')
def asterisk_users():
    template = jenv.get_template(USERS_TEMPLATE)

    return template.render(users=get_users())

@APP.route('/asterisk_skinny')
def asterisk_skinny():
    template = jenv.get_template(SKINNY_TEMPLATE)

    users = get_users()

    return template.render(users=users)

@APP.route('/asterisk_extens')
def asterisk_extensions():
    template = jenv.get_template(EXTENS_TEMPLATE)

    extensions = get_extens()
    for user in get_users():
        if user['exten'] not in extensions:
            extensions[user['exten']] = {
                'users': [],
                'desc': user['exten'],
                'cid': user['exten'],
            }

        if 'users' not in extensions[user['exten']]:
            extensions[user['exten']]['users'] = []

        if 'chan_address' in user:
            extensions[user['exten']]['users'].append(user['chan_address'].format(**user))
        else:
            extensions[user['exten']]['users'].append(user.get('chan', 'SIP') + "/" + user['username'])

    return template.render(extens=extensions)

APP.run('0.0.0.0', port=8080, debug=True)

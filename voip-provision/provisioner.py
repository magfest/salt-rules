#!/usr/bin/env python3
import os
import json
import flask
import jinja2
import random
import string
import os.path
import requests
from flask import request
from collections import namedtuple

Model = namedtuple('Model', ['label', 'desc', 'template'])

jenv = jinja2.Environment(loader=jinja2.FileSystemLoader('/etc/voip-provision/templates'))

APP = flask.Flask(__name__)

ASTERISK_URL = "http://asterisk:8080/"
USERS_FILE = "/etc/voip-provision/users.json"
EXTENS_FILE = "/etc/voip-provision/extens.json"

INDEX_TEMPLATE = "index.html.jinja"

USERS_TEMPLATE = "ast_sip.jinja"
EXTENS_TEMPLATE = "ast_extens.jinja"

CISCO_TEMPLATE = "cisco_SIP.cnf.jinja"
POLYCOM_TEMPLATE = "phoneMAC.cfg.jinja"

TFTP_DIR = "/srv/tftp"

MODEL_C7940 = "c7940"
MODEL_C7940G = "c7940g"
MODEL_C7960 = "c7960"
MODEL_C7960G = "c7960g"
MODEL_P321 = 'p321'

MODELS = {
    MODEL_C7940: Model(MODEL_C7940, 'Cisco 7940', 'CTLSEP{umac}.tlv'),
    MODEL_C7940G: Model(MODEL_C7940G, 'Cisco 7940G', 'CTLSEP{umac}.tlv'),
    MODEL_C7960: Model(MODEL_C7960, 'Cisco 7960', 'CTLSEP{umac}.tlv'),
    MODEL_P321: Model(MODEL_P321, 'Polycom 321', 'phone{umac}.cfg'),
}

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
            res = user
            break
    else:
        res = {
            'mac': mac,
            'exten': exten,
            'model': model,
            'username': gen_username(exten, mac),
            'password': gen_password(),
        }
        users.append(res)

    extens = get_extens()
    if exten in extens:
        user['callerid'] = extens[exten].get('cid', exten)
        user['desc'] = extens[exten].get('desc', exten)

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

    elif model == MODEL_P321:
        template = jenv.get_template(POLYCOM_TEMPLATE)

        with open(os.path.join(TFTP_DIR, 'phone{}.cfg'.format(mac.upper())), 'w') as target:
            target.write(template.render(
                username=user['username'],
                cid=user.get('callerid', exten),
                password=user['password'],
                desc=user.get('desc', exten)))

def reload_asterisk():
    requests.post(ASTERISK_URL)

@APP.route('/')
def index():
    template = jenv.get_template(INDEX_TEMPLATE)

    return template.render()

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

        extensions[user['exten']]['users'].append("SIP/" + user['username'])

    return template.render(extens=extensions)

APP.run('0.0.0.0', port=8080, debug=True)

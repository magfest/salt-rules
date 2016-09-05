#!/usr/bin/env python
import flask
import os

APP = flask.Flask(__name__)

@APP.route('/', methods=['POST'])
def reload():
    os.system("getast_conf users &")
    os.system("getast_conf extens &")
    os.system("getast_conf skinnny &")
    os.system("systemctl reload asterisk &")
    return ""

APP.run(host='0.0.0.0', port=8080)

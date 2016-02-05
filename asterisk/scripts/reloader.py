#!/usr/bin/env python3
import flask
import os

APP = flask.Flask(__name__)

@APP.route('/', methods=['POST'])
def reload():
    os.system("systemctl reload asterisk &")
    return ""

APP.run(host='0.0.0.0', port=8080)

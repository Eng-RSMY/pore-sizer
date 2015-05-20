from flask import Flask, send_from_directory
from os import path

APP_DIR = path.abspath(path.dirname(path.realpath(__file__)))
STATIC_DIR = path.join(APP_DIR, '..', 'static')

application = Flask(__name__)

@application.route('/static/<file>')
def send_static(file):
  return send_from_directory(STATIC_DIR, file)

from app import views

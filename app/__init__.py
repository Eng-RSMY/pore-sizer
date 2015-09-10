from flask import Flask, send_from_directory
from flask.ext.assets import Environment
from app.assets import *

application = Flask(__name__)
application.debug = True

assets = Environment(application)

assets.register('vendor_javascript', vendor_javascript)
assets.register('vendor_stylesheet', vendor_stylesheet)
assets.register('app_stylesheet', app_stylesheet)
assets.register('app_javascript', app_javascript)

from app import views

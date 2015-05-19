from flask import render_template
from app import application

@application.route('/')
def index():
  return render_template('index.html')

@application.route('/sizer')
def sizer():
  return render_template('sizer.html')

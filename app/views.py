from flask import render_template, request
from app import application
from app.lib import distribution as dist
import json

@application.route('/', methods=['GET'])
def index():
  return render_template('index.html')

@application.route('/sizer', methods=['GET'])
def sizer():
  return render_template('sizer.html')

@application.route('/sizer/distribution', methods=['GET'])
def distribution():
  query = json.loads(request.args.get('query'))
  result = dist.simulation(query)
  return json.dumps(result)

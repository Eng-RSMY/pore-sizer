import json
from flask import render_template, request, Response
from app import application
from app.lib import ordinary_percolation_simulation as ops
from app.forms import QueryForm

@application.route('/', methods=['GET'])
def index():
  return render_template('index.html')

@application.route('/sizer', methods=['GET'])
def sizer():
  form = QueryForm()
  return render_template('sizer.html', topology=form.topology,
                         geometry=form.geometry, phase=form.phase,
                         physics=form.physics)

@application.route('/sizer/op_simulation', methods=['POST'])
def op_simulation():
  query = QueryForm(request)
  if form.validate():
    result = {
      'error': False,
      'result': ops.run(query)
    }
  else:
    result = {
      'error', True
    }
  return Response(json.dumps(result), mimetype='application/json')

@application.route('/sizer/distribution', methods=['GET'])
def distribution():
  query = json.loads(request.args.get('query'))

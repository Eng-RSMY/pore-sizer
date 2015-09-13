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
  form = QueryForm(csrf_enabled=False)
  return render_template('sizer.html', topology=form.topology,
                         geometry=form.geometry, phase=form.phase,
                         physics=form.physics)

@application.route('/sizer/op_simulation', methods=['POST'])
def op_simulation():
  query = QueryForm(request.form)
  if query.validate():
    result = {
      'errors': {},
      'result': ops.run(query)
    }
  else:
    result = {
      'errors': query.errors,
      'result': 'There are errors with your query.'
    }
  return Response(json.dumps(result), mimetype='application/json')

@application.route('/sizer/distribution', methods=['GET'])
def distribution():
  query = json.loads(request.args.get('query'))

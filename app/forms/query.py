from wtforms import Form, FormField
from wtforms.validators import InputRequired
from .geometry import GeometryForm
from .phase import PhaseForm
from .topology import TopologyForm
from .physics import PhysicsForm

class QueryForm(Form):
  topology = FormField(TopologyForm)
  geometry = FormField(GeometryForm)
  phase = FormField(PhaseForm)
  physics = FormField(PhysicsForm)

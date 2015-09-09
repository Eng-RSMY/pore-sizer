from wtforms import Form, DecimalField
from wtforms.validators import InputRequired

class PhaseForm(Form):
  surface_tension = DecimalField('Surface Tension', [InputRequired()])
  contact_angle = DecimalField('Contact Angle', [InputRequired()])

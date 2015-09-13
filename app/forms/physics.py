from wtforms import Form, SelectField
from wtforms.validators import InputRequired

capillary_pressure_options = [
  ('purecell', 'Purcell'),
  ('washburn', 'Washburn')
]

class PhysicsForm(Form):
  capillary_pressure = SelectField('Capillary Pressure',
                                   choices=capillary_pressure_options)

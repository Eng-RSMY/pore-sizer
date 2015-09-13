from wtforms import Form, SelectField, IntegerField, FormField
from wtforms.validators import InputRequired

pore_seed_options = [
    ('correlated', 'Correlated'),
    ('random', 'Random')
]

throat_seed_choices = [
    ('average', 'Average'),
    ('minimum', 'Minimum'),
    ('maximum', 'Maximum')
]


class CorrelationDistanceForm(Form):
  lx = IntegerField('Lx', [InputRequired()])
  ly = IntegerField('Ly', [InputRequired()])
  lz = IntegerField('Lz', [InputRequired()])


class GeometryForm(Form):
  pore_seed = SelectField('Pore Seed', choices=pore_seed_options)
  throat_seed = SelectField('Throat Seed', choices=throat_seed_choices)
  correlation_distances = FormField(CorrelationDistanceForm,'Correlation Distances')

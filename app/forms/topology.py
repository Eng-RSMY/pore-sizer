from wtforms import Form, IntegerField, SelectField, FormField
from wtforms.validators import InputRequired

connectivity_options = [
  (6, '6: Faces only'),
  (8, '8: Corners only'),
  (12, '12: Edges only'),
  (14, '14: Faces and Corners'),
  (18, '18: Faces and Edges'),
  (20, '20: Edges and Corners'),
  (26, '26: Faces, Edges and Corners')
]


class DimensionsForm(Form):
  height = IntegerField('Height', [InputRequired()])
  width = IntegerField('Width', [InputRequired()])
  depth = IntegerField('Depth', [InputRequired()])


class TopologyForm(Form):
  dimensions = FormField(DimensionsForm, 'Dimensions')
  size = IntegerField('Size', [InputRequired()])
  connectivity = SelectField('Connectivity', [InputRequired()],
                             choices=connectivity_options)

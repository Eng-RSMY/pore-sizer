from flask.ext.assets import Bundle
from os.path import join, dirname, abspath

JS_DIR = abspath(join(dirname(__file__), '../assets/javascripts'))
CSS_DIR = abspath(join(dirname(__file__), '../assets/stylesheets'))

vendor_javascript = Bundle(join(JS_DIR, 'vendor/twine.js'), output='vendor.js')
vendor_stylesheet = Bundle(join(CSS_DIR, 'vendor/semantic.css'), output='vendor.css')

app_javascript = Bundle(join(JS_DIR, 'app.coffee'), filters=['coffeescript'], output='app.js')
app_stylesheet = Bundle(join(CSS_DIR, 'app.scss'), filters=['pyscss'], output='app.css')

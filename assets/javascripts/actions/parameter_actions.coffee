Flux = require 'reflux'

AppActions = Flux.createActions([
  'updatePhase'
  'updatePhysics'
  'updateTopology'
  'updateGeometry'
  'validate'
  'getErrors'
])

module.exports = AppActions

Flux = require 'reflux'

AppActions = Flux.createActions([
  'updatePhase'
  'updatePhysics'
  'updateTopology'
  'updateGeometry'
  'validate'
])

module.exports = AppActions

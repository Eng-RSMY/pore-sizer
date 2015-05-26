Flux = require 'reflux'

AppActions = Flux.createActions([
  'updatePhase'
  'updatePhysics'
  'updateTopology'
  'updateGeometry'
])

module.exports = AppActions

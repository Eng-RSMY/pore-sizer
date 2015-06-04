_ = require 'lodash'
Joi = require 'joi'
Flux = require 'reflux'
schema = require '../lib/schema'
ResultsActions = require '../actions/results_actions'
ParameterActions = require '../actions/parameter_actions'

ParameterStore = Flux.createStore
  listenables: ParameterActions

  init: ->
    @schema = schema
    @parameters =
      topology:
        height: null
        width: null
        depth: null
        size: null
        connections: null
      geometry:
        poreSeed: 'correlated'
        lx: null
        ly: null
        lz: null
        poreDiameter: 'logNormal'
        throatSeed: 'average'
        throatDiameter: 'logNormal'
      phase:
        type: 'air'
        surfaceTension: null
        contactAngle: null
      physics:
        capillaryPressure: 'purcell'

  getInitialState: ->
    @parameters

  onUpdatePhase: (key, value) ->
    @parameters.phase[key] = value
    @trigger(@parameters)

  onUpdatePhysics: (key, value) ->
    @parameters.physics[key] = value
    @trigger(@parameters)

  onUpdateTopology: (key, value) ->
    @parameters.topology[key] = value
    @trigger(@parameters)

  onUpdateGeometry: (key, value) ->
    @parameters.geometry[key] = value
    @trigger(@parameters)

  onValidate: ->
    result = Joi.validate(@parameters, @schema, {abortEarly: false})
    if result.error?
      _.each(result.error.details, (d) =>
        _.set(@parameters, d.path, {error: true, message: d.message}))
    else
      ResultsActions.fetch(@parameters)

    @trigger(@parameters)

module.exports = ParameterStore

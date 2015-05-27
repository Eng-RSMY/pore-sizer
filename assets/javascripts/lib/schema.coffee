Joi = require 'joi'

module.exports = Joi.object().keys
  topology:
    dimensions: Joi.object.keys
      height: Joi.number().integer().required()
      width: Joi.number().integer().equired()
      depth: Joi.number().integer().required()
    size: Joi.number().integer().required()
    connections: Joi.number().integer().required()

  geometry:
    poreSeed: Joi.string().required()
    poreDiameter: Joi.number().float().required()
    throatSeed: Joi.string().required()
    throatDiameter: Joi.number().float().required()

  phase:
    type: Joi.string().required()
    surfaceTension: Joi.number().when('type', {is: 'custom', then: Joi.required()})
    contactAngle: Joi.number().when('type', {is: 'custom', then: Joi.required()})

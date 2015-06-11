React = require 'react'
{updatePhysics} = require '../actions/parameter_actions'

PhysicsPanel = React.createClass
  render: ->
    <div className='ui eight wide column form'>
      <h4 className="ui top attached header">Physics</h4>
      <div className='ui fluid bottom attached segment' onChange={@_onChange}>
        <div className='field'>
          <label>Capillary Pressure</label>
          <select name='type' value={@props.type} className='ui dropdown'>
            <option value='purcell'>Purcell</option>
            <option value='washburn'>Washburn</option>
          </select>
        </div>
      </div>
    </div>

  _onChange: (evt) ->
    value = if evt.target.value == '' then null else evt.target.value
    updatePhysics(evt.target.name, value)

module.exports = PhysicsPanel

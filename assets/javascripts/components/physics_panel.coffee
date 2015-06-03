React = require 'react'
{updatePhysics} = require '../actions/parameter_actions'

PhysicsPanel = React.createClass
  render: ->
    <div className='ui eight wide column form'>
      <h4 className="ui top attached header">Physics</h4>
      <div className='ui fluid bottom attached segment'>
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
    updatePhysics(evt.target.name, evt.target.value)

module.exports = PhysicsPanel

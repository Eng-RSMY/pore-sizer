React = require 'react'
{updatePhase} = require '../actions/parameter_actions'

PhasePanel = React.createClass
  render: ->
    <div className='ui eight wide column form'>
      <h4 className="ui top attached header">Phase</h4>
      <div className='ui fluid bottom attached segment' onChange={@_onChange}>
        <div className='field'>
          <label>Phase Type</label>
          <select name='type' value={@props.type} className='ui dropdown'>
            <option value='air'>Air</option>
            <option value='custom'>Custom</option>
            <option value='mercury'>Mercury</option>
            <option value='water'>Water</option>
          </select>
        </div>

        {if @props.type == 'custom'
          <div className='two fields'>
            <div className={if @props.surfaceTension?.error then 'field error' else 'field'}>
              <label>Surface Tension</label>
              <div className='ui right labeled input'>
                <input name='surfaceTension' type='text' placeholder='Ex. 0.1' />
                <div className='ui label'>N/m</div>
              </div>
            </div>
            <div className={if @props.contactAngle?.error then 'field error' else 'field'}>
              <label>Contact Angle</label>
              <div className='ui right labeled input'>
                <input name='contactAngle' type='text' placeholder='Ex. 0.1' />
                <div className='ui label'>degrees</div>
              </div>
            </div>
          </div>
        }
      </div>
    </div>

  _onChange: (evt) ->
    updatePhase(evt.target.name, evt.target.value)

module.exports = PhasePanel

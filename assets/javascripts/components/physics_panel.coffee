React = require 'react'
{updatePhysics} = require '../actions/parameter_actions'

PhysicsPanel = React.createClass
  getInitialState: ->
    capillaryPressure: 'purcell'

  render: ->
    <div className='ui eight wide column form'>
      <h4 className="ui top attached header">Physics</h4>
      <div className='ui fluid bottom attached segment'>
        <div className={if @props.errors.type then 'field error' else 'field'}>
          <label>Capillary Pressure</label>
          <select name='type' className='ui dropdown'>
            <option value='purcell'>Purcell</option>
            <option value='washburn'>Washburn</option>
          </select>
        </div>
      </div>
    </div>

  _onChange: (evt) ->
    newState = do ->
      state = {}
      state[evt.target.name] = evt.target.value
      state
    @setState(newState, => updatePhysics(@state))

module.exports = PhysicsPanel

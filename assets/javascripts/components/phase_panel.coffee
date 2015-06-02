React = require 'react'
{updatePhase} = require '../actions/parameter_actions'

PhasePanel = React.createClass
  getInitialState: ->
    type: 'air'
    surfaceTension: null
    contactAngle: null

  componentWillMount: ->
    updatePhase(@state)

  render: ->
    <div className='ui eight wide column form'>
      <h4 className="ui top attached header">Phase</h4>
      <div className='ui fluid bottom attached segment' onChange={@_onChange}>
        <div className={if @props.errors.type then 'field error' else 'field'}>
          <label>Phase Type</label>
          <select name='type' className='ui dropdown'>
            <option value='air'>Air</option>
            <option value='custom'>Custom</option>
            <option value='mercury'>Mercury</option>
            <option value='water'>Water</option>
          </select>
        </div>

        {if @state.type == 'custom'
          <div className='two fields'>
            <div className={if @props.errors.surfaceTension then 'field error' else 'field'}>
              <label>Surface Tension</label>
              <div className='ui right labeled input'>
                <input name='surfaceTension' type='text' placeholder='Ex. 0.1' />
                <div className='ui label'>N/m</div>
              </div>
            </div>
            <div className={if @props.errors.contactAngle then 'field error' else 'field'}>
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
    newState = do ->
      state = {}
      state[evt.target.name] = evt.target.value
      state
    @setState(newState, => updatePhase(@state))

module.exports = PhasePanel

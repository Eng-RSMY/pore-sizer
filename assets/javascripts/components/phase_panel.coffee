React = require 'react'
{updatePhase} = require '../actions/parameter_actions'

PhasePanel = React.createClass
  getInitialState: ->
    phaseTypeSelected: 'air'

  render: ->
    <div className='ui eight wide column form'>
      <h4 className="ui top attached header">Phase</h4>
      <div className='ui fluid bottom attached segment' onChange={@_onChange}>
        <div className='field'>
          <label>Phase Type</label>
          <select ref='phaseType' className='ui dropdown' onChange={@_onPhaseChange}>
            <option value='air'>Air</option>
            <option value='custom'>Custom</option>
            <option value='mercury'>Mercury</option>
            <option value='water'>Water</option>
          </select>
        </div>

        {if @state.phaseTypeSelected == 'custom'
          <div className='two fields'>
            <div className='field'>
              <label>Surface Tension</label>
              <div className='ui right labeled input'>
                <input ref='surfaceTension' type='text' placeholder='Ex. 0.1' />
                <div className='ui label'>N/m</div>
              </div>
            </div>
            <div className='field'>
              <label>Contact Angle</label>
              <div className='ui right labeled input'>
                <input ref='contactAngle' type='text' placeholder='Ex. 0.1' />
                <div className='ui label'>radians</div>
              </div>
            </div>
          </div>
        }
      </div>
    </div>

  _onChange: ->
    phase =
      type: @state.phaseTypeSelected
      surfaceTension: null
      contactAngle: null

    if phase.type == 'custom'
      phase.surfaceTension = parseFloat @refs.surfaceTension.getDOMNode().value
      phase.contactAngle = parseFloat @refs.contactAngle.getDOMNode().value

    updatePhase(phase)

  _onPhaseChange: (evt) ->
    evt.stopPropagation()
    phaseTypeNode = @refs.phaseType.getDOMNode()
    phaseTypeSelected = phaseTypeNode.options[phaseTypeNode.selectedIndex].value
    @setState(phaseTypeSelected: phaseTypeSelected, => @_onChange())

module.exports = PhasePanel

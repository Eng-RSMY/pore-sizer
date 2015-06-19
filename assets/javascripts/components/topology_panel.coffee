React = require 'react'
{updateTopology} = require '../actions/parameter_actions'

TopologyPanel = React.createClass
  render: ->
    <div className='ui eight wide column form'>
      <h4 className="ui top attached header">Topology</h4>
      <div className='ui fluid bottom attached segment' onChange={@_onChange}>

        <div className='field'>
          <label>Dimensions</label>
          <div className='three fields'>
            <div className={if @props.height?.error then 'field error' else 'field'}>
              <input name='height' type='text' placeholder='Height' />
            </div>

            <div className={if @props.width?.error then 'field error' else 'field'}>
              <input name='width' type='text' placeholder='Width' />
            </div>

            <div className={if @props.depth?.error then 'field error' else 'field'}>
              <input name='depth' type='text' placeholder='Depth' />
            </div>
          </div>
        </div>

        <div className='two fields'>
          <div className={if @props.size?.error then 'field error' else 'field'}>
            <label>Size</label>
            <input name='size' type='text' placeholder='Ex. 100' />
          </div>

          <div className='field'>
            <label>Connectivity</label>
            <select name='connectivity' value={@props.connectivity} className='ui dropdown'>
              <option value='6'>6: Faces only</option>
              <option value='8'>8: Corners only</option>
              <option value='12'>12: Edges Only</option>
              <option value='14'>14: Faces and Corners</option>
              <option value='18'>18: Faces and Edges</option>
              <option value='20'>20: Edges and Corners</option>
              <option value='26'>26: Faces, Edges and Corners</option>
            </select>
          </div>
        </div>
      </div>
    </div>

  _onChange: (evt) ->
    value = if evt.target.value == '' then null else evt.target.value
    updateTopology(evt.target.name, value)

module.exports = TopologyPanel

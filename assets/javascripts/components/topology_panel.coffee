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

          <div className={if @props.connections?.error then 'field error' else 'field'}>
            <label>Connections</label>
            <input name='connections' type='text' placeholder='Ex. 6' />
          </div>
        </div>
      </div>
    </div>

  _onChange: (evt) ->
    updateTopology(evt.target.name, evt.target.value)

module.exports = TopologyPanel

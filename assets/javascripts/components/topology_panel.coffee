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
            <div className='field'>
              <input ref='height' type='text' placeholder='Height' />
            </div>

            <div className='field'>
              <input ref='width' type='text' placeholder='Width' />
            </div>

            <div className='field'>
              <input ref='depth' type='text' placeholder='Depth' />
            </div>
          </div>
        </div>

        <div className='two fields'>
          <div className='field'>
            <label>Size</label>
            <input ref='size' type='text' placeholder='Ex. 100' />
          </div>

          <div className='field'>
            <label>Connections</label>
            <input ref='connections' type='text' placeholder='Ex. 6' />
          </div>
        </div>
      </div>
    </div>

  _onChange: ->
    topology =
      dimensions:
        height: @refs.height.getDOMNode().value
        width: @refs.width.getDOMNode().value
        depth: @refs.depth.getDOMNode().value
      size: @refs.size.getDOMNode().value
      connections: @refs.connections.getDOMNode().value

    updateTopology(topology)

module.exports = TopologyPanel

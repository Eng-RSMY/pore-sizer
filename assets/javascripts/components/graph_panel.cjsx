React = require 'react'
Histogram = require './histogram'
LineGraph = require './line_graph'

GraphPanel = React.createClass
  propTypes:
    experimentalData: React.PropTypes.array

  getInitialState: ->
    lineGraph: null
    histrogram: null

  render: ->
    <div className='row'>
      <div id='lineGraph' className='eight wide column' />
      <div id='histrogram' className='eight wide column' />
    </div>

  componentDidMount: ->
    @state.lineGraph = new LineGraph('#lineGraph', @props.experimentalData)

module.exports = GraphPanel

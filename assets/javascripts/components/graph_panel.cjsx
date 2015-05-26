_ = require 'lodash'
React = require 'react'
Histogram = require './histogram'
LineGraph = require './line_graph'

GraphPanel = React.createClass
  propTypes:
    experimentalData: React.PropTypes.array

  getInitialState: ->
    lineGraph: null
    histrogram: null

  shouldComponentUpdate: (nextProps, nextState) ->
    !_.isEqual(@props, nextProps)

  render: ->
    <div className='two column row'>
      <div id='lineGraph' className='eight wide column' />
      <div id='histrogram' className='eight wide column' />
    </div>

  componentDidMount: ->
    @state.lineGraph = new LineGraph('#lineGraph', [])

  componentDidUpdate: ->
    @state.lineGraph.update(@props.experimentalData)

module.exports = GraphPanel

_ = require 'lodash'
React = require 'react'
AreaGraph = require './area_graph'
LineGraph = require './line_graph'

GraphPanel = React.createClass
  propTypes:
    experimentalData: React.PropTypes.array
    results: React.PropTypes.array

  getInitialState: ->
    lineGraph: null
    histrogram: null

  shouldComponentUpdate: (nextProps, nextState) ->
    !_.isEqual(@props, nextProps)

  render: ->
    <div className='two column row'>
      <div id='lineGraph' className='eight wide column' />
      <div id='areaGraph' className='eight wide column' />
    </div>

  componentDidMount: ->
    @state.lineGraph = new LineGraph('#lineGraph', [{
      name: 'experimentalData'
      dataset: []
    }])
    
    @state.areaGraph = new AreaGraph('#areaGraph', [{
      name: 'experimentalData',
      dataset: []
    }])

  componentDidUpdate: ->
    invasionPressureData = [
      {name: 'experimentalData', dataset: @props.experimentalData}
      {name: 'simulationData', dataset: @props.results.invasion_pressures}
    ]
    poreVolumeData = [
      {name: 'poreVolume', dataset: @props.results.pore_volumes}
    ]

    @state.lineGraph.update(invasionPressureData)
    @state.areaGraph.update(poreVolumeData)

module.exports = GraphPanel

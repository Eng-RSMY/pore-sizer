React = require 'react'
Histogram = require './histogram.cjsx'
LineGraph = require './line_graph.cjsx'

GraphPanel = React.createClass
  propTypes:
    experimentalData: React.PropTypes.array

  render: ->
    <div className='row'>
      test
      {@props.experimentalData}
    </div>

module.exports = GraphPanel

###
<LineGraph data={@props.experimentalData} />
<Histogram data={@props.experimentalData} />
###

d3 = require 'd3'

module.exports = class LineGraph
  MARGIN:
    top: 20
    bottom: 20
    left: 30
    right: 20

  constructor: (@selector, @data) ->
    @_calculateDimensions()
    @svg = d3.select(@selector)
      .append('svg')
        .classed(graph: true)
        .attr('width', @width)
        .attr('height', @height)
      .append('g')
        .attr('transform', "translate(#{@MARGIN.left}, #{@MARGIN.top})")

    @xAxis = @svg.append('g')
      .classed(x: true, axis: true)
      .attr('transform', "translate(0, #{@graphHeight})")

    @yAxis = @svg.append('g')
      .classed(y: true, axis: true)

    @_render()

  update: (newData) ->
    @data = newData
    @_calculateScales()
    @_buildAxes()
    @_buildLine()
    @_render()

  _render: ->
    @_calculateScales()
    @_buildAxes()
    @_buildLine()

    @xAxis.transition().call(@_xAxis)
    @yAxis.transition().call(@_yAxis)

    @series = @svg.selectAll('.line').data(@data)
      .classed(line: true)

    @series.transition()
      .attr('d', (d) => @line(d.dataset))

    @newSeries = @series.enter()
      .append('path')
      .classed(line: true)
      .transition()
      .attr('d', (d) => @line(d.dataset))

  _calculateDimensions: ->
    @_clientRect = d3.select(@selector).node().getBoundingClientRect()
    @width = @_clientRect.width
    @height = @width * (2/3)
    @graphWidth = @width - (@MARGIN.left + @MARGIN.right)
    @graphHeight = @height - (@MARGIN.top + @MARGIN.bottom)

  _calculateScales: ->
    xValues = []
    for series in @data
      xValues = xValues.concat(series.dataset.map (d) -> d[0])
    xMax = d3.max(xValues)
    yMax = 1

    @_xScale = d3.scale.linear()
      .domain([0, xMax])
      .range([0, @graphWidth])

    @_yScale = d3.scale.linear()
      .domain([0, yMax])
      .range([@graphHeight, 0])

  _buildLine: ->
    @line = d3.svg.line()
      .x((d) => @_xScale(d[0]))
      .y((d) => @_yScale(d[1]))

  _buildAxes: ->
    @_xAxis = d3.svg.axis()
      .scale(@_xScale)
      .orient('bottom')

    @_yAxis = d3.svg.axis()
      .scale(@_yScale)
      .orient('left')

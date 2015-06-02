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

    @_render()

  update: (newData) ->
    @data = newData
    @_calculateScales()
    @_buildAxes()
    @_buildLine()

    @svg.select('.x.axis')
      .transition()
      .call(@_xAxis)
    @svg.select('.y.axis')
      .transition()
      .call(@_yAxis)
    @svg.select('.line')
      .datum(@data)
      .transition()
      .attr('d', @line)

  _render: ->
    @_calculateScales()
    @_buildAxes()
    @_buildLine()

    @svg.append('g')
      .classed(x: true, axis: true)
      .attr('transform', "translate(0, #{@graphHeight})")
      .call(@_xAxis)

    @svg.append('g')
      .classed(y: true, axis: true)
      .call(@_yAxis)

    @svg.append('path')
      .datum(@data)
      .classed(line: true)
      .attr('d', @line)

  _calculateDimensions: ->
    @_clientRect = d3.select(@selector).node().getBoundingClientRect()
    @width = @_clientRect.width
    @height = @width * (2/3)
    @graphWidth = @width - (@MARGIN.left + @MARGIN.right)
    @graphHeight = @height - (@MARGIN.top + @MARGIN.bottom)

  _calculateScales: ->
    xMax = if @data.length > 0 then d3.max(@data, (d) -> d[0]) else @graphWidth
    yMax = if @data.length > 0 then d3.max(@data, (d) -> d[1]) else @graphHeight

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

PoreSizer =
  init: ->
    @query = {}
    @errors = {}
    @loading = false
    $('select.dropdown').dropdown()
    $('[bind-event-change]').each (_, $node) =>
      @query[$node.name] = $node.value
    return

  onChange: (node)->
    @query[node.name] = node.value
    return

  evaluateError: (node) ->
    path = $(node).find('input').attr('name').split('-').join('.')
    _.has(@errors, path)

  validate: ->
    @loading = true
    $.ajax
      method: 'POST'
      url: '/sizer/op_simulation'
      dataType: 'json'
      data: @query
      success: (data) =>
        @loading = false
        if Object.keys(data.errors).length
          @renderErrors(data)
        else
          @renderPlots(data)

  renderPlots: (data) ->
    console.log(data)

  renderErrors: (data) ->
    @errors = data.errors
    Twine.refresh()

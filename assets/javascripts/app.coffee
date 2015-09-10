PoreSizer =
  validate: ->
    $.ajax
      url: '/sizer/op_simulation'
      method: 'POST'
      data: JSON.stringify(this)

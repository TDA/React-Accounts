@Record = React.createClass
  getInitialState: () ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record
  actions: () ->
    React.DOM.div
      className: 'div'
      React.DOM.a
        className: 'btn btn-danger'
        onClick: @handleDelete
        'Delete'
      React.DOM.a
        className: 'btn btn-info'
        onClick: @handleToggle
        'Edit'
  recordReadOnly: () ->
    React.DOM.tr null,
      React.DOM.td null, @props.record.date
      React.DOM.td null, @props.record.title
      React.DOM.td null, amountFormat(@props.record.amount)
      React.DOM.td null, @actions()
  recordInputField: () ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.date
          ref: 'date'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.title
          ref: 'title'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: amountFormat(@props.record.amount)
          ref: 'amount'
      React.DOM.td null, @actions()
  render: () ->
    if @state.edit
      @recordInputField()
    else
      @recordReadOnly()

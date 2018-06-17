class Events
  constructor: ->
    @bindEvents()
  
  bindEvents: ->
    $('#calendar').on 'dblclick', '.calendar__days-day', ->
      $('#addModal').modal()

$ -> new Events()
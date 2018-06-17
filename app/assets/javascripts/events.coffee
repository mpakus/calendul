class Events
  constructor: ->
    @bindEvents()
  
  bindEvents: ->
    $('#calendar').on 'dblclick', '.calendar__days-day', ->
      day = $(@).data('day')
      $('#event_start_on').val(day)
      $('#event_end_on').val(day)
      $('#addModal').modal()

$ -> new Events()
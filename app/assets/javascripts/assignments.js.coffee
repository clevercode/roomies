# =========================================
# ========== NEW ASSIGNMENT JAZZ ==========
# =========================================

$('#repeating').live 'change', ->
  $('.littler_guys').toggle()
  $('.littler_guys').find('#assignment_duration').attr('value','')

selectRoomies = (name) ->
  $('#assignment_assignee_ids option').each ->
    $this = $(this)
    if $this.text() == name
      $this.attr('selected',true)

split = (val) ->
  return val.split( /,\s*/ )

extractLast = (term) ->
  return split( term ).pop()

do roomies.ui.autocompleteSetup = ->
  assignee_names = []
  $assignees = $('#assignment_assignee_ids')
  $assignees.parent('div').hide()
  
  $assignees.children('option').each ->
    assignee_names.push($(this).text())

  $( "#assignment_assignee_names" )
    # // don't navigate away from the field on tab when selecting an item
    .live 'keydown', (event) ->
      if event.keyCode == $.ui.keyCode.TAB && $(this).data('autocomplete').menu.active
        event.preventDefault()
    .autocomplete {
      delay: 100,
      minLength: 0,
      source: (request, response) ->
        # // delegate back to autocomplete, but extract the last term
        response($.ui.autocomplete.filter(assignee_names, extractLast(request.term)))
      ,
      focus: ->
        # // prevent value inserted on focus
        return false
      ,
      select: (event, ui) ->
        terms = split( this.value )
        # // remove the current input
        terms.pop()
        # // add the selected item
        terms.push( ui.item.value )
        # // add placeholder to get the comma-and-space at the end
        terms.push( "" )
        this.value = terms.join( ", " )
        return false
    }

$( "#assignment_assignee_names" ).live 'keyup', ->
  $('#assignment_assignee_ids option').attr('selected',false)
  names = split( $(this).val() )
  selectRoomies name for name in names

$( "#assignment_assignee_names" ).live 'focusout', ->
  $('#assignment_assignee_ids option').attr('selected',false)
  names = split( $(this).val() )
  selectRoomies name for name in names

do roomies.ui.superDate = ->
  $picker    = $("#picker")
  $superdate = $('.superdate')

  $superdate.live 'keyup', ->
    val = $(this).val()
    if val?
      # // parsing anything the user enters as a date
      date = Date.parse( val )

      # // making the date more legible and concise
      date = date.toString('MMMM d, yyyy') if date

      # // updating the datepicker
      $picker.datepicker('setDate', date)

  $superdate.live 'focusout', ->
    $superdate = $(this)
    val = $(this).val()
    if val?
      date = Date.parse( val )
      date = date.toString('MMMM d, yyyy') if date
      $(this).val(date)
      $picker.datepicker('setDate', date)

  $('.superdate').live 'focusin', ->
    $superdate = $(this)
    val = $(this).val()
    if val?
      date = Date.parse( val )
      date = date.toString('MMMM d, yyyy') if date
      $(this).val(date)
      $picker.datepicker('setDate', date)

  $picker.datepicker(
    dateFormat: 'MM d, yy',
    beforeShow: (dateText, inst) ->
      if $superdate.val?
        $picker.datepicker("setDate", $superdate.val())
    onSelect: (dateText, inst) ->
      date = dateText.toString('MMMM d, yyyy')
      $superdate.val(date)
  )

  $('.ui-datepicker-today a').click()
  $superdate = $('.superdate:eq(0)')
  window.roomies.ui.recalculateStickyFooter()
  return $superdate


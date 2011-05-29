# =========================================
# ================ Globals ================
# =========================================

_fadeSpeed         = 100
_slideDownSpeed    = 200
_slideUpSpeed      = 250
hovering_over      = null
$                  = jQuery
$body              = $('body')
$main              = $('#main')
$footer            = $('footer')
$modal             = $('#modal')
$loader            = $('.loader')
$darknessification = $('#darknessification')
$ajaxed            = $modal.children('#ajaxed')
$ajaxed_again      = $modal.children('#ajaxed_again')

# =========================================
# =========== Functions & Stuff ===========
# =========================================
  
# // Handles the sticky footer
stickyFooter = ->  
  $footer.css({position:'static'})
  if window.innerHeight > $body.height()
    $footer.css({position:'fixed', bottom:0})

stickyFooter()

$(window).bind 'resize', ->
  stickyFooter()
  centerModal()

# // Hides the flash notice if it's visible.
$('#flash').live 'click', ->
  $('#flash').hide 'fast', ->
    stickyFooter()

# // Hides the flash notice after 5 seconds if the user hasn't clicked on it yet.
setTimeout( ->
  $('#flash .notice').parent().hide 'fast', ->
    stickyFooter()
, 5000)

calculateCenter = (container, element) ->  
  l = (container.outerWidth()/2) - (element.outerWidth()/2)
  t = ($(window).height()/2) - (element.outerHeight()/2)
  t = 0 if t < 0
  
  center = { left: l + 'px', top: t + 'px' }
  return center

showLoader = ->
  $darknessification.fadeIn _fadeSpeed
  center = calculateCenter($('html'), $loader)
  $loader.css({left: center.left, top: center.top}).show 'fast'


# =========================================
# ========== HEADER NOTIFICATION ==========
# =========================================

$('nav li.notification a').live 'mouseover', ->
  $this = $(this)
  $pastDueLabel = $("<span class='notification_title'>#{$this.text()}</span>")
  $pastDueLabel.hide().appendTo('header')
  
  l = $this.offset().left - (($pastDueLabel.outerWidth() - $this.outerWidth()) / 2)
  t = $this.offset().top + $this.outerHeight() + 5
  
  $pastDueLabel.css({left:l,top:t}).slideDown('fast').fadeIn()

$('nav li.notification a').live 'mouseout', ->
  $('.notification_title').fadeOut -> $(this).remove()


# =========================================
# ================= MODAL =================
# =========================================

hideModal = (event) ->
  $darknessification.hide 'fast'
  $modal.hide 'fast'

centerModal = (animate = false) ->
  center = calculateCenter($('html'), $modal)
  if animate
    $modal.animate({left: center.left, top: center.top})
  else
    $modal.css({left: center.left, top: center.top})

generateModal = (url, inline = false) ->
  showLoader()
  unless inline
    $ajaxed_again.hide()
    $ajaxed.show()
  $.ajax
    url: url,
    success: (data) ->
      if inline
        $ajaxed.hide 'fast', ->
          $ajaxed_again.empty()
          $(data).appendTo $ajaxed_again
          $ajaxed_again.show 'fast'
          $("<span class='go_back'>back</span>").appendTo '#modal #ajaxed_again h1'
      else
        $ajaxed.empty()
        $(data).appendTo $ajaxed
        
      $loader.fadeOut 'fast'
      $('#modal #ajaxed h1 span').remove()
      $('<span>x</span>').appendTo '#modal h1'
      unless inline
        superDate()
        autocompleteSetup()
        $darknessification.fadeIn _fadeSpeed
      $modal.fadeIn _fadeSpeed
      centerModal()
    
      if $ajaxed.children('form.assignment').length > 0 || $ajaxed_again.children('form.assignment').length > 0
        $modal.css('width','600px')
        centerModal()
      
      setTimeout( ->
        centerModal(true)
      ,400)
      
  return false

# // Listens for a click on any anchor with a class of ajax.
# // Knabs the anchor's href and ajaxes it in to the modal.
$('a.ajax').live 'click', ->
  if $(this).hasClass('view_detail')
    generateModal($(this).attr('href'), true)
  else
    generateModal($(this).attr('href'))

# // Listens for a click on the overlay when the modal or detail list is up.
$darknessification.live 'click', ->
  hideModal()
  
# // Watches for an escape keypress and hides the modal, overlay, and detail list.
$(window).live 'keyup', (event) ->
  if event.keyCode == 27
    $('.detail_day_view').hide 'fast'
    hideModal()

# // Watches for a click on the 'x' and hides the modal and overlay.
$('#modal h1 span').live 'click', ->
  if $(this).hasClass('go_back')
    $ajaxed_again.hide 'fast', ->
      $ajaxed.show 'fast', ->
        centerModal(true)
  else
    hideModal()


# =========================================
# =============== CORKBOARD ===============
# =========================================
  
# // Listens for a click on the calendar view option links.
$('.header_bar a').live 'click', ->
  unless $(this).hasClass('active')
    $header_bar = $(this).parent().parent().siblings('.header_bar')
    $('.header_bar.monthly, .header_bar.upcoming').hide()
    
    # // Checks to see if the we want to show the full on calendar or not.
    if $header_bar.hasClass('upcoming')
      $('.header_bar.upcoming').show()
      $('.calendar').hide 'fast', ->
        $('.centric').show 'fast'
        stickyFooter()
    else
      $('.header_bar.monthly').show()
      $('.centric').hide 'fast', ->
        $('.calendar').show 'fast'
        stickyFooter()
        
    if   $('.corkboard_view.current').hasClass('all')
    then $('.corkboard_view.my').children('.calendar, .centric').hide()
    else $('.corkboard_view.all').children('.calendar, .centric').hide()
  
  return false

setListHeights = ->
  max_list_height = 0
  $('.semantic_shmantic').each ->
    $this = $(this)
    $this.css('height','auto')
    max_list_height = $this.height() if $this.height() > max_list_height

  $('.semantic_shmantic').each ->
    $(this).css('height',max_list_height)

# // Listens for a click on the assignee filters and changes the UI accordingly.
$('#upcoming_filters #assignee_filters li').live 'click', ->
  unless $(this).hasClass('active')
    $(this).siblings().andSelf().toggleClass('active')
    $('.corkboard_view').toggleClass('current')
    generateDetailLists()
    setListHeights()

# // $('#assignment_filters').live 'click', (event) ->
# //   $this = $(event.target)
# //   unless $this.hasClass('active')
# //     $this.addClass('active').siblings().removeClass('active')
# //     $('.corkboard_view.current .assignment').slideDown 'fast'
# //     $(".corkboard_view.current .#{$this.data('filter')}").slideUp 'fast', ->
# //       stickyFooter()

setListHeights()

# // Listens for a click on the body and closes the detailed list of
# // assignments that's what it should be doing.
$body.live 'click', (event) ->
  $clicky = $(event.target)
  if $clicky.parent('.todo').length < 1 && !$clicky.hasClass('detail_day_view')
    if $('.detail_day_view').length > 0
      $('.detail_day_view').hide 'fast'

# =========================================
# =============== CALENDARS ===============
# =========================================

# // Listens for a click, hover, and leave event on the anchors in the calendar.
# // Pops up with a list of the corresponding assignments for that day.
$('.todo a').live 'click',      -> return false
$('.todo a').live 'mouseleave', -> hovering_over = null
$('.todo a').live 'mouseenter', ->

  $this = $(this)
  $('.detail_day_view').hide 'fast'
  day_number = $(this).parent('.todo').parent('.day').data('number')
  hovering_over = day_number
  
  # // Sets a delay on animating in the list of assignments, then positions
  # // it perfectly where we want it.
  setTimeout( ->
    if hovering_over == day_number
      $('.detail_day_view').each ->
        $detailList = $(this)
        if $detailList.data('number') == day_number && $detailList.data('type') == $this.hasClass('tasks')
          $('.detail_day_view').hide 'fast'
          # // Sets the top to just above the anchor and the left to the anchor's left.
          top = $this.offset().top - $detailList.outerHeight() - 10
          $detailList.css({top: top, left: $this.offset().left}).fadeIn 'fast'

          listPlacement = $detailList.offset().left + $detailList.outerWidth()
          mainWidth     = $main.offset().left + $main.width()

          # // Checks to see if the popup needs to go the other direction or not.
          if listPlacement > mainWidth
            left = ($this.offset().left + $this.outerWidth()) - $detailList.outerWidth()
            $detailList.css('left',left)
  , 500)

# // Listens for the mouse leave event on our list of assignments
# // and hides them when detected.
$('.detail_day_view').live 'mouseleave', ->
  $('.detail_day_view').hide 'fast'

# // Loops through all todo badges on each day and generates a detailed list.
generateDetailLists = ->
  $('.corkboard_view.current .calendar .todo').each ->
    $this = $(this)
    $badges = $this.children('a')
    $('.detail_day_view').remove()
  
    if $badges.length < 2
      $badges.css('marginLeft','13px')
  
    day_number = $this.parent('.day').data('number')
  
    $badges.each ->
      $this = $(this)    
      type =  $this.hasClass('tasks')
    
      $detailList = $("<div class='detail_day_view' data-number='#{day_number}' data-type='#{type}' />")
  
      $.ajax
        url: $this.attr('href'),
        success: (data) ->
          $(data).each ->
            $("<li>
                <a href='/assignments/#{this._id}' class='ajax'>#{this.purpose}</a>
              </li>").appendTo $detailList

          $detailList.appendTo $main

generateDetailLists()


# =========================================
# =========== ASSIGNMENT LISTS ============
# =========================================

$('.assignment[data-completed=true]')
  .removeClass('assignment')
  .find('.type')
  .removeClass()
  .addClass('check')

# // Handles mouseenter and mouseleave for the corkboard lists.
$('.list .assignment').live 'mouseenter', ->
  unless $(this).hasClass('working_on_it')
    $(this)
      .find('li:eq(2)').animate {paddingRight:'0px'}, 'fast', ->
        $(this).prev().stop(true).show 'fast'
      .siblings('li:eq(0)').removeClass().addClass('check')

$('.list .assignment').live 'mouseleave', ->
  $(this)
    .find('li:eq(1)').fadeOut 'fast', ->
      $(this).hide().next().stop(true).animate {paddingRight:'25px'}, 'fast'
    .siblings('li:eq(0)').removeClass().addClass('type')

$('.list li[data-completed=true], .list .completed').live 'mouseenter', ->
  $(this)
    .children('ul')
      .children('li:eq(0)')
        .removeClass()
        .addClass('undo')
        .attr('title','mark as incomplete')

$('.list li[data-completed=true], .list .completed').live 'mouseleave', ->
  $(this)
    .children('ul')
      .children('li:eq(0)')
        .removeClass()
        .addClass('check')
        .attr('title','completed')
      .next()
        .hide 'fast'

# // Edit assignment on edit icon click.
$('.edit').live 'click', ->
  id = $(this).data("assignment_id")
  generateModal("/assignments/#{id}/edit")

# // Mark as completed on check icon click.
$('.check').live 'click', ->
  $this       = $(this)
  id          = $this.data('assignment_id')
  $assignment = $this.parent('ul').parent('li')
  
  $assignment.addClass('working_on_it').children('ul').children('li:eq(0), li:eq(1)').hide 'fast'
  $assignmentType = $assignment.children('ul').children('li:eq(0)')
  left = ($assignmentType.offset().left + $assignmentType.width() - 34)
  top   = ($assignmentType.offset().top + 2)
  $assignmentLoader = $("<div class='loader loading' />").appendTo('#main').css({top:top,left:left}).show 'fast'
  
  if $assignment.hasClass('task')
    type = 'task'
  else
    type = 'expense'
  
  $.ajax
    type: 'post',
    url: "/assignments/#{id}/complete",
    success: (data) ->
      $assignmentLoader.hide('fast', -> $(this).remove())
      $assignment
        .removeClass()
        .attr('data-type',type)
        .addClass('completed')
        .find('.type')
          .removeClass()
          .addClass('check')
          .show('fast')
  return false

# // Mark as incomplete on x icon click.
$('li[data-completed=true] .undo, .list .undo').live 'click', ->
  $this       = $(this)
  id          = $this.data('assignment_id')
  $assignment = $this.parent('ul').parent('li')
  type        = $assignment.data('type')
  
  $assignment.addClass('working_on_it').children('ul').children('li:eq(0), li:eq(1)').hide 'fast'
  $assignmentType = $assignment.children('ul').children('li:eq(0)')
  left = ($assignmentType.offset().left + $assignmentType.width() - 34)
  top   = ($assignmentType.offset().top + 2)
  $assignmentLoader = $("<div class='loader loading' />").appendTo('#main').css({top:top,left:left}).show 'fast'
  
  $.ajax
    type: 'post',
    url: "/assignments/#{id}/undo_complete",
    success: (data) ->
      $assignmentLoader.hide('fast', -> $(this).remove())
      $darknessification.fadeOut 'fast'
      $assignment
        .attr('data-completed','')
        .removeClass()
        .addClass('assignment')
        .find('.check')
          .removeClass()
          .addClass('type')
          .attr('title',type)
          .show('fast')
        .find('.undo')
          .removeClass()
          .addClass('type')
          .attr('title',type)
  return false


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

do autocompleteSetup = ->
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

do superDate = ->
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
  stickyFooter()


# =========================================
# ========== SIGN UP AMAZINGNESS ==========
# =========================================

signup_ready = false
$('.home #user_new #user_submit').live 'click', ->
  $('.home #user_new .input:eq(0)').fadeOut( -> 
    $('.home #password_junk').fadeIn()
    signup_ready = true
  )
  $('.other_auths').fadeOut( -> 
    $('.generate').fadeIn()
  )
  return false unless signup_ready
  
$('.generate').live 'click', ->
  characters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz"
  random_string = ''
  for i in [1..32]
    random_number = Math.floor(Math.random() * characters.length)
    random_string += characters.substring(random_number, random_number + 1)
    
  $('#password_junk input').attr('value',random_string)
  $darknessification.fadeIn _fadeSpeed
  $ajaxed.empty()
  
  $("<h1>generated password</h1>
     <p class='pass'>#{random_string}</p>
     <p>Be sure to write this down, because we will be storing it securly and won't be able to access it again.
     If you forget your password, you can always click on the \"forgot password\" link when signing in.</p>
     <p class='button'><a href='sign_up'>sign me up!</a>
  ").appendTo('#modal #ajaxed').fadeIn _fadeSpeed
  
  modal_left = ($('html').outerWidth()/2) - ($modal.outerWidth()/2)
  $modal.css({left: modal_left}).show()
  
  return false
  
$('p.button a').live 'click', ->
  $('#user_new').submit()
  return false

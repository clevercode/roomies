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
        $('.centric').show 'fast', ->
          window.roomies.ui.recalculateStickyFooter()
    else
      $('.header_bar.monthly').show()
      $('.centric').hide 'fast', ->
        $('.calendar').show 'fast', ->
          window.roomies.ui.recalculateStickyFooter()
        
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
# //       window.roomies.ui.recalculateStickyFooter()

setListHeights()

# // Listens for a click on the body and closes the detailed list of
# // assignments that's what it should be doing.
window.roomies.ui.$body.live 'click', (event) ->
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
  $this = $(this)
  id = $this.data("assignment_id")
  $this.attr('href',"/assignments/#{id}/edit")
  generateModal($this)

# // Mark as completed on check icon click.
$('.check').live 'click', ->
  $this       = $(this)
  id          = $this.data('assignment_id')
  $assignment = $this.parent('ul').parent('li')
  
  $assignment.addClass('working_on_it').children('ul').children('li:eq(0), li:eq(1)').hide 'fast'
  $assignmentType = $assignment.children('ul').children('li:eq(0)')
  left = ($assignmentType.offset().left + $assignmentType.width() - 34)
  top   = ($assignmentType.offset().top + 2)
  $assignmentLoader = $("<div class='loader loading' />").appendTo('#main').css({top:top,left:left,opacity:0.4}).show 'fast'
  
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
  $assignmentLoader = $("<div class='loader loading' />").appendTo('#main').css({top:top,left:left,opacity:0.4}).show 'fast'
  
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

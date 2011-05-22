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
$darknessification = $('#darknessification')
$ajaxed            = $modal.children('#ajaxed')

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

# // Hides the flash notice if it's visible.
$('#flash').live 'click', ->
  $('#flash').hide 'fast', ->
    stickyFooter()

# // Hides the flash notice after 20 seconds if the user hasn't clicked on it yet.
setTimeout( ->
  $('#flash').hide 'fast', ->
    stickyFooter()
, 10000)

if $('#flash > div').length > 0
  top    = $('#flash > div:eq(0)').offset().top
  height = $('#flash > div:eq(0)').outerHeight()
  $('#flash > div:eq(1)').css({top:top+height+20})
  
hideModal = (event) ->
  $darknessification.hide 'fast'
  $modal.hide 'fast'


# =========================================
# ========== HEADER NOTIFICATION ==========
# =========================================

$('nav li.notification a').bind 'click', -> return false

$('nav li.notification a').bind 'mouseover', ->
  $this = $(this)
  $pastDueLabel = $("<span class='notification_title'>#{$this.text()}</span>")
  $pastDueLabel.hide().appendTo('header')
  
  l = $this.offset().left - (($pastDueLabel.outerWidth() - $this.outerWidth()) / 2)
  t = $this.offset().top + $this.outerHeight() + 5
  
  $pastDueLabel.css({left:l,top:t}).slideDown('fast').fadeIn()

$('nav li.notification a').bind 'mouseout', ->
  $('.notification_title').fadeOut(-> $(this).remove())


# =========================================
# ================= MODAL =================
# =========================================

# // Listens for a click on any anchor with a class of ajax.
# // Knabs the anchor's href and ajaxes it in to the modal.
$('a.ajax').live 'click', ->
  $ajaxed.empty().load($(this).attr('href'), ->
    $('<span>x</span>').appendTo('#modal h1')
    superDate()
    modal_left = ($('html').outerWidth()/2) - ($modal.outerWidth()/2)
    modal_top = ($(window).height()/2) - ($modal.outerHeight()/2)
    modal_top = 0 if modal_top < 0
    $darknessification.fadeIn _fadeSpeed
    $modal.css({left: modal_left, top: modal_top}).fadeIn _fadeSpeed
  )
  return false

# // Listens for a click on the overlay when the modal or detail list is up.
$darknessification.live 'click', ->
  $detailList.hide 'fast'
  hideModal()
  
# // Watches for an escape keypress and hides the modal, overlay, and detail list.
$(window).bind 'keyup', (event) ->
  if event.keyCode == 27
    $detailList.hide 'fast'
    hideModal()

# // Watches for a click on the 'x' and hides the modal and overlay.
$('#modal h1 span').live 'click', ->
  hideModal()


# =========================================
# =============== CORKBOARD ===============
# =========================================

# // Handles mouseenter and mouseleave for the corkboard lists.
$('.list .assignment').live 'mouseenter', ->
  $(this)
    .find('li:eq(1)').animate {paddingRight:'0px'}, 'fast', ->
      $(this).next().stop(true).show 'fast'
    .siblings('.type').removeClass('type').addClass('check')

$('.list .assignment').live 'mouseleave', ->
  $(this)
    .find('li:eq(2)').fadeOut 'fast', ->
      $(this).hide().prev().stop(true).animate {paddingRight:'25px'}, 'fast'
    .siblings('.check').removeClass('check').addClass('type')

# // Edit assignment on edit icon click.
$('.edit').live 'click', ->
  id = $(this).data("assignment_id")
  window.location.href = "/assignments/#{id}/edit"
  return false
  
# // Listens for a click on the calendar view option links.
$('.header_bar a').bind 'click', ->
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
  
# // Listens for a hover event on the anchors in the calendar.
# // Pops up with a list of the corresponding assignments for that day.
$('.todo a').live 'click', ->
  $this = $(this)
  
  results = $('<div />').load($this.attr('href'), ->
    data = $.parseJSON($(results[0]).text())
    $detailList.empty()
    $(data).each( ->
      $("<li>
          <a href='/assignments/#{this._id}'>#{this.purpose}</a>
        </li>").appendTo $detailList
    )

    # // Sets the top to just above the anchor and the left to the anchor's left.
    top = $this.offset().top - $detailList.outerHeight() - 10
    $darknessification.css('opacity','0').show()
    $detailList.css({top: top, left: $this.offset().left}).fadeIn _fadeSpeed

    listPlacement = $detailList.offset().left + $detailList.outerWidth()
    mainWidth     = $main.offset().left + $main.width()

    # // Checks to see if the popup needs to go the other direction or not.
    if listPlacement > mainWidth
      left = ($this.offset().left + $this.outerWidth()) - $detailList.outerWidth()
      $detailList.css('left',left)
  )
        
  return false

# // Listens for the mouse leave event on our list of assignments.
$detailList.live 'mouseleave', ->
  $detailList.hide('fast')
  $darknessification.css('opacity','.75').hide()

# // Loops through each assignment badge block on the days and center
# // it if there is only one of them.
$('.todo').each( ->
  if $(this).children('a').length < 2
    $(this).children('a').css('marginLeft','13px')
)

# // Listens for a click on the assignee filters and changes the UI accordingly.
$('#upcoming_filters #assignee_filters li').live 'click', ->
  $(this).siblings().andSelf().toggleClass('active')
  $('.corkboard_view').toggleClass('current')
    
$('.check').live 'click', ->
  $this      = $(this)
  id         = $this.data('assignment_id')
  $assignment = $this.parent('ul').parent('li')
  
  $.ajax
    type: 'post',
    url: "/assignments/#{id}/complete",
    success: (data) ->
      $assignment.removeClass('assignment').addClass('completed').find('.type').removeClass().addClass('check')
  return false


# =========================================
# ========== NEW ASSIGNMENT JAZZ ==========
# =========================================

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
  
  $('#repeating').parent('div').next().hide()
  $('#repeating').bind 'change', (event) ->
    if event.currentTarget.checked
      $(this).parent('div').next().show()
    else
      $(this).parent('div').next().hide()

# $('#assignment_due_date').live 'keyup', (event) ->
#   unless megadate == "unknown"
#     $('#picker').datepicker('setDate', saved_date)


# =========================================
# ========== SIGN UP AMAZINGNESS ==========
# =========================================

signup_ready = false
$('.home #user_new #user_submit').bind 'click', ->
  $('.home #user_new .input:eq(0)').fadeOut( -> 
    $('.home #password_junk').fadeIn()
    signup_ready = true
  )
  $('.other_auths').fadeOut( -> 
    $('.generate').fadeIn()
  )
  return false unless signup_ready
  
$('.generate').bind 'click', ->
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
  
  $('p.button a').live 'click', ->
    $('#user_new').submit()
    return false
  return false

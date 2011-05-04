# =========================================
# ================ Globals ================
# =========================================

_fadeSpeed         = 100
_slideDownSpeed    = 200
_slideUpSpeed      = 250
$                  = jQuery
$body              = $('body')
$modal             = $('#modal')
$footer            = $('footer')
$easy_button       = $('#easy_button')
$darknessification = $('#darknessification')

# =========================================
# =========== Functions & Stuff ===========
# =========================================
  
# // Handles the sticky footer
stickyFooter = (event) ->  
  if window.innerHeight > $body.height()
    $footer.css({position:'fixed', bottom:0})

stickyFooter()

# // Hides the flash notice if it's visible.
$('#flash').bind 'click', (event) ->
  $('#flash').fadeOut(() ->
    stickyFooter()
  )
  
hideModal = (event) ->
  $darknessification.fadeOut _fadeSpeed
  $modal.fadeOut _fadeSpeed

# // Provides requestAnimationFrame in a cross browser way.
# // @author paulirish / http://paulirish.com/
unless window.requestAnimationFrame
  window.requestAnimationFrame =
    window.webkitRequestAnimationFrame or
    window.mozRequestAnimationFrame or
    window.oRequestAnimationFrame or
    window.msRequestAnimationFrame or
    (callback, element) ->
      window.setTimeout( callback, 1000 / 60 )

Clouds = 
  # // Initialize the counter
  xPosition: 0

  # // Cache the element
  element: $('#clouds')

  # // Animation Logic
  animate: ->
    # // Create a binded version of this method
    @_bindedAnimate ||= _(@animate).bind(this)

    # // Queue up another call of this method
    window.requestAnimationFrame(@_bindedAnimate)

    # // Update our internal counter 
    @xPosition -= 0.25

    # // Set CSS to new the new counter value
    @element.css("background-position", @xPosition+"px 0")

Clouds.animate()


# =========================================
# ================= MODAL =================
# =========================================

# // Listens for a click on any anchor with a class of ajax.
# // Knabs the anchor's href and ajaxes it in to the modal.
$('a.ajax').bind 'click', (event) ->
  $.ajax url: $(this).attr('href'), success: (data) -> 
    $modal.children('#ajaxed').empty()
    $(data).appendTo('#modal #ajaxed')
    $('<span>x</span>').appendTo('#modal h1')
    $darknessification.fadeIn _fadeSpeed
    modal_left = ($('html').outerWidth()/2) - ($modal.outerWidth()/2)
    modal_top = ($(window).height()/2) - ($modal.outerHeight()/2)
    modal_top = 0 if modal_top < 0
    $modal.css({left: modal_left, top: modal_top}).fadeIn _fadeSpeed
    superDate()
    $modal.find("form > .string > input").not("input[type=hidden]").first().focus()
  return false

# // Listens for a click on the dark overlay when the modal is up.
$darknessification.live 'click', (event) ->
  hideModal()
  return false
  
# // Watches for an escape keypress and hides the modal and overlay.
$(window).bind 'keyup', (event) ->
  if event.keyCode == 27
    hideModal()

# // Watches for a click on the 'x' and hides the modal and overlay.
$('#modal h1 span').live 'click', (event) ->
  hideModal()


# =========================================
# =============== CORKBOARD ===============
# =========================================

# // Handles mouseover and mouseout for the corkboard lists.
$('.list .expense, .list .task, 
   .list .bounty, .list .freebie, 
   .list .gift').live 'mouseover', (event) ->
    $(this)
      .children('ul')
        .children('li:eq(1)')
        .stop(true)
        .animate {paddingRight:'0px'}, _fadeSpeed, (event) ->
          $(this).next().show().animate {opacity:1}, _fadeSpeed
        
$('.list .expense, .list .task, 
   .list .bounty, .list .freebie, 
   .list .gift').live 'mouseleave', (event) ->
    $(this)
      .children('ul')
        .children('li:eq(2)')
        .stop(true)
        .animate {opacity:0}, _fadeSpeed, (event) ->
          $(this).hide().prev().animate {paddingRight:'25px'}, _fadeSpeed

# // Edit assignment on edit icon click.
$('.edit').live 'click', (event) ->
  id = $(this).data("assignment_id")
  window.location.href = "/assignments/#{id}/edit"
  return false
  
# // Listens for a click on the calendar view option links.
$('.header_bar a').bind 'click', (event) ->
  unless $(this).hasClass('active')
    $header_bar = $(this).parent().parent().siblings('.header_bar')
    $header_bar.show().siblings('.header_bar').hide()
  
    # // Checks to see if the we want to show the full on calendar or not.
    if $header_bar.hasClass('upcoming')
      $footer.css({position:'fixed'})
      $('#calendar').slideUp _slideUpSpeed, ->
        $('#centric').slideDown _slideDownSpeed
        stickyFooter()
    else
      $footer.css({position:'fixed'})
      $('#centric').slideUp _slideUpSpeed, ->
        $('#calendar').slideDown _slideDownSpeed
        $footer.css({position:'static'})
  
  return false


# =========================================
# ========== NEW ASSIGNMENT JAZZ ==========
# =========================================

do superDate = ->
  $picker    = $("#picker")
  $superdate = $('.superdate')

  $superdate.live 'keyup', (event) ->
    val = $(this).val()
    if val?
      # // parsing anything the user enters as a date
      date = Date.parse( val )

      # // making the date more legible and concise
      date = date.toString('MMMM d, yyyy')

      # // updating the datepicker
      $picker.datepicker('setDate', date)

  $superdate.live 'focusout', (event) ->
    val = $(this).val()
    if val?
      date = Date.parse( val )
      date = date.toString('MMMM d, yyyy')
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
$('#user_new #user_submit').bind 'click', (event) ->
  $('#user_new .input:eq(0)').fadeOut((event) -> 
    $('#password_junk').fadeIn()
    signup_ready = true
  )
  $('.other_auths').fadeOut((event) -> 
    $('.generate').fadeIn()
  )
  return false unless signup_ready
  
$('.generate').bind 'click', (event) ->
  characters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz"
  random_string = ''
  for i in [1..32]
    random_number = Math.floor(Math.random() * characters.length)
    random_string += characters.substring(random_number, random_number + 1)
    
  $('#password_junk input').attr('value',random_string)
  $darknessification.fadeIn _fadeSpeed
  $modal.children('#ajaxed').empty()
  
  $('<h1>generated password</h1>' +
    '<p class="pass">' + random_string + '</p>' +
    '<p>Be sure to write this down, as we will be storing it securly and wont be able to access it again.</p>' +
    '<p>If you forget your password, you can always click on the "forgot password" link when signing in.</p>' +
    '<p class="button"><a href="sign_up">sign me up!</a>'
  ).appendTo('#modal #ajaxed').fadeIn _fadeSpeed
  
  modal_left = ($('html').outerWidth()/2) - ($modal.outerWidth()/2)
  $modal.css({left: modal_left}).show()
  
  $('p.button a').live 'click', (event) ->
    $('#user_new').submit()
    return false
  return false

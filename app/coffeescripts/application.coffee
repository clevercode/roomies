$                  = jQuery
$body              = $('body')
$modal             = $('#modal')
$footer            = $('footer')
$easy_button       = $('#easy_button')
$darknessification = $('#darknessification')

# // Adds a class of nighttime to the html after 8pm and before 6am
d = new Date()
if d.getHours() < 6 || d.getHours() > 20
  $('html').addClass('nighttime')
  
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
    $modal.empty()
    $(data).find('#main').appendTo('#modal')
    $('<span>x</span>').appendTo('#modal h1')
    $darknessification.show()
    modal_left = ($(window).width()/2) - ($modal.outerWidth()/2)
    modal_top = ($(window).height()/2) - ($modal.outerHeight()/2)
    modal_top = 0 if modal_top < 0
    $modal.css({left: modal_left, top: modal_top}).show()
    superDate()
    $modal.find("form > .string > input").not("input[type=hidden]").first().focus()
  return false

# // Listens for a click on the dark overlay when the modal is up.
$darknessification.live 'click', (event) ->
  $darknessification.hide()
  $modal.hide()
  return false
  
# // Watches for an escape keypress and hides the modal and overlay.
$(window).bind 'keyup', (event) ->
  if event.keyCode == 27
    $modal.hide()
    $darknessification.hide()

# // Watches for a click on the 'x' and hides the modal and overlay.
$('#modal h1 span').live 'click', (event) ->
  $modal.hide()
  $darknessification.hide()


# =========================================
# =============== CORKBOARD ===============
# =========================================

# // Handles mouseover and mouseout for the corkboard lists.
$('.corkboard #upcoming li.expense, 
   .corkboard #upcoming li.task, 
   .corkboard .others li.bounty, 
   .corkboard .others li.freebie, 
   .corkboard .others li.gift').live 'mouseover', (event) ->
    $(this)
      .children('ul')
        .children('li:eq(1)')
        .stop()
        .animate({paddingRight:'0px'}, 100, (event) ->
          $(this).next().show().animate({opacity:1}, 100)
        )
        
$('.corkboard #upcoming li.expense, 
   .corkboard #upcoming li.task, 
   .corkboard .others li.bounty, 
   .corkboard .others li.freebie, 
   .corkboard .others li.gift').live 'mouseleave', (event) ->
    $(this)
      .children('ul')
        .children('li:eq(2)')
        .stop()
        .animate({opacity:0}, 100, (event) ->
          $(this).hide().prev().animate({paddingRight:'25px'}, 100)
        )

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
      $('#calendar').hide()
      $('#centric').show()
      stickyFooter()
    else
      $footer.css({position:'static'})
      $('#centric').hide()
      $('#calendar').show()
  
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
  $darknessification.show()
  $modal.empty()
  
  $('<div id="main">' +
      '<h1>generated password</h1>' +
      '<p class="pass">' + random_string + '</p>' +
      '<p>Be sure to write this down, as we will be storing it securly and wont be able to access it again.</p>' +
      '<p>If you forget your password, you can always click on the "forgot password" link when signing in.</p>' +
      '<p class="button"><a href="sign_up">sign me up!</a>' +
    '</div>'
  ).appendTo('#modal')
  
  modal_left = ($('html').outerWidth()/2) - ($modal.outerWidth()/2)
  $modal.css({left: modal_left}).show()
  
  $('p.button a').live 'click', (event) ->
    $('#user_new').submit()
    return false
  return false

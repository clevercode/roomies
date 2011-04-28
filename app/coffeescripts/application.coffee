###
Provides requestAnimationFrame in a cross browser way.
@author paulirish / http://paulirish.com/
###

unless window.requestAnimationFrame
  window.requestAnimationFrame =
    window.webkitRequestAnimationFrame or
    window.mozRequestAnimationFrame or
    window.oRequestAnimationFrame or
    window.msRequestAnimationFrame or
    (callback, element) ->
      window.setTimeout( callback, 1000 / 60 )

$ = jQuery

$body              = $('body')
$modal             = $('#modal')
$footer            = $('footer')
$easy_button       = $('#easy_button')
$darknessification = $('#darknessification')
$superdate         = $('.superdate')
# $names             = $('#names')

# $('body').noisy(
#   intensity: 0.4, 
#   size: 200, 
#   opacity: 0.06,
#   fallback: 'fallback.png',
#   monochrome: true
# )

# // Adds a class of nighttime to the html after 8pm and before 6am
d = new Date()
if d.getHours() < 6 || d.getHours() > 20
  $('html').addClass('nighttime')
  
# // Handles the sticky footer
if window.innerHeight > $body.height()
  $footer.css({position:'fixed', bottom:0})

# // Hides the flash notice if it's visible.
if $('#flash').height() > '5'
  setTimeout ->
    $('#flash').fadeOut()
  , 5000
  

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


# ===========================
# ========== MODAL ==========
# ===========================

# // Listens for a click on any anchor with a class of ajax.
# // Knabs the anchor's href and ajaxes it in to the modal.
$('a.ajax').bind 'click', (event) ->
  $.ajax url: $(this).attr('href'), success: (data) -> 
    $modal.empty()
    $(data).find('#main').appendTo('#modal')
    $darknessification.show()
    modal_left = ($('html').outerWidth()/2) - ($modal.outerWidth()/2)
    $modal.css({left: modal_left}).show()
    $modal.find("form > .string > input").not("input[type=hidden]").first().focus() 
  return false

# // Listens for a click on the dark overlay when the modal is up
$darknessification.live 'click', (event) ->
  $darknessification.hide()
  $modal.hide()
  return false


# ===============================
# ========== CORKBOARD ==========
# ===============================

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

# // Edit assignment on edit icon click 
$('.edit').live 'click', (event) ->
  id = $(this).data("assignment_id")
  window.location.href = "/assignments/#{id}/edit"
  return false
  
$('.header_bar a').bind 'click', (event) ->
  $this = $(this)
  $header_bar = $this.parent().parent()
  
  # // Adds a class of active to the clicked on link, and removes it from the sibling.
  $this.addClass('active').siblings().removeClass('active')

  # // Removes the current class and add the appropriate one.
  $header_bar.removeClass($this.siblings().text()).addClass($this.text())
  
  # // Checks to see if the we want to show the full on calendar or not.
  if $header_bar.hasClass('upcoming')
    $header_bar.find('h1').text('these coming days')
    $('#calendar').hide()
    $('#centric').show()
    
    if window.innerHeight > $body.height()
      $footer.css({position:'fixed', bottom:0})
  else
    $header_bar.find('h1').text('this coming month')
    $footer.css({position:'static'})
    $('#centric').hide()
    $('#calendar').show()
  
  return false


# =========================================
# ========== NEW ASSIGNMENT JAZZ ==========
# =========================================
  
# $('#assignment_assignees').live 'keyup', (event) ->
#   input_text = $(event.target).val()
#   if input_text.length > 1
#     $.ajax url: '/users?name=' + input_text, success: (data) ->
#       $names.empty().show()
#       $(data).find('#names li').appendTo('#names')
#   else
#     $names.hide().empty()

# $('#names li').live 'click', (event) ->
#   $('#assignment_assignees').attr('value',$(this).text())

# Variables
$picker = $("#picker")

$superdate.live 'keyup', (event) ->
  val = $(this).val()
  if val?
    console.log('val after existence check: ', val)

    # parsing anything the user enters as a date
    date = Date.parse( val )
    console.log('date after DateJS parsing: ', date)

    # making the date more legible and concise
    date = date.toString('MMMM d, yyyy')

    # updating the datepicker
    $picker.datepicker('setDate', date)

    console.log('date after toString: ', date)
    console.log('d after instantiation with val', d)

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
    # date = Date.parse( dateText )
    console.log(Date.parse(dateText))
    console.log(Date.parse("today"))
    if Date.parse($superdate.val) == Date.parse("today")
      console.log('yo today dude')
    # date = date.toString('MMMM d, yyyy')
    $superdate.val(dateText)
)

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

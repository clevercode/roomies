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

$modal             = $('#modal')
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

# // Sets the modal to be right aligned with the add assignment button
if $('body').hasClass('signed_in')
  modal_right = $('html').outerWidth() - ($easy_button.offset().left + $easy_button.outerWidth()) + 2
  
# // Handles the sticky footer
if window.innerHeight > $('body').height()
  $('footer').css({position:'fixed', bottom:0, width:'940px'})
  $('body').css({minHeight:window.innerHeight})

# // Listens for a click on any anchor with a class of ajax.
# // Knabs the anchor's href and ajaxes it in to the modal.
$('a.ajax').bind 'click', (event) ->
  $.ajax url: $(this).attr('href'), success: (data) -> 
    $modal.empty()
    $(data).find('#main').appendTo('#modal')
    $darknessification.show()
    $modal.css({right: modal_right}).show()
    # roomies    = $(data).find('#main p:eq(0)').text()
    # roomie_ids = $(data).find('#main p:eq(1)').text()
    # apply_autocomplete(roomies,roomie_ids)
  return false

# // Listens for a click on the dark overlay when the modal is up
$darknessification.live 'click', (event) ->
  $darknessification.hide()
  $modal.hide()
  return false
  

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
        .animate({paddingRight:'0px'}, 200, (event) ->
          $(this).next().show().animate({opacity:1}, 200)
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
        .animate({opacity:0}, (event) ->
          $(this).hide().prev().animate({paddingRight:'25px'})
        )

# // Hides the flash notice if it's visible.
if $('#flash').height() > '5'
  setTimeout ->
    $('#flash').fadeOut()
  , 3000


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
  $modal.show().find('p.pass').text(random_string)
  $('p.button a').live 'click', (event) ->
    $('#user_new').submit()
    return false
  return false

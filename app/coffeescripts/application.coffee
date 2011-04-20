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

$modal             = $('#modal')
$easy_button       = $('#easy_button')
$darknessification = $('#darknessification')
$superdate         = $('.superdate')

# // Sets the modal to be right aligned with the add assignment button
if $('body').hasClass('signed_in')
  modal_right = $('html').outerWidth() - ($easy_button.offset().left + $easy_button.outerWidth()) + 2
  
# // Handles the sticky footer
if window.innerHeight > $('body').height()
  $('footer').css({position:'fixed', bottom:0, width:'940px'})
  $('body').css({minHeight:window.innerHeight})

$superdate.live 'keyup', (event) ->
  val = $(this).val()
  console.log('got a value')
  if val?
    console.log('val after existence check: ', val)
    date = Date.parse( val )
    console.log('date after DateJS parsing: ', date)
    date = date.toString('MMMM d, yyyy')
    console.log('date after toString: ', date)
    $('#popol').html(date)
    d = new Date(val)
    console.log('d after instantiation with val', d)
    if d.getMonth() is not NaN
      # check for invalid date
      month : d.getMonth()+1,
      day : d.getDate(),
      year : d.getFullYear()
    else
      false

    $('#picker').datepicker( "setDate" , date )
  
# $('#picker').datepicker()

# // Listens for a click on any anchor with a class of ajax.
# // Knabs the anchor's href and ajaxes it in to the modal.
$('a.ajax').bind 'click', (event) ->
  $.ajax url: $(this).attr('href'), success: (data) -> 
    $modal.empty()
    $(data).find('#main').appendTo('#modal')
    $darknessification.show()
    $modal.css({right: modal_right}).show()
    roomies    = $(data).find('#main p:eq(0)').text()
    roomie_ids = $(data).find('#main p:eq(1)').text()
    apply_autocomplete(roomies,roomie_ids)
  return false

# // Listens for a click on the dark overlay when the modal is up
$darknessification.live 'click', (event) ->
  $darknessification.hide()
  $modal.hide()
  return false

# // Listens for a click on the add roomie link, showing a
# // single input field when clicked.
$('#add_roomie').live 'click', (event) ->
  $(this).hide()
  $('#modal form').show()
  return false
  

Clouds = 
  # Initialize the counter
  xPosition: 0

  # Cache the element
  element: $('#clouds')

  # Animation Logic
  animate: ->
    # Create a binded version of this method
    @_bindedAnimate ||= _(@animate).bind(this)

    # Queue up another call of this method
    window.requestAnimationFrame(@_bindedAnimate)

    # Update our internal counter 
    @xPosition -= 0.25

    # Set CSS to new the new counter value
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


# ============================================
# ========== AUTOCOMPLETEY GOODNESS ==========
# ============================================

window.apply_autocomplete = (roomies, roomie_ids) ->
  split = (val) ->
    return val.split(/,\s*/)
  extractLast = (value) ->
    return split(value).pop()
  make_array = (value) ->
    return value.replace('["','').replace('"]','').replace('", "',',')
    
  roomies_array    = roomies
  roomie_ids_array = roomie_ids
  $('.autocomplete')
    # // dont navigate away from the field on tab when selecting an item
    .bind "keydown", (event) ->
      if event.keyCode == $.ui.keyCode.TAB && $( this ).data( "autocomplete" ).menu.active
        event.preventDefault()
    .autocomplete({
      source: ( request, response ) ->
        # // delegate back to autocomplete, but extract the last term
        if typeof(roomies) == 'string'
          roomies_array = split(make_array(roomies))
          roomie_ids_array = split(make_array(roomie_ids))
        response( $.ui.autocomplete.filter(roomies_array,extractLast(request.term)) )
      ,
      search: () ->
        # // custom minLength
        term = extractLast(this.value)
        if term.length < 1 
          return false
      ,
      focus: () ->
        # // prevent value inserted on focus
        return false
      ,
      select: (event, ui) ->
        terms = split(this.value)
        ids   = split($(this).prev().attr('value'))
        
        # // remove the current input
        terms.pop()
        if ids.length < 2 && ids[0] == ''
          ids.pop()
        
        # // add the selected item
        terms.push(ui.item.value)
        ids.push(roomie_ids_array[roomies_array.indexOf(ui.item.value)])
        
        # // add placeholder to get the comma-and-space at the end
        terms.push('')
        this.value = terms.join(', ')
        $(this).prev().attr('value',ids)
        
        return false
    })

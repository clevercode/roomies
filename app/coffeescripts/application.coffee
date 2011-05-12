# =========================================
# ================ Globals ================
# =========================================

_fadeSpeed         = 100
_slideDownSpeed    = 200
_slideUpSpeed      = 250
$                  = jQuery
$body              = $('body')
$main              = $('#main')
$footer            = $('footer')
$modal             = $('#modal')
$names             = $('#names')
$easy_button       = $('#easy_button')
$detailList        = $('.detail_day_view')
$darknessification = $('#darknessification')

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
  $('#flash').fadeOut( ->
    stickyFooter()
  )

# // Hides the flash notice after 20 seconds if the user hasn't clicked on it yet.
setTimeout( ->
  $('#flash').fadeOut( ->
    stickyFooter()
  )
, 20000)
  
hideModal = (event) ->
  $darknessification.css('opacity','.75').hide()
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
$('a.ajax').bind 'click', ->
  $.ajax 
    url: $(this).attr('href'), 
    success: (data) -> 
      $modal.children('#ajaxed').empty()
      $(data).appendTo('#modal #ajaxed')
      $('<span>x</span>').appendTo('#modal h1')
      $darknessification.fadeIn _fadeSpeed
      superDate()
      modal_left = ($('html').outerWidth()/2) - ($modal.outerWidth()/2)
      modal_top = ($(window).height()/2) - ($modal.outerHeight()/2)
      modal_top = 0 if modal_top < 0
      $modal.css({left: modal_left, top: modal_top}).fadeIn _fadeSpeed
      $modal.find("form > .string > input").not("input[type=hidden]").first().focus()
  return false

# // Listens for a click on the overlay when the modal or detail list is up.
$darknessification.live 'click', ->
  hideModal()
  $detailList.fadeOut _fadeSpeed
  return false
  
# // Watches for an escape keypress and hides the modal, overlay, and detail list.
$(window).bind 'keyup', ->
  if event.keyCode == 27
    $detailList.fadeOut _fadeSpeed
    hideModal()

# // Watches for a click on the 'x' and hides the modal and overlay.
$('#modal h1 span').live 'click', ->
  hideModal()


# =========================================
# =============== CORKBOARD ===============
# =========================================

# // Handles mouseover and mouseout for the corkboard lists.
$('.list .assignment').live 'mouseover', ->
    $(this)
      .children('ul')
        .children('li:eq(1)')
          .stop(true)
          .animate {paddingRight:'0px'}, _fadeSpeed, ->
            $(this).next().show().animate {opacity:1}, _fadeSpeed
        .siblings('.type')
          .removeClass('type')
          .addClass('check')
        
$('.list .assignment').live 'mouseleave', ->
    $(this)
      .children('ul')
        .children('li:eq(2)')
          .stop(true)
          .animate {opacity:0}, _fadeSpeed, ->
            $(this).hide().prev().animate {paddingRight:'25px'}, _fadeSpeed
        .siblings('.check')
          .removeClass('check')
          .addClass('type')

# // Edit assignment on edit icon click.
$('.edit').live 'click', ->
  id = $(this).data("assignment_id")
  window.location.href = "/assignments/#{id}/edit"
  return false
  
# // Listens for a click on the calendar view option links.
$('.header_bar a').bind 'click', ->
  unless $(this).hasClass('active')
    $header_bar = $(this).parent().parent().siblings('.header_bar')
    $('.header_bar').hide()
    if $header_bar.hasClass('upcoming')
      $('.header_bar.upcoming').show()
    else
      $('.header_bar').show()
      $('.header_bar.upcoming').hide()
  
    # // Checks to see if the we want to show the full on calendar or not.
    if $header_bar.hasClass('upcoming')
      $('.calendar').slideUp _slideUpSpeed, ->
        $('.centric').slideDown _slideDownSpeed
        stickyFooter()
        
      if $('.corkboard_view.current').hasClass('all')
        $('.corkboard_view.my .calendar').hide()
        $('.corkboard_view.my .centric').show()
      else
        $('.corkboard_view.all .calendar').hide()
        $('.corkboard_view.all .centric').show()
    else
      $('.centric').slideUp _slideUpSpeed, ->
        $('.calendar').slideDown _slideDownSpeed
        stickyFooter()
        
      if $('.corkboard_view.current').hasClass('all')  
        $('.corkboard_view.my .centric').hide()
        $('.corkboard_view.my .calendar').show()
      else  
        $('.corkboard_view.all .centric').hide()
        $('.corkboard_view.all .calendar').show()
  
  return false
  
# // Listens for a hover event on the anchors in the calendar.
# // Pops up with a list of the corresponding assignments for that day.
$('.todo a').live 'click', ->
  $this = $(this)
  $.ajax
    url: $this.attr('href'), 
    success: (data) ->
      $detailList.empty()
      $(data).each( ->
        $("<li>
            <a href='/assignments/#{this._id}'>#{this.purpose}</a>
          </li>").appendTo('.detail_day_view')
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
        
  return false

# // Listens for the mouse leave event on our list of assignments.
$detailList.live 'mouseleave', ->
  $detailList.fadeOut _fadeSpeed
  $darknessification.css('opacity','.75').hide()

# // Loops through each assignment badge block on the days and center
# // it if there is only one of them.
$('.todo').each( ->
  if $(this).children('a').length < 2
    $(this).children('a').css('marginLeft','13px')
)

# // Listens for a click on the assignee filters and changes the UI accordingly.
$('#upcoming_filters #assignee_filters li').live 'click', ->
  $this = $(this)
  unless $this.hasClass('active')
    $this.addClass('active').siblings('li').removeClass('active')
    $('.corkboard_view').each( ->
      $this = $(this)
      if $this.hasClass('current')
        $this.removeClass('current')
      else
        $this.addClass('current')
    )

$('.check').live 'click', ->
  $this      = $(this)
  id         = $this.data('assignment_id')
  $assignment = $this.parent('ul').parent('li')
  
  $.ajax
    type: 'post',
    url: "/assignments/#{id}/complete",
    success: (data) ->
      $assignment.slideUp _slideUpSpeed
      $("<div id='flash'>
           <div class='reward'>
             <p>Congratulations! You completed an assignment! You get cookies.</p>
           </div>
         </div>"
      ).css('opacity',0).animate({opacity:1}).insertBefore('.notifications')
      if $assignment.siblings().length == 0
        $("<li class='assignment'>
             <ul>
               <li class='purpose'>So far so good...</li>
             </ul>
           </li>"
        ).appendTo $assignment.parent('ul')
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
      date = date.toString('MMMM d, yyyy')

      # // updating the datepicker
      $picker.datepicker('setDate', date)

  $superdate.live 'focusout', ->
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
$('#user_new #user_submit').bind 'click', ->
  $('#user_new .input:eq(0)').fadeOut( -> 
    $('#password_junk').fadeIn()
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
  $modal.children('#ajaxed').empty()
  
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

# App Namespace
this.roomies =
  init: []
  ui: {}
  utils: {}

# Convienence variable
roomies = this.roomies

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

# NEW #
roomies.$ = jQuery
roomies.ui.$body = $body
roomies.ui.$main = $main
roomies.ui.$footer = $footer
roomies.ui.$modal = $modal
roomies.ui.$loader = $loader

# =========================================
# ============= Roomies Core ==============
# =========================================

roomies.initialize = ->
  for initFunctionName in roomies.init
    initFunction = roomies.utils.getNestedValueForObject(roomies, initFunctionName)
    initFunction()


roomies.utils.getNestedValueForObject = (obj, identifier) ->
  parts = identifier.split('.')
  return obj[identifier] if parts.length is 1
  nestedValue = obj 
  for part in parts
    nestedValue = nestedValue[part]
  return nestedValue


# =========================================
# =========== Functions & Stuff ===========
# =========================================
  
# // Handles the sticky footer
roomies.ui.recalculateStickyFooter = ->
  footer = roomies.ui.$footer
  body = roomies.ui.$body
  footer.css({position:'static'})
  if window.innerHeight > body.height()
    footer.css({position:'fixed', bottom:0})

roomies.init.push('ui.recalculateStickyFooter')

$(window).bind 'resize', ->
  roomies.ui.recalculateStickyFooter()
  centerModal()

# // Hides the flash notice if it's visible.
$('#flash').live 'click', ->
  $('#flash').hide 'fast', ->
    roomies.ui.recalculateStickyFooter()

# // Hides the flash notice after 5 seconds if the user hasn't clicked on it yet.
setTimeout( ->
  $('#flash .notice').parent().hide 'fast', ->
    roomies.ui.recalculateStickyFooter()
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

generateModal = (anchor, inline = false) ->
  showLoader()
  unless inline
    $ajaxed_again.hide()
    $ajaxed.show()
  $.ajax
    url: anchor.attr('href'),
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
      
      if anchor.parent('li').hasClass('rewards')
        anchor.parent('li').remove()
        $.ajax
          type: 'post',
          url: "/rewards/view_all"
      
      setTimeout( ->
        centerModal(true)
      ,400)
      
  return false

# // Listens for a click on any anchor with a class of ajax.
# // Knabs the anchor's href and ajaxes it in to the modal.
$('a.ajax').live 'click', ->
  if $(this).hasClass('view_detail')
    generateModal($(this), true)
  else
    generateModal($(this))

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

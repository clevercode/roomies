Flash =
  ANIMATION_TIME: 300
  TEMPLATE: Hogan.compile """
    <div class="flash_{{type}}">
      <p>{{text}}</p>
    </div> 
  """
  # Returns a subclass of jQuery that includes flash-related methods
  $: jQuery.sub()

Flash.$.fn.extend
  openIn: (parent, callback)->
    this.css({opacity: 0})
    this.prependTo(parent)
    top = -this.outerHeight()
    this.css({top: top, opacity: 1})
    this.animate({top: 0}, Flash.ANIMATION_TIME, callback)

  # NOTE: Calling `close` on a sticky flash will not restart the queue. Restart
  # the queue manually with `roomies.flash.queueNextClose()`
  close: (callback)->
    newTop = -this.outerHeight()
    this.animate({top: newTop }, Flash.ANIMATION_TIME, ->
      $(this).detach()
      callback() if callback?
    )
  # Sticky flashes block the auto-clear queue. Requiring the user to click the
  # flash element to make it close.
  sticky: ->
    this.addClass('sticky')
    
  isSticky: ->
    this.hasClass('sticky')


class FlashesView
  constructor: (element)->
    @$element = $(element)
    this.bindEvents()
    this.queueNextClose()

  bindEvents: ->
    @$element.on('click', 'div', $.proxy(@, '_onFlashClick'))

  _onFlashClick: (event)->
    this.resetNextClose()
    Flash.$(event.currentTarget).close()

  queueNextClose: (wait = 5000)->
    unless @queueTimer
      @queueTimer = setTimeout($.proxy(@, '_onQueueTimer'), wait)

  resetNextClose: ->
    if @queueTimer?
      clearTimeout(@queueTimer)
      @queueTimer = null
    this.queueNextClose()

  _onQueueTimer: ->
    @queueTimer = null
    flashToHandle = Flash.$(@$element.children().last())
    unless flashToHandle.isSticky()
      flashToHandle.close =>
        this.queueNextClose()

  alert: (text)->
    this.showFlash('alert', text)

  notice: (text)->
    this.showFlash('notice', text)

  showFlash: (type, text)->
    content = Flash.TEMPLATE.render(type: type, text: text)
    Flash.$(content).openIn @$element, =>
      this.resetNextClose()

jQuery ($)->
  @roomies.flash = new FlashesView($('#flashes'))

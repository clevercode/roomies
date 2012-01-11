roomies = @roomies
FLASH_TEMPLATE = Hogan.compile """
  <div class="flash_{{type}}">
    <p>{{text}}</p>
  </div> 
"""
class FlashesView
  constructor: (jq)->
    @$ = jq
    this.bindEvents()
    this.queueNextClose()

  bindEvents: ->
    @$.on('click', 'div', $.proxy(@, '_onFlashClick'))

  _onFlashClick: (event)->
    this.resetNextClose()
    this._closeFlash(event.currentTarget)

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
    flashes = @$.children()
    if flashes.length != 0
      nextFlash = flashes.last()
      this._closeFlash(nextFlash)
      this.queueNextClose()

  # @private - Not sure about the API here
  _closeFlash: (flashElem)->
    $flashElem = $(flashElem)
    newTop = -$flashElem.outerHeight()
    $flashElem.animate({top: newTop }, ->
      $(this).detach()
    )

  alert: (text)->
    this.showFlash('alert', text)

  notice: (text)->
    this.showFlash('notice', text)

  showFlash: (type, text)->
    $flashElem = $(FLASH_TEMPLATE.render(type: type, text: text))
    # we have to inject it into the template to get the correct outerHeight
    $flashElem.css({opacity: 0})
    $flashElem.prependTo(@$)
    top = -$flashElem.outerHeight()
    $flashElem.css({top: top, opacity: 1})
    $flashElem.animate({top: 0}, =>
      this.resetNextClose()
    )





jQuery ($)->
  roomies.flash = new FlashesView($('#flashes'))

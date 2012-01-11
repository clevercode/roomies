Flash =
  ANIMATION_TIME: 300
  TEMPLATE: Hogan.compile """
    <div class="flash_{{type}}">
      <p>{{text}}</p>
    </div> 
  """
  DEFAULT_OPTIONS: 
    text: 'Unkown Notice'
    type: 'notice'

  # Returns a subclass of jQuery that includes flash-related methods
  $: do -> 
    jq = jQuery.sub()
    jq.fn.extend(
      openIn: (parent, callback)->
        this.css({opacity: 0})
        this.prependTo(parent)
        top = -this.outerHeight()
        this.css({top: top, opacity: 1})
        this.animate({top: 0}, Flash.ANIMATION_TIME, ->
          callback() if callback?
        )

      # NOTE: Calling `close` on a sticky flash will not restart the queue. Restart
      # the queue manually with `roomies.flash.queueNextClose()`
      close: (callback)->
        newTop = -this.outerHeight()
        this.animate({top: newTop }, Flash.ANIMATION_TIME, ->
          $(this).remove()
          callback() if callback?
        )
      # Sticky flashes block the auto-clear queue. Requiring the user to click the
      # flash element to make it close.
      sticky: ->
        this.addClass('sticky')
        
      isSticky: ->
        this.hasClass('sticky')
    )
    return jq

  make: (opts = {})->
    context = _.defaults(opts, Flash.DEFAULT_OPTIONS)
    Flash.$(Flash.TEMPLATE.render(context))





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
    flash = Flash.make(type: type, text: text)
    flash.openIn @$element, =>
      this.resetNextClose()

# export to global
@Roomies.Flash = Flash
@Roomies.FlashesView = FlashesView

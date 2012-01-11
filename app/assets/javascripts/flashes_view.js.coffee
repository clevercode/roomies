# import
Flash = @Roomies.Flash

# FlashesView should really be renamed FlashesController its repsponsible for
# dispatatching new flash messages and clearing out expired messages
#
# @example Flashing the user
#   flashes.alert('Alert message')
#   flashes.notice('Notice message')
#
# If you need a flash to stick around, simply sticky it
# @example
#   flashes.alert('Sticky alert message').sticky()
# 
# @since 2.0.0
class FlashesView

  # Requires a parent element that the flash elements will insert into.
  #
  # @example
  #   @roomies.flashes = new Roomies.FlashesView($('#flashes'))
  constructor: (element)->
    @$element = $(element)
    this.bindEvents()
    this.queueNextClose()

  bindEvents: ->
    @$element.on('click', 'div', $.proxy(@, '_onFlashClick'))

  _onFlashClick: (event)->
    this.resetNextClose()
    Flash.$(event.currentTarget).close()

  # Sets a timer for the specified amount of time before clearing the oldest
  # flash that is displayed
  # @param wait - duration in milliseconds
  queueNextClose: (wait = 5000)->
    unless @queueTimer
      @queueTimer = setTimeout($.proxy(@, '_onQueueTimer'), wait)

  # Cancels the current timer and starts a new one
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

  # Alert the user with an alert flash.
  # @return (Roomies.Flash.$)
  alert: (text)->
    this.showFlash('alert', text)

  # Notify the user with a notice flash.
  # @return (Roomies.Flash.$)
  notice: (text)->
    this.showFlash('notice', text)

  # Show the user a flash of any type. 
  # @note You must style a `.flash_*type*` on your own.
  # @return (Roomies.Flash.$)
  showFlash: (type, text)->
    flash = Flash.make(type: type, text: text)
    flash.openIn @$element, =>
      this.resetNextClose()

# export
@Roomies.FlashesView = FlashesView

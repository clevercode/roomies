# A Flash is a rendered message to the user. 
#
# @since 2.0.0
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

  # A subclass of jQuery that includes flash-related methods
  $: do -> 
    jq = jQuery.sub()
    jq.fn.extend(
      # Displays the flash inside the specified parent obj
      # @param parent (jQuery, htmlObj) 
      # @param callback (function) - optional callback that is called at the
      #   completion of the opening animation
      openIn: (parent, callback)->
        this.css({opacity: 0})
        this.prependTo(parent)
        top = -this.outerHeight()
        this.css({top: top, opacity: 1})
        this.animate({top: 0}, Flash.ANIMATION_TIME, ->
          callback() if callback?
        )

      # Dismisses the flash with an animated exit.
      # @param callback (function) - optional callback that is called when the
      #   animation is completed
      # @note Calling `close` on a sticky flash will not restart the queue. Restart
      #   the queue manually with `roomies.flash.queueNextClose()`
      close: (callback)->
        newTop = -this.outerHeight()
        this.animate({top: newTop }, Flash.ANIMATION_TIME, ->
          $(this).remove()
          callback() if callback?
        )

      # Sticky flashes block the auto-clear queue. A sticky flash requires the
      # user to click the flash element to make it close.
      # @return (Flash.$)
      sticky: ->
        this.addClass('sticky')
        
      # @return (boolean) True if the flash is marked as sticky (see #sticky)
      isSticky: ->
        this.hasClass('sticky')
    )
    return jq

  # Don't use Flash.make directly. Instead use FlashesView#alert & #notice
  # @return (Roomies.Flash.$) - rendered template wrapped with jQuery
  make: (opts = {})->
    context = _.defaults(opts, Flash.DEFAULT_OPTIONS)
    Flash.$(Flash.TEMPLATE.render(context))

# export
@Roomies.Flash = Flash

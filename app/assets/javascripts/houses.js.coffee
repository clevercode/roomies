class Roomies.SponsorHouseView

  constructor: (selector)->
    @el = $(selector)[0]
    this.bindEvents()
    this.prefill()

  prefill: () ->
    @$('#card_number').val('4242-4242-4242-4242')
    @$('#card_expiry_month').val('10')
    @$('#card_expiry_year').val('2020')
    @$('#card_cvc').val('123')

  addCard: (event) ->
    # prevent going to server
    event.preventDefault() 
    # prevent repeated clicks
    $('input[type=submit]', event.target).attr('disabled', 'disabled')

    card = this.getCard()

    responseHandler = (status, response) ->
      # remove status indicator
      if status == 200
        @last4 = response.card.last4
        @stripe_token = response.id
        @$('#stripe_token').val(@stripe_token)
        @$('#credit_card_info').replaceWith('<p class="credit_card selected">XXXX-XXXX-XXXX-'+@last4+'</p>')
      else
        # handle error

    if this.validate(card)
      # show status indicator
      Stripe.createToken card, _(responseHandler).bind(@)
    return true

  sponsor: (event) ->
    $form = $(event.target)
    # prevent repeated clicks
    $('input[type=submit]', event.target).attr('disabled', 'disabled')
    $.post $target.attr('action'), $target.serialize(), (data, status) ->
    
    return false
    
  cancel: (event) ->
    this.roomies.ui.hideModel()  
    return false

  $: (selector) ->
    return $(selector, @el)

  validate: (card) ->
    this.validateCC(card.number)
    this.validateCVC(card.cvc)
    this.validateExpiry(card.exp_month, card.exp_year)

  getCard: () ->
    return {
      number: @$('#card_number').val()
      exp_month: @$('#card_expiry_month').val()
      exp_year: @$('#card_expiry_year').val()
      cvc: @$('#card_cvc').val()
    }

  getCardType: () ->
    Stripe.cardType(@$('#card_number').val())

  #private
  bindEvents: () ->
    _(@).bindAll('addCard', 'sponsor', 'cancel')
    @$('#credit_card_info').bind('submit', @addCard)
    @$('.edit_house').bind('submit', @sponsor)
    @$('.cancel').bind('click', @cancel)

  validateCC: (creditCardNumber) ->
    return Stripe.validateCardNumber(creditCardNumber)
  validateCVC: (cvc) ->
    return Stripe.validateCVC(cvc)
  validateExpiry: (month, year) ->
    return Stripe.validateExpiry(month, year)



# imports
Roomies = @Roomies
roomies = @roomies
PasswordGenerator = Roomies.utils.PasswordGenerator

class SignUpView 
  @views = []

  constructor: (element)->
    @$ = $(element)
    this.bindEvents()

  bindEvents: ->
    # ignore clicks from the submit button if form is incomplete
    @$.on('click', 'input[type=submit]', $.proxy(@, '_onSubmitClick'))
    # disable button when submitting
    @$.on('submit', 'form', $.proxy(@, '_onFormSubmit'))
    @$.on('click', '.generate a', $.proxy(@, '_onGenerateClick'))

  # @private
  _onSubmitClick: (event) ->
    return if @isComplete()
    event.preventDefault()
    switch this.missing[0]
      when 'email' then this.transitionToEmail()
      when 'password' then this.transitionToPassword()
      else
        throw new Error('Unknown missing field')

  # @private
  _onFormSubmit: (event) ->

  # @private
  _onGenerateClick: (event) ->
    event.preventDefault()
    passwordInput = @$.find('input:password')
    @_oldPassword = passwordInput.val()
    password = PasswordGenerator.generate()
    passwordInput.val(password)
    # TODO: Remove template from javascript, localization
    modal = new Roomies.Modal(content: """
      <code class="password">#{password}</code>
      <p>Be sure to copy this down, because we will be storing it securely and will be unable to access it again.
      If you forget your password, you can always click on the "password help" link when signing in.</p>
    """, title: "Password Generated", affirm: "Okay, I've got it", reject: "Nevermind, I'll use my own password")
    $(modal).on('modal:close', $.proxy(@, '_onModalClose'))
    roomies.openModal(modal)

  _onModalClose: (event) ->
    switch event.action
      when Modal.REJECT, Modal.INTERRUPT
        @$.find('input:password').val(@_oldPassword)
      else
        @$.find('input[type=submit]')
        # handle AFFIRM

  isComplete: ->
    @missing = []
    if @$.find('input[name="user[email]"]').val() == ''
      @missing.push 'email'
    if @$.find('input[name="user[password]"]').val() == ''
      @missing.push 'password'
    return @missing.length == 0

  transitionToEmail: ->
    @$.find('.password, .generate').fadeOut =>
      @$.find('.email, .other_auths').fadeIn()

  transitionToPassword: ->
    @$.find('.email, .other_auths').fadeOut =>
      @$.find('.password, .generate').fadeIn()


ModalPresenter =
  currentModal: null
  presenterElement: $('<div class="modalPresenter"/>')

  openModal: (modal)->
    this.initializeModalPresenter()
    throw new Error("Cannot show another modal until the current modal is closed") if @currentModal
    modal.presenter = this
    modalDomFragment = modal.render()
    @presenterElement.append(modalDomFragment)
    @presenterElement.appendTo(@root)
    @presenterElement.fadeIn()
    this.centerModal()
    $(@root).css('overflow','hidden')
    @currentModal = modal

  closeModal: ->
    # animate presenter element hiding
    @presenterElement.fadeOut =>
      $(@root).css('overflow','auto')
      @presenterElement.detach()
      @presenterElement.empty()
      @currentModal = null

  # Initializes the hidden container object. Only runs once
  initializeModalPresenter: ()->
    return true if @_modalPresenterInitialized
    throw new Error("ModalPresenter needs an @root property to function") unless @root
    @presenterElement.hide()
    @presenterElement.on('click',$.proxy(@, '_onPresenterClick'))
    jwerty.key('escape', $.proxy(@,'_onKeyEscape'))

    @_modalPresenterInitialized = true

  # Centers the modal vertically and horizontally within the window
  centerModal: ->
    modal = @presenterElement.children()
    top = ((@presenterElement.height() - modal.outerHeight()) / 2) + @presenterElement.scrollTop() + 'px'
    left = ((@presenterElement.width() - modal.outerWidth()) / 2) + @presenterElement.scrollLeft() + 'px'
    modal.css(position: 'absolute', top: top, left: left)

  # @private 
  _onPresenterClick: (event)->
    if @currentModal? && event.target == event.currentTarget
      @currentModal.resolveAndCloseWithAction(Modal.INTERRUPT)

  # @private
  _onKeyEscape: (event)->
    if @currentModal
      @currentModal.resolveAndCloseWithAction(Modal.INTERRUPT)

class Modal
  Modal.DEFAULT_OPTIONS = 
    title: null
    content: null
    affirm: "Okay"
    reject: null
  Modal.REJECT = 'reject'
  Modal.AFFIRM = 'affirm'
  Modal.INTERRUPT = 'interrupt'

  # TODO: Find a home for template!
  @template = Hogan.compile """
    <section role="modal">
      {{#title}}
        <header>
          <h1>{{title}}</h1>
        </header>
      {{/title}}
      {{{content}}}
      <footer>
        {{#reject}}
          <button id="modal-reject">{{reject}}</button>
        {{/reject}}
        <button id="modal-affirm">{{affirm}}</button>
      </footer>
    </section>
  """

  constructor: (options)->
    @context = _.defaults(options, Modal.DEFAULT_OPTIONS)

  # It's important to note that each call to Modal#render() will result in
  # a brand new DOM fragment. We don't reuse the fragment so that there is no
  # leak in DOM state, e.g. event handlers, modified classes
  render: ->
    @$ = $(this.renderTemplate())
    this.bindEvents(@$)

    @$

  renderTemplate: ->
    Modal.template.render(@context)

  # TIDBIT for Andrew: Remember parens problem
  bindEvents: (jq)->
    jq.on('click', '#modal-affirm', $.proxy(@, '_onAffirm'))
    jq.on('click', '#modal-reject', $.proxy(@, '_onReject'))

  _onAffirm: (event)->
    $(event.target).addClass('active')
    this.resolveAndCloseWithAction(Modal.AFFIRM)

  _onReject: (event)->
    $(event.target).addClass('active')
    this.resolveAndCloseWithAction(Modal.REJECT)

  resolveAndCloseWithAction: (action)->
    $(@).trigger(type: 'modal:close', action: action)
    @presenter.closeModal() if @presenter


# TODO: Move into separate file

# Export to namespace
Roomies.SignUpView = SignUpView
Roomies.Modal = Modal
Roomies.ModalPresenter = ModalPresenter

jQuery ($)->
# TODO: Move this
  _.extend(roomies, ModalPresenter)
  roomies.root = document.body

  views = $('.sign-up-box').map (index, element)->
    new SignUpView(element)


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
    @$.on('click', 'input[type=submit]', $.proxy(@, 'onSubmitClick'))
    # disable button when submitting
    @$.on('submit', 'form', $.proxy(@, 'onFormSubmit'))
    @$.on('click', '.generate a', $.proxy(@, 'onGenerateClick'))

  onSubmitClick: (event) ->
    return if @isComplete()
    switch this.missing[0]
      when 'email' then this.transitionToEmail()
      when 'password' then this.transitionToPassword()
      else
        throw new Error('Unknown missing field')
    event.preventDefault()

  onFormSubmit: (event) ->

  onGenerateClick: (event) ->
    event.preventDefault()
    passwordInput = @$.find('input:password')
    @_oldPassword = passwordInput.val()
    password = PasswordGenerator.generate()
    passwordInput.val(password)
    # TODO: Remove template from javascript, localization
    modal = new Roomies.Modal(content: """
      <code class="password">#{password}</code>
      <p>Be sure to write this down, because we will be storing it securely and will be unable to access it again.
      If you forget your password, you can always click on the "password help" link when signing in.</p>
    """, title: "Password Generated", affirm: "I've got it", reject: "Nevermind, I'll use my own password")
    $(modal).on('modal:close', $.proxy(@, 'onModalClose'))
    roomies.openModal(modal)

  onModalClose: (event) ->
    switch event.action
      when Modal.REJECT, Modal.INTERRUPT
        @$.find('input:password').val(@_oldPassword)
      else
        @$.find('input[type=submit]')
        # handle AFFIRM

  isComplete: ->
    @missing = []
    if @$.find('input[name="user[password]"]').val() == ''
      @missing.push 'password'
    if @$.find('input[name="user[email]"]').val() == ''
      @missing.push 'email'
    return @missing.length == 0

  transitionToEmail: ->
    @$.find('.password, .generate').fadeOut =>
      @$.find('.email, .other_auths').fadeIn()

  transitionToPassword: ->
    @$.find('.email, .other_auths').fadeOut =>
      @$.find('.password, .generate').fadeIn()


ModalPresenter =
  currentModal: null
  presenterElement: $('<div class="modalPresenter"/>').hide()
  openModal: (modal)->
    throw new Error("ModalPresenter needs an @root property to function") unless @root
    throw new Error("Cannot show another modal until the current modal is closed") if @currentModal
    modal.presenter = this
    modalDomFragment = modal.render()
    @presenterElement.append(modalDomFragment)
    @presenterElement.on('click',$.proxy(@, 'onPresenterClick'))
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
      @presenterElement.off('click',$.proxy(@, 'onPresenterClick'))
      @presenterElement.empty()
      @currentModal = null

  centerModal: ->
    modal = @presenterElement.children()
    top = ((@presenterElement.height() - modal.outerHeight()) / 2) + @presenterElement.scrollTop() + 'px'
    left = ((@presenterElement.width() - modal.outerWidth()) / 2) + @presenterElement.scrollLeft() + 'px'
    modal.css(position: 'absolute', top: top, left: left)

  onPresenterClick: (event)->
    if @currentModal? && event.target == event.currentTarget
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
    this.resolveAndCloseWithAction(Modal.AFFIRM)

  _onReject: (event)->
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


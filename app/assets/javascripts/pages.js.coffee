# =========================================
# ========== SIGN UP AMAZINGNESS ==========
# =========================================

signup_ready = false
$('.home #user_new #user_submit').live 'click', ->
  $('.home #user_new .input:eq(0)').fadeOut( -> 
    $('.home #password_junk').fadeIn()
    signup_ready = true
  )
  $('.other_auths').fadeOut( -> 
    $('.generate').fadeIn()
  )
  return false unless signup_ready
  
$('.generate').live 'click', ->
  characters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz"
  random_string = ''
  for i in [1..32]
    random_number = Math.floor(Math.random() * characters.length)
    random_string += characters.substring(random_number, random_number + 1)
    
  $('#password_junk input').attr('value',random_string)
  $darknessification.fadeIn _fadeSpeed
  $ajaxed.empty()
  
  $("<h1>generated password</h1>
     <p class='pass'>#{random_string}</p>
     <p>Be sure to write this down, because we will be storing it securly and won't be able to access it again.
     If you forget your password, you can always click on the \"forgot password\" link when signing in.</p>
     <p class='button'><a href='sign_up'>sign me up!</a>
  ").appendTo('#modal #ajaxed').fadeIn _fadeSpeed
  
  modal_left = ($('html').outerWidth()/2) - ($modal.outerWidth()/2)
  $modal.css({left: modal_left}).show()
  
  return false
  
$('p.button a').live 'click', ->
  $('#user_new').submit()
  return false
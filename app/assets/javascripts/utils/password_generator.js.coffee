PasswordGenerator =
  # TODO: We should suggest some better passwords. Ones with symbols too
  charset: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz".split('')
    
  generate: (length = 32)->
    password = ''
    for i in [1..length]
      password += this.getRandomCharacter()

    password

  getRandomCharacter: ->
    index = Math.floor(Math.random() * @charset.length) 

    @charset[index] 

#export
@Roomies.utils.PasswordGenerator = PasswordGenerator

# Place your application-specific JavaScript functions and classes here
# This file is automatically included by javascript_include_tag :defaults

$ = jQuery

# $('body').noisy(
#   intensity: 0.4, 
#   size: 200, 
#   opacity: 0.06,
#   fallback: 'fallback.png',
#   monochrome: true
# )
  
$('input:password').nakedPassword({path: '/images/naked/'})

superdate = $('.superdate')
superdate.live 'keyup', (event) ->
  val = $(this).val()
  console.log('got a value')
  if val?
    console.log('val after existence check: ', val)
    date = Date.parse( val )
    console.log('date after DateJS parsing: ', date)
    date = date.toString('MMMM d, yyyy')
    console.log('date after toString: ', date)
    $('#popol').html(date)
    d = new Date(val)
    console.log('d after instantiation with val', d)
    if d.getMonth() is not NaN
      # check for invalid date
      month : d.getMonth()+1,
      day : d.getDate(),
      year : d.getFullYear()
    else
      false

    $('#picker').datepicker( "setDate" , date )
  
$('#picker').datepicker()

textWidth = $('.widtherize').innerWidth()
$(".widtherize p").widtherize( {'width': textWidth } )
                                                                             
$('input').bind 'focus', (event) ->        
  $this = $(this)
  if $this.attr('value') == 'email' || $this.attr('value') == 'password'
    $this.attr('value','')

$('input').bind 'blur', (event) ->
  $this = $(this)
  if $this.attr('value') == ''
    if $this.attr('type') == 'text'
      $this.attr('value','email')
    else if $this.attr('type') == 'password'
      $this.attr('value','password')

$('p.edit_profile a').bind 'click', (event) ->
  $.ajax url: $(this).attr('href'), success: (data) -> 
    $('#modal').empty()
    $(data).find('#main').appendTo('#modal')
    $('#darknessification').show()
    $('#modal').show()
  return false

$('#darknessification, .cancel a').live 'click', (event) ->
  $('#darknessification').hide()
  $('#modal').hide()
  return false
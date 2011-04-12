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

d = new Date()
if d.getHours() < 6 || d.getHours() > 8
  $('html').addClass('nighttime')

$('input:password').nakedPassword({path: '/images/naked/'})

$modal             = $('#modal')
$easy_button       = $('#easy_button')
$darknessification = $('#darknessification')

if $('body').hasClass('signed_in')
  modal_right = $('html').outerWidth() - ($easy_button.offset().left + $easy_button.outerWidth()) + 2

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

value = ''

$('input').live 'focus', (event) ->        
  $this = $(this)
  $value = $this.attr('value')
  if $value == 'email' || $value == 'password' || $value == 'example@domain.com'
    value = $this.attr('value')
    $this.attr('value','').css({color:'#3a4859',fontStyle:'normal'})

$('input').live 'blur', (event) ->
  $this = $(this)
  if $this.attr('value') == ''
    $this.attr('value',value).css({color:'#7490b3',fontStyle:'italic'})

$('a.ajax').bind 'click', (event) ->
  $.ajax url: $(this).attr('href'), success: (data) -> 
    $modal.empty()
    $(data).find('#main').appendTo('#modal')
    $darknessification.show()
    $modal.css({right: modal_right}).show()
    $easy_button.text('close')
  return false

$('#darknessification').live 'click', (event) ->
  $darknessification.hide()
  $modal.hide()
  $easy_button.text('+ add assignment')
  return false

$('#add_roomie').live 'click', (event) ->
  $(this).hide()
  $('#modal form').show()
  return false
  
current = 0

init = setInterval(() -> 
  current -= 1
  $('#clouds').css("background-position",current+"px 0")
,70)

$('.corkboard #upcoming li.expense, 
   .corkboard #upcoming li.task, 
   .corkboard .others li.bounty, 
   .corkboard .others li.freebie, 
   .corkboard .others li.gift').live 'mouseover', (event) ->
    $(this)
      .children('ul')
        .children('li:eq(1)')
        .stop()
        .animate({paddingRight:'0px'}, 200, (event) ->
          $(this).next().show().animate({opacity:1}, 200)
        )
        
$('.corkboard #upcoming li.expense, 
   .corkboard #upcoming li.task, 
   .corkboard .others li.bounty, 
   .corkboard .others li.freebie, 
   .corkboard .others li.gift').live 'mouseleave', (event) ->
    $(this)
      .children('ul')
        .children('li:eq(2)')
        .stop()
        .animate({opacity:0}, (event) ->
          $(this).hide().prev().animate({paddingRight:'25px'})
        )
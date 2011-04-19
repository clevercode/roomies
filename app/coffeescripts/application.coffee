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

# $('input:password').nakedPassword({path: '/images/naked/'})

$modal             = $('#modal')
$easy_button       = $('#easy_button')
$darknessification = $('#darknessification')
$superdate         = $('.superdate')

if $('body').hasClass('signed_in')
  modal_right = $('html').outerWidth() - ($easy_button.offset().left + $easy_button.outerWidth()) + 2
  
if window.innerHeight > $('body').height()
  $('footer').css({position:'fixed', bottom:0, width:'940px'})
  $('body').css({minHeight:window.innerHeight})

$superdate.live 'keyup', (event) ->
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
  
# $('#picker').datepicker()

$('a.ajax').bind 'click', (event) ->
  $.ajax url: $(this).attr('href'), success: (data) -> 
    $modal.empty()
    $(data).find('#main').appendTo('#modal')
    $darknessification.show()
    $modal.css({right: modal_right}).show()
    roomies    = $(data).find('#main p:eq(0)').text()
    roomie_ids = $(data).find('#main p:eq(1)').text()
    apply_autocomplete(roomies,roomie_ids)
    console.log roomies
    console.log roomie_ids
  return false

$darknessification.live 'click', (event) ->
  $darknessification.hide()
  $modal.hide()
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
        
if $('#flash').height() > '5'
  setTimeout ->
    $('#flash').fadeOut()
  , 3000
  


# ============================================
# ========== AUTOCOMPLETEY GOODNESS ==========
# ============================================

window.apply_autocomplete = (roomies, roomie_ids) ->
  split = (val) ->
    return val.split(/,\s*/)
  extractLast = (value) ->
    return split(value).pop()
  make_array = (value) ->
    return value.replace('["','').replace('"]','').replace('", "',',')
    
  roomies_array    = roomies
  roomie_ids_array = roomie_ids
  $('.autocomplete')
    # // dont navigate away from the field on tab when selecting an item
    .bind "keydown", (event) ->
      if event.keyCode == $.ui.keyCode.TAB && $( this ).data( "autocomplete" ).menu.active
        event.preventDefault()
    .autocomplete({
      source: ( request, response ) ->
        # // delegate back to autocomplete, but extract the last term
        if typeof(roomies) == 'string'
          roomies_array = split(make_array(roomies))
          roomie_ids_array = split(make_array(roomie_ids))
        response( $.ui.autocomplete.filter(roomies_array,extractLast(request.term)) )
      ,
      search: () ->
        # // custom minLength
        term = extractLast(this.value)
        if term.length < 1 
          return false
      ,
      focus: () ->
        # // prevent value inserted on focus
        return false
      ,
      select: (event, ui) ->
        terms = split(this.value)
        ids   = split($(this).prev().attr('value'))
        
        # // remove the current input
        terms.pop()
        if ids.length < 2 && ids[0] == ''
          ids.pop()
        
        # // add the selected item
        terms.push(ui.item.value)
        ids.push(roomie_ids_array[roomies_array.indexOf(ui.item.value)])
        
        # // add placeholder to get the comma-and-space at the end
        terms.push('')
        this.value = terms.join(', ')
        $(this).prev().attr('value',ids)
        
        return false
    })
/* DO NOT MODIFY. This file was compiled Wed, 13 Apr 2011 22:40:48 GMT from
 * /Users/zachary/Documents/Full Sail/Current Classes/WPP/roomies/app/coffeescripts/application.coffee
 */

(function() {
  var $, $darknessification, $easy_button, $modal, $superdate, current, d, init, modal_right, value;
  $ = jQuery;
  d = new Date();
  if (d.getHours() < 6 || d.getHours() > 8) {
    $('html').addClass('nighttime');
  }
  $('input:password').nakedPassword({
    path: '/images/naked/'
  });
  $modal = $('#modal');
  $easy_button = $('#easy_button');
  $darknessification = $('#darknessification');
  $superdate = $('.superdate');
  if ($('body').hasClass('signed_in')) {
    modal_right = $('html').outerWidth() - ($easy_button.offset().left + $easy_button.outerWidth()) + 2;
  }
  if (window.innerHeight > $('body').height()) {
    $('footer').css({
      position: 'fixed',
      bottom: 0
    });
    $('body').css({
      minHeight: window.innerHeight
    });
  }
  $('.home #signup form').bind('submit', function(event) {
    return alert('hi');
  });
  $superdate.live('keyup', function(event) {
    var date, val;
    val = $(this).val();
    console.log('got a value');
    if (val != null) {
      console.log('val after existence check: ', val);
      date = Date.parse(val);
      console.log('date after DateJS parsing: ', date);
      date = date.toString('MMMM d, yyyy');
      console.log('date after toString: ', date);
      $('#popol').html(date);
      d = new Date(val);
      console.log('d after instantiation with val', d);
      if (d.getMonth() === !NaN) {
        ({
          month: d.getMonth() + 1,
          day: d.getDate(),
          year: d.getFullYear()
        });
      } else {
        false;
      }
      return $('#picker').datepicker("setDate", date);
    }
  });
  $('#picker').datepicker();
  value = '';
  $('input').live('focus', function(event) {
    var $this, $value;
    $this = $(this);
    $value = $this.attr('value');
    if ($value === 'email' || $value === 'password' || $value === 'example@domain.com') {
      value = $this.attr('value');
      return $this.attr('value', '').css({
        color: '#3a4859',
        fontStyle: 'normal'
      });
    }
  });
  $('input').live('blur', function(event) {
    var $this;
    $this = $(this);
    if ($this.attr('value') === '') {
      return $this.attr('value', value).css({
        color: '#7490b3',
        fontStyle: 'italic'
      });
    }
  });
  $('a.ajax').bind('click', function(event) {
    $.ajax({
      url: $(this).attr('href'),
      success: function(data) {
        $modal.empty();
        $(data).find('#main').appendTo('#modal');
        $darknessification.show();
        $modal.css({
          right: modal_right
        }).show();
        return $easy_button.text('close');
      }
    });
    return false;
  });
  $darknessification.live('click', function(event) {
    $darknessification.hide();
    $modal.hide();
    $easy_button.text('+ add assignment');
    return false;
  });
  $('#add_roomie').live('click', function(event) {
    $(this).hide();
    $('#modal form').show();
    return false;
  });
  current = 0;
  init = setInterval(function() {
    current -= 1;
    return $('#clouds').css("background-position", current + "px 0");
  }, 70);
  $('.corkboard #upcoming li.expense, \
   .corkboard #upcoming li.task, \
   .corkboard .others li.bounty, \
   .corkboard .others li.freebie, \
   .corkboard .others li.gift').live('mouseover', function(event) {
    return $(this).children('ul').children('li:eq(1)').stop().animate({
      paddingRight: '0px'
    }, 200, function(event) {
      return $(this).next().show().animate({
        opacity: 1
      }, 200);
    });
  });
  $('.corkboard #upcoming li.expense, \
   .corkboard #upcoming li.task, \
   .corkboard .others li.bounty, \
   .corkboard .others li.freebie, \
   .corkboard .others li.gift').live('mouseleave', function(event) {
    return $(this).children('ul').children('li:eq(2)').stop().animate({
      opacity: 0
    }, function(event) {
      return $(this).hide().prev().animate({
        paddingRight: '25px'
      });
    });
  });
}).call(this);

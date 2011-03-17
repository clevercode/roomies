/* DO NOT MODIFY. This file was compiled Thu, 17 Mar 2011 15:57:12 GMT from
 * /Users/zachary/Documents/Full Sail/Current Classes/WPP/roomies/app/coffeescripts/application.coffee
 */

(function() {
  var $, $body, $footer, width;
  $ = jQuery;
  $('body').noisy({
    intensity: 0.4,
    size: 200,
    opacity: 0.06,
    fallback: 'fallback.png',
    monochrome: true
  });
  $body = $('body');
  $footer = $('footer');
  if ($('#main').outerHeight(true) >= ($(window).height() - $footer.outerHeight(true) - $('header').outerHeight(true))) {
    $footer.css({
      position: 'static'
    });
  } else {
    width = $(window).width() - ($body.outerWidth(true) - $body.outerWidth());
    $footer.css({
      width: width
    });
  }
  $("input:password").nakedPassword({
    path: "/images/naked/"
  });
}).call(this);

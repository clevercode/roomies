/* DO NOT MODIFY. This file was compiled Fri, 18 Mar 2011 08:24:42 GMT from
 * /Users/olivier/Sites/fullsail/roomies/app/coffeescripts/application.coffee
 */

(function() {
  var $, $body, $footer, width;
  $ = jQuery;
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

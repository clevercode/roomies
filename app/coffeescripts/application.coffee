# Place your application-specific JavaScript functions and classes here
# This file is automatically included by javascript_include_tag :defaults

$ = jQuery

$('body').noisy(
  intensity: 0.4, 
  size: 200, 
  opacity: 0.06,
  fallback: 'fallback.png',
  monochrome: true
)

$body   = $('body')
$footer = $('footer')

if $('#main').outerHeight(true) >= ($(window).height() - $footer.outerHeight(true) - $('header').outerHeight(true))
  $footer.css position:'static'
else
  width = $(window).width() - ($body.outerWidth(true) - $body.outerWidth())
  $footer.css width:width
  
$("input:password").nakedPassword({path: "/images/naked/"})
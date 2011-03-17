# Place your application-specific JavaScript functions and classes here
# This file is automatically included by javascript_include_tag :defaults

$ = jQuery

$('body').noisy(
  intensity: 0.9, 
  size: 200, 
  opacity: 0.08,
  fallback: 'fallback.png',
  monochrome: false
)

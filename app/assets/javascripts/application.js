// Vendor libaries
//= require underscore.min
//= require jquery.min
//= require jwerty
//= require hogan
//
// Application libraries
//= require namespace
//= require utils/password_generator
//= require flash
//= require flashes_view
//= require sign_up
//
// This File
//= require_self

Roomies = this.Roomies
roomies = this.roomies
jQuery(function($){
  roomies.flash = new Roomies.FlashesView($('#flashes'));
});

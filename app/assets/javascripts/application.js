// Vendor libaries
//= require underscore.min
//= require jquery_ujs
//= require jwerty
//= require hogan
//
// Application libraries
//= require namespace
//= require utils/password_generator
//= require flash
//= require flashes_controller
//= require sign_up
//
// This File
//= require_self

Roomies = this.Roomies;
roomies = this.roomies;

Roomies.boot = function() {
  roomies.flash = new Roomies.FlashesController($('#flashes'));
};

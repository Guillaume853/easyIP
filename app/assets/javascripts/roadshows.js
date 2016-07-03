// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  $(".navbar-wagon").on("mouseenter", function(){
    $(this).removeClass("navbar-transparent")
  });
  $(".navbar-wagon").on("mouseleave", function(){
    $(this).addClass("navbar-transparent")
  });
});



// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  $(".navbar-wagon").on("mouseenter", function(){
    $(this).removeClass("navbar-transparent")
  });
  $(".navbar-wagon").on("mouseleave", function(){
    $(this).addClass("navbar-transparent")
  });
  $(window).on("scroll", function(){
    if ($(this).scrollTop() > 20){
      $(".navbar-wagon").removeClass("navbar-transparent");
      }
    else {
      $(".navbar-wagon").addClass("navbar-transparent");
    }
  });
  $(function() {
    $('a[href*="#"]:not([href="#"])').click(function() {
      if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
        var target = $(this.hash);
        target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
        if (target.length) {
          $('html, body').animate({
            scrollTop: target.offset().top
          }, 1000);
          return false;
        }
      }
    });
  });
});



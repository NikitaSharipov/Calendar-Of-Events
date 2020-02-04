$(document).on('turbolinks:load', function(){
  $('.simple-calendar').on('click', '.delete-event-link', function(e) {
    neededDivClass = $(this).parents().eq(0)[0].className
    console.log($('.' + neededDivClass));
    $('.' + neededDivClass).hide()
  })
});


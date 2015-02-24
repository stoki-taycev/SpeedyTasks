$(function(){

  var formPadHeight = 210;
  var formPadFadeIn = 800;
  var formPadFadeOut = 400;

  var formDelay = 400;
  var formFadeIn = 800;
  var formFadeOut = 200;


  // New Task Form Animation

  $("#newTask").on("click", function(){
    var formPad = $("#newTaskFormPad");
    if (formPad.height() === 0) {
      $(formPad).animate({
        "height": formPadHeight + "px",
      }, formPadFadeIn);
      setTimeout( function() {
        $("#newTaskForm").fadeToggle(formFadeIn);
      }, formDelay);

    } else if (formPad.height() === formPadHeight) {
      $("#newTaskForm").fadeToggle(formFadeOut);
      $(formPad).animate({
        "height": "0px",
      }, formPadFadeOut);
    }
  });

});
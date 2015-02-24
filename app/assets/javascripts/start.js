$(function(){

  // Login Popover with Bootstrap

    $("#logInButton").popover({
      html: true,
      trigger: "click",
      placement: "auto",
      animation: "true",
      content: function(){
        return $(this).parents().find("#logInForm").html();
      }
    });

});
$(document).ready(function(){ 
	removeFlashMessage();
})


function removeFlashMessage() {
  if($('.js-flash-msg').length > 0){
    setTimeout(function() { 
      $('.js-flash-msg').remove();
    }, 3000);

  }
}

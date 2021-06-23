

$(document).ready(function(){
var smoothScroll = function(clickThis, goTo, speed){
		$('body').on('click', clickThis, function(){

			$('html, body').animate({
				scrollTop: $(goTo).offset().top
			}, speed);
			return false;
		});
	};


	

	smoothScroll('a.submission', '#sub-form-section', 500);

})

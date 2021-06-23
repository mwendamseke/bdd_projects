$(document).ready(function(){
	(function() {


	var triggerBttn = document.getElementById( 'trigger-overlay' ),
		overlay = document.querySelector( 'div.overlay' ),
		closeBttn = overlay.querySelector( 'button.overlay-close' );
		transEndEventNames = {
			'WebkitTransition': 'webkitTransitionEnd',
			'MozTransition': 'transitionend',
			'OTransition': 'oTransitionEnd',
			'msTransition': 'MSTransitionEnd',
			'transition': 'transitionend'
		},
		transEndEventName = transEndEventNames[ Modernizr.prefixed( 'transition' ) ],
		support = { transitions : Modernizr.csstransitions };

	function toggleOverlay() {
		if( $(overlay).hasClass('open') ) {
			console.log('abc');
			$(overlay).removeClass('open');
			// classie.remove( overlay, 'open' );
			// // classie.add( overlay, 'close' );
			// var onEndTransitionFn = function( ev ) {
			// 	console.log('abc')
			// 	// console.log('abc')
			// 	if( support.transitions ) {
			// 		if( ev.propertyName !== 'visibility' ) return;
			// 		this.removeEventListener( transEndEventName, onEndTransitionFn );
			// 	}
			// 	classie.remove( overlay, 'close' );
			// };
			// if( support.transitions ) {
			// 	overlay.addEventListener( transEndEventName, onEndTransitionFn );
			// }
			// else {
			// 	onEndTransitionFn();
			// }
		}
		else {
			console.log('def');

			$(overlay).addClass('open');
			
		}
	}

	console.log(triggerBttn)

	triggerBttn.addEventListener( 'click', toggleOverlay );
	closeBttn.addEventListener( 'click', toggleOverlay );
})();
	
})


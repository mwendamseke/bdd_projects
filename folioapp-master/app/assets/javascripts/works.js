$(document).ready(function(){
	$('div.texteditor').focus().click();
	$('form.work-form').focus().click();
	$('div.collection-display').focus().click();

	$('textarea').on('keyup', function() {
			var o = $(this)[0];
	    o.style.height = "1px";
	    o.style.height = (25+o.scrollHeight)+"px";
	});
});


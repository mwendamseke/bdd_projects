/*
	Adds a fieldset to help people enter common OpenID services they may not know about.
*/


(function() {
	var addEvent = function() {
	
	  if (window.addEventListener) {
	    return function(el, type, fn) {
	      el.addEventListener(type, fn, false);
	    };
	  } else if (window.attachEvent) {
	    return function(el, type, fn) {
	      var f = function() {
	        fn.call(el, window.event);
	      };
	      el.attachEvent('on' + type, f);
	    };
	  }
	}();
	
	var openIdProviders = {
		"Wordpress": "http://<username>.wordpress.com",
		"Blogger": "http://<username>.blogger.com",
		"Flickr": "http://www.flickr.com/photos/<username>",
		"Technorati": "http://technorati.com/people/technorati/<username>",
		"AOL": "http://openid.aol.com/<username>",
		"Live Journal": "http://<username>.livejournal.com"
	}
	
	var openIdProviderNames = [];
	for (var s in openIdProviders) {
		openIdProviderNames.push(s);
	}
	
	var icoForService = function(serviceName) {
	  return "/images/openid-logos/id-" + serviceName.toLowerCase().replace(/ +/,"") + ".ico"
	}

	var	explanationParagraph = function() {
		var p = document.createElement("p");
		
		var providerNames = [];
		for (var providerName in openIdProviders) {
			providerNames.push(providerName);
		}
		
		var providersInSentenceForm = "";
		for (var i=0; i < providerNames.length; i=i+1) {
			if (i == 0) {
				providersInSentenceForm = providersInSentenceForm + providerNames[i];
			} else if (i == (providerNames.length - 1)) {
				providersInSentenceForm = providersInSentenceForm + " or " + providerNames[i];
			} else {
				providersInSentenceForm = providersInSentenceForm + ", " + providerNames[i];
			}
		}
		
		p.innerHTML = 'If you use ' + providersInSentenceForm + ' you probably already have an OpenID and you didn&rsquo;t even know it. (Unfortunately, that list does not include Blogger accounts at Blogspot domains, but you can use your blogspot.com URL directly in the \"My own OpenID URL\" field.)<br><br>If you want to register your own, see <a href="http://openid.net/get/">openid.net</a> for a list of reputable OpenID providers. Or just sign in with one you&rsquo;ve already got!'
		p.className = "explanation";
		return p;
	}
			
	/*
		Replaces the OpenID URL input with some helpers for constructing OpenID
    URLs for common services.

		The input is replaced with something like:
			<span class="contruct-openid">
				<input class="hidden" type="hidden" value="http://ablog.wordpress.com" />
				<span class="service-images">
					<a onclick=".."><img src="https://www.blogger.com/img/openid-inputicon.gif" width="16" height="16" /></a>
					<a onclick=".."><img src="https://www.blogger.com/img/openid-inputicon.gif" width="16" height="16" /></a>
					<!- ... ->
				</ul>
				<select>
					<option>Wordpress</option>
					<option>...</option>
				</select>
				<label>
				  <span>Your OpenID URL</span>
				  <input class="text" type="text" value="ablog" />
				</label>
				<em class="preview">http://ablog.wordpress.com</em>
			</span>
			
		A paragraph is also placed as the first child of the containing form:
			<p class="explanation">If you use WordPress...</p>
	*/
	var initOpenIDHelper = function(urlInput) {
		var form = urlInput;
		while (form.tagName != "FORM") {
			form = form.parentNode;
		}
		form.id = "login";

		form.insertBefore(explanationParagraph(), form.firstChild);
		
		var surroundingSpan = document.createElement("span");
		surroundingSpan.className = "construct-openid";
		
		var hiddenUrlInput = document.createElement("input");
		hiddenUrlInput.type = "hidden";
		hiddenUrlInput.className = "hidden";
		hiddenUrlInput.name = urlInput.name;
		hiddenUrlInput.value = urlInput.value;
		surroundingSpan.appendChild(hiddenUrlInput);
		
		var service = document.createElement("select");

		var serviceImagesSpan = document.createElement("span");
		serviceImagesSpan.className = "service-images";
		for (var i=0; i < openIdProviderNames.length; i=i+1) {
			var a  = document.createElement("a");
			var img = document.createElement("img");
			img.src = icoForService(openIdProviderNames[i]);
			img.width = "16";
			img.height = "16";
			img.alt = openIdProviderNames[i];
			img.href = "#";
			img.serviceIndex = i;
			a.appendChild(img);
			addEvent(a, "click", function(event) {
				var event = (event) ? event : ((window.event) ? window.event : null);
				if (event) {
					service.selectedIndex = event.target.serviceIndex + 1;
					updateUrl();
				}
			});
			serviceImagesSpan.appendChild(a);
		}
		surroundingSpan.appendChild(serviceImagesSpan);
		
		surroundingSpan.appendChild(service);
		
		var option = document.createElement("option");
		option.value = "";
		option.appendChild(document.createTextNode("My own OpenID URL"));
		service.appendChild(option);
		
		var optGroup = document.createElement("optgroup");
		optGroup.label = "Account with an OpenID Enabled Service";
		
		for (var serviceName in openIdProviders) {
			var option = document.createElement("option");
			option.value = serviceName;
			option.appendChild(document.createTextNode(serviceName));
			optGroup.appendChild(option);
		}
		
		service.appendChild(optGroup);
		
		var inputLabel = document.createElement("label");
		var inputSpan = document.createElement("span");
		var inputLabelText = document.createTextNode("Enter your OpenID URL");
		inputSpan.appendChild(inputLabelText);
		inputLabel.appendChild(inputSpan);
		surroundingSpan.appendChild(inputLabel);
		
		var newInput = document.createElement("input");
		newInput.type = "text";
		newInput.className = "text";
		newInput.value = "";
		inputLabel.appendChild(newInput);

		var previewEm = document.createElement("em");
		previewEm.style.className = "preview";
		previewEm.style.display = "none";
		surroundingSpan.appendChild(previewEm);

		var updateUrl = function() {
			if (service.value == "") {
				hiddenUrlInput.value = newInput.value;
				previewEm.style.display = "none";
				inputLabelText.data = "Enter your address "
			} else {
				var urlTemplate = openIdProviders[service.value];
				if (newInput.value == "") {
					var replaceUsername = "<strong>(username)</strong>";
				} else {
					var replaceUsername = newInput.value;
				}
				hiddenUrlInput.value = urlTemplate.replace("<username>", replaceUsername);
				previewEm.innerHTML = hiddenUrlInput.value;
				previewEm.style.display = "block";
				inputLabelText.data = "Enter your username "
			}
		}
		
		addEvent(newInput, "keyup", updateUrl);
		addEvent(service, "change", updateUrl);
		
		urlInput.parentNode.replaceChild(surroundingSpan, urlInput);
		$("#labeltext").remove();
	}
	
	// An input field is an OpenID URL if it has the id or a class name "openid_url"
	var isOpenIdUrlInput = function(input) {
		return input.id == "openid_url" ||
					   input.className && input.className.match(/(^| )openid_url( |$)/)
	}
		
	addEvent(window, 'load', function() {
		// making sexy unobtrusive CSS possible since 2006
		document.body.className = (document.body.className +' '||'') + 'js';
		
		var inputs = document.getElementsByTagName("input");
		for (var i = 0; i<inputs.length; i=i+1) {
			if (isOpenIdUrlInput(inputs[i])) initOpenIDHelper(inputs[i]);
		}
	})
})();
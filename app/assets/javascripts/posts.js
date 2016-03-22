


var loadFIle = function(event) {
	var output = document.getElementById('image-preview');
	output.src = URL.createobjectURL(event.target.files[0]);
};
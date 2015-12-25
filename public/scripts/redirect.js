var red = setTimeout(function() {redirect()}, 2000);

function redirect() {
	clearTimeout(red);
	window.location.replace("../../views/login");
}
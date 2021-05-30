function load_content(path) {
	fetch(path, { mode: "no-cors", }).then(async function(response) {
	  if(response.ok) {
		document.getElementsByTagName("main")[0].innerHTML = await response.text();
	  } else {
	    console.log('Net OK but HTTP Error');
	  }
	})
	.catch(function(error) {
	  console.log('Request Fetch error:' + error.message);
	});
}

/* First action: Load main page*/
load_content("static/html/main.html");

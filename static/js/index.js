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

/* Set events listeners */
document.querySelector("header .logo")
.addEventListener('click', event => {
	load_content("static/html/main.html");
});

document.querySelector("header #integration")
.addEventListener('click', () => {
	load_content("static/html/integrations.html");
});

document.querySelector("header #erp-odoo")
.addEventListener('click', () => {
	load_content("static/html/erp_odoo.html");
});

document.querySelector("header #apps")
.addEventListener('click', () => {
	load_content("static/html/apps.html");
});

document.querySelectorAll("header .contact-us")
.forEach(item => {
	item.addEventListener('click', () => {
		load_content("static/html/contactus.html");
	});
});

/* First action: Load main page*/
load_content("static/html/main.html");


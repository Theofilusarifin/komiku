var $$ = Dom7;
var root = "http://localhost/hmp/uts/";

var device = Framework7.getDevice();
var app = new Framework7({
	name: "komiku", // App name
	theme: "auto", // Automatic theme detection
	el: "#app", // App root element

	id: "io.framework7.myapp", // App bundle ID
	// App store
	store: store,
	// App routes
	routes: routes,

	// Input settings
	input: {
		scrollIntoViewOnFocus: device.cordova && !device.electron,
		scrollIntoViewCentered: device.cordova && !device.electron,
	},
	// Cordova Statusbar settings
	statusbar: {
		iosOverlaysWebView: true,
		androidOverlaysWebView: false,
	},
	on: {
		init: function () {
			var f7 = this;
			if (f7.device.cordova) {
				// Init cordova APIs (see cordova-app.js)
				cordovaApp.init(f7);
			}

			$$(document).on("page:afterin", (e, page) => {
				if (page.name != "register" || page.name != "login") {
					// Appen Panel Menu
					$$("#panel_menu").html(`
					<ul style="background-color: #161d31">
						<li class="montserrat-regular" style="height: 50px"><a href="/" class="link panel-close" style="color: #fff">Home</a></li>
						<li class="montserrat-regular" style="height: 50px"><a href="/genre" class="link panel-close" style="color: #fff">Genres</a></li>
						<li class="montserrat-regular" style="height: 50px"><a href="/completed" class="link panel-close" style="color: #fff">Completed</a></li>
						<li class="montserrat-regular" style="height: 50px"><a href="/random" class="link panel-close" style="color: #fff">Random</a></li>
						<li class="montserrat-regular" style="height: 50px"><a class="link external" href="https://www.linkedin.com/in/theofilusarifin/" target="_blank" style="color: #fff">Developer</a></li>
					</ul>`);

					// Authentication
					if (localStorage.email) {
						$$("#auth-container").html(`
							<div class="row no-gap display-flex justify-content-center" style="margin: 20px 0px 0px 0px">
								<img src="assets/logo/account.png" class="col-100" style="border-radius: 50%; max-height: 40px; width: auto" alt="Avatar" />
								<p class="col-100 montserrat-regular" style="text-align: center; color: white">${localStorage.username}</p>
							</div>
							<div class="row no-gap" style="margin: 0px 0px 20px 0px">
								<div class="col-50" style="padding: 0px 7px 0px 20px">
									<a href="/settings" class="montserrat-regular button button-outline button-round button-raised panel-close">Settings</a>
								</div>
								<div class="col-50" style="padding: 0px 20px 0px 7px">
									<button onclick="logout()" class="montserrat-regular button button-outline button-round button-raised panel-close">Log Out</button>
								</div>
							</div>
						`);
					} else {
						$$("#auth-container").html(`
							<div class="row no-gap" style="margin: 20px 0px 20px 0px">
								<div class="col-50" style="padding: 0px 7px 0px 20px">
									<a href="/login" class="montserrat-regular button button-outline button-round button-raised panel-close">Login</a>
								</div>
								<div class="col-50" style="padding: 0px 20px 0px 7px">
									<a href="/register" class="montserrat-regular button button-outline button-round button-raised panel-close">Register</a>
								</div>
							</div>
						`);
					}
				}
			});

			$$(document).on("page:init", (e, page) => {
				// Login page
				if (page.name == "login") {
					localStorage.removeItem("email");

					$$("#btn-login").on("click", () => {
						const email = $$("#email").val();
						const password = $$("#password").val();

						if (email == "" || password == "") {
							app.dialog.alert("Please fill out all the input!");
							return;
						}

						if (!email.includes("@")) {
							app.dialog.alert("Invalid email");
							return;
						}

						app.request.post(
							root + "login.php",
							{
								email: email,
								password: password,
							},
							data => {
								const res = JSON.parse(data);

								if (res.result == "success") {
									localStorage.email = email;
									localStorage.username = res.username;
									page.router.navigate("/");
								} else {
									app.dialog.alert(res.message);
								}
							}
						);
					});
				}
				// Register page
				else if (page.name == "register") {
					$$("#btn-register").on("click", () => {
						const email = $$("#regis-email").val();
						const password = $$("#regis-password").val();
						const username = $$("#regis-username").val();

						if (email == "" || password == "" || username == "") {
							app.dialog.alert("Please fill out all the input!");
							return;
						}

						if (!email.includes("@")) {
							app.dialog.alert("Invalid email");
							return;
						}

						if (password !== $$("#regis-confirm-password").val()) {
							app.dialog.alert("Password doesn't match");
							return;
						}

						app.request.post(
							root + "register.php",
							{
								email: email,
								password: password,
								username: username,
							},
							data => {
								const res = JSON.parse(data);

								if (res.result == "success") {
									app.dialog.alert("Registration Sucessful!");
									page.router.navigate("/login");
								} else {
									app.dialog.alert(res.message);
								}
							}
						);
					});
				}
				// Home page
				else if (page.name == "home") {
					this.request.post(root + "latestcomic.php", {}, data => {
						console.log(data);
						const res = JSON.parse(data);

						if (res.result == "success") {
							res.comics.forEach(comic => {
								displayComic(comic);
							});
						} else {
							app.dialog.alert(res.message);
						}
					});
					this.request.post(root + "popularcomic.php", {}, data => {
						console.log(data);
						const res = JSON.parse(data);

						if (res.result == "success") {
							// $$("#popular-comic").html("");
							res.comics.forEach(comic => {
								var comic_name = comic.name;
								if (comic.name.length > 20) {
									comic_name = comic.name.slice(0, 20) + "...";
								}
								$$("#popular-comic").append(`
									<div class="swiper-slide">
										<a href="/comic/${comic.id}">
											<div class="card card-index row" style="padding:0px; margin:0px;">
												<img src="${comic.url_poster}" style="border-radius: 8px" class="col-100 comic-poster" alt="" />
												<p class="col-100 montserrat-bold margin-top-half" style="color: #161d31;">${comic_name}</p>
											</div>
										</a>
									</div>
								`);
							});
						} else {
							app.dialog.alert(res.message);
						}
					});
				}
				// Search Page
				else if (page.name == "search") {
					app.request.post(root + "comic.php", {}, data => {
						console.log(data);
						const res = JSON.parse(data);

						if (res.result == "success") {
							res.comics.forEach(comic => {
								displayComic(comic);
							});
						} else {
							app.dialog.alert(res.message);
						}
					});
				}
				// Favorite Page
				else if (page.name == "bookmark") {
					if (localStorage.email) {
						app.request.post(
							root + "favorite.php",
							{
								email: localStorage.email,
							},
							data => {
								const res = JSON.parse(data);

								if (res.result == "success") {
									// Clear html first
									$$("#comic-container").html("");
									// Add each comic
									res.comics.forEach(comic => {
										displayComic(comic);
									});
								} else {
									app.dialog.alert(res.message);
								}
							}
						);
					} else {
						$$("#comic-container").html(`<h3 class="montserrat-bold;" style="margin:0; padding:0; color:#161d31;">Login to see your favorites!</h3>`);
					}
				}
				// Genre Page
				else if (page.name == "genre") {
					app.request.post(root + "genre.php", {}, data => {
						const res = JSON.parse(data);

						if (res.result == "success") {
							// Clear html first
							$$("#genre-container").html("");
							// Add each genre
							res.genres.forEach(genre => {
								$$("#genre-container").append(`
									<div class="col-33 margin-vertical">
										<a href="/genre/${genre.id}" class="col button button-fill button-round">${genre.name}</a>
									</div>`);
							});
						} else {
							app.dialog.alert(res.message);
						}
					});
				}
				// Completed Page
				else if (page.name == "completed") {
					app.request.post(root + "completedcomic.php", {}, data => {
						const res = JSON.parse(data);

						if (res.result == "success") {
							res.comics.forEach(comic => {
								displayComic(comic);
							});
						} else {
							app.dialog.alert(res.message);
						}
					});
				}

				// Detail Genre Page
				else if (page.name == "detailgenre") {
					const genreId = page.router.currentRoute.params.id;

					app.request.post(
						root + "detailgenre.php",
						{
							genreId: genreId,
						},
						data => {
							const res = JSON.parse(data);
							console.log(data);

							if (res.result == "success") {
								$$("#content").append(`
								<h2 style="margin: 0; padding: 0">${res.genre.name}</h2>
								<p style="text-align: justify; text-justify: inter-word">
									${res.genre.description}
								</p>
							`);
								res.comics.forEach(comic => {
									displayComic(comic);
								});
							} else {
								app.dialog.alert(res.message);
							}
						}
					);
				}
				// Detail Comic Page
				else if (page.name == "detailcomic") {
					const comicId = page.router.currentRoute.params.id;

					app.request.post(
						root + "detailcomic.php",
						{
							comicId: comicId,
						},
						data => {
							const res = JSON.parse(data);

							if (res.result == "success") {
								// res.comics.forEach(comic => {
								// 	displayComic(comic);
								// });
							} else {
								app.dialog.alert(res.message);
							}
						}
					);
				}
			});
		},
	},
});

const logout = () => {
	localStorage.removeItem("email");
	localStorage.removeItem("username");
	location.reload();
};

const displayComic = comic => {
	var today = new Date();
	var latest_update = new Date(comic.latest_update);
	var diffMins = Math.abs(Math.round((((latest_update - today) % 86400000) % 3600000) / 60000));

	$$("#comic-container").append(`
									<div class="col-50 margin-bottom">
										<a href="/comic/${comic.id}">
											<div class="row no-gap">
												<div class="col-100">
													<img src="${comic.url_poster}" style="border-radius: 8px" class="comic-poster-big" alt="" />
												</div>
												<div class="col-100 display-flex align-items-flex-start margin-top-half" style="min-height: 50px;">
													<p class="montserrat-bold" style="margin: 0; color: #161d31">${comic.name}</p>
												</div>
											</div>
											<div class="row display-flex justify-content-space-between enter">
												<div class="col-50">
													<button class="button button-small button-round button-fill montserrat-medium" style="font-size: 9px; width: max-content">Chapter ${comic.comic_chapter}</button>
												</div>
												<div class="col-50">
													<p class="montserrat-medium" style="font-size: 9px; color: #161d31">${diffMins} Minutes Ago</p>
												</div>
											</div>
										</a>
									</div>`);
};

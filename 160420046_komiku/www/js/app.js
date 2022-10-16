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
								// Add Title
								$$("#comic-title").html(`
									<h2 class="montserrat-medium col-100">${res.comic.name}</h2>
								`);
								// Add Poster
								$$("#comic-poster").html(`
									<img src="${res.comic.url_poster}" style="width: 90%; height: auto" alt="" />
								`);

								// Add Rating
								var banyak_rating = res.rating.banyak_rating;
								var total_rating = res.rating.total_rating;
								var avg_rating = parseFloat((total_rating / banyak_rating).toFixed(2));
								var floor_rating = Math.floor(avg_rating);
								$$("#star" + floor_rating).attr("checked", true);
								str_rating = "";
								detail_rating = "";

								if (total_rating > 0) {
									str_rating = avg_rating + " / 5 <br/>of " + banyak_rating + " Vote";
									detail_rating = avg_rating + " / 5 of " + banyak_rating + " Vote";
								} else {
									detail_rating = str_rating = "Unrated";
								}
								$$("#total_rating").html(`
									${str_rating}
								`);
								// Add Details
								var genre_arr = [];
								for (var i in res.genres) {
									genre_arr.push(res.genres[i].name);
								}
								let genre_str = genre_arr.join(", ");
								$$("#comic_detail").html(`
									<h4 class="montserrat-medium" style="color: #161d31; margin-bottom: 5px">Rating</h4>
									<p style="margin-top: 0px; font-size: 12px" class="montserrat-regular">${detail_rating}</p>

									<h4 class="montserrat-medium" style="color: #161d31; margin-bottom: 5px">Author</h4>
									<p style="margin-top: 0px; font-size: 12px" class="montserrat-regular">${res.comic.author}</p>

									<h4 class="montserrat-medium" style="color: #161d31; margin-bottom: 5px">View</h4>
									<p style="margin-top: 0px; font-size: 12px" class="montserrat-regular">${res.comic.total_view}</p>

									<h4 class="montserrat-medium" style="color: #161d31; margin-bottom: 5px">Status</h4>
									<p style="margin-top: 0px; font-size: 12px" class="montserrat-regular">${res.comic.status}</p>

									<h4 class="montserrat-medium" style="color: #161d31; margin-bottom: 5px">Genre</h4>
									<p style="margin-top: 0px; font-size: 12px" class="montserrat-regular">${genre_str}</p>
								`);

								// Add Comment
								$$("#user_comment").html(`
									<p>${res.all_comment} Comments</p>
								`);

								// Add Favorite
								$$("#user_favorite").html(`
									<p style="text-align: center" >
										${res.favorite.total} Users <br />
										Favorited this
									</p>
								`);

								// Set Button ReadFirst and ReadLast
								$$("#button_read").html(`
									<div class="col-50 display-flex justify-content-flex-end">
											<a href="/comic/${res.comic.id}/chapter/1" class="button button-fill montserrat-bold" style="padding-top: 20px; padding-bottom: 20px; background: #7367f0; color: white; max-width: max-content; font-size: 12px">
												Read First
											</a>
									</div>
									<div class="col-50 display-flex justify-content-flex-start">
											<a href="/comic/${res.comic.id}/chapter/${res.chapters.length}" class="button button-fill montserrat-bold" style="padding-top: 20px; padding-bottom: 20px; background: #7367f0; color: white; max-width: max-content; font-size: 12px">
												Read Last
											</a>
									</div>
								`);
								// Add Summary
								$$("#comic_summary").html(res.comic.summary);

								// Add Chapter List
								var temp = `
									<tr style="height: 0px">
										<th style="width: 40%"></th>
										<th style="width: 30%"></th>
										<th style="width: 30%"></th>
									</tr>
								`;
								res.chapters.forEach(chapter => {
									temp += `
										<tr>
											<td>
												<a href="/comic/${res.comic.id}/chapter/${chapter.id}">
													<h4 style="margin: 0" class="montserrat-regular">Chapter ${chapter.number}</h4>
												</a>
											</td>
											<td>
												<p style="margin: 0; font-size: 10px" class="montserrat-regular">${chapter.total_view} Views</p>
											</td>
											<td>
												<p style="margin: 0; font-size: 10px" class="montserrat-regular">7 Days Ago</p>
											</td>
										</tr>
									`;
								});
								$$("#chapter_list").html(temp);

								// Add Comment When Button Comment Clicked
								$$("#comment_button").on("click", () => {
									const comment = $$("#comment_area").text();
									if (!localStorage.email) {
										app.dialog.alert("Login to use this feature!");
									} else if (comment == "") {
										app.dialog.alert("Please input a comment");
									} else {
										app.request.post(
											root + "/addcomment.php",
											{
												user_email: localStorage.email,
												comic_id: res.comic.id,
												comment: comment,
											},
											data => {
												const res = JSON.parse(data);

												if (res.result == "success") {
													app.dialog.alert("Comment Added Successfuly!");
												} else {
													app.dialog.alert("Comment Failed!");
												}
											}
										);
										page.router.navigate(`/comic/${res.comic.id}`);
									}
								});

								// Show Comment
								res.comments.forEach(comment => {
									comment_date = calculateDate(comment.date);
									var comment_temp = `
									<div class="row">
										<div class="col-100 margin-top">
											<div class="row no-gap">
												<div class="col-15 display-flex justify-content-center align-items-flex-start">
													<img src="assets/logo/account.png" style="border-radius: 50%; max-height: 40px; width: auto" alt="" />
												</div>
												<div class="col-85">
													<div class="card" style="margin-top: 0; background: #efeff4; box-shadow: none">
														<div class="card-content card-content-padding">
															<p class="montserrat-bold">
																${comment.username} &nbsp;
																<span class="montserrat-regular" style="font-size: 10px; font-weight: 100">${comment_date}</span>
															</p>
															<p class="montserrat-regular">
																${comment.text}
															</p>
															<div class="row">
																<div class="col-100 display-flex justify-content-flex-end">
																	<button class="button montserrat-medium" style="width: max-content" onclick="changeReply(${comment.id})">Reply</button>
																</div>
															</div>
															<div class="row display-none" id="replySection_${comment.id}">
																<div class="col-100 margin-vertical">
																	<div
																		class="text-editor text-editor-init text-editor-resizable"
																		style="margin: 0"
																		data-placeholder="Leave a Reply here..."
																		data-mode="keyboard-toolbar"
																		style="--f7-text-editor-height: 150px"
																	>
																		<div class="text-editor-content" id="replyArea_${comment.id}" contenteditable></div>
																	</div>
																</div>
																<div class="col-100 display-flex justify-content-flex-end margin-top-half">
																	<button class="button button-small button-fill montserrat-regular" style="width: max-content" onclick="addReply(${comment.id}, ${res.comic.id})">Comment</button>
																</div>
															</div>
															<div style="margin-top: 20px">
																<hr style="height: 1px; background-color: rgba(22, 29, 49, 0.3); border: none" />
															</div>
															<!-- Users Reply -->
															
															`;
									// Add Reply
									res.replies.forEach(reply => {
										if (reply.comment_id == comment.id) {
											reply_date = calculateDate(reply.date);
											comment_temp += `
											<div class="row no-gap">
												<div class="col-15 display-flex justify-content-flex-start margin-top">
													<img src="assets/logo/account.png" style="border-radius: 50%; max-height: 35px; width: auto" alt="" />
												</div>
												<div class="col-85">
													<div class="card" style="margin-top: 0; margin-bottom: 0; background: #efeff4; box-shadow: none">
														<div class="card-content card-content-padding" style="padding-bottom: 0">
															<p class="montserrat-bold" style="margin: 0">${reply.username}</p>
															<p class="montserrat-regular" style="font-size: 10px; font-weight: 100; margin: 0">${reply_date}</p>
															<p class="montserrat-regular margin-top-half">${reply.text}</p>
														</div>
													</div>
												</div>
											</div>
											`;
										}
									});

									comment_temp += `<!-- End OF Users Reply -->
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>`;

									$$("#comment_detail").append(comment_temp);
								});
							} else {
								app.dialog.alert(res.message);
							}
						}
					);
				}

				// Detail Chapter Page
				else if (page.name == "detailchapter") {
					const comic_id = page.router.currentRoute.params.id;
					const chapter_id = page.router.currentRoute.params.chapter;

					app.request.post(
						root + "detailchapter.php",
						{
							comic_id,
							chapter_id,
						},
						data => {
							const res = JSON.parse(data);

							if (res.result == "success") {
								// Add Title
								$$("#comic_title").html(`
									<h2 class="montserrat-medium col-100">${res.comic.name} - Chapter ${chapter_id}</h2>
								`);

								// Add Navigation Tools
								var nav_temp = ``;
								nav_temp += `
								<div class="col-50 display-flex justify-content-flex-start">
                                    <a href="/" class="tab-link">
                                        <button class="col button button-fill padding margin-right-half">
                                            <i class="f7-icons" style="font-size: 16px">house_fill</i>
                                        </button>
                                    </a>
                                    <a href="/comic/${res.comic.id}" class="tab-link">
                                        <button class="col button button-fill padding">
                                            <i class="f7-icons" style="font-size: 16px">info_circle_fill</i>
                                        </button>
                                    </a>
                                </div>
								<div class="col-50 display-flex justify-content-flex-end">
								`;
								if (res.chapter.number > 1) {
									nav_temp += `
									<a href="/comic/${res.comic.id}/chapter/${chapter_id * 1 - 1}" class="tab-link">
                                        <button class="col button button-fill padding-vertical margin-right-half">
                                            <i class="f7-icons" style="font-size: 16px">arrowtriangle_left_fill</i>
                                        </button>
                                    </a>
								`;
								}
								if (res.chapter.number < res.total_chapter.total) {
									nav_temp += `
									<a href="/comic/${res.comic.id}/chapter/${chapter_id * 1 + 1}" class="tab-link">
                                        <button class="col button button-fill padding-vertical margin-right-half">
                                            <i class="f7-icons" style="font-size: 16px">arrowtriangle_left_fill</i>
                                        </button>
                                    </a>
								`;
								}
								nav_temp += `</div>`;
								$$("#navigation_tools").html(nav_temp);

								// Add Page Image
								$$("#page_container").html("");
								var temp = ``;
								res.pages.forEach(page => {
									temp += `<img src="${page.img_url}" style="width: 100%; height: auto" alt="" />`;
								});
								$$("#page_container").append(temp);
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
	var release_date = calculateDate(comic.latest_update);

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
													<p class="montserrat-medium" style="font-size: 9px; color: #161d31">${release_date}</p>
												</div>
											</div>
										</a>
									</div>`);
};

const calculateDate = date => {
	var today = new Date();
	var comic_date = new Date(date);

	var diffyear = today.getFullYear() - comic_date.getFullYear();
	if (diffyear > 0) return diffyear + " years ago";

	var diffmonth = today.getMonth() - comic_date.getMonth();
	if (diffmonth > 0) return diffmonth + " months ago";

	var diffday = today.getDate() - comic_date.getDate();
	if (diffday > 0) return diffday + " days ago";

	var diffhour = today.getHours() - comic_date.getHours();
	if (diffhour > 0) return diffhour + " hours ago";

	var diffmin = today.getMinutes() - comic_date.getMinutes();
	if (diffmin > 0) return diffmin + " minutes ago";

	var diffsec = today.getSeconds() - comic_date.getSeconds();
	if (diffsec > 0) return diffsec + " seconds ago";

	return "Just released";
};

const addReply = (comment_id, comic_id) => {
	if (!localStorage.email) {
		app.dialog.alert("Login to use this feature!");
	} else {
		// console.log(replier_email);
		// console.log(comment_id);
		// console.log(localStorage.email);
		// console.log(comic_id);
		// console.log($$("#replyArea_" + comment_id).text());

		app.request.post(
			root + "addreply.php",
			{
				replier_email: localStorage.email,
				comment_id: comment_id,
				comic_id: comic_id,
				comment: $$("#replyArea_" + comment_id).text(),
			},
			data => {
				const res = JSON.parse(data);

				if (res.result == "success") {
					app.dialog.alert("Reply Added Successfuly!");
				} else {
					app.dialog.alert(res.message);
				}
			}
		);
	}
};

const changeReply = comic_id => {
	$$("#replySection_" + comic_id).toggleClass("display-none");
};
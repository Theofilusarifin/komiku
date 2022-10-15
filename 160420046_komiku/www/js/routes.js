var routes = [
	// Toolbar
	{
		path: "/",
		url: "./index.html",
	},
	{
		path: "/search",
		url: "./search.html",
	},
	{
		path: "/bookmarked",
		url: "./bookmark.html",
	},

	// Auth
	{
		path: "/login",
		url: "./login.html",
	},
	{
		path: "/register",
		url: "./register.html",
	},

	// Panel
	{
		path: "/setting",
		url: "./setting.html",
	},
	{
		path: "/genre",
		url: "./genre.html",
	},
	{
		path: "/completed",
		url: "./completed.html",
	},
	{
		path: "/random",
		url: "./random.html",
	},

	// Detail
	{
		path: "/genre/:id",
		url: "./detailgenre.html",
	},
	{
		path: "/comic/:id",
		url: "./detailcomic.html",
	},
	{
		path: "/comic/:id/chapter/:chapter",
		url: "./detailchapter.html",
	},
];

return {
	s({ trig = "html5", dscr = "HTML5 Boilerplate" }, {
		t("<!DOCTYPE html>"),
		t('<html lang="en">'),
		t("<head>"),
		t('\t<meta charset="UTF-8">'),
		t('\t<meta name="viewport" content="width=device-width, initial-scale=1.0">'),
		t("\t<title>"),
		i(1, "Document"),
		t("</title>"),
		t("</head>"),
		t("<body>"),
		t("\t"),
		i(0),
		t("</body>"),
		t("</html>"),
	}),
}, {
	s({ trig = "div", dscr = "Div element" }, {
		t("<div>"),
		i(1),
		t("</div>"),
	}),
}

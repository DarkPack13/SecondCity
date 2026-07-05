// useful proc to announce events as endposts
/proc/endpost_announce(body, author = "SF Chronicle Nightly")
	UNTYPED_LIST_ADD(SSphones.endpost_posts, list(
		"body" = body,
		"date" = server_timestamp("Day, Month DD, "),
		"time" = server_timestamp("hh:mm", ic_time = TRUE),
		"author" = author,
		//"thumbsup_voters" = list(),
		//"thumbsdown_voters" = list(),
	))

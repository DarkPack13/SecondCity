// useful proc to announce events as endposts
/proc/endpost_announce(body, author = "SF Chronicle Nightly")
	UNTYPED_LIST_ADD(SSphones.endpost_posts, list(
		"body" = body,
		"date" = station_time_timestamp("Day, Month DD, ") + "[CURRENT_STATION_YEAR]",
		"time" = station_time_timestamp("hh:mm"),
		"author" = author,
		//"thumbsup_voters" = list(),
		//"thumbsdown_voters" = list(),
	))

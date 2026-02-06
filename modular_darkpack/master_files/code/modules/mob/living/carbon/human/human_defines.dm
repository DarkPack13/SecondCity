/mob/living/carbon/human
	// NPC humans get the area of effect, player humans dont.
	var/violation_aoe = FALSE
	/// List of ownership types the player has claimed keys for (e.g., "apartment", "car")
	var/list/received_ownership_keys = list()
	// Visible adjectives, used for Guestbooks.
	var/visible_adjective = ""

	// Humans have a default bloodpool of 10
	maxbloodpool = 10
	bloodpool = 10

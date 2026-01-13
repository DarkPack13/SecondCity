/mob/living/carbon/human
	// NPC humans get the area of effect, player humans dont.
	var/violation_aoe = FALSE
	var/received_apartment_key = FALSE // i despise this but i suppose we need to make sure players get one apartment only.
	// Visible adjectives, used for Guestbooks.
	var/visible_adjective = ""

	// Humans have a default bloodpool of 10
	maxbloodpool = 10
	bloodpool = 10

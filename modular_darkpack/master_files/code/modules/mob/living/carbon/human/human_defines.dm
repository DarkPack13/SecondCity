/mob/living/carbon/human
	// NPC humans get the area of effect, player humans dont.
	var/violation_aoe = FALSE

	// Humans have a default bloodpool of 10
	maxbloodpool = 10
	bloodpool = 10

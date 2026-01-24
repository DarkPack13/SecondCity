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

	#warn doucment
	var/transformation_sound = 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/transform.ogg'
	var/transformation_size_width = 1 //Scale of sprites, used for the shapeshifting animation's end result
	var/transformation_size_height = 1

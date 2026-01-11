/mob/living/carbon/human
	// NPC humans get the area of effect, player humans dont.
	var/violation_aoe = FALSE
	var/received_apartment_key = FALSE // i despise this but i suppose we need to make sure players get one apartment only.
	// Visible adjectives, used for Guestbooks.
	var/visible_adjective = ""

	// Humans have a default bloodpool of 10
	maxbloodpool = 10
	bloodpool = 10

	#warn doucment
	var/transformation_sound = 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/transform.ogg'
	var/transformation_size_width = 1 //Scale of sprites, used for the shapeshifting animation's end result
	var/transformation_size_height = 1

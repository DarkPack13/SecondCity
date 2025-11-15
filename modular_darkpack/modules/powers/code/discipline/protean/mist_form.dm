/datum/action/cooldown/spell/shapeshift/mist
	name = "Mist Form"
	desc = "Dissipate your body and move as mist."
	//charge_max = 50
	cooldown_time = 5 SECONDS
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	shapeshift_type = /mob/living/basic/mist

/mob/living/basic/mist
	name = "mist"
	desc = "A cloud of mist."
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	icon_living = "smoke"
	alpha = 128
	mob_biotypes = MOB_ORGANIC
	density = FALSE
	// = VENTCRAWLER_ALWAYS
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	speed = -0.8
	maxHealth = 400
	health = 400
	//harm_intent_damage = 0
	melee_damage_lower = 0
	melee_damage_upper = 0
	//a_intent = INTENT_HELP
	//dextrous = FALSE
	//possible_a_intents = list(INTENT_HELP)


/mob/living/basic/mist/Move(NewLoc, direct)
	. = ..()
	var/obj/structure/vampdoor/V = locate() in NewLoc
	if(V)
		if(V.lockpick_difficulty <= 10)
			forceMove(get_turf(V))

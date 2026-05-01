/datum/action/cooldown/spell/shapeshift/gangrel/mist
	name = "Mist Form"
	desc = "Dissipate your body and move as mist."
	possible_shapes = list(/mob/living/basic/mist)

/mob/living/basic/mist
	name = "mist"
	desc = "A cloud of mist."
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	icon_living = "smoke"
	alpha = 128
	mob_biotypes = MOB_ORGANIC
	density = FALSE
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	mob_size = MOB_SIZE_TINY
	speed = -0.2
	maxHealth = 400
	health = 400
	melee_damage_lower = 0
	melee_damage_upper = 0

/mob/living/basic/mist/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)
	AddElement(/datum/element/simple_flying)

/mob/living/basic/mist/Move(NewLoc, direct)
	. = ..()
	var/obj/structure/vampdoor/V = locate() in NewLoc
	if(V)
		if(V.lockpick_difficulty <= 10)
			forceMove(get_turf(V))

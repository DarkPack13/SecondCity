/mob/living/basic/avatar
	name = "ghost"
	desc = "A malevolent spirit."
	icon = 'icons/mob/simple/mob.dmi'
	icon_state = "ghost"
	mob_biotypes = MOB_SPIRIT
	incorporeal_move = INCORPOREAL_MOVE_AVATAR
	invisibility = INVISIBILITY_REVENANT
	see_invisible = INVISIBILITY_REVENANT
	health = INFINITY // You cant kill a ghost
	maxHealth = INFINITY
	plane = GHOST_PLANE
	sight = SEE_SELF
	throwforce = 0

	friendly_verb_continuous = "touches"
	friendly_verb_simple = "touch"
	response_help_continuous = "passes through"
	response_help_simple = "pass through"
	response_disarm_continuous = "swings through"
	response_disarm_simple = "swing through"
	response_harm_continuous = "punches through"
	response_harm_simple = "punch through"
	unsuitable_atmos_damage = 0
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 0, STAMINA = 0, OXY = 0)
	habitable_atmos = null
	minimum_survivable_temperature = 0
	maximum_survivable_temperature = INFINITY

	status_flags = NONE
	density = FALSE
	move_resist = MOVE_FORCE_OVERPOWERING
	mob_size = MOB_SIZE_TINY
	movement_type = GROUND | FLYING
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB
	speed = 1
	hud_type = /datum/hud/avatar

/mob/living/basic/avatar/Initialize(mapload)
	. = ..()

	var/mob/body = loc
	if(ismob(body))
		gender = body.gender
		if(body.mind && body.mind.name)
			name = body.mind.ghostname || body.mind.name
		else
			name = body.real_name || generate_random_mob_name(gender)


		mind = body.mind //we don't transfer the mind but we keep a reference to it.

		if(HAS_TRAIT_FROM_ONLY(body, TRAIT_SUICIDED, REF(body))) // transfer if the body was killed due to suicide
			ADD_TRAIT(src, TRAIT_SUICIDED, REF(body))

	abstract_move(get_turf(body))

	AddElement(/datum/element/movetype_handler)

	ADD_TRAIT(src, TRAIT_HEAR_THROUGH_DARKNESS, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_GOOD_HEARING, INNATE_TRAIT)

//We don't want to update the current var
//But we will still carry a mind.
/mob/living/basic/avatar/mind_initialize()
	return

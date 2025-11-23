/mob/living/basic/avatar
	name = "revenant"
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

	//These variables store hair data if the ghost originates from a species with head and/or facial hair.
	var/hairstyle
	var/hair_color
	var/mutable_appearance/hair_overlay
	var/facial_hairstyle
	var/facial_hair_color
	var/mutable_appearance/facial_hair_overlay
	var/image/ghostimage_default = null //this mobs ghost image without accessories and dirs

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

		if(ishuman(body))
			var/mob/living/carbon/human/body_human = body
			var/datum/species/human_species = body_human.dna.species
			if(human_species.check_head_flags(HEAD_HAIR))
				hairstyle = body_human.hairstyle
				hair_color = ghostify_color(body_human.hair_color)
			if(human_species.check_head_flags(HEAD_FACIAL_HAIR))
				facial_hairstyle = body_human.facial_hairstyle
				facial_hair_color = ghostify_color(body_human.facial_hair_color)

	//To prevent nameless ghosts
	name ||= generate_random_mob_name(FALSE)
	real_name = name

	update_appearance()

	abstract_move(get_turf(body))

	AddElement(/datum/element/movetype_handler)

	SSpoints_of_interest.make_point_of_interest(src)
	ADD_TRAIT(src, TRAIT_HEAR_THROUGH_DARKNESS, INNATE_TRAIT)
	ADD_TRAIT(src, TRAIT_GOOD_HEARING, INNATE_TRAIT)

/mob/living/basic/avatar/Destroy()
	SSpoints_of_interest.remove_point_of_interest(src)
	return ..()

//We don't want to update the current var
//But we will still carry a mind.
/mob/living/basic/avatar/mind_initialize()
	return

/*
 * This proc will update the icon of the ghost itself, with hair overlays, as well as the ghost image.
 * Please call update_icon(updates, icon_state) from now on when you want to update the icon_state of the ghost,
 * or you might end up with hair on a sprite that's not supposed to get it.
 * Hair will always update its dir, so if your sprite has no dirs the haircut will go all over the place.
 * |- Ricotez
 */
/mob/living/basic/avatar/update_icon(updates=ALL, new_form)
	. = ..()

	if(hair_overlay)
		cut_overlay(hair_overlay)
		hair_overlay = null

	if(facial_hair_overlay)
		cut_overlay(facial_hair_overlay)
		facial_hair_overlay = null


	if(new_form)
		icon_state = new_form
		if(icon_state in GLOB.ghost_forms_with_directions_list)
			ghostimage_default.icon_state = new_form + "_nodir" //if this icon has dirs, the default ghostimage must use its nodir version or clients with the preference set to default sprites only will see the dirs
		else
			ghostimage_default.icon_state = new_form

	if(facial_hairstyle)
		var/datum/sprite_accessory/S = SSaccessories.facial_hairstyles_list[facial_hairstyle]
		if(S)
			facial_hair_overlay = mutable_appearance(S.icon, "[S.icon_state]", -HAIR_LAYER)
			if(facial_hair_color)
				facial_hair_overlay.color = facial_hair_color
			facial_hair_overlay.alpha = 200
			add_overlay(facial_hair_overlay)
	if(hairstyle)
		var/datum/sprite_accessory/hair/S = SSaccessories.hairstyles_list[hairstyle]
		if(S)
			hair_overlay = mutable_appearance(S.icon, "[S.icon_state]", -HAIR_LAYER)
			if(hair_color)
				hair_overlay.color = hair_color
			hair_overlay.alpha = 200
			hair_overlay.pixel_z = S.y_offset
			add_overlay(hair_overlay)

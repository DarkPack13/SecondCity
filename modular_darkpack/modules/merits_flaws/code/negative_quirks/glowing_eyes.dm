// VTM pg. 482
/datum/quirk/darkpack/glowing_eyes
	name = "Glowing Eyes"
	desc = {"You have the stereotypical glowing eyes of vampire legend, giving you a -1 difficulty when intimidating some mortals.
However, you MUST constantly disguise your condition in the dark, and the glow impairs your vision."}
	icon = FA_ICON_EYE
	value = -3
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_PROCESSES
	gain_text = span_notice("Your eyes glow with unnatural light in the dark.")
	lose_text = span_notice("The light in your eyes fades.")
	failure_message = span_notice("The light in your eyes fades.")
	mob_trait = TRAIT_GLOWING_EYES
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_KIASYD)// They already have masq violating eyes!
	var/glow_color

/*You have the stereotypical glowing eyes of vampire
legend, which gives you a -1 difficulty on Intimidation
rolls when you’re dealing with mortals. However, the
tradeoffs are many; you must constantly disguise your
condition (no, contacts don’t cut it); the glow impairs
your vision and puts you at +1 difficulty on all sight
based rolls (including the use of ranged weapons); and
the radiance emanating from your eye sockets makes
it difficult to hide (+2 difficulty to Stealth rolls) in the
dark.*/

/datum/quirk/darkpack/glowing_eyes/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	ADD_TRAIT(quirk_holder, TRAIT_LUMINESCENT_EYES, QUIRK_TRAIT)
	human_holder.st_add_stat_mod(STAT_PERCEPTION, -1, "Glowing Eyes")
	var/obj/item/organ/eyes/eyes_organ = human_holder.get_organ_slot(ORGAN_SLOT_EYES)
	glow_color = eyes_organ?.eye_color_left
	var/obj/item/clothing/glasses/vampire/sun/new_glasses = new(human_holder.loc) // Give them glasses so they aren't immediately breaching on spawn or anything
	human_holder.equip_to_appropriate_slot(new_glasses, TRUE)
	RegisterSignal(quirk_holder, COMSIG_MOVABLE_MOVED, PROC_REF(on_holder_moved))

/datum/quirk/darkpack/glowing_eyes/remove()
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	UnregisterSignal(quirk_holder, COMSIG_MOVABLE_MOVED)
	quirk_holder.remove_status_effect(/datum/status_effect/glowing_eyes_warning, TRUE)
	quirk_holder.remove_status_effect(/datum/status_effect/glowing_eyes_full, TRUE)
	quirk_holder.remove_traits(list(TRAIT_LUMINESCENT_EYES, TRAIT_MASQUERADE_VIOLATING_EYES), QUIRK_TRAIT)
	human_holder.st_remove_stat_mod(STAT_PERCEPTION, "Glowing Eyes")

/datum/quirk/darkpack/glowing_eyes/process(seconds_per_tick)
	check_glow()

/datum/quirk/darkpack/glowing_eyes/proc/on_holder_moved(mob/living/source, atom/old_loc, dir, forced) // taken from photophobia.dm
	SIGNAL_HANDLER
	check_glow()

/datum/quirk/darkpack/glowing_eyes/proc/check_glow()
	if(quirk_holder.IsSleeping() || quirk_holder.IsUnconscious() || quirk_holder.is_eyes_covered())
		quirk_holder.remove_traits(list(TRAIT_GLOWING_EYES, TRAIT_MASQUERADE_VIOLATING_EYES), QUIRK_TRAIT)
		quirk_holder.remove_status_effect(/datum/status_effect/glowing_eyes_warning)
		quirk_holder.remove_status_effect(/datum/status_effect/glowing_eyes_full)
		return

	var/turf/holder_turf = get_turf(quirk_holder)
	var/light_amount = holder_turf.get_lumcount()
	if(light_amount < 0.2) // you can only tell someone's eyes are glowing if it's dark enough
		if(quirk_holder.has_status_effect(/datum/status_effect/glowing_eyes_full))
			quirk_holder.apply_status_effect(/datum/status_effect/glowing_eyes_full, glow_color)
		else
			quirk_holder.apply_status_effect(/datum/status_effect/glowing_eyes_warning, glow_color)
	else
		quirk_holder.remove_status_effect(/datum/status_effect/glowing_eyes_warning)
		quirk_holder.remove_status_effect(/datum/status_effect/glowing_eyes_full)

/datum/status_effect/glowing_eyes_warning
	id = "glowing_eyes_warning"
	status_type = STATUS_EFFECT_UNIQUE
	duration = STATUS_EFFECT_PERMANENT
	tick_interval = 3 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/glowing_eyes_warning
	var/glow_color
	var/escalating = FALSE

/datum/status_effect/glowing_eyes_warning/on_creation(mob/living/new_owner, set_glow_color)
	glow_color = set_glow_color
	..()
	linked_alert?.update_appearance(UPDATE_OVERLAYS)

/datum/status_effect/glowing_eyes_warning/tick(seconds_between_ticks)
	var/turf/holder_turf = get_turf(owner)
	if(owner.IsSleeping() || owner.IsUnconscious() || owner.is_eyes_covered() || holder_turf.get_lumcount() >= 0.2)
		qdel(src)
		return
	escalating = TRUE
	owner.apply_status_effect(/datum/status_effect/glowing_eyes_full, glow_color)
	qdel(src)

/atom/movable/screen/alert/status_effect/glowing_eyes_warning
	name = "Glowing Eyes"
	desc = "Your unnatural eyes are starting to catch the light in the dark. Find somewhere brighter or cover them before a mortal notices."

/atom/movable/screen/alert/status_effect/glowing_eyes_warning/update_overlays()
	. = ..()
	var/datum/status_effect/glowing_eyes_warning/effect = attached_effect
	var/mutable_appearance/glow = mutable_appearance('icons/mob/human/human_eyes.dmi', "eyes_glow_gs")
	glow.color = effect?.glow_color
	glow.transform = matrix() * 2
	glow.pixel_y = -16
	. += glow

/datum/status_effect/glowing_eyes_full
	id = "glowing_eyes_full"
	status_type = STATUS_EFFECT_REFRESH
	duration = 2 SECONDS
	tick_interval = STATUS_EFFECT_NO_TICK
	alert_type = /atom/movable/screen/alert/status_effect/glowing_eyes_full
	var/glow_color

/datum/status_effect/glowing_eyes_full/on_creation(mob/living/new_owner, eye_color)
	glow_color = eye_color
	..()
	linked_alert?.update_appearance(UPDATE_OVERLAYS)

/datum/status_effect/glowing_eyes_full/on_apply()
	owner.add_traits(list(TRAIT_GLOWING_EYES, TRAIT_MASQUERADE_VIOLATING_EYES), QUIRK_TRAIT)
	return TRUE

/datum/status_effect/glowing_eyes_full/on_remove()
	owner.remove_traits(list(TRAIT_GLOWING_EYES, TRAIT_MASQUERADE_VIOLATING_EYES), QUIRK_TRAIT)

/atom/movable/screen/alert/status_effect/glowing_eyes_full
	name = "Glowing Eyes"
	desc = "Your unnatural eyes are glowing and visible in the dark, horrifying any mortals who might see them. Wear a mask, glasses, or enter the light to hide them."

/atom/movable/screen/alert/status_effect/glowing_eyes_full/update_overlays()
	. = ..()
	var/datum/status_effect/glowing_eyes_full/effect = attached_effect
	var/mutable_appearance/glow = mutable_appearance('icons/mob/human/human_eyes.dmi', "eyes_mothglow_gs")
	glow.color = effect?.glow_color
	glow.transform = matrix() * 2
	glow.pixel_y = -16
	. += glow

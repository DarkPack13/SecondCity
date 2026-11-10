/datum/quirk/darkpack/good_old_boy_or_girl
	name = "Good old Boy (or Girl)"
	desc = {"For either gender, this merit means the same thing: You're an intrinsically
			nice person, and you genuinely care about your fellows. Depending upon the
			setting, werewolves and other Kin (both human and wolf) tend to like you
			and confide in you. Even lupus Garou may approach you in a friendly manner;
			something about you just seems trustworthy and inviting."}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 54)
	value = 2
	mob_trait = TRAIT_GOOD_OLD_BOY_OR_GIRL
	gain_text = span_notice("You feel great empathy for your kin.")
	lose_text = span_notice("Your feelings towards your kin mellow out.")
	icon = FA_ICON_HAND_HOLDING_HEART
	failure_message = "Your feelings towards your kin mellow out."
	allowed_splats = list(SPLAT_KINFOLK)
	var/datum/proximity_monitor/advanced/demoraliser/gob_og_holder_prox

// NOTE - Re-add "Take an extra die on all Social rolls involving interaction with Garou or Kinfolk." to the end if the rolls end up ingame.

/datum/quirk/darkpack/good_old_boy_or_girl/add(client/client_source)
	var/datum/demoralise_moods/good_kinfolk_application/mood_category = new()
	gob_og_holder_prox = new(quirk_holder, 3, TRUE, mood_category)


/datum/quirk/darkpack/good_old_boy_or_girl/remove(datum/quirk/darkpack/good_old_boy_or_girl/gob_og_holder_prox)
	QDEL_NULL(gob_og_holder_prox)
	return ..()


// Moodlet stuff
/datum/proximity_monitor/advanced/demoraliser
	var/mob/living/carbon/human/human_quirk_holder

/datum/proximity_monitor/advanced/demoraliser/proc/get_holder_name(datum/quirk/darkpack/quirk_holder)
	human_quirk_holder = quirk_holder

/datum/demoralise_moods/good_kinfolk_application
	mood_category = "good_kinfolk_application"
	crew_mood = /datum/mood_event/good_kinfolk

/datum/mood_event/good_kinfolk
	description = "A kinfolk I've met as of late has brought me some comfort."
	mood_change = 4
	timeout = 2 MINUTES

/datum/proximity_monitor/advanced/demoraliser/good_kinfolk/on_seen(mob/living/viewer)
	. = ..()
	if (viewer.invisibility > human_quirk_holder.see_invisible || viewer.alpha < 20)
		return FALSE
	if (!get_werewolf_splat(viewer))
		return FALSE
	if (host == human_quirk_holder)
		return FALSE
	get_holder_name()
	to_chat(viewer, span_notice("Wow! [human_quirk_holder] is pleasant to be around!"))
	viewer.add_mood_event(moods.mood_category, moods.crew_mood)
	return



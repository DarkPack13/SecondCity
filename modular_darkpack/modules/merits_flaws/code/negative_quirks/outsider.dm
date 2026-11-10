#define OUTSIDER_MOOD "outsider_mood"

/datum/quirk/darkpack/outsider
	name = "Outsider"
	desc = {"Because of false rumors, an ill-done deed or some other reason, you have a poor
			reputation among the Kinfolk and Garou. They don't necessarily hurt you, but they
			let you know you aren't welcome in their camps or homes."}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 52)
	value = -2
	mob_trait = TRAIT_OUTSIDER
	gain_text = span_notice("You are ostracized from your Kin.")
	lose_text = span_notice("You have been welcomed back by your Kin.")
	allowed_splats = list(SPLAT_KINFOLK)
	icon = FA_ICON_SQUARE_PERSON_CONFINED
	failure_message = "You have been welcomed back by your Kin."
	var/datum/proximity_monitor/advanced/demoraliser/outsider_prox
	// Negative moodlet to other Kinfolk and Garou.
	// Removes Gaia Caern Friend
	// Outsider inspect text seen by Kinfolk & Garou

// NOTE - Add "Make all Social rolls involving interaction with werewolves and Kin at +2 difficulty." if ever relevant.

/datum/quirk/darkpack/outsider/add(client/client_source)
	var/datum/demoralise_moods/outsider_application/mood_category = new()
	outsider_prox = new(quirk_holder, 3, TRUE, mood_category)
	REMOVE_TRAIT(quirk_holder, TRAIT_GAIA_CAERN_FRIEND, TRAIT_GENERIC)


/datum/quirk/darkpack/outsider/remove(datum/quirk/darkpack/outsider/outsider_prox)
	QDEL_NULL(outsider_prox)
	ADD_TRAIT(quirk_holder, TRAIT_GAIA_CAERN_FRIEND, TRAIT_GENERIC)
	return ..()


// Moodlet stuff
/datum/demoralise_moods/outsider_application
	mood_category = OUTSIDER_MOOD
	crew_mood = /datum/mood_event/outsider

/datum/mood_event/outsider
	description = "The nerve for that kinfolk to show their face here!"
	mood_change = -2
	timeout = 2 MINUTES

/datum/proximity_monitor/advanced/demoraliser/outsider/on_seen(mob/living/viewer, datum/quirk/darkpack/quirk_holder)
	. = ..()
	var/mob/living/carbon/human/human_quirk_holder = quirk_holder
	var/mob/living/carbon/human/human_viewer = viewer
	if (viewer == quirk_holder)
		return
	if (viewer.invisibility > human_quirk_holder.see_invisible || viewer.alpha < 20)
		return
	if (!get_werewolf_splat(human_viewer))
		return
	if (HAS_TRAIT(human_viewer, TRAIT_OUTSIDER))
		return
	if (human_viewer.is_tribe(TRIBE_BLACK_SPIRAL_DANCERS) || human_viewer.is_tribe(TRIBE_RONIN) || human_viewer.is_auspice(AUSPICE_NONE)) // Y'know I'm a bit of an outsider myself.
		return
	to_chat(viewer, span_notice("I've heard about the things [quirk_holder] has done... [p_they()]] should know they aren't welcome here."))
	viewer.add_mood_event(OUTSIDER_MOOD, /datum/mood_event/outsider)
	return

#undef OUTSIDER_MOOD

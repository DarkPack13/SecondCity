#define OUTSIDER_MOOD "outsider_mood"

/datum/quirk/darkpack/outsider
	name = "Outsider"
	desc = {"Because of false rumors, an ill-done deed or some other reason, you have a poor
			reputation among the Kinfolk and Fera. They don't necessarily hurt you, but they
			let you know you aren't welcome in their camps or homes."}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 52)
	value = -2
	mob_trait = TRAIT_OUTSIDER
	gain_text = span_notice("You are ostracized from your Kin.")
	lose_text = span_notice("You have been welcomed back by your Kin.")
	allowed_splats = list(SPLAT_KINFOLK)
	icon = FA_ICON_SQUARE_PERSON_CONFINED
	failure_message = "You have been welcomed back by your Kin."
	var/datum/proximity_monitor/advanced/mood_aura/werewolf_splats/outsider_holder_aura
	// Negative moodlet to other Kinfolk and Fera.
	// Removes Gaia Caern Friend
	// Outsider inspect text seen by Kinfolk & Fera

// NOTE - Add "Make all Social rolls involving interaction with werewolves and Kin at +2 difficulty." if ever relevant.

/datum/quirk/darkpack/outsider/add(client/client_source)
	var/datum/proximity_moods/outsider_application/mood_category = new()
	outsider_holder_aura = new(quirk_holder, 3, TRUE, mood_category)
	REMOVE_TRAIT(quirk_holder, TRAIT_GAIA_CAERN_FRIEND, TRAIT_GENERIC)


/datum/quirk/darkpack/outsider/remove(datum/quirk/darkpack/outsider/outsider_holder_aura)
	qdel(outsider_holder_aura)
	ADD_TRAIT(quirk_holder, TRAIT_GAIA_CAERN_FRIEND, TRAIT_GENERIC)


// Moodlet stuff //
/datum/proximity_monitor/advanced/mood_aura/werewolf_splats/outsider/on_seen(mob/living/carbon/human/viewer)
	if (HAS_TRAIT(viewer, TRAIT_OUTSIDER))
		return
	if (viewer.is_tribe(TRIBE_BLACK_SPIRAL_DANCERS) || viewer.is_tribe(TRIBE_RONIN) || viewer.is_auspice(AUSPICE_NONE)) // Y'know I'm a bit of an outsider myself.
		return
	. = ..()
	return


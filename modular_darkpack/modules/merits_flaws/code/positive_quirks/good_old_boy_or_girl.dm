/datum/quirk/darkpack/good_old_boy_or_girl
	name = "Good Old Kin"
	desc = {"You're an intrinsically nice person, and you genuinely care about
			your fellows. Depending upon the setting, Fera and other Kin
			(both human and beast) tend to like you	and confide in you.
			Even lupus Garou may approach you in a friendly manner; something
			about you just seems trustworthy and inviting."}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 53)
	value = 2
	mob_trait = TRAIT_GOOD_OLD_BOY_OR_GIRL
	gain_text = span_notice("You feel great empathy for your kin.")
	lose_text = span_notice("Your feelings towards your kin mellow out.")
	icon = FA_ICON_HAND_HOLDING_HEART
	failure_message = "Your feelings towards your kin mellow out."
	allowed_splats = list(SPLAT_KINFOLK)
	var/datum/proximity_monitor/advanced/mood_aura/werewolf_splats/good_old_boy_or_girl/gob_og_holder_aura
	// Positive moodlet nearby surrounding Kinfolk & Fera.
	// NOTE - Re-add "Take an extra die on all Social rolls involving interaction with Garou or Kinfolk." to the end if the rolls end up ingame.

/datum/quirk/darkpack/good_old_boy_or_girl/add(client/client_source)
	var/datum/proximity_moods/good_kinfolk_application/mood_category = new()
	gob_og_holder_aura = new(quirk_holder, 3, TRUE, mood_category)

/datum/quirk/darkpack/good_old_boy_or_girl/remove()
	QDEL_NULL(gob_og_holder_aura)


// Moodlet stuff //
/datum/proximity_monitor/advanced/mood_aura/werewolf_splats/good_old_boy_or_girl/on_seen(mob/living/carbon/human/viewer)
	if (HAS_TRAIT(viewer, TRAIT_GOOD_OLD_BOY_OR_GIRL))
		return
	if (viewer.is_tribe(TRIBE_RED_TALONS)) // If Lupus Kinfolk ever exist IG they can make Talons happy... Grinches of the Garou I tell you.
		return
	. = ..()

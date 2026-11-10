/datum/quirk/darkpack/gall
	name = "Gall"
	desc = {"Audacity, guts, pluck - whatever it's called, you've got it. You aren't afraid
			to stand up to anyone, from naughty children to tribal leaders. This isn't brash,
			foolhardy behavior; you're still polite, after all. You simply don't get the shakes
			when the Silver Fang Ahroun comes over to speak to you. Many respect you for your
			honesty and forthrightness. Add an extra die to any Social roll involving a display
			of backbone."}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 52)
	value = 2
	mob_trait = TRAIT_GALL
	gain_text = span_notice("You've got guts kid.")
	lose_text = span_notice("Your burning will has been smothered.")
	icon = FA_ICON_PAW
	failure_message = "Your burning will has been smothered."
	allowed_splats = list(SPLAT_KINFOLK)
	// +1 modifier to your social stats.

/datum/quirk/darkpack/gall/add(client/client_source)
	quirk_holder.st_add_stat_mod(STAT_CHARISMA, 1, TRAIT_GALL)
	quirk_holder.st_add_stat_mod(STAT_MANIPULATION, 1, TRAIT_GALL)
	quirk_holder.st_add_stat_mod(STAT_APPEARANCE, 1, TRAIT_GALL)

/datum/quirk/darkpack/gall/remove()
	quirk_holder.st_remove_stat_mod(STAT_CHARISMA, TRAIT_GALL)
	quirk_holder.st_remove_stat_mod(STAT_MANIPULATION, TRAIT_GALL)
	quirk_holder.st_remove_stat_mod(STAT_APPEARANCE, TRAIT_GALL)

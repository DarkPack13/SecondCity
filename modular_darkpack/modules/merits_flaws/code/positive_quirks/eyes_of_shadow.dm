// Lore of the Clans pg. 121
/datum/quirk/darkpack/eyes_of_shadow
	name = "Eyes of Shadow"
	desc = {"There is something about your eyes that makes you
look dark and dangerous. Making eye contact with you
is like staring into the Abyss. It may not be obvious why,
but anyone you talk to gets a chill when they meet your
gaze. The difficulty for any Intimidation roll is reduced by 2."} // since this is a 2 point merit, reduce diffs by 2.
	value = 2 // If this is changed, change desc and all roll diff changes accordingly.
	icon = FA_ICON_EYE_LOW_VISION
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_LASOMBRA)
	mob_trait = TRAIT_EYES_OF_SHADOW

/*There is something about your eyes that makes you
look dark and dangerous. Making eye contact with you
is like staring into the Abyss. It may not be obvious why,
but anyone you talk to gets a chill when they meet your
gaze. The difficulty for any Intimidation roll is reduced by
the number of points in this Merit (to a minimum of 2).*/

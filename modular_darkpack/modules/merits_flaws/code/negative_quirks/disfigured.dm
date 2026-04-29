// VTM pg. 481
/datum/quirk/darkpack/disfigured
	name = "Disfigured"
	desc = {"A hideous disfigurement makes your appearance disturbing and memorable.
	The difficulties of all die rolls relating to social interaction are increased by two.
	You may not have an Appearance rating greater than 2."}
	icon = FA_ICON_FACE_GRIMACE
	value = -2
	gain_text = span_notice("Your face is disfigured!")
	lose_text = span_notice("You feel like you look a lot better.")
	failure_message = span_notice("You don't look too bad.")
	mob_trait = TRAIT_DISFIGURED_APPEARANCE
	excluded_clans = list(VAMPIRE_CLAN_KIASYD, VAMPIRE_CLAN_GARGOYLE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_CAPPADOCIAN, VAMPIRE_CLAN_SAMEDI, VAMPIRE_CLAN_HARBINGER)
	var/appearance_to_subtract

/datum/quirk/darkpack/disfigured/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	var/mob/living/carbon/human/human_holder = new_holder
	appearance_to_subtract = human_holder.st_get_stat(STAT_APPEARANCE)-2 //5-2=3 dots removed, ect
	if(human_holder.st_get_stat(STAT_APPEARANCE) > 2)
		human_holder.st_add_stat_mod(STAT_APPEARANCE, human_holder.st_get_stat(STAT_APPEARANCE) - appearance_to_subtract, "Disfigured")// Test after the stat mod pr is in

/datum/quirk/darkpack/disfigured/remove()
	. = ..()
	quirk_holder.st_remove_stat_mod(STAT_APPEARANCE, "Disfigured")

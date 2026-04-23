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
	var/appearance_to_subtract

/datum/quirk/darkpack/disfigured/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	var/mob/living/carbon/human/human_holder = new_holder
	appearance_to_subtract = human_holder.st_get_stat(STAT_APPEARANCE)-2 //5-2=3 dots removed, ect
	if(human_holder.st_get_stat(STAT_APPEARANCE) > 2)
		human_holder.st_set_stat(STAT_APPEARANCE, human_holder.st_get_stat(STAT_APPEARANCE) - appearance_to_subtract)// I'd use add_stat_mod if it worked here.

/datum/quirk/darkpack/disfigured/post_add()
	. = ..()
	to_chat(quirk_holder, span_warning ("Your disfigurement takes a toll. Your appearance can't be raised above 2 dots!"))// Tell them why the dots are removed.
	if(appearance_to_subtract > 0)
		to_chat(quirk_holder, span_warning("Removed [appearance_to_subtract] appearance."))// Tell them how many dots we removed.

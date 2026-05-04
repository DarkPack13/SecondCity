// VTM pg. 481
/datum/quirk/darkpack/short
	name = "Short"
	desc = {"You are well below average height.
You have difficulty reaching or manipulating objects designed for normal adult size,
and your running speed is one-half that of an average human."}
	icon = FA_ICON_ARROW_DOWN
	value = -1
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_CHANGES_APPEARANCE
	gain_text = span_notice("You feel shorter than average.")
	lose_text = span_notice("You don't feel so small now.")
	failure_message = span_notice("You don't feel so small now.")
	mob_trait = TRAIT_DWARF

/*You are well below average height — four and a half feet (1.5 meters) tall or less.
You have difficulty reaching or manipulating objects designed for normal adult size,
and your running speed is one-half that of an average human.*/

/datum/movespeed_modifier/quirk_short
	multiplicative_slowdown = 2

/datum/quirk/darkpack/short/add(client/client_source)
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.add_movespeed_modifier(/datum/movespeed_modifier/quirk_short)

/datum/quirk/darkpack/short/remove()
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	human_holder.remove_movespeed_modifier(/datum/movespeed_modifier/quirk_short)

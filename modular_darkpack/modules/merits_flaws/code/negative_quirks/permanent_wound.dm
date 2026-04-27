// VTM pg. 482-483
/datum/quirk/darkpack/permanent_wound
	name = "Permanent Wound"
	desc = {"You suffered injuries during your Embrace which your transformation somehow failed to repair.
At the beginning of each night, you rise from sleep heavily wounded."}
	value = -3
	gain_text = span_notice("An unhealed wound aches.")
	lose_text = span_notice("You can't feel the pain of your wound anymore.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_USER_INJURED
	failure_message = "You can't feel the pain of your wound anymore."

/*You suffered injuries during your Embrace which your transformation somehow failed to repair.
At the beginning of each night,
you rise from sleep at the Wounded health level, though this may be healed by spending blood points.*/

/datum/quirk/darkpack/disfigured/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	var/mob/living/carbon/human/human_holder = new_holder
	human_holder.adjust_brute_loss(90, TRUE)

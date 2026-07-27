/datum/action/cooldown/power/fomori_power/walking_bomb // Freak Legion pg. 47
	name = "Walking Bomb"
	desc = "There's a bomb in your head!"
	rank = 1 // of 1

/datum/action/cooldown/power/fomori_power/walking_bomb/Grant(mob/granted_to)
	. = ..()
	var/mob/living/carbon/human/fomor = granted_to
	var/obj/item/implant/walking_bomb/imp = new
	imp.implant(fomor, fomor, TRUE, TRUE)
	Remove(fomor)

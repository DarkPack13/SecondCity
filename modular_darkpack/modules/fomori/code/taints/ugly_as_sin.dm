/datum/action/cooldown/power/fomori_power/ugly_as_sin
	name = "Ugly as Sin"
	desc = "You are horribly ugly, and your Appearance stat is locked to zero."
	rank = 1

/datum/action/cooldown/power/fomori_power/ugly_as_sin/Grant(mob/granted_to) // TODO: Find some way to prevent further appearance mods (this is a problem with all code like this)
	. = ..()
	var/mob/living/carbon/human/human_owner = astype(owner)
	var/normal_appearance = human_owner.st_get_stat(STAT_APPEARANCE)
	human_owner.st_add_stat_mod(STAT_APPEARANCE, -normal_appearance, "fomor_ugly_as_sin")
	ADD_TRAIT(owner, TRAIT_DISFIGURED_APPEARANCE, "fomor_ugly_as_sin")
	Remove(owner)

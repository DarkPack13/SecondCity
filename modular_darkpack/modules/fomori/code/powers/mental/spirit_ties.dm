/datum/action/cooldown/power/fomori_power/spirit_ties
	name = "Spirit Ties"
	desc = "You have an innate connection to the spirit world, allowing you to have a gnosis score."
	rank = 1

/datum/action/cooldown/power/fomori_power/spirit_ties/Grant(mob/granted_to) // TODO: Find some way to prevent further appearance mods (this is a problem with all code like this)
	. = ..()
	var/datum/splat/werewolf/fomori/fomor_splat = get_fomori_splat(granted_to)
	fomor_splat.uses_hud = TRUE
	fomor_splat.uses_gnosis = TRUE
	fomor_splat.permanent_gnosis = rank
	fomor_splat.adjust_gnosis(rank)
	Remove(granted_to)

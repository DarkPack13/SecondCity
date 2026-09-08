/datum/action/cooldown/power/fomori_power/berserker
	name = "Berserker"
	desc = "You have an innate rage boiling within you, not unlike the Garou."
	rank = 1
	ttrpg_sources = list(/datum/source_book/freak_legion = 30)

/datum/action/cooldown/power/fomori_power/berserker/Grant(mob/granted_to) // TODO: Find some way to prevent further appearance mods (this is a problem with all code like this)
	. = ..()
	var/datum/splat/werewolf/fomori/fomor_splat = get_fomori_splat(granted_to)
	fomor_splat.uses_hud = TRUE
	fomor_splat.uses_rage = TRUE
	fomor_splat.permanent_rage = rank
	fomor_splat.adjust_rage(rank, sound = FALSE)
	Remove(granted_to)

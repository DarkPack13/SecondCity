/datum/action/cooldown/power/fomori_power/inner_volcano
	name = "Inner Volcano"
	desc = "Strenuous activity causes your body to massively heat up, and you cool down much slower."
	rank = 1

	ttrpg_sources = list(/datum/source_book/freak_legion = 43)

/datum/action/cooldown/power/fomori_power/inner_volcano/Grant(mob/granted_to)
	. = ..()
	owner.AddComponent(/datum/component/inner_volcano)
	Remove(owner)

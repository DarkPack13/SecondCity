/datum/action/cooldown/power/fomori_power/bane_attractor // Freak Legion pg. 42
	name = "Bane Attractor"
	desc = "Your corruption is so potent that you attract banes wherever you go, giving you and those around you great misfortune."
	rank = 1

/datum/action/cooldown/power/fomori_power/bane_attractor/Grant(mob/granted_to) // shamelessly stolen from Cursed
	. = ..()
	owner.AddComponent(
		/datum/component/omen, \
		incidents_left = INFINITY, \
		luck_mod = 0.15, \
		damage_mod = 0.125, \
		bless_fixable = FALSE, \
	)
	Remove(owner)

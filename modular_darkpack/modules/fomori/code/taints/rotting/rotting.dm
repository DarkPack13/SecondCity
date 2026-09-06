/datum/action/cooldown/power/fomori_power/rotting
	name = "Rotting"
	desc = "You're slowly rotting away. Your limbs will be torn from your body if the damage inflicted by a hit excedes your stamina. This can kill you instantly."
	rank = 1

/datum/action/cooldown/power/fomori_power/rotting/Grant(mob/granted_to)
	. = ..()
	owner.AddComponent(/datum/component/rotting)
	Remove(owner)

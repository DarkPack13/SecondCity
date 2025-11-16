/datum/component/ear_damage
	var/increase_amount = 1

/datum/component/ear_damage/RegisterWithParent(increase_amount = 1)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	if(increase_amount)
		src.increase_amount = increase_amount
	RegisterSignal(parent, COMSIG_CARBON_SOUNDBANG, PROC_REF(increase_bang))

/datum/component/ear_damage/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_CARBON_SOUNDBANG)

/datum/component/ear_damage/proc/increase_bang(datum/source, list/reflist)
	reflist[1] += increase_amount

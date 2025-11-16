/datum/element/ear_damage
	var/increase_amount = 1

/datum/element/ear_damage/Attach(datum/target, increase_amount = 1)
	. = ..()
	if(!isliving(target))
		return ELEMENT_INCOMPATIBLE
	if(increase_amount)
		src.increase_amount = increase_amount
	RegisterSignal(target, COMSIG_CARBON_SOUNDBANG, PROC_REF(increase_bang))

/datum/element/ear_damage/Detach(datum/source)
	. = ..()
	UnregisterSignal(source, COMSIG_CARBON_SOUNDBANG)

/datum/element/ear_damage/proc/increase_bang(datum/source, list/reflist)
	reflist[1] += increase_amount

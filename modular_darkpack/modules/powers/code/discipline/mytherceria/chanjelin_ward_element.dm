/datum/element/chanjelin_ward
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 1
	// The guy who placed the ward
	var/mob/warder

/*/datum/element/chanjelin_ward/Attach(mob/placed_by, datum/target)
	. = ..()
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))


	if(isturf(target))
		RegisterSignal(target, COMSIG_ATOM_ENTERED, PROC_REF(on_entered))

/datum/element/chanjelin_ward/Detach(datum/target)
	UnregisterSignal(target, list(COMSIG_ATOM_EXAMINE))
	if(isturf(target))
		UnregisterSignal(target, list(COMSIG_ATOM_ENTERED))

	return ..()*/

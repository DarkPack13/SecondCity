/datum/subsplat/werewolf
	abstract_type = /datum/subsplat/werewolf
	// Currently un-implemented
	/// Fera required to have this subsplat. If null its takeable by any splat.
	var/fera_restriction

	// At present it grants all of them but this is a mechanical limitation while i wait for the disc rework.
	// /datum/action/cooldown/power/gift
	/// All gifts avalible via this subsplat.
	var/list/gifts_provided = list()

/datum/subsplat/werewolf/on_gain(datum/splat/gaining, joining_round)
	. = ..()
	// Placeholder!
	for(var/gift in gifts_provided)
		gaining.add_power(gift)

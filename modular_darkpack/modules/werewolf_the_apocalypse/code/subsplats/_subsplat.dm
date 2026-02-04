/datum/subsplat/werewolf
	abstract_type = /datum/subsplat/werewolf
	// Currently un-implemented
	/// Fera required to have this subsplat. If null its takeable by any splat.
	var/fera_restriction

	// At present it grants all of them but this is a mechanical limitation while i wait for the disc rework.
	/// All gifts avalible via this subsplat.
	var/list/datum/action/cooldown/power/gift/gifts_provided = list()

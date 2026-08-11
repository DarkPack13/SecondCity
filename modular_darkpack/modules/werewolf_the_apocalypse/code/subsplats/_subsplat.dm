/datum/subsplat/werewolf
	abstract_type = /datum/subsplat/werewolf
	// Currently un-implemented
	/// Fera required to have this subsplat. If null its takeable by any splat.
	var/fera_restriction

	// At present it grants all of them but this is a mechanical limitation while i wait for the disc rework.
	// /datum/action/cooldown/power/gift
	/// All gifts avalible via this subsplat.
	var/list/gifts_provided = list()
	//CRIMSON GRID CHANGE BELOW
	var/tribe_traits = list()//Used for BSD stuff currently but essentially used for any special tribe stuff

/datum/subsplat/werewolf/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()
	// Placeholder!
	for(var/gift in gifts_provided)
		gaining_splat.add_power(gift)
	//START OF CRIMSON GRID CHANGES
	for(var/traits in tribe_traits)
		ADD_TRAIT(gaining_mob, traits, TRIBE_TRAIT) //Adds all the tribe traits
	//END OF CRIMSON GRID CHANGES

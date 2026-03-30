/atom
	// DARKPACK Module - discipline - Used by Mytherceria 3 to determine who scanned us.
	var/mob/aura_scanner
	// What our scanner rolled, and what we must beat. DARKPACK TODO: Make Auspex 3 tabletop accurate so this isn't a binary
	var/aura_difficulty = 0

/atom/Initialize()
	. = ..()
	if(fae_sight_aura)
		AddComponent(/datum/component/fae_sight)

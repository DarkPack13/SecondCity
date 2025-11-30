/**
 * If the character is any kind of vampiric creature, named after the game line
 */
/proc/isvampiresplat(mob/character)
	RETURN_TYPE(/datum/splat/vampire)

	return character.get_splat(/datum/splat/vampire)

/proc/has_vitae(mob/character)
	RETURN_TYPE(/datum/splat/vampire)

	return isvampiresplat(character)

/proc/iskindred(mob/character)
	RETURN_TYPE(/datum/splat/vampire/kindred)

	return character.get_splat(/datum/splat/vampire/kindred)

/proc/isghoul(mob/character)
	RETURN_TYPE(/datum/splat/vampire/ghoul)

	return character.get_splat(/datum/splat/vampire/ghoul)

/**
 * If the character is any kind of vampiric creature, named after the game line
 */
/proc/isvampiresplat(mob/character)
	RETURN_TYPE(/datum/splat/vampire)

	return character.get_splat(/datum/splat/vampire)

/**
 * If the character has Vitae, readable wrapper for isvampiresplat() for checking Vitae
 */
/proc/has_vitae(mob/character)
	RETURN_TYPE(/datum/splat/vampire)

	return isvampiresplat(character)

/**
 * If the character can learn and use Disciplines, readable wrapper for isvampiresplat() for Discipline uses
 */
/proc/does_use_disciplines(mob/character)
	RETURN_TYPE(/datum/splat/vampire)

	return isvampiresplat(character)

/proc/iskindred(mob/character)
	RETURN_TYPE(/datum/splat/vampire/kindred)

	return character.get_splat(/datum/splat/vampire/kindred)

/proc/isghoul(mob/character)
	RETURN_TYPE(/datum/splat/vampire/ghoul)

	return character.get_splat(/datum/splat/vampire/ghoul)

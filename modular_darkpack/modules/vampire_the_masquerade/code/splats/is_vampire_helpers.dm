/**
 * If the character is any kind of vampiric creature, named after the game line
 */
/proc/get_vampire_splat(mob/character)
	RETURN_TYPE(/datum/splat/vampire)

	return character.get_splat(/datum/splat/vampire)

/**
 * If the character has Vitae, readable wrapper for get_vampire_splat() for checking Vitae
 */
/proc/get_splat_with_vitae(mob/character)
	RETURN_TYPE(/datum/splat/vampire)

	return get_vampire_splat(character)

/**
 * If the character can learn and use Disciplines, readable wrapper for get_vampire_splat() for Discipline uses
 */
/proc/get_splat_with_discipline(mob/character)
	RETURN_TYPE(/datum/splat/vampire)

	return get_vampire_splat(character)

/proc/get_kindred_splat(mob/character)
	RETURN_TYPE(/datum/splat/vampire/kindred)

	return character.get_splat(/datum/splat/vampire/kindred)

/proc/get_ghoul_splat(mob/character)
	RETURN_TYPE(/datum/splat/vampire/ghoul)

	return character.get_splat(/datum/splat/vampire/ghoul)

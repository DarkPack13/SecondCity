/**
 * If the character is any kind of fera or kinfolk creature, named after the game line
 */
/proc/iswerewolfsplat(mob/character)
	RETURN_TYPE(/datum/splat/werewolf)

	return character.get_splat(/datum/splat/werewolf)

/proc/isshifter(mob/character)
	RETURN_TYPE(/datum/splat/werewolf/shifter)

	return character.get_splat(/datum/splat/werewolf/shifter)

/proc/isgarou(mob/character)
	RETURN_TYPE(/datum/splat/werewolf/shifter/garou)

	return character.get_splat(/datum/splat/werewolf/shifter/garou)

/* // DARKPACK TODO - CORAX
/proc/iscorax(mob/character)
	RETURN_TYPE(/datum/splat/werewolf/shifter/cora

	return character.get_splat(/datum/splat/werewolf/shifter/corax)
*/

/proc/iskinfolk(mob/character)
	RETURN_TYPE(/datum/splat/werewolf/kinfolk)

	return character.get_splat(/datum/splat/werewolf/kinfolk)


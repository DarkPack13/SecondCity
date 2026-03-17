/**
 * If the character is any kind of fera or kinfolk creature, named after the game line
 */
/proc/get_werewolf_splat(mob/character)
	RETURN_TYPE(/datum/splat/werewolf)

	return character.get_splat(/datum/splat/werewolf)

/proc/get_shifter_splat(mob/character)
	RETURN_TYPE(/datum/splat/werewolf/shifter)

	return character.get_splat(/datum/splat/werewolf/shifter)

/proc/get_garou_splat(mob/character)
	RETURN_TYPE(/datum/splat/werewolf/shifter/garou)

	return character.get_splat(/datum/splat/werewolf/shifter/garou)

/* // DARKPACK TODO - CORAX
/proc/get_corax_splat(mob/character)
	RETURN_TYPE(/datum/splat/werewolf/shifter/cora

	return character.get_splat(/datum/splat/werewolf/shifter/corax)
*/

/proc/get_kinfolk_splat(mob/character)
	RETURN_TYPE(/datum/splat/werewolf/kinfolk)

	return character.get_splat(/datum/splat/werewolf/kinfolk)


/**
 * How many splats the character has, can be treated as true/false
 */
/proc/issupernatural(mob/character)
	if (!isliving(character))
		// Zero splats, this does not account for ghosts being supernatural
		return 0

	var/mob/living/living_character = character
	return length(living_character.splats)

/**
 * If the character is not supernatural, ie has no splats
 */
/proc/ismundane(mob/character)
	return !issupernatural(character)

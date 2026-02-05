#define MAX_RENOWN 10

/datum/splat/werewolf/proc/adjust_renown(attribute, amount)
	if(!renown[attribute])
		renown[attribute] = 0


	var/old_rank = renown_rank
	var/new_amount = clamp(renown[attribute] + amount, 0, MAX_RENOWN)

	renown[attribute] = new_amount
	if(amount < 0)
		to_chat(owner, span_userdanger("You feel [get_negative_emotion(attribute)]!"))
	else if(amount > 0)
		to_chat(owner, span_bold("You feel [get_positive_emotion(attribute)]!"))

	switch(attribute)
		if(RENOWN_HONOR)
			owner.write_preference_midround(/datum/preference/numeric/renown/honor, new_amount)
		if(RENOWN_GLORY)
			owner.write_preference_midround(/datum/preference/numeric/renown/glory, new_amount)
		if(RENOWN_WISDOM)
			owner.write_preference_midround(/datum/preference/numeric/renown/wisdom, new_amount)

	renown_rank = auspice_rank_check()
	if(old_rank != renown_rank)
		to_chat(owner, span_boldnotice("You are now a [fera_rank_name(renown_rank)]."))

	owner.write_preference_midround(/datum/preference/numeric/fera_rank, renown_rank)


/datum/splat/werewolf/proc/get_negative_emotion(attribute)
	switch(attribute)
		if(RENOWN_HONOR)
			return "ashamed"

		if(RENOWN_GLORY)
			return "humiliated"

		if(RENOWN_WISDOM)
			return "foolish"

	return "unsure"

/datum/splat/werewolf/proc/get_positive_emotion(attribute)
	switch(attribute)

		if(RENOWN_HONOR)
			return "vindicated"

		if(RENOWN_GLORY)
			return "brave"

		if(RENOWN_WISDOM)
			return "clever"

	return "confident"


/datum/splat/werewolf/proc/auspice_rank_check()
	return auspice.rank_requirments(renown)

// Pretty iffy on this. This could likely just be moved onto the splat itself so corax and other breeds can override it.
/proc/fera_rank_name(rank, breed)

	// if(breed != "Corax") DARKPACK TODO - CORAX
	switch(rank)
		if(RANK_CUB)
			return "cub" // in lowercase so that \a might function during the character examine
		if(RANK_CLIATH)
			return "cliath"
		if(RANK_FOSTERN)
			return "fostern"
		if(RANK_ADREN)
			return "adren"
		if(RANK_ATHRO)
			return "athro"
		if(RANK_ELDER)
			return "elder"
		if(RANK_LEGEND)
			return "legend"
/* DARKPACK TODO - CORAX
	switch(rank)
		if(0)
			return "fledgling"
		if(1)
			return "oviculum"
		if(2)
			return "neocornix"
		if(3)
			return "ales"
		if(4)
			return "volucris"
		if(5)
			return "corvus"
		if(6)
			return "grey eminence"
*/

#undef MAX_RENOWN

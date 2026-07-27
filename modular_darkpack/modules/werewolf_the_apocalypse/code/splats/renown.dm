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
		to_chat(owner, span_boldnotice("You are now a [fera_rank_name(renown_rank, id)]."))

	// Not acctually used ANYWHERE rn. Its super easy to just calculate it from our renown anyway.
	// owner.write_preference_midround(/datum/preference/numeric/fera_rank, renown_rank)


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
	if(!auspice)
		return RANK_CUB
	return auspice.rank_requirments(renown)

// Pretty iffy on this. This could likely just be moved onto the splat itself so corax and other breeds can override it.
/proc/fera_rank_name(rank, breed)
	switch(breed)
		if(SPLAT_CORAX)
			switch(rank)
				if(RANK_CUB)
					return "fledgling"
				if(RANK_CLIATH)
					return "oviculum"
				if(RANK_FOSTERN)
					return "neocornix"
				if(RANK_ADREN)
					return "ales"
				if(RANK_ATHRO)
					return "volucris"
				if(RANK_ELDER)
					return "corvus"
				if(RANK_LEGEND)
					return "grey eminence"
		else
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

/datum/action/cooldown/modify_renown
	name = "Award/Remove Renown"
	button_icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/werewolf_abilities.dmi'
	button_icon_state = "wip"
	click_to_activate = TRUE

/datum/action/cooldown/modify_renown/Activate(atom/target)
	if(target == owner)
		return
	var/mob/living/living_target = astype(target)
	if(!living_target)
		return

	. = ..()

	var/datum/splat/werewolf/werewolf_spalt = get_werewolf_splat(living_target)
	if(!werewolf_spalt)
		return TRUE

	var/datum/splat/werewolf/our_werewolf_spalt = get_werewolf_splat(owner)
	if(!our_werewolf_spalt)
		return TRUE

	if(werewolf_spalt.renown_rank >= our_werewolf_spalt.renown_rank)
		to_chat(owner, span_warning("They have a rank equal or greater then yours."))
		return TRUE

	to_chat(owner, span_warning("This adjusts the renown permently of the selected mob. This is logged to admins and should be used with care."))

	var/renown_input = tgui_alert(owner, "Choose Renown to adjust.", "Modify Renown", ALL_RENOWNS)
	if(!renown_input)
		return TRUE

	var/renown_amount = tgui_input_number(owner, "Choose amount to adjust.", "Modify Renown", 1, MAX_RENOWN, -MAX_RENOWN)
	if(!renown_amount)
		return TRUE

	var/renown_reason = tgui_input_text(owner, "Declare a reason for this shift. A table for sample renown awards can be found in Werewolf The Apocalypse 20th Anniversary Edition p. 246", "Modify Renown")
	if(!renown_reason)
		return TRUE

	werewolf_spalt.adjust_renown(renown_input, renown_amount)
	to_chat(owner, span_notice("[renown_input] adjusted!"))

	message_admins("[ADMIN_LOOKUPFLW(owner)] adjusted [renown_input] of [ADMIN_LOOKUPFLW(target)] by [renown_amount] for reason: \"[renown_reason]\".")
	owner.log_message(" adjusted [renown_input] of [key_name(target)] by [renown_amount] for reason: \"[renown_reason]\".", LOG_GAME)
	return TRUE

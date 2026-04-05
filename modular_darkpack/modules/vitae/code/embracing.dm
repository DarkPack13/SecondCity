/mob/living/carbon/human/proc/attempt_embrace_target(mob/living/carbon/human/childe, second_party_embrace)
	var/chat_message_reciever = src
	if(second_party_embrace)
		chat_message_reciever = second_party_embrace
	if(!childe.can_be_embraced || !childe.mind)
		to_chat(chat_message_reciever, span_notice("[childe.name] doesn't respond to the Vitae."))
		return
	// If they've been dead for more than 5 minutes, then nothing happens.
	if(!((childe.timeofdeath + 5 MINUTES) > world.time))
		to_chat(chat_message_reciever, span_notice("[childe] is totally <b>DEAD</b>!"))
		return FALSE

	embrace_target(childe, second_party_embrace)

/mob/living/carbon/human/proc/embrace_target(mob/living/carbon/human/childe, second_party_embrace)
	log_game("[key_name(src)] has Embraced [key_name(childe)]. [second_party_embrace ? "Using [second_party_embrace]'s vitae!" : null]")
	message_admins("[ADMIN_LOOKUPFLW(src)] has Embraced [ADMIN_LOOKUPFLW(childe)]. [second_party_embrace ? "Using [second_party_embrace]'s vitae!" : null]")
	childe.revive(full_heal_flags = HEAL_ALL, force_grab_ghost = TRUE)
	childe.grab_ghost(force = TRUE)
	to_chat(childe, span_cult("You rise with a start! You feel a tremendous pulse echoing in your ears. As you focus your mind on it, you discover it to be the last few throbs of your heart beating until it slows to a halt. The warmth from your skin slowly fades until it settles to the ambient temperature around you...- and you are very hungry."))

	childe.make_kindred_from_sire(src)

	//Gives the Childe the sire's first three Disciplines
	var/clan_disciplines = get_clan().clan_disciplines
	for(var/i in 1 to 3)
		childe.give_st_power(clan_disciplines[i])

	var/datum/st_stat/morality_path/morality/stat_morality_childe = childe.storyteller_stats[STAT_MORALITY]

	if(stat_morality_childe)
		stat_morality_childe.morality_path = new /datum/morality/humanity(childe) // set morality to path of humanity

		var/datum/splat/vampire/kindred/kindred_splat = get_kindred_splat(childe) // if this is null something has gone seriously wrong

		// update morality score and the splat enlightenment
		if(istype(kindred_splat))
			var/datum/st_stat/stat_conscience = childe.storyteller_stats[STAT_CONSCIENCE]
			var/datum/st_stat/stat_self_control = childe.storyteller_stats[STAT_SELF_CONTROL]
			var/datum/st_stat/stat_conviction = childe.storyteller_stats[STAT_CONVICTION]
			var/datum/st_stat/stat_instinct = childe.storyteller_stats[STAT_INSTINCT]

			if(stat_morality_childe.morality_path.alignment == MORALITY_HUMANITY)
				stat_morality_childe.set_score(clamp(stat_conscience.get_score(include_bonus = TRUE) + stat_self_control.get_score(include_bonus = TRUE), 0, 10))
			else if(stat_morality_childe.morality_path.alignment == MORALITY_ENLIGHTENMENT) // just in case, but should be unreachable rn.
				stat_morality_childe.set_score(clamp(stat_conviction.get_score(include_bonus = TRUE) + stat_instinct.get_score(include_bonus = TRUE), 0, 10))

	addtimer(CALLBACK(childe, PROC_REF(prompt_permanent_embrace)), 1 SECONDS)

/* // DARKPACK TODO - WEREWOLF
/mob/living/carbon/human/proc/attempt_abomination_embrace(mob/living/carbon/human/childe, second_party_embrace)
	if(!(childe.auspice?.level)) //here be Abominations
		return
	if(childe.auspice.force_abomination)
		to_chat(src, span_danger("Something terrible is happening."))
		to_chat(childe, span_userdanger("Gaia has forsaken you."))
		message_admins("[ADMIN_LOOKUPFLW(src)] has turned [ADMIN_LOOKUPFLW(childe)] into an Abomination through an admin setting the force_abomination var. [second_party_embrace ? "Using [second_party_embrace]'s vitae!" : null]")
		log_game("[key_name(src)] has turned [key_name(childe)] into an Abomination through an admin setting the force_abomination var. [second_party_embrace ? "Using [second_party_embrace]'s vitae!" : null]")
	else
		switch(SSroll.storyteller_roll(childe.auspice.level))
			if(ROLL_BOTCH)
				to_chat(src, span_danger("Something terrible is happening."))
				to_chat(childe, span_userdanger("Gaia has forsaken you."))
				message_admins("[ADMIN_LOOKUPFLW(src)] has turned [ADMIN_LOOKUPFLW(childe)] into an Abomination. [second_party_embrace ? "Using [second_party_embrace]'s vitae!" : null]")
				log_game("[key_name(src)] has turned [key_name(childe)] into an Abomination. [second_party_embrace ? "Using [second_party_embrace]'s vitae!" : null]")
				embrace_target(childe)
				return
			if(ROLL_FAILURE)
				childe.visible_message(span_warning("[childe.name] convulses in sheer agony!"))
				childe.Shake(15, 15, 5 SECONDS)
				playsound(childe.loc, 'code/modules/wod13/sounds/vicissitude.ogg', 100, TRUE)
				childe.can_be_embraced = FALSE
				return
			if(ROLL_SUCCESS)
				to_chat(src, span_notice("[childe.name] does not respond to your Vitae..."))
				childe.can_be_embraced = FALSE
				return
*/


/mob/living/carbon/human/proc/prompt_permanent_embrace()
	var/response = tgui_alert(src, "Do you wish to keep being a vampire on your save slot? This is a permanent choice, and you can't go back!", "Embrace", list("Yes", "No"))
	//Verify if they accepted to save being a vampire
	if(response != "Yes" || !client)
		return

	write_preference_midround(/datum/preference/choiced/splats, SPLAT_KINDRED)
	write_preference_midround(/datum/preference/choiced/subsplat/vampire_clan, get_clan()?.name) // clan should already be changed by the embracing itself...

	// ...same with your morality path. unfortunately, this is a bit of a clusterfuck to get
	var/datum/st_stat/morality_path/morality/stat_morality = storyteller_stats[STAT_MORALITY]
	if(stat_morality?.morality_path)
		write_preference_midround(/datum/preference/choiced/vtm_morality, stat_morality.morality_path.name)
		// the actual stat isnt editable, so i *shouldnt* need to worry about setting the stat in preferences,
		// it should just take care of itself

	/* // DARKPACK TODO - PREFERENCES
	var/datum/preferences/childe_prefs_v = client.prefs

	//Rarely the new mid round vampires get the 3 brujah skil(it is default)
	//This will remove if it happens
	// Or if they are a ghoul with abunch of disciplines
	if(childe_prefs_v.discipline_types.len > 0)
		for (var/i in 1 to childe_prefs_v.discipline_types.len)
			var/removing_discipline = childe_prefs_v.discipline_types[1]
			if (removing_discipline)
				var/index = childe_prefs_v.discipline_types.Find(removing_discipline)
				childe_prefs_v.discipline_types.Cut(index, index + 1)
				childe_prefs_v.discipline_levels.Cut(index, index + 1)

	if(childe_prefs_v.discipline_types.len == 0)
		for (var/i in 1 to 3)
			childe_prefs_v.discipline_types += childe_prefs_v.clan.clan_disciplines[i]
			childe_prefs_v.discipline_levels += 1
	*/

	to_chat(src, span_danger("You have chosen to permanently become a vampire!"))


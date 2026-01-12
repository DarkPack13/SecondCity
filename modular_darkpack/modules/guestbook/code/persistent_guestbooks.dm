///Saves all guestbooks for everyone's original characters
/datum/controller/subsystem/persistence/proc/save_guestbooks()
	for(var/i in GLOB.joined_player_list)
		var/mob/living/carbon/human/ending_human = get_mob_by_ckey(i)
		if(!istype(ending_human) || !ending_human.mind?.original_character_slot_index)
			continue

		var/mob/living/carbon/human/original_human = ending_human.mind.original_character.resolve()

		if(!original_human)
			continue

		if(original_human == ending_human)
			original_human.client.prefs.guestbook_names = original_human.mind.guestbook.known_names
			original_human.client.prefs.save_character()

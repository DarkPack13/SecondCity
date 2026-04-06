/datum/action/resist_presence
	name = "Resist Presence"
	desc = "Burn a point of your temporary willpower to resist the effects of Awe; re-roll and spend temporary willpower to resist the effects of Entrancement."
	button_icon = 'modular_darkpack/modules/powers/icons/actions.dmi'
	button_icon_state = "presence"
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/resist_presence/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE

	var/mob/living/carbon/human/user = owner
	if(!ishuman(user))
		return FALSE

	if(user.st_get_stat(STAT_TEMPORARY_WILLPOWER) <= 0)
		to_chat(user, span_warning("You don't have any temporary willpower left to resist!"))
		return FALSE

	//V20 rules - burn a WP point to resist awe
	if(owner.has_status_effect(STATUS_EFFECT_AWE))
		user.st_add_stat_mod(STAT_TEMPORARY_WILLPOWER, -1)
		to_chat(user, span_warning("You burn a point of willpower to resist the supernatural influence..."))
		var/list/hearers = oviewers(DEFAULT_MESSAGE_RANGE, owner)
		for(var/mob/living/hearer in hearers)
			to_chat(hearer, span_notice("[owner] doesn't seem impressed anymore.."))
		user.remove_status_effect(STATUS_EFFECT_AWE)
		user.remove_overlay(MUTATIONS_LAYER)
		Remove(user)
		return TRUE

	//V20 rules for entrancement let you burn the WP; we make it harder using the following line:
	//"The Storyteller may wish to make the roll instead, since the character is never certain of the strength of her hold on the victim."
	if(user.has_alert("entrancement", /atom/movable/screen/alert/entrancement))
		var/successes = SSroll.storyteller_roll(user, user.st_get_stat(STAT_TEMPORARY_WILLPOWER), difficulty = 8)
		if(successes > 0)
			user.st_add_stat_mod(STAT_TEMPORARY_WILLPOWER, -1)
			user.clear_alert("entrancement", /atom/movable/screen/alert/entrancement)
			to_chat(user, span_notice("You have succeeded in resisting the effects of Presence."))
			var/list/hearers = oviewers(DEFAULT_MESSAGE_RANGE, owner)
			for(var/mob/living/hearer in hearers)
				to_chat(hearer, span_notice("[owner] shakes off the entrancement had on them!"))
			Remove(user)
			return TRUE
		else
			to_chat(user, span_warning("Despite your efforts, the supernatural influence remains too strong!"))
			return FALSE

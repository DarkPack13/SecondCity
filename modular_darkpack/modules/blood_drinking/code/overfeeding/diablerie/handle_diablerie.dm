/mob/living/carbon/human/proc/handle_diablerie(mob/living/victim)
	AdjustHumanity(-1, 0)

	var/datum/splat/vampire/kindred/kindred = iskindred(src)
	var/generation = get_generation()
	var/victim_generation = victim.get_generation()

	if(victim_generation >= generation)
		message_admins("[ADMIN_LOOKUPFLW(src)] successfully Diablerized [ADMIN_LOOKUPFLW(victim)]")
		log_attack("[key_name(src)] successfully Diablerized [key_name(victim)].")
		if(victim.client)
			var/datum/brain_trauma/special/imaginary_friend/trauma = gain_trauma(/datum/brain_trauma/special/imaginary_friend)
			trauma.friend.key = victim.key
	else
		var/start_prob = 10
		if(HAS_TRAIT(src, TRAIT_DIABLERIE))
			start_prob = 30
		if(prob(min(99, start_prob+((generation-victim_generation)*10))))
			to_chat(src, span_userdanger(span_bold("[victim]'s soul overcomes yours and gains control of your body!")))
			message_admins("[ADMIN_LOOKUPFLW(src)] tried to Diablerize [ADMIN_LOOKUPFLW(victim)] and was overtaken.")
			log_attack("[key_name(src)] tried to Diablerize [key_name(victim)] and was overtaken.")
			kindred.set_generation(victim_generation)
			if(victim.mind)
				victim.mind.transfer_to(src, TRUE)
			else
				death()
			return
		message_admins("[ADMIN_LOOKUPFLW(src)] successfully Diablerized [ADMIN_LOOKUPFLW(victim)]")
		log_attack("[key_name(src)] successfully Diablerized [key_name(victim)].")
		if(victim.client)
			var/datum/brain_trauma/special/imaginary_friend/trauma = gain_trauma(/datum/brain_trauma/special/imaginary_friend)
			trauma.friend.key = victim.key

	make_diablerist()
	adjust_brute_loss(-50, TRUE)
	adjust_fire_loss(-50, TRUE)
	victim.death()


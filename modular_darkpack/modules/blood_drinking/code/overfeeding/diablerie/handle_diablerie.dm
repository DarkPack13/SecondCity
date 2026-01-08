/mob/living/carbon/human/proc/handle_diablerie(mob/living/mob)
	if(!ishuman(mob))
		CRASH("Tried to diablerize nonhuman vampire. Add handling for this!")

	var/mob/living/carbon/human/mob_human = mob
	AdjustHumanity(-1, 0)

	if(mob_human.dna.species.generation >= dna.species.generation)
		message_admins("[ADMIN_LOOKUPFLW(src)] successfully Diablerized [ADMIN_LOOKUPFLW(mob)]")
		log_attack("[key_name(src)] successfully Diablerized [key_name(mob)].")
		if(mob_human.client)
			var/datum/brain_trauma/special/imaginary_friend/trauma = gain_trauma(/datum/brain_trauma/special/imaginary_friend)
			trauma.friend.key = mob_human.key
	else
		var/start_prob = 10
		if(HAS_TRAIT(src, TRAIT_DIABLERIE))
			start_prob = 30
		if(prob(min(99, start_prob+((dna.species.generation - mob_human.dna.species.generation)*10))))
			to_chat(src, span_userdanger("<b>[mob_human]'s SOUL OVERCOMES YOURS AND GAINS CONTROL OF YOUR BODY.</b>"))
			message_admins("[ADMIN_LOOKUPFLW(src)] tried to Diablerize [ADMIN_LOOKUPFLW(mob)] and was overtaken.")
			log_attack("[key_name(src)] tried to Diablerize [key_name(mob)] and was overtaken.")
			dna.species.generation = mob_human.dna.species.generation
			if(mob_human.mind)
				mob_human.mind.transfer_to(src, TRUE)
			else
				death()
			return
		message_admins("[ADMIN_LOOKUPFLW(src)] successfully Diablerized [ADMIN_LOOKUPFLW(mob)]")
		log_attack("[key_name(src)] successfully Diablerized [key_name(mob)].")
		if(mob_human.client)
			var/datum/brain_trauma/special/imaginary_friend/trauma = gain_trauma(/datum/brain_trauma/special/imaginary_friend)
			trauma.friend.key = mob_human.key

	make_diablerist()
	adjust_brute_loss(-50, TRUE)
	adjust_fire_loss(-50, TRUE)
	mob.death()


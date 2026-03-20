/mob/living/carbon/human/proc/check_can_drink_dry(var/mob/living/mob)
	if(!get_kindred_splat(mob) || !get_kindred_splat(src))
		return TRUE

	if(!mob.client)
		to_chat(src, span_warning("You need [mob]'s attention to do that..."))
		return FALSE

	message_admins("[ADMIN_LOOKUPFLW(src)] is attempting to Diablerize [ADMIN_LOOKUPFLW(mob)]")
	log_attack("[key_name(src)] is attempting to Diablerize [key_name(mob)].")

	to_chat(src, span_userdanger(span_bold("YOU TRY TO COMMIT DIABLERIE ON [mob].")))
	return TRUE

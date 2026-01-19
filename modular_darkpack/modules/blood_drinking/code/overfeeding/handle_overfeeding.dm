/mob/living/carbon/human/proc/handle_overfeeding(var/mob/living/carbon/human/human_mob)
	human_mob.blood_volume = 0
	if(human_mob.stat != DEAD)
		if(isnpc(human_mob))
			var/mob/living/carbon/human/npc/Npc = human_mob
			Npc.last_attacker = null
			killed_count = killed_count+1
			if(killed_count >= 5)
				SEND_SOUND(src, sound('modular_darkpack/modules/deprecated/sounds/humanity_loss.ogg', 0, 0, 75))
				to_chat(src, span_userdanger("<b>POLICE ASSAULT IN PROGRESS</b>"))
		SEND_SOUND(src, sound('modular_darkpack/modules/deprecated/sounds/feed_failed.ogg', 0, 0, 75))
		to_chat(src, span_warning("This sad sacrifice for your own pleasure affects something deep in your mind."))
		SEND_SIGNAL(src, COMSIG_PATH_HIT, -1, 0, FALSE)
		human_mob.death()

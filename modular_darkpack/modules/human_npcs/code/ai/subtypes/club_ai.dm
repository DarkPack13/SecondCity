#warn move life to ai controller
/datum/ai_controller/npc/stand_still/club


/mob/living/carbon/human/npc/average/club/Life(seconds_per_tick)
	. = ..()

	if(IS_UNCONSCIOUS_OR_CRIT(src))
		return
	if(!SPT_PROB_RATE(5, seconds_per_tick))
		return

	INVOKE_ASYNC(src, PROC_REF(dance_at_jukebox))

/mob/living/carbon/human/npc/average/club/proc/dance_at_jukebox()
	var/hasjukebox = FALSE
	for(var/obj/machinery/jukebox/jukebox in range(7, src))
		if(!jukebox.music_player?.active_song_sound)
			continue
		hasjukebox = TRUE
		break

	if(hasjukebox)
		if(prob(50))
			dancefirst(src)
		else
			dancesecond(src)

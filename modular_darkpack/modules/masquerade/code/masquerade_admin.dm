/mob/living/carbon/human/proc/AdjustMasquerade(value, reason = "debug")
	if(ismundane(src))
		return
	if(!GLOB.canon_event)
		return

	switch(value)
		if(1)
			SSmasquerade.masquerade_reinforce(reason, src)
		if(-1)
			SSmasquerade.masquerade_breach(reason, src, MASQUERADE_REASON_OTHER)

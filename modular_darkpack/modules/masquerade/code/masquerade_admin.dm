// DARKPACK TODO - Hey this doesnt work and is not used anywhere anymore anyway.
/mob/living/carbon/human/proc/AdjustMasquerade(value, reason = "debug")
	if(ismundane(src))
		return

	switch(value)
		if(1)
			SSmasquerade.masquerade_reinforce(reason, src)
		if(-1)
			SSmasquerade.masquerade_breach(reason, src, MASQUERADE_REASON_OTHER)

/mob/proc/enter_avatar()
	if(!key)
		return
	if(IS_FAKE_KEY(key)) // Skip aghosts.
		return

	stop_sound_channel(CHANNEL_HEARTBEAT) //Stop heartbeat sounds because You Are A Ghost Now
	var/mob/living/basic/avatar/ghost = new(src) // Transfer safety to observer spawning proc.
	SStgui.on_transfer(src, ghost) // Transfer NanoUIs.
	ghost.PossessByPlayer(key)
	ghost.client?.init_verbs()
	return ghost

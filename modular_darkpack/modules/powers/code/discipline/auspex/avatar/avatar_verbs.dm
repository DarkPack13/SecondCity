/mob/living/basic/avatar/verb/reenter_corpse()
	set name = "Re-enter Corpse"

	if(!client)
		return
	if(!mind || QDELETED(mind.current))
		to_chat(src, span_warning("You have no body."))
		return
	if(mind.current.key && !IS_FAKE_KEY(mind.current.key)) //makes sure we don't accidentally kick any clients
		to_chat(usr, span_warning("Another consciousness is in your body...It is resisting you."))
		return
	client.view_size.resetToDefault()//Let's reset so people can't become allseeing gods
	SStgui.on_transfer(src, mind.current) // Transfer NanoUIs.
	if(mind.current.stat == DEAD && SSlag_switch.measures[DISABLE_DEAD_KEYLOOP])
		to_chat(src, span_warning("To leave your body again use the Ghost verb."))
	mind.current.PossessByPlayer(key)
	mind.current.client.init_verbs()
	return TRUE

///Shows a tgui window with memories
/mob/verb/emotion_panel()
	set name = "Emotion Panel"
	set category = "IC"
	set desc = "Change your character's emotions."

	var/new_emotion = tgui_input_list(src, "What are you feeling?", "Feelings", GLOB.aura_list)
	if(isnull(new_emotion))
		return FALSE
	SEND_SIGNAL(src, COMSIG_MOB_EMOTION_CHANGED, new_emotion)


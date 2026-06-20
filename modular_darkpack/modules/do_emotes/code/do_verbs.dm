/mob/verb/do_verb(message as text)
	set name = VERB_DO
	if(GLOB.say_disabled) // This is here to try to identify lag problems
		to_chat(usr, span_danger("Speech is currently admin-disabled."))
		return

	message = trim(copytext_char(sanitize(message), 1, MAX_MESSAGE_LEN))

	QUEUE_OR_CALL_VERB_FOR(VERB_CALLBACK(src, TYPE_PROC_REF(/mob, emote), "do_emote", NONE, message, TRUE), SSspeech_controller)


/datum/emote/living/custom/do_emote
	key = "do_emote"
	key_third_person = "do_emote"
	message = null


/datum/emote/living/custom/do_emote/run_emote(mob/user, params, type_override, intentional)
	var/msg = select_message_type(user, message, intentional)
	if(params)
		if(message_param)
			msg = select_param(user, params)
		else
			msg = params

	msg = replace_pronoun(user, msg)
	if(!msg)
		return


	if (!user.try_speak(msg)) // ensure we pass the vibe check (filters, etc)
		return

	var/name_stub = " (<b>[user.name]</b>)"
	msg = trim(copytext_char(msg, 1, (MAX_MESSAGE_LEN - length(name_stub))))
	var/message_with_name = msg + name_stub

	user.log_message(msg, LOG_EMOTE)

	var/list/viewers = get_hearers_in_view(DEFAULT_MESSAGE_RANGE, user)

	for(var/mob/ghost as anything in GLOB.dead_mob_list)
		name_stub = " (<b>[GET_GUESTBOOK_NAME(ghost, user)]</b>)"
		message_with_name = msg + name_stub
		if((ghost.client?.prefs.chat_toggles & CHAT_GHOSTSIGHT) && !(ghost in viewers))
			to_chat(ghost, "[FOLLOW_LINK(ghost, user)] [span_emote(message_with_name)]")

	for(var/mob/receiver in viewers)
		name_stub = " (<b>[GET_GUESTBOOK_NAME(receiver, user)]</b>)"
		message_with_name = msg + name_stub
		receiver.show_message(span_emote(message_with_name), alt_msg = span_emote(message_with_name))
		if (receiver.client?.prefs.read_preference(/datum/preference/toggle/enable_runechat))
			receiver.create_chat_message(user, null, msg, null, EMOTE_MESSAGE)

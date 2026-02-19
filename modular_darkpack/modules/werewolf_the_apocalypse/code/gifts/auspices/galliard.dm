/*
/datum/action/cooldown/power/gift/beast_speech
	name = "Beast Speech"
	desc = "The werewolf with this Gift may communicate with any animals from fish to mammals."
	button_icon_state = "beast_speech"
	rage_req = 1
	//gnosis_req = 1

/datum/action/cooldown/power/gift/beast_speech/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		if(length(C.beastmaster) > 3)
			var/mob/living/simple_animal/hostile/beastmaster/B = pick(C.beastmaster)
			qdel(B)
		playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/wolves.ogg', 75, FALSE)
		if(!length(C.beastmaster))
			var/datum/action/beastmaster_stay/E1 = new()
			E1.Grant(C)
			var/datum/action/beastmaster_deaggro/E2 = new()
			E2.Grant(C)
		var/mob/living/simple_animal/hostile/beastmaster/D = new(get_turf(C))
		D.my_creator = C
		C.beastmaster |= D
		D.beastmaster = C
*/

/*
/datum/action/cooldown/power/gift/call_of_the_wyld
	name = "Call Of The Wyld"
	desc = "The werewolf may send her howl far beyond the normal range of hearing and imbue it with great emotion, stirring the hearts of fellow Garou and chilling the bones of all others."
	button_icon_state = "call_of_the_wyld"
	rage_req = 1

/datum/action/cooldown/power/gift/call_of_the_wyld/Activate(atom/target)
	. = ..()

	if(!ishuman(owner))
		return
	var/mob/living/carbon/human/human_owner = owner
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		C.emote("howl")
		for(var/mob/living/carbon/A in orange(6, owner))
			if(isgarou(A) || iswerewolf(A))
				A.emote("howl")
				spawn(1 SECONDS)
					adjust_gnosis(1, A, TRUE)
//	awo1
*/

// Very inaccurate right now
/datum/action/cooldown/power/gift/mindspeak
	name = "Mindspeak"
	desc = "By invoking the power of waking dreams, the Garou can place any chosen characters into silent communion."
	button_icon_state = "mindspeak"
//	gnosis_req = 1


/datum/action/cooldown/power/gift/mindspeak/Activate(atom/target)
	var/input = tgui_input_text(usr, "What do you want to tell to your Tribe?", name, max_length = MAX_MESSAGE_LEN)
	if(!input || !IsAvailable(feedback = TRUE))
		return

	var/list/filter_result = CAN_BYPASS_FILTER(usr) ? null : is_ic_filtered(input)
	if(filter_result)
		REPORT_CHAT_FILTER_TO_USER(usr, filter_result)
		return

	var/list/soft_filter_result = CAN_BYPASS_FILTER(usr) ? null : is_soft_ic_filtered(input)
	if(soft_filter_result)
		if(tgui_alert(usr,"Your message contains \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\". \"[soft_filter_result[CHAT_FILTER_INDEX_REASON]]\", Are you sure you want to say it?", "Soft Blocked Word", list("Yes", "No")) != "Yes")
			return
		message_admins("[ADMIN_LOOKUPFLW(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[html_encode(input)]\"")
		log_admin_private("[key_name(usr)] has passed the soft filter for \"[soft_filter_result[CHAT_FILTER_INDEX_WORD]]\" they may be using a disallowed term. Message: \"[input]\"")
	commune_tribe(usr, input)

/datum/action/cooldown/power/gift/mindspeak/proc/commune_tribe(mob/living/user, message)
	var/my_message
	if(!message || !user.mind)
		return

	my_message = "<b>[findtextEx(user.name, user.real_name) ? user.name : "[user.real_name] (as [user.name])"]:</b> [message]"
	var/datum/splat/werewolf/our_splat = iswerewolfsplat(user)
	if(!our_splat?.tribe)
		return
	for(var/mob/living/listener in viewers(9, owner))
		var/datum/splat/werewolf/listener_splat = iswerewolfsplat(listener)
		if(listener == user)
			to_chat(user, "You transfer this message to your tribe members nearby: <b>[message]</b>", type = MESSAGE_TYPE_RADIO, avoid_highlighting = TRUE)
		else if(listener_splat?.tribe?.name == our_splat.tribe.name)
			to_chat(listener, "You hear a message in your head... <b>[message]</b>", type = MESSAGE_TYPE_RADIO)

	for(var/mob/listener in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(listener, user)
		to_chat(listener, "[link] [my_message]", type = MESSAGE_TYPE_RADIO)

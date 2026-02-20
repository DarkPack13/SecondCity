/*
/datum/action/cooldown/power/gift/blur_of_the_milky_eye
	name = "Blur Of The Milky Eye"
	desc = "The Garou's form becomes a shimmering blur, allowing him to pass unnoticed among others."
	button_icon_state = "blur_of_the_milky_eye"
	rage_req = 2
	//gnosis_req = 1

/datum/action/cooldown/power/gift/blur_of_the_milky_eye/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		C.alpha = 36
		playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/milky_blur.ogg', 75, FALSE)
		spawn(20 SECONDS)
			C.alpha = 255
*/

/datum/action/cooldown/power/gift/infectious_laughter
	name = "Infectious Laughter"
	desc = "When the Ragabash laughs, those around her are compelled to follow along, forgetting their grievances. Uses the last message you spoke for the ability"
	button_icon_state = "infectious_laughter"
	// I dont acctually see anything in the book that is causes rage.
	// rage_req = 1
	var/last_spoken_message
	var/when_spoken = 0

/datum/action/cooldown/power/gift/infectious_laughter/Grant(mob/granted_to)
	. = ..()

	RegisterSignal(granted_to, COMSIG_MOB_SAY, PROC_REF(on_mob_say))

/datum/action/cooldown/power/gift/infectious_laughter/Remove(mob/removed_from)
	. = ..()

	UnregisterSignal(removed_from, COMSIG_MOB_SAY)

/datum/action/cooldown/power/gift/infectious_laughter/proc/on_mob_say(datum/source, list/speech_args)
	SIGNAL_HANDLER

	last_spoken_message = speech_args[SPEECH_MESSAGE]
	when_spoken = world.time

/datum/action/cooldown/power/gift/infectious_laughter/IsAvailable(feedback)
	. = ..()
	if(!last_spoken_message || (when_spoken + 3 TURNS < world.time))
		if(feedback)
			to_chat(owner, span_warning("You haven't said anything making a joke of the current scene in the past few moments!"))
		return FALSE

/datum/action/cooldown/power/gift/infectious_laughter/Activate(atom/target)
	. = ..()

	if(!ishuman(owner))
		return
	if(!last_spoken_message || (when_spoken + 3 TURNS < world.time))
		return
	var/mob/living/carbon/human/human_owner = owner

	owner.emote("laugh")
	playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/infectious_laughter.ogg', 50, FALSE)
	var/list/hearers = oviewers(DEFAULT_MESSAGE_RANGE, owner)
	var/highest_diff = 0
	for(var/mob/living/dice_guy in hearers)
		var/datum/splat/werewolf/rage_haver = iswerewolfsplat(dice_guy)
		if(!rage_haver)
			continue
		highest_diff = max(highest_diff, rage_haver.rage)
	var/roll = SSroll.storyteller_roll(human_owner.st_get_stat(STAT_MANIPULATION) + human_owner.st_get_stat(STAT_EMPATHY), highest_diff, owner)
	if(roll == ROLL_SUCCESS)
		for(var/mob/living/hearer in hearers)
			to_chat(hearer, span_hypnophrase("The message bounces around in your head, \"[last_spoken_message]\". You struggle to recall why you might have been mad."))
			hearer.emote("laugh")

	last_spoken_message = null
	when_spoken = 0


	// laughers.emote("laugh")

/*
/datum/action/cooldown/power/gift/open_seal
	name = "Open Seal"
	desc = "With this Gift, the Garou can open nearly any sort of closed or locked physical device."
	button_icon_state = "open_seal"
//	gnosis_req = 1

/datum/action/cooldown/power/gift/open_seal/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		for(var/obj/structure/vampdoor/V in range(5, owner))
			if(V.closed)
				if(V.lockpick_difficulty < 10)
					V.open_door(owner, TRUE)
*/

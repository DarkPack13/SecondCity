/*
From W20 p. 164
Mother's Touch
System: The player spends one Gnosis point and rolls
Intelligence + Empathy (difficulty is the target’s current
Rage, or 5 for those with no Rage). Each success heals one
level of lethal, bashing, or aggravated damage. The healer
may even heal fresh Battle Scars (see p. 259) in this man-
ner, if the Gift is applied during the same scene in which
the scar is received and an extra Gnosis point is spent.
*/
/datum/action/cooldown/power/gift/mothers_touch
	name = "Mother's Touch"
	desc = "The Garou is able to heal the wounds of any living creature, aggravated or otherwise, simply by laying hands over the afflicted area."
	button_icon_state = "mothers_touch"
	click_to_activate = TRUE
	rank = 1

	//rage_req = 1
	gnosis_req = 1

/datum/action/cooldown/power/gift/mothers_touch/Activate(atom/target)
	if(!isliving(target))
		return
	if(!(target in range(1, owner)))
		return

	. = ..()

	var/mob/living/living_owner = owner
	var/datum/splat/werewolf/werewolf_splat = iswerewolfsplat(owner)
	var/difficulty = werewolf_splat.uses_rage ? werewolf_splat.rage : 5
	var/successes = SSroll.storyteller_roll(living_owner.st_get_stat(STAT_INTELLIGENCE) + living_owner.st_get_stat(STAT_EMPATHY), difficulty, owner, TRUE)

	var/mob/living/living_target = target
	living_target.heal_storyteller_health(successes, TRUE, TRUE, TRUE)

	SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)
	StartCooldown()
	return TRUE

/*
/datum/action/cooldown/power/gift/sense_wyrm
	name = "Sense Wyrm"
	desc = "This Gift allows the werewolf to sense the presence of Wyrm."
	button_icon_state = "sense_wyrm"
	rage_req = 1

/datum/action/cooldown/power/gift/sense_wyrm/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		C.sight = SEE_MOBS|SEE_OBJS
		playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/sense_wyrm.ogg', 75, FALSE)
		to_chat(owner, span_notice("You feel your sense sharpening..."))
		spawn(200)
			C.sight = initial(C.sight)
			to_chat(owner, span_warning("You no longer sense anything more than normal..."))

/datum/action/cooldown/power/gift/spirit_speech
	name = "Spirit Speech"
	desc = "This Gift allows the Garou to communicate with encountered spirits."
	button_icon_state = "spirit_speech"
	//gnosis_req = 1

/datum/action/cooldown/power/gift/spirit_speech/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		C.see_invisible = SEE_INVISIBLE_OBSERVER
		spawn(200)
			C.see_invisible = initial(C.see_invisible)
*/

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

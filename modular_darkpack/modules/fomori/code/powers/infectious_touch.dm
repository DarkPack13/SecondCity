/datum/storyteller_roll/infectious_touch
	bumper_text = "infectious touch"
	difficulty = 7
	applicable_stats = list(STAT_STAMINA, STAT_MEDICINE)
	numerical = TRUE
	roll_output_type = ROLL_PRIVATE

/datum/storyteller_roll/infectious_touch/defender
	applicable_stats = list(STAT_STAMINA)
	roll_output_type = ROLL_NONE

/datum/action/cooldown/power/fomori_power/infectious_touch
	name = "Infectious Touch"
	desc = "Spend a willpower point to cause an unnatural sickness to set in to your target's body."
	button_icon_state = "infectious_touch"
	rank = 1 // of 1
	click_to_activate = TRUE
	willpower_cost = 1

/datum/action/cooldown/power/fomori_power/infectious_touch/Activate(atom/target)
	if(!isliving(target))
		return
	if(!(target in range(1, owner)))
		return

	. = ..()
	var/mob/living/defender = target

	to_chat(owner, span_warning("You touch [defender], intending to infect them with a grotesque illness..."))

	var/datum/storyteller_roll/roll_datum = new /datum/storyteller_roll/infectious_touch
	var/datum/storyteller_roll/roll_datum_defender = new /datum/storyteller_roll/infectious_touch/defender
	var/our_power = roll_datum.st_roll(owner)
	var/their_power = roll_datum_defender.st_roll(defender)

	playsound(get_turf(src), 'sound/items/weapons/thudswoosh.ogg', 25, TRUE, -15) // Only hearable in extreme proximity

	if(our_power > their_power)
		var/net_power = our_power - their_power
		if(get_vampire_splat(defender))
			return // Stops just before applying damage without feedback so it's not a splat detector

		addtimer(CALLBACK(src, PROC_REF(infect), target, net_power), 3 TURNS)

	StartCooldown()
	return TRUE

/datum/action/cooldown/power/fomori_power/infectious_touch/proc/feedback(mob/living/target, net_power)
	defender.apply_damage(30*net_power, TOX) // Rules as written it's supposed to be aggravated, but this is better for flavor I think.
	if(target.stat < DEAD)
		to_chat(target, span_userdanger("You feel woozy."))
		SEND_SOUND(target, 'sound/effects/wounds/sizzle2.ogg')

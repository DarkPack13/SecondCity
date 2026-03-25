// V20 p.298 + W20 p.261


/*
/client/Click(object,location,control,params)
	if(isatom(object))
		if(ishuman(mob))
			var/mob/living/carbon/human/H = mob
			if(H.in_frenzy)
				return
	..()
*/


/*
/datum/storyteller_roll/frenzy
/mob/living/carbon/proc/rollfrenzy()
	if(!client && !isnpc(src)) // I guess this is to make sure afk players dont have there characters frenzy while they arent here?
		return

	if(iskindred(src))
		to_chat(src, "I need [span_danger("<b>BLOOD</b>")]. The [span_danger("<b>BEAST</b>")] is calling. Rolling...")
	/* // DARKPACK TODO - WEREWOLF
	else if(isshifter(src))
		to_chat(src, "I'm full of [span_danger("<b>ANGER</b>")], and I'm about to flare up in [span_danger("<b>RAGE</b>")]. Rolling...")
	*/
	else
		to_chat(src, "I'm too [span_danger("<b>AFRAID</b>")] to continue doing this. Rolling...")
	SEND_SOUND(src, sound('modular_darkpack/modules/deprecated/sounds/bloodneed.ogg', volume = 50))

	var/check = SSroll.storyteller_roll(max(1, round(humanity/2)), min(frenzy_chance_boost, frenzy_hardness), src)

	// Modifier for frenzy duration
	var/length_modifier = HAS_TRAIT(src, TRAIT_DIFFICULT_FRENZY) ? 2 : 1

	switch(check)
		if (DICE_CRIT_FAILURE)
			enter_frenzy_mode()
			addtimer(CALLBACK(src, PROC_REF(exit_frenzy_mode)), 3 TURNS * length_modifier)
			frenzy_hardness = 1
		if (DICE_FAILURE)
			enter_frenzy_mode()
			addtimer(CALLBACK(src, PROC_REF(exit_frenzy_mode)), 1 TURNS * length_modifier)
			frenzy_hardness = 1
		if (DICE_CRIT_WIN)
			frenzy_hardness = max(1, frenzy_hardness - 1)
		else
			frenzy_hardness = min(10, frenzy_hardness + 1)
*/

/mob/living/carbon/proc/enter_frenzy_mode(atom/target, fleeing = FALSE)
	if(HAS_TRAIT(src, TRAIT_IN_FRENZY))
		return
	ADD_TRAIT(src, TRAIT_IN_FRENZY, FRENZY_TRAIT)
	message_admins("[ADMIN_LOOKUPFLW(src)] has entered frenzy")
	log_message("entered frenzy.", LOG_GAME)

	if(fleeing)
		to_chat(src, span_danger("FLEE."))
	else
		to_chat(src, span_bolddanger("FRENZY."))

	SEND_SOUND(src, sound('modular_darkpack/modules/frenzy/sounds/frenzy.ogg', volume = 50))

	apply_status_effect(/datum/status_effect/frenzy, target)

	// This is assuming no other interaction happens to remove it before this.
	addtimer(CALLBACK(src, PROC_REF(exit_frenzy_mode)), 3 TURNS)

/mob/living/carbon/proc/exit_frenzy_mode()
	if(!HAS_TRAIT(src, TRAIT_IN_FRENZY))
		return
	REMOVE_TRAIT(src, TRAIT_IN_FRENZY, FRENZY_TRAIT)
	log_message("exited frenzy.", LOG_GAME)

	remove_status_effect(/datum/status_effect/frenzy)

/datum/storyteller_roll/frenzy
	abstract_type = /datum/storyteller_roll/frenzy
	bumper_text = "frenzy"
	numerical = TRUE

/datum/storyteller_roll/frenzy/calculate_used_difficulty(mob/living/roller)
	. = ..()
	// V20 p.51
	if(HAS_TRAIT(roller, TRAIT_DIFFICULT_FRENZY))
		. += 2

/datum/storyteller_roll/frenzy/rotschreck
	applicable_stats = list(STAT_COURAGE)

/datum/storyteller_roll/frenzy/kindred

/mob/living/carbon/proc/trigger_rotschreck(atom/fire, difficulty = 6)
	var/datum/storyteller_roll/frenzy/rotschreck/frenzy_roll = new()
	frenzy_roll.difficulty = difficulty
	var/frenzy_result = frenzy_roll.st_roll(src, fire)
	if(frenzy_result >= 5)
		return
	// Mabye change some logic to signals as well.
	if(iskindred(src))
		enter_frenzy_mode(fire, TRUE)

/mob/living/carbon/proc/trigger_kindred_frenzy(atom/target, difficulty = 6, flavor_text = "Something")
	var/datum/splat/vampire/kindred/kindred_species = iskindred(src)
	var/stat_to_roll = kindred_species.enlightenment ? STAT_INSTINCT : STAT_SELF_CONTROL
	var/datum/storyteller_roll/frenzy/kindred/frenzy_roll = new()
	frenzy_roll.applicable_stats = list(stat_to_roll)
	frenzy_roll.difficulty = difficulty
	var/frenzy_result = frenzy_roll.st_roll(src, target)
	if(frenzy_result >= 5)
		to_chat(src, span_green("[flavor_text] almost drives you into frenzy!"))
		return
	to_chat(src, span_userdanger("[flavor_text] sends you into a frenzy!"))
	enter_frenzy_mode(target)

// Unimplemented


/mob/living/carbon/proc/can_frenzy_move()
	if(HAS_TRAIT(src, TRAIT_INCAPACITATED))
		return FALSE
	if(HAS_TRAIT(src, TRAIT_RESTRAINED))
		return FALSE

	return TRUE

/mob/living/carbon/proc/frenzystep()
	if(!isturf(loc) || can_frenzy_move())
		return
	if(move_intent == MOVE_INTENT_WALK)
		toggle_move_intent(src)

	var/atom/fear = get_closest_atom(/obj/effect/abstract/turf_fire, view(7, src), src)

	var/frenzy_target
	if(!fear && !frenzy_target)
		return

	/*
	if(get_kindred_splat(src))
		if(fear)
			step_away(src,fear,99)
			if(prob(25))
				emote("scream")
		else
			var/mob/living/carbon/human/H = src
			if(get_dist(frenzy_target, src) <= 1)
				if(isliving(frenzy_target))
					var/mob/living/L = frenzy_target
					if(L.bloodpool && L.stat != DEAD && last_drinkblood_use+95 <= world.time)
						L.grabbedby(src)
						if(ishuman(L))
							L.emote("scream")
							var/mob/living/carbon/human/BT = L
							BT.add_bite_animation()
						if(CheckEyewitness(L, src, 7, FALSE))
							H.adjust_masquerade(-1)
						playsound(src, 'modular_darkpack/modules/deprecated/sounds/drinkblood1.ogg', 50, TRUE)
						L.visible_message(span_warning("<b>[src] bites [L]'s neck!</b>"), span_warning("<b>[src] bites your neck!</b>"))
						face_atom(L)
						H.vamp_bite()
			else
				step_to(src,frenzy_target,0)
				face_atom(frenzy_target)
	else
		if(get_dist(frenzy_target, src) <= 1)
			if(isliving(frenzy_target))
				var/mob/living/L = frenzy_target
				if(L.stat != DEAD)
					a_intent = INTENT_HARM
					if(last_rage_hit+5 < world.time)
						last_rage_hit = world.time
						UnarmedAttack(L)
		else
			step_to(src,frenzy_target,0)
			face_atom(frenzy_target)
	*/

/*
/mob/living/carbon/proc/get_frenzy_targets()
	var/list/targets = list()
	if(get_kindred_splat(src))
		for(var/mob/living/L in oviewers(DEFAULT_SIGHT_DISTANCE, src))
			if(!get_kindred_splat(L) && L.bloodpool && L.stat != DEAD)
				targets += L
				if(L == frenzy_target)
					return L
	else
		for(var/mob/living/L in oviewers(DEFAULT_SIGHT_DISTANCE, src))
			if(L.stat != DEAD)
				targets += L
				if(L == frenzy_target)
					return L
	if(length(targets) > 0)
		return pick(targets)
	else
		return null
*/

/*
/mob/living/carbon/proc/handle_automated_frenzy()
	for(var/mob/living/carbon/human/npc/NPC in viewers(5, src))
		NPC.Aggro(src)
	if(isturf(loc))
		frenzy_target = get_frenzy_targets()
		if(frenzy_target)
			var/datum/cb = CALLBACK(src, PROC_REF(frenzystep))
			var/reqsteps = SSfrenzypool.wait/cached_multiplicative_slowdown
			for(var/i in 1 to reqsteps)
				addtimer(cb, (i - 1)*cached_multiplicative_slowdown)
		else
			if(!can_frenzy_move())
				if(isturf(loc))
					var/turf/T = get_step(loc, pick(NORTH, SOUTH, WEST, EAST))
					face_atom(T)
					Move(T)
*/

#warn placeholder
/mob/living/carbon/verb/manual_frenzy(atom/movable/AM as mob|obj in oview(7))
	set name = "Frenzy"
	set category = "Object"

	if(!istype(AM))
		return
	if(!issupernatural(src))
		return

	if(iskindred(src))
		trigger_kindred_frenzy(AM)
	else
		enter_frenzy_mode(AM)

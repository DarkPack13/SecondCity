// V20 p.298 + W20 p.261

// Fleeing is used for either fox frenzies, or rotschreck
/mob/living/carbon/proc/enter_frenzy_mode(atom/target, fleeing = FALSE)
	if(HAS_TRAIT(src, TRAIT_IN_FRENZY))
		return
	if(HAS_TRAIT(src, TRAIT_KNOCKEDOUT))
		return
	add_traits(list(TRAIT_IN_FRENZY, TRAIT_NOSOFTCRIT, TRAIT_ANALGESIA), FRENZY_TRAIT)
	message_admins("[ADMIN_LOOKUPFLW(src)] has entered frenzy[target ? " targeting [ADMIN_LOOKUPFLW(src)]": ""]")
	log_message("entered frenzy.", LOG_GAME)

	if(fleeing)
		to_chat(src, span_danger("FLEE."))
	else
		to_chat(src, span_bolddanger("FRENZY."))

	SEND_SOUND(src, sound('modular_darkpack/modules/frenzy/sounds/frenzy.ogg', volume = 50))

	apply_status_effect(/datum/status_effect/frenzy, target)

	// This is assuming no other interaction happens to remove it before this.
	addtimer(CALLBACK(src, PROC_REF(exit_frenzy_mode)), 1 SCENES)

/mob/living/carbon/proc/exit_frenzy_mode()
	if(!HAS_TRAIT(src, TRAIT_IN_FRENZY))
		return
	remove_traits(list(TRAIT_IN_FRENZY, TRAIT_NOSOFTCRIT, TRAIT_ANALGESIA), FRENZY_TRAIT)
	log_message("exited frenzy.", LOG_GAME)

	remove_status_effect(/datum/status_effect/frenzy)

/datum/storyteller_roll/frenzy
	abstract_type = /datum/storyteller_roll/frenzy
	bumper_text = "frenzy"
	numerical = TRUE

/datum/storyteller_roll/frenzy/rotschreck
	applicable_stats = list(STAT_COURAGE)

/datum/storyteller_roll/frenzy/kindred

// Specificly kindred as I dont really think brujah are meant to rotschreck easier.
/datum/storyteller_roll/frenzy/kindred/calculate_used_difficulty(mob/living/roller)
	. = ..()
	// V20 p.51
	if(HAS_TRAIT(roller, TRAIT_DIFFICULT_FRENZY))
		. += 2


/mob/living/carbon/proc/trigger_rotschreck(atom/fire, difficulty = 6, successes = 0)
	if(HAS_TRAIT(src, TRAIT_KNOCKEDOUT))
		return
	if(!get_kindred_splat(src))
		return

	var/datum/storyteller_roll/frenzy/rotschreck/frenzy_roll = new()
	frenzy_roll.difficulty = difficulty
	var/frenzy_result = frenzy_roll.st_roll(src, fire)
	if(frenzy_result <= 0)
		enter_frenzy_mode(fire, TRUE)
		return
	successes += frenzy_result
	if(successes >= 5)
		return

	addtimer(CALLBACK(src, PROC_REF(trigger_rotschreck), fire, difficulty, successes), 1 TURNS)


/mob/living/carbon/proc/trigger_kindred_frenzy(atom/target, difficulty = 6, successes = 0, flavor_text = "Something")
	if(HAS_TRAIT(src, TRAIT_KNOCKEDOUT))
		return
	if(!get_kindred_splat(src))
		return

	var/stat_to_roll = is_enlightenment() ? STAT_INSTINCT : STAT_SELF_CONTROL
	var/datum/storyteller_roll/frenzy/kindred/frenzy_roll = new()
	frenzy_roll.applicable_stats = list(stat_to_roll)
	frenzy_roll.difficulty = difficulty
	var/frenzy_result = frenzy_roll.st_roll(src, target)
	if(frenzy_result <= 0)
		to_chat(src, span_userdanger("[flavor_text] sends you into a frenzy!"))
		var/victim = get_closest_atom(/atom, get_frenzy_victims(), src)
		enter_frenzy_mode(victim)
		return

	successes += frenzy_result
	if(successes >= 5)
		to_chat(src, span_green("[flavor_text] almost drives you into frenzy but you steel your nerves and it subsides!"))
		return

	addtimer(CALLBACK(src, PROC_REF(trigger_kindred_frenzy), target, difficulty, successes, flavor_text), 1 TURNS)

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

	var/atom/fear = get_closest_atom(/obj/effect/abstract/turf_fire, view(DEFAULT_SIGHT_DISTANCE, src), src)

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
/mob/living/carbon/proc/handle_automated_frenzy()
	for(var/mob/living/carbon/human/npc/NPC in viewers(5, src))
		NPC.Aggro(src)
	if(isturf(loc))
		frenzy_target = get_closest_atom(/atom, get_frenzy_victims(), src)
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

/mob/living/carbon/proc/manual_frenzy(atom/movable/AM as mob|obj in oview(DEFAULT_SIGHT_DISTANCE))
	set name = "Manual Frenzy"
	set category = "Object"

	if(!istype(AM))
		return
	if(!issupernatural(src))
		return

	enter_frenzy_mode(AM)

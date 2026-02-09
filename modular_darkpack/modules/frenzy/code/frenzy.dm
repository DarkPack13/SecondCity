//Here's things for future madness

//add_client_colour(/datum/client_colour/glass_colour/red)
//remove_client_colour(/datum/client_colour/glass_colour/red)
/client/Click(object,location,control,params)
	if(isatom(object))
		if(ishuman(mob))
			var/mob/living/carbon/human/H = mob
			if(H.in_frenzy)
				return
	..()

/mob/living/carbon/proc/rollfrenzy()
	if(client)
		if(isgarou(src) || iswerewolf(src))
			to_chat(src, "I'm full of [span_danger("<b>ANGER</b>")], and I'm about to flare up in [span_danger("<b>RAGE</b>")]. Rolling...")
		else if(iskindred(src))
			to_chat(src, "I need [span_danger("<b>BLOOD</b>")]. The [span_danger("<b>BEAST</b>")] is calling. Rolling...")
		else
			to_chat(src, "I'm too [span_danger("<b>AFRAID</b>")] to continue doing this. Rolling...")
		SEND_SOUND(src, sound('modular_darkpack/modules/deprecated/sounds/bloodneed.ogg', volume = 50))

		var/check = SSroll.storyteller_roll(max(1, round(humanity/2)), min(frenzy_chance_boost, frenzy_hardness), src)

		// Modifier for frenzy duration
		var/length_modifier = HAS_TRAIT(src, TRAIT_LONGER_FRENZY) ? 2 : 1

		switch(check)
			if (DICE_CRIT_FAILURE)
				enter_frenzymod()
				addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 20 SECONDS * length_modifier)
				frenzy_hardness = 1
			if (DICE_FAILURE)
				enter_frenzymod()
				addtimer(CALLBACK(src, PROC_REF(exit_frenzymod)), 10 SECONDS * length_modifier)
				frenzy_hardness = 1
			if (DICE_CRIT_WIN)
				frenzy_hardness = max(1, frenzy_hardness - 1)
			else
				frenzy_hardness = min(10, frenzy_hardness + 1)

/mob/living/carbon/proc/enter_frenzymod()
	if (in_frenzy)
		return

	SEND_SOUND(src, sound('modular_darkpack/modules/frenzy/sounds/frenzy.ogg', volume = 50))
	in_frenzy = TRUE
	add_client_colour(/datum/client_colour/glass_colour/red)
	demon_chi = 0
	GLOB.frenzy_list += src

/mob/living/carbon/proc/exit_frenzymod()
	if (!in_frenzy)
		return

	in_frenzy = FALSE
	remove_client_colour(/datum/client_colour/glass_colour/red)
	GLOB.frenzy_list -= src

/mob/living/carbon/proc/CheckFrenzyMove()
	if(stat >= SOFT_CRIT)
		return TRUE
	if(IsSleeping())
		return TRUE
	if(IsUnconscious())
		return TRUE
	if(IsParalyzed())
		return TRUE
	if(IsKnockdown())
		return TRUE
	if(IsStun())
		return TRUE
	if(HAS_TRAIT(src, TRAIT_RESTRAINED))
		return TRUE

/mob/living/carbon/proc/frenzystep()
	if(!isturf(loc) || CheckFrenzyMove())
		return
	if(move_intent == MOVE_INTENT_WALK)
		toggle_move_intent(src)
	set_glide_size(DELAY_TO_GLIDE_SIZE(cached_multiplicative_slowdown))

	var/atom/fear = get_closest_atom(/obj/effect/abstract/turf_fire, view(7, src), src)

//	if(!fear && !frenzy_target)
//		return

	if(iskindred(src))
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

/mob/living/carbon/proc/get_frenzy_targets()
	var/list/targets = list()
	if(iskindred(src))
		for(var/mob/living/L in oviewers(DEFAULT_SIGHT_DISTANCE, src))
			if(!iskindred(L) && L.bloodpool && L.stat != DEAD)
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
			if(!CheckFrenzyMove())
				if(isturf(loc))
					var/turf/T = get_step(loc, pick(NORTH, SOUTH, WEST, EAST))
					face_atom(T)
					Move(T)

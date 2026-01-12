
/mob/living/carbon/werewolf/get_eye_protection()
	return ..() + 2 //potential cyber implants + natural eye protection

/mob/living/carbon/werewolf/get_ear_protection()
	return 2 //no ears

/mob/living/carbon/werewolf/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
	..(AM, skipcatch = TRUE, hitpush = FALSE)

/mob/living/carbon/werewolf/attack_hand(mob/living/carbon/human/M)
	. = ..()
	if(.)	//to allow surgery to return properly.
		return FALSE

	switch(M.a_intent)
		if("help")
			help_shake_act(M)
		if("grab")
			grabbedby(M)
		if ("harm")
			M.do_attack_animation(src, ATTACK_EFFECT_PUNCH)
			return TRUE
		if("disarm")
			M.do_attack_animation(src, ATTACK_EFFECT_DISARM)
			return TRUE
	return FALSE

/mob/living/carbon/werewolf/attack_animal(mob/living/simple_animal/M)
	. = ..()
	do_rage_from_attack()
	if(.)
		var/damage = rand(M.melee_damage_lower, M.melee_damage_upper)
		switch(M.melee_damage_type)
			if(BRUTE)
				adjust_brute_loss(damage)
			if(BURN)
				adjust_fire_loss(damage)
			if(TOX)
				adjustToxLoss(damage)
			if(OXY)
				adjust_oxy_loss(damage)
			if(AGGRAVATED)
				adjust_agg_loss(damage)
			if(STAMINA)
				adjust_stamina_loss(damage)

/mob/living/carbon/werewolf/ex_act(severity, target, origin)
	if(origin && istype(origin, /datum/spacevine_mutation) && isvineimmune(src))
		return
	. = ..()
	if(QDELETED(src))
		return
	var/obj/item/organ/ears/ears = getorganslot(ORGAN_SLOT_EARS)
	switch (severity)
		if (EXPLODE_DEVASTATE)
			gib()
			return

		if (EXPLODE_HEAVY)
			take_overall_damage(60, 60)
			if(ears)
				ears.adjustEarDamage(30,120)

		if(EXPLODE_LIGHT)
			take_overall_damage(30,0)
			if(prob(50))
				Unconscious(20)
			if(ears)
				ears.adjustEarDamage(15,60)

/mob/living/carbon/werewolf/soundbang_act(intensity = 1, stun_pwr = 20, damage_pwr = 5, deafen_pwr = 15)
	return 0

/mob/living/carbon/werewolf/acid_act(acidpwr, acid_volume)
	return FALSE//aliens are immune to acid.

/mob/living/carbon/werewolf/attack_hand(mob/living/carbon/human/M)
	if(..())
		switch(M.a_intent)
			if ("harm")
				var/damage = rand(1, 9)
				if (prob(90))
					playsound(loc, "punch", 25, TRUE, -1)
					visible_message(span_danger("[M] punches [src]!"), \
									span_userdanger("[M] punches you!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), COMBAT_MESSAGE_RANGE, M)
					to_chat(M, span_danger("You punch [src]!"))
					if ((stat != DEAD) && (damage > 9 || prob(5)))//Regular humans have a very small chance of knocking an alien down.
						Unconscious(3 SECONDS)
						visible_message(span_danger("[M] knocks [src] down!"), \
										span_userdanger("[M] knocks you down!"), span_hear("You hear a sickening sound of flesh hitting flesh!"), null, M)
						to_chat(M, span_danger("You knock [src] down!"))
					var/obj/item/bodypart/affecting = get_bodypart(ran_zone(M.zone_selected))
					apply_damage(damage, BRUTE, affecting)
					log_combat(M, src, "attacked")
				else
					playsound(loc, 'sound/items/weapons/punchmiss.ogg', 25, TRUE, -1)
					visible_message(span_danger("[M]'s punch misses [src]!"), \
									span_danger("You avoid [M]'s punch!"), span_hear("You hear a swoosh!"), COMBAT_MESSAGE_RANGE, M)
					to_chat(M, span_warning("Your punch misses [src]!"))

			if ("disarm")
				if (body_position == STANDING_UP)
					if (prob(5))
						Unconscious(3 SECONDS)
						playsound(loc, 'sound/items/weapons/thudswoosh.ogg', 50, TRUE, -1)
						log_combat(M, src, "pushed")
						visible_message(span_danger("[M] pushes [src] down!"), \
										span_userdanger("[M] pushes you down!"), span_hear("You hear aggressive shuffling followed by a loud thud!"), null, M)
						to_chat(M, span_danger("You push [src] down!"))
					else
						if (prob(50))
							dropItemToGround(get_active_held_item())
							playsound(loc, 'sound/items/weapons/thudswoosh.ogg', 50, TRUE, -1)
							visible_message(span_danger("[M] disarms [src]!"), \
											span_userdanger("[M] disarms you!"), span_hear("You hear aggressive shuffling!"), COMBAT_MESSAGE_RANGE, M)
							to_chat(M, span_danger("You disarm [src]!"))
						else
							playsound(loc, 'sound/items/weapons/punchmiss.ogg', 25, TRUE, -1)
							visible_message(span_danger("[M] fails to disarm [src]!"),\
											span_danger("[M] fails to disarm you!"), span_hear("You hear a swoosh!"), COMBAT_MESSAGE_RANGE, M)
							to_chat(M, span_warning("You fail to disarm [src]!"))



/mob/living/carbon/werewolf/crinos/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!no_effect && !visual_effect_icon)
		visual_effect_icon = ATTACK_EFFECT_CLAW
	. = ..()

/mob/living/carbon/werewolf/lupus/do_attack_animation(atom/A, visual_effect_icon, obj/item/used_item, no_effect)
	if(!no_effect && !visual_effect_icon)
		visual_effect_icon = ATTACK_EFFECT_BITE
	. = ..()

/mob/living/carbon/werewolf/getarmor(def_zone, type)
	if(type == BRUTE)
		return werewolf_armor
	else
		return 0

/mob/living/carbon/human/proc/drinksomeblood(mob/living/victim,  first_drink = FALSE)
	COOLDOWN_START(src, drinkblood_use_cd, 3 SECONDS)
	update_drinking_overlay(victim)

	if(HAS_TRAIT(src, TRAIT_BLOODY_SUCKER))
		src.emote("moan")
		Immobilize(30, TRUE)

	if(isnpc(victim))
		var/mob/living/carbon/human/npc/NPC = victim
		NPC.danger_source = null
		victim.Stun(40) //NPCs don't get to resist

	if(victim.blood_volume <= BLOOD_VOLUME_BAD)
		to_chat(src, span_warning("Your victim's heart beats only weakly. Death comes for them."))

	//Check if we can drink this person to death
	if(victim.bloodpool <= 0 && !check_can_drink_dry(victim))
		remove_drinking_overlay(victim)
		return


	if(victim.bloodpool <= 1 && victim.maxbloodpool > 1)
		to_chat(src, span_warning("You feel small amount of <b>BLOOD</b> in your victim."))

	if(!HAS_TRAIT(src, TRAIT_BLOODY_LOVER))
		SEND_SIGNAL(src, COMSIG_MASQUERADE_VIOLATION)

	if(!do_after(src, 3 SECONDS, target = victim, timed_action_flags = NONE, progress = FALSE))
		remove_drinking_overlay(victim)
		if(!(SEND_SIGNAL(victim, COMSIG_MOB_VAMPIRE_SUCKED, victim) & COMPONENT_RESIST_VAMPIRE_KISS))
			victim.apply_status_effect(/datum/status_effect/kissed)
		return

	victim.adjust_blood_pool(-1)
	suckbar.icon_state = "[round(14*(victim.bloodpool/victim.maxbloodpool))]"
	if(ishuman(victim))
		var/mob/living/carbon/human/H = victim
		drunked_of |= "[H.dna.real_name]"

		if(!iskindred(victim))
			H.blood_volume = max(H.blood_volume-50, 150)

		if(H.reagents)
			H.reagents.trans_to(src, min(10, H.reagents.total_volume), transferred_by = victim, methods = INGEST)

	if(HAS_TRAIT(src, TRAIT_PAINFUL_VAMPIRE_KISS))
		victim.adjust_brute_loss(20, TRUE)

	//Ventrue can suck on normal people, but not homeless people and animals.
	//BLOOD_QUALITY_LOV - 1, BLOOD_QUALITY_NORMAL - 2, BLOOD_QUALITY_HIGH - 3. Blue blood gives +1 to suction
	if(HAS_TRAIT(src, TRAIT_FEEDING_RESTRICTION) && victim.bloodquality < BLOOD_QUALITY_NORMAL)
		to_chat(src, span_warning("You are too privileged to drink that awful <b>BLOOD</b>. Go get something better."))
		visible_message(span_danger("[src] throws up!"), span_userdanger("You throw up!"))
		playsound(get_turf(src), 'modular_darkpack/modules/deprecated/sounds/vomit.ogg', 75, TRUE)
		if(isturf(loc))
			add_splatter_floor(loc)
		remove_drinking_overlay(victim)
		return

	if(iskindred(victim))
		to_chat(src, span_userdanger("[victim]'s blood tastes HEAVENLY..."))
		adjust_brute_loss(-25, TRUE)
		adjust_fire_loss(-25, TRUE)
	else
		to_chat(src, span_warning("You sip some <b>BLOOD</b> from your victim. It feels good."))

	var/drink_mod = calculate_drink_modifier(victim)

	if(drink_mod)
		adjust_blood_pool(drink_mod*max(1, victim.bloodquality-1))
		adjust_brute_loss(-10, TRUE)
		adjust_fire_loss(-10, TRUE)
		update_damage_overlays()
		update_health_hud()

	if(victim.bloodpool <= 0)
		handle_drink_dry(victim)
		remove_drinking_overlay(victim)
		return

	if(grab_state >= GRAB_PASSIVE)
		stop_sound_channel(CHANNEL_BLOOD)
		drinksomeblood(victim)

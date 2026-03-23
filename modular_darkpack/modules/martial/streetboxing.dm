#define UPPERCUT_COMBO "HDH"
#define JAB_COMBO "GHH"
#define CROSS_COMBO "DHH"
#define DIRTY_COMBO "GD"

/datum/martial_art/darkpack_boxing
	name = "Kung Fu"
	id = MARTIALART_DARKPACK_BOXING
	help_verb = /mob/living/proc/streetboxing_help
	display_combos = TRUE
	grab_state_modifier = 1


/datum/martial_art/darkpack_boxing/activate_style(mob/living/new_holder)
	. = ..()
	//RegisterSignal(new_holder, COMSIG_ATOM_ATTACKBY, PROC_REF(on_attackby))
	RegisterSignal(new_holder, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(check_dodge))
	if (iscarbon(new_holder))
		var/list/obj/item/bodypart/affected_bodyparts
		var/mob/living/carbon/human/carbon_owner = new_holder
		for (var/obj/item/bodypart/limb as anything in carbon_owner.bodyparts)
			if (!istype(limb, /obj/item/bodypart/arm) && !istype(limb, /obj/item/bodypart/leg))
				continue

			LAZYADD(affected_bodyparts, limb)

			//limb.unarmed_damage_low += 5 Unsure on this one
			//limb.unarmed_damage_high += 5
			//limb.unarmed_attack_sound = 'modular_darkpack/modules/martial/sounds/harmboxing.ogg'

/datum/martial_art/darkpack_boxing/deactivate_style(mob/living/remove_from)
	UnregisterSignal(remove_from, list(COMSIG_LIVING_CHECK_BLOCK))
	return ..()

/datum/martial_art/darkpack_boxing/proc/check_streak(mob/living/attacker, mob/living/defender)

	if(findtext(streak,UPPERCUT_COMBO))
		reset_streak()
		return uppercut(attacker, defender)

	if(findtext(streak,JAB_COMBO))
		reset_streak()
		return jab_combo(attacker, defender)

	if(findtext(streak,CROSS_COMBO))
		reset_streak()
		return cross_punch(attacker, defender)

	if(findtext(streak,DIRTY_COMBO))
		reset_streak()
		return dirty_hit(attacker, defender)

	return FALSE

/// Frontal Kick: Harm Disarm combo, knocks back relative to Attacker Str - Defender Fort
/datum/martial_art/darkpack_boxing/proc/uppercut(mob/living/attacker, mob/living/defender)
	attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
	uppercut_animation(attacker)
	addtimer(CALLBACK(src, PROC_REF(reset_animation), attacker, FALSE), 0.1 SECONDS)
	defender.visible_message(
		span_warning("[attacker] uppercuts [defender] square in the jaw, sending you flying"),
		span_userdanger("You are uppercut in the jaw by [attacker], sending you flying!"),
		span_hear("You hear a sickening sound of flesh hitting flesh!"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)

	playsound(attacker, 'modular_darkpack/modules/martial/sounds/uppercut.ogg', 50, TRUE, -1)
	var/atom/throw_target = get_edge_target_turf(defender, attacker.dir)
	var/throw_distance = clamp((attacker.st_get_stat(STAT_STRENGTH) - defender.st_get_stat(STAT_STAMINA)), 1, 3)
	defender.throw_at(throw_target, throw_distance, 4, attacker)
	defender.apply_damage(6 * attacker.st_get_stat(STAT_STRENGTH), attacker.get_attack_type(), BODY_ZONE_HEAD)
	log_combat(attacker, defender, "Frontal Kicked (Kungfu)")
	return TRUE

/// Jab Combo: Hit the other guy twice in quick succession
/datum/martial_art/darkpack_boxing/proc/jab_combo(mob/living/attacker, mob/living/defender)
	attacker.do_attack_animation(defender, ATTACK_EFFECT_PUNCH)
	playsound(attacker, 'modular_darkpack/modules/martial/sounds/jabcombo.ogg', 50, TRUE, -1)
	defender.visible_message(span_warning("[attacker] rapidly jabs [defender]'s head!"), \
				span_userdanger("You are jabbed in the head by [attacker], leaving you disoriented!"), span_hear("You hear a sickening sound of knuckles hitting flesh!"), COMBAT_MESSAGE_RANGE, attacker)
	defender.adjust_stamina_loss(45)
	defender.apply_damage(20, attacker.get_attack_type(), BODY_ZONE_HEAD)
	defender.adjust_dizzy_up_to(10 SECONDS, 10 SECONDS)
	log_combat(attacker, defender, "Jab Combo'd (Boxing)")
	return TRUE

/// Cross Punch: Figure out
/datum/martial_art/darkpack_boxing/proc/cross_punch(mob/living/attacker, mob/living/defender)
	attacker.do_attack_animation(defender, ATTACK_EFFECT_KICK)
	playsound(attacker, 'modular_darkpack/modules/martial/sounds/grabbed.ogg', 70, TRUE, -1)
	defender.visible_message(
		span_warning("[attacker] violently slams [attacker.p_their()] knee into [defender]!"),
		span_userdanger("You slam your knee straight into [defender]!"),
		span_hear("You hear a sickening sound of flesh hitting flesh!"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)
	var/roll_success = SSroll.storyteller_roll((attacker.st_get_stat(STAT_STRENGTH) + attacker.st_get_stat(STAT_BRAWL)), difficulty = 8, roller = attacker)
	if(roll_success)
		defender.Knockdown(3 SECONDS)
	defender.apply_damage(40, STAMINA)
	defender.adjust_silence_up_to(5 SECONDS, 5 SECONDS)
	log_combat(attacker, defender, "kneed in the stomach (Kung-Fu)")
	return TRUE

/// Dirty Move: Liver Punch or something
/datum/martial_art/darkpack_boxing/proc/dirty_hit(mob/living/attacker, mob/living/defender)
	attacker.do_attack_animation(defender, ATTACK_EFFECT_KICK)
	playsound(attacker, 'modular_darkpack/modules/martial/sounds/grabbed.ogg', 70, TRUE, -1)
	defender.visible_message(
		span_warning("[attacker] violently slams [attacker.p_their()] knee into [defender]!"),
		span_userdanger("You slam your knee straight into [defender]!"),
		span_hear("You hear a sickening sound of flesh hitting flesh!"),
		COMBAT_MESSAGE_RANGE,
		attacker,
	)
	var/roll_success = SSroll.storyteller_roll((attacker.st_get_stat(STAT_STRENGTH) + attacker.st_get_stat(STAT_BRAWL)), difficulty = 8, roller = attacker)
	if(roll_success)
		defender.Knockdown(3 SECONDS)
	defender.apply_damage(40, STAMINA)
	defender.adjust_silence_up_to(5 SECONDS, 5 SECONDS)
	log_combat(attacker, defender, "kneed in the stomach (Kung-Fu)")
	return TRUE

/datum/martial_art/darkpack_boxing/grab_act(mob/living/attacker, mob/living/defender)
	if(defender.check_block(attacker, 0, "[attacker]'s grab", UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	add_to_streak("G", defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS
	defender.apply_damage(15, STAMINA)
	return MARTIAL_ATTACK_INVALID //Boxing is not known for holds at all

/datum/martial_art/darkpack_boxing/harm_act(mob/living/attacker, mob/living/defender)
	if(defender.check_block(attacker, 10, attacker.name, UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	add_to_streak("H", defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS

	return MARTIAL_ATTACK_INVALID //You're gonna punch someone in the face normally and like it

/datum/martial_art/darkpack_boxing/disarm_act(mob/living/attacker, mob/living/defender)
	if(!can_deflect(attacker)) //you arent swiping at someone on the ground
		return MARTIAL_ATTACK_INVALID
	if(defender.check_block(attacker, 0, attacker.name, UNARMED_ATTACK))
		return MARTIAL_ATTACK_FAIL

	add_to_streak("D", defender)
	if(check_streak(attacker, defender))
		return MARTIAL_ATTACK_SUCCESS

	//playsound(defender, 'modular_darkpack/modules/martial/sounds/swipe.ogg', 25, TRUE, -1)
	defender.apply_damage(20, STAMINA)
	return MARTIAL_ATTACK_INVALID //Essentially taking a swipe at their face

/datum/martial_art/darkpack_boxing/proc/can_deflect(mob/living/user)
	if(!can_use(user) || !user.combat_mode)
		return FALSE
	if(INCAPACITATED_IGNORING(user, INCAPABLE_GRAB)) //NO STUN
		return FALSE
	if(!(user.mobility_flags & MOBILITY_USE)) //NO UNABLE TO USE
		return FALSE
	if(HAS_TRAIT(user, TRAIT_HULK)) //NO HULK
		return FALSE
	if(!isturf(user.loc)) //NO MOTHERFLIPPIN MECHS!
		return FALSE
	return TRUE

/datum/martial_art/darkpack_boxing/proc/reset_animation(mob/living/user, fadein)
	if(fadein)
		animate(user, alpha = 225, time = 0.1 SECONDS)
		return
	else
		animate(user, alpha = 225, pixel_x = 0, pixel_y = 0, time = 0.1 SECONDS)

/datum/martial_art/darkpack_boxing/proc/dodge_animation(mob/living/user)
	var/new_pixel_x
	var/new_pixel_y
	var/userdir = user.dir
	switch(userdir)
		if(EAST)
			new_pixel_x = rand(-16, -8)
			new_pixel_y = rand(-24, 24)
		if(WEST)
			new_pixel_x = rand(8, 16)
			new_pixel_y = rand(-24, 24)
		if(NORTH)
			new_pixel_x = rand(-16,16)
			new_pixel_y = rand(-16, -8)
		if(SOUTH)
			new_pixel_x = rand(-16,16)
			new_pixel_y = rand(8, 16)
	animate(user, alpha = 200, pixel_x = new_pixel_x, pixel_y = new_pixel_y, time = 0.2 SECONDS)

/datum/martial_art/darkpack_boxing/proc/uppercut_animation(mob/living/user)
	var/new_pixel_x
	var/new_pixel_y
	var/userdir = user.dir
	switch(userdir)
		if(EAST)
			new_pixel_x = rand(0, 4)
			new_pixel_y = rand(0, 12)
		if(WEST)
			new_pixel_x = rand(-4, 0)
			new_pixel_y = rand(0, 12)
		if(NORTH)
			new_pixel_y = rand(0, 12)
		if(SOUTH)
			new_pixel_y = rand(0, 12)
	animate(user, alpha = 200, pixel_x = new_pixel_x, pixel_y = new_pixel_y, time = 0.2 SECONDS)

/// Like the hit game "Punch Out!!"" (1984) you can dodge incoming punches at you.. melee weapons and projectiles? not so lucky
/datum/martial_art/darkpack_boxing/proc/check_dodge(mob/living/user, atom/movable/hitby, damage, attack_text, attack_type, ...)
	SIGNAL_HANDLER

	var/determine_avoidance = ((user.st_get_stat(STAT_ATHLETICS) + user.st_get_stat(STAT_DEXTERITY) + user.st_get_stat(STAT_BRAWL)) * 2) //Theoretical max of 40% with Cel 5

	if(!can_deflect(user))
		return

	if(user.throw_mode) //Theoretical max of 80% with Cel 5
		determine_avoidance *= 2

	if(attack_type != UNARMED_ATTACK)
		return NONE

	if(!prob(determine_avoidance))
		return NONE

	user.visible_message(
		span_danger("[user] cleanly dodges [attack_text] with incredible speed!"),
		span_userdanger("You dodge [attack_text]"),
	)
	playsound(user.loc, 'sound/items/weapons/punchmiss.ogg', 25, TRUE, -1)
	var/mob/living/attacker = GET_ASSAILANT(hitby)
	user.setDir(turn(attacker.dir, 180))
	var/mob/living/carbon/human/dodger = user
	dodge_animation(dodger)
	addtimer(CALLBACK(src, PROC_REF(reset_animation), dodger, FALSE), 0.1 SECONDS)


	return SUCCESSFUL_BLOCK

/mob/living/proc/streetboxing_help()
	set name = "Recall Teachings"
	set desc = "Remember the martial techniques of the Kung-Fu"
	set category = "Martial Arts"

	to_chat(usr, span_info("<b><i>You retreat inward and recall your past training</i></b>"))
	to_chat(usr, "[span_notice("Frontal Kick")]: Punch Shove. Launch your opponent away from you with incredible force!")
	to_chat(usr, "[span_notice("Roundhouse Kick")]: Shove Shove. Nonlethally kick an opponent to the floor, knocking them down, discombobulating them and dealing substantial stamina damage. If they're already prone, disarm them as well.")
	to_chat(usr, "[span_notice("Flying Knee")]: Grab Punch. Deliver a knee jab into the opponent, dealing high stamina damage, as well as briefly stunning them, winding them and making it difficult for them to speak.")
	to_chat(usr, "[span_notice("Grabs and Shoves")]: While in combat mode, your typical grab and shove do decent stamina damage, and your grabs harder to break. If you grab someone who has substantial amounts of stamina damage, you knock them out!")

#undef UPPERCUT_COMBO
#undef JAB_COMBO
#undef CROSS_COMBO
#undef DIRTY_COMBO

/obj/item/clothing/gloves/boxing_gloves
	name = "Debugging Gloves"
	desc = "Delete at some point"
	icon_state = "black"
	greyscale_colors = COLOR_BLACK
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE

/obj/item/clothing/gloves/boxing_gloves/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/martial_art_giver, /datum/martial_art/darkpack_boxing)


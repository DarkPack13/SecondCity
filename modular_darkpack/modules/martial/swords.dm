/*
#define ATTACK_STRIKE "Hilt Strike"
#define ATTACK_SLICE "Wide Slice"
#define ATTACK_CUT "Tendon Cut"

/obj/item/testing_katana
	name = "testing katana"
	desc = "It's a regular Katana.. like one of those japanese animes."
	icon = 'icons/obj/mining_zones/artefacts.dmi'
	icon_state = "cursed_katana"
	icon_angle = -45
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	force = 15
	armour_penetration = 30
	block_chance = 30
	block_sound = 'sound/items/weapons/parry.ogg'
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_HUGE
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | FREEZE_PROOF
	var/static/list/combo_list = list(
		ATTACK_STRIKE = list(COMBO_STEPS = list(LEFT_ATTACK, LEFT_ATTACK, RIGHT_ATTACK), COMBO_PROC = PROC_REF(strike)),
		ATTACK_SLICE = list(COMBO_STEPS = list(RIGHT_ATTACK, LEFT_ATTACK, LEFT_ATTACK), COMBO_PROC = PROC_REF(slice)),
		ATTACK_CUT = list(COMBO_STEPS = list(RIGHT_ATTACK, RIGHT_ATTACK, LEFT_ATTACK), COMBO_PROC = PROC_REF(cut)),
	)
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

/obj/item/testing_katana/Initialize(mapload)
	. = ..()
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple)
	AddComponent( \
		/datum/component/combo_attacks, \
		combos = combo_list, \
		max_combo_length = 3, \
		examine_message = span_notice("<i>This seems to be a skilled weapon... perhaps I could use my experience?</i>"), \
		reset_message = "you return to neutral stance", \
		can_attack_callback = CALLBACK(src, PROC_REF(can_combo_attack)) \
	)

/obj/item/testing_katana/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	var/datum/storyteller_roll/melee_block/parry_roll = new()
	var/puller_result = parry_roll.st_roll(owner, src)
	final_block_chance = puller_result * 5 //I dont see what can go wrong with allowing a theoretical 100% parry chance for an individual hit. There was infact something wrong
	return ..()

/obj/item/testing_katana/proc/can_combo_attack(mob/living/carbon/user, mob/living/target) //prevents the unworthy from properly using blades
	return target.stat != DEAD && target != user && (user.st_get_stat(STAT_MELEE) >= 4)

/obj/item/testing_katana/proc/strike(mob/living/target, mob/user)
	user.visible_message(span_warning("[user] strikes [target] with [src]'s hilt!"),
		span_notice("You hilt strike [target]!"))
	to_chat(target, span_userdanger("You've been struck by [user]!"))
	playsound(src, 'sound/items/weapons/genhit3.ogg', 50, TRUE)
	RegisterSignal(target, COMSIG_MOVABLE_IMPACT, PROC_REF(strike_throw_impact))
	var/atom/throw_target = get_edge_target_turf(target, user.dir)
	target.throw_at(throw_target, 5, 3, user, FALSE, gentle = TRUE)
	target.apply_damage(damage = 17, exposed_wound_bonus = 10)
	to_chat(target, span_userdanger("You've been struck by [user]!"))
	user.do_attack_animation(target, ATTACK_EFFECT_PUNCH)

/obj/item/testing_katana/proc/strike_throw_impact(mob/living/source, atom/hit_atom, datum/thrownthing/thrownthing)
	SIGNAL_HANDLER

	UnregisterSignal(source, COMSIG_MOVABLE_IMPACT)
	if(isclosedturf(hit_atom))
		source.apply_damage(damage = 5)
		if(ishostile(source))
			var/mob/living/simple_animal/hostile/target = source
			target.ranged_cooldown += 5 SECONDS
		else if(iscarbon(source))
			var/mob/living/carbon/target = source
			target.set_confusion_if_lower(8 SECONDS)
	return NONE

/obj/item/testing_katana/proc/slice(mob/living/target, mob/user)
	user.visible_message(span_warning("[user] does a wide slice!"),
		span_notice("You do a wide slice!"))
	playsound(src, 'sound/items/weapons/bladeslice.ogg', 50, TRUE)
	user.do_item_attack_animation(target, used_item = src, animation_type = ATTACK_ANIMATION_SLASH)
	var/turf/user_turf = get_turf(user)
	var/dir_to_target = get_dir(user_turf, get_turf(target))
	var/static/list/testing_katana_slice_angles = list(0, -45, 45, -90, 90) //so that the animation animates towards the target clicked and not towards a side target
	for(var/iteration in testing_katana_slice_angles)
		var/turf/turf = get_step(user_turf, turn(dir_to_target, iteration))
		user.do_attack_animation(turf, ATTACK_EFFECT_SLASH)
		for(var/mob/living/additional_target in turf)
			if(user.Adjacent(additional_target) && additional_target.density)
				additional_target.apply_damage(damage = 15, sharpness = SHARP_EDGED, exposed_wound_bonus = 10)
				to_chat(additional_target, span_userdanger("You've been sliced by [user]!"))
	target.apply_damage(damage = 5, sharpness = SHARP_EDGED, wound_bonus = 10)

/obj/item/testing_katana/proc/cut(mob/living/target, mob/user)
	user.visible_message(span_warning("[user] cuts [target]'s tendons!"),
		span_notice("You tendon cut [target]!"))
	to_chat(target, span_userdanger("Your tendons have been cut by [user]!"))
	user.do_item_attack_animation(target, used_item = src, animation_type = ATTACK_ANIMATION_SLASH)
	target.apply_damage(damage = 15, sharpness = SHARP_EDGED, wound_bonus = 15)
	user.do_attack_animation(target, ATTACK_EFFECT_DISARM)
	playsound(src, 'sound/items/weapons/rapierhit.ogg', 50, TRUE)
	var/datum/status_effect/stacking/saw_bleed/bloodletting/status = target.has_status_effect(/datum/status_effect/stacking/saw_bleed/bloodletting)
	if(!status)
		target.apply_status_effect(/datum/status_effect/stacking/saw_bleed/bloodletting, 6)
	else
		status.add_stacks(6)

#undef ATTACK_STRIKE
#undef ATTACK_SLICE
#undef ATTACK_CUT
*/

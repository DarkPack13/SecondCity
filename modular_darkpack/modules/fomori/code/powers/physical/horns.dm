/datum/action/cooldown/mob_cooldown/charge/basic_charge/fomor_horns
	name = "Gore"
	button_icon = 'modular_darkpack/modules/fomori/icons/fomori_abilities.dmi'
	button_icon_state = "horns_charge"
	cooldown_time = 1 TURNS
	recoil_duration = 1 SECONDS
	destroy_objects = FALSE
	var/turf/starting_point

/datum/action/cooldown/mob_cooldown/charge/basic_charge/fomor_horns/on_moved(atom/source)
	move_sound = "sound/effects/footstep/asteroid[rand(1,5)].ogg"
	. = ..()

/datum/action/cooldown/mob_cooldown/charge/basic_charge/fomor_horns/Activate(atom/target_atom)
	var/mob/living/carbon/human/jumper = owner
	var/strength = jumper.st_get_stat(STAT_STRENGTH)
	var/athletics = jumper.st_get_stat(STAT_ATHLETICS)

	charge_distance = clamp((4 + 0.75 + max(0,(strength -1)) * 0.5 + athletics), 1, 10)

	charge_damage = strength+2 TTRPG_DAMAGE

	. = ..()

/datum/action/cooldown/mob_cooldown/charge/basic_charge/fomor_horns/hit_target(atom/movable/source, mob/living/target, damage_dealt)
	. = ..()
	if(get_dist(starting_point, get_turf(owner)) > 10) // Unlikely to ever happen but "Strength+4 if the target just moved 10 yards or more". We're assuming a tile is 1 yard.
		damage_dealt += 4 TTRPG_DAMAGE // Holy whopper. We're looking at a max of 110 Aggravated damage if someone pulls off the omega-tipper.

	target.apply_damage(damage_dealt, AGGRAVATED)
	playsound(get_turf(target), hit_sound, 100, TRUE)
	shake_camera(target, 4, 3)
	shake_camera(source, 2, 3)
	GLOB.move_manager.stop_looping(source)
	charge_end(source)

/datum/action/cooldown/mob_cooldown/charge/basic_charge/fomor_horns/do_charge(atom/movable/charger, atom/target_atom, delay, past)
	. = ..()
	if(!isliving(charger))
		return
	apply_post_charge(charger)

/datum/action/cooldown/mob_cooldown/charge/basic_charge/fomor_horns/proc/apply_post_charge(mob/living/charger)
	charger.apply_status_effect(/datum/status_effect/tired_post_charge)

/datum/bodypart_overlay/simple/fomor_horns // Freak Legion pg.31
	icon_state = "horns"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_sprite_accessories.dmi'
	layers = LOW_FACEMASK_LAYER

/datum/action/cooldown/power/fomori_power/horns
	name = "Horns"
	desc = "Use the grotesque horns atop your head to charge and gore your enemies."
	button_icon_state = "horns"
	rank = 1 // of 1

	fomor_part = /datum/bodypart_overlay/simple/fomor_horns

	var/datum/action/cooldown/mob_cooldown/charge/basic_charge/fomor_horns/linked_charge

/datum/action/cooldown/power/fomori_power/horns/Activate(atom/target)
	. = ..()
	toggle_feature(deployed)

	if(deployed)
		linked_charge.Remove(owner)
		QDEL_NULL(linked_charge)
		deployed = FALSE
	else
		linked_charge = new
		linked_charge.Grant(owner)
		deployed = TRUE

/datum/discipline/obeah
	name = "Obeah"
	desc = "Use your third eye in healing or protecting needs."
	icon_state = "obeah"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/obeah

/datum/discipline_power/obeah
	name = "Valeren power name"
	desc = "Valeren power description"

	activate_sound = 'modular_darkpack/modules/powers/sounds/obeah.ogg'

//SENSE VITALITY
/datum/discipline_power/obeah/sense_vitality
	name = "Sense Vitality"
	desc = "Focus your senses to read the vitality of a target."

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND
	target_type = TARGET_MOB | TARGET_SELF
	range = 1
	vitae_cost = 0
	cooldown_length = 1 TURNS
	violates_masquerade = TRUE

// perception + empathy at diff 7
// 1 success = splat
// 2 success = splat + vitals
// 3 success = splat + vital + current bloodpool
/datum/discipline_power/obeah/sense_vitality/activate(mob/living/target)
	. = ..()
	var/datum/storyteller_roll/sense_vitality_roll = new()
	sense_vitality_roll.applicable_stats = list(STAT_PERCEPTION, STAT_EMPATHY)
	sense_vitality_roll.difficulty = 7
	sense_vitality_roll.numerical = TRUE
	sense_vitality_roll.roll_output_type = ROLL_PRIVATE_ADMIN
	var/roll_result = sense_vitality_roll.st_roll(owner)

	var/list/render_list = list()
	render_list = do_roll_results(target, roll_result)
	to_chat(owner, custom_boxed_message("blue_box", jointext(render_list, "")), type = MESSAGE_TYPE_INFO)

/datum/discipline_power/obeah/sense_vitality/proc/do_roll_results(mob/living/target, roll_result)
	var/list/render_list = list()
	if(roll_result < 1)
		render_list += span_danger("You fail to sense anything.\n")
		return render_list

	// One Success.
	var/datum/splat/sensed_splat = LAZYACCESS(target.splats, 1)
	render_list += span_notice("You identify them to be a [sensed_splat ? sensed_splat.name : "Human"].\n")

	if(roll_result < 2)
		return render_list
	// Two Successes.
	render_list += custom_boxed_message("blue_box", healthscan(user = owner, target = target, mode = SCANNER_VERBOSE, advanced = TRUE, tochat = FALSE))

	if(roll_result < 3)
		return render_list
	// Three Successes.
	var/mob/living/carbon/human/target_human = target
	var/bloodpool = target_human?.bloodpool
	render_list += span_notice("You sense they have [bloodpool ? bloodpool : "no"] Vitae remaining.\n")
	return render_list

//////////////////////////////////////////////////////////////////////////////////////////////////////////

//ANESTHETIC TOUCH
/datum/discipline_power/obeah/anesthetic_touch
	name = "Anesthetic Touch"
	desc = "Soothe your patient's pain, or put them to peaceful sleep."

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND
	target_type = TARGET_LIVING
	range = 1
	cooldown_length = 1 TURNS
	violates_masquerade = TRUE

// TO DO, make this use two mouse buttons instead of radial menu.
// LMB: Block someone's pain
// RMB: Put mortal to sleep.
/datum/discipline_power/obeah/anesthetic_touch/activate(mob/living/target)
	. = ..()
	var/chosen_option = show_radial_menu(owner, target, list("Soothe Pain", "Put To Sleep"), radius = 38, require_near = TRUE)
	switch(chosen_option)
		if("Soothe Pain")
			ADD_TRAIT(target, TRAIT_IGNORESLOWDOWN, DISCIPLINE_TRAIT(type))
			addtimer(CALLBACK(src, PROC_REF(end_soothe_pain), target), 1 SCENES)
		if("Put To Sleep")
			if(get_kindred_splat(target))
				to_chat(owner, span_warning("You can't put a Kindred to sleep with this power!"))
				return TRUE
			target.SetSleeping(10 SCENES) // 30 minutes if left alone
			target.adjust_blood_pool(1) // Mortal regains a blood point.
	return TRUE

/datum/discipline_power/obeah/anesthetic_touch/proc/end_soothe_pain(mob/living/target)
	REMOVE_TRAIT(target, TRAIT_IGNORESLOWDOWN, DISCIPLINE_TRAIT(type))

//////////////////////////////////////////////////////////////////////////////////////////////////////////

//CORPORE SANO
/datum/discipline_power/obeah/corpore_sano
	name = "Corpore Sano"
	desc = "Lay hands on your patient and heal their wounds."

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	target_type = TARGET_LIVING
	range = 1

	violates_masquerade = TRUE
	cooldown_length = 1 TURNS

/datum/discipline_power/obeah/corpore_sano/activate(atom/target)
	. = ..()
	var/mob/living/living_target = target
	if(living_target.get_agg_loss() && (owner.bloodpool >= 1))
		owner.adjust_blood_pool(-1)
		living_target.heal_storyteller_health(dots_to_heal = 1, heal_aggravated = TRUE, heal_scars = TRUE, heal_blood = TRUE)
	else
		living_target.heal_storyteller_health(dots_to_heal = 1, heal_aggravated = FALSE, heal_scars = TRUE, heal_blood = TRUE)

// Radius - the length of the line you draw from the central point of a circle towards any point of the outer boundary, which in geometry is called the circumference.
#define SHEPHERDS_WATCH_RADIUS 3
/datum/discipline_power/obeah/shepherds_watch
	name = "Shepherd's Watch"
	desc = "Create a supernatural barrier to protect yourself from harm."

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	violates_masquerade = TRUE
	cooldown_length = 1 TURNS
	duration_length = 1 TURNS
	willpower_cost = 2
	cancelable = TRUE
	var/datum/proximity_monitor/advanced/shepherds_watch/area_of_effect

/datum/discipline_power/obeah/shepherds_watch/activate(atom/target)
	. = ..()
	area_of_effect = new(owner, SHEPHERDS_WATCH_RADIUS)
	for(var/mob/living/mob_living in range(SHEPHERDS_WATCH_RADIUS, owner))
		area_of_effect.ignored_mobs |= mob_living

/datum/discipline_power/duration_expire(atom/target)
	clear_duration_timer()
	if(!check_discipline_flags())
		deactivate(owner, TRUE)
	to_chat(owner, span_notice("You concentrate on keeping [src] active."))
	owner.update_action_buttons()
	do_duration(owner)

/datum/discipline_power/obeah/shepherds_watch/deactivate(atom/target, direct)
	. = ..()
	QDEL_NULL(area_of_effect)

#undef SHEPHERDS_WATCH_RADIUS

//UNBURDEN THE BESTIAL SOUL
/datum/discipline_power/obeah/unburden_the_bestial_soul
	name = "Unburden The Bestial Soul"
	desc = "Draw out a Kindred's soul and heal it of impurities."

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE | DISC_CHECK_FREE_HAND
	target_type = TARGET_LIVING
	range = 1

	cooldown_length = 5 SECONDS



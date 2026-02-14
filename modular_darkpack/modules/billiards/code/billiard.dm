#define SOLID_BALL "Solid Ball"
#define STRIPED_BALL "Striped Ball"
#define EIGHT_BALL "8-Ball"
#define ZERO_BALL "0-Ball"

/obj/item/pool_cue
	name = "pool cue"
	desc = "Used for playing a game of 8 ball."
	icon = 'modular_darkpack/modules/billiards/icons/billiard.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/billiards/icons/billiard_onfloor.dmi')
	icon_state = "cue"
	base_icon_state = "cue"
	force = 10
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	throwforce = 15
	throw_speed = 2
	attack_verb_continuous = list("smashes", "slams", "whacks", "thwacks")
	attack_verb_simple = list("smash", "slam", "whack", "thwack")

/obj/item/pool_cue/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, \
		force_unwielded = /obj/item/pool_cue::force, \
		force_wielded = 15, \
	)

/obj/item/pool_ball
	name = "pool ball"
	desc = "Used for playing a game of 8 ball."
	icon = 'modular_darkpack/modules/billiards/icons/billiard.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/billiards/icons/billiard_onfloor.dmi')
	icon_state = "0ball"
	var/ball_number = 0

/obj/item/pool_ball/update_name(updates)
	. = ..()
	name = "[ball_number] ball"

/obj/item/pool_ball/update_icon_state()
	. = ..()
	icon_state = "[ball_number]ball"

/obj/item/pool_ball/random/Initialize(mapload)
	. = ..()
	ball_number = rand(0,15)
	update_appearance()

/obj/structure/table/wood/billiard
	name = "billiard table"
	desc = "Come here, play some BALLS. tool know you want it so much..."
	icon = 'modular_darkpack/modules/billiards/icons/32x48.dmi'
	icon_state = "billiard1"
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	//pixel_z = -16
	pixel_y = -16

	can_flip = FALSE

	var/start_with_cues = TRUE
	var/start_min_cues = 1
	var/start_max_cues = 4

	var/start_with_balls = TRUE

/obj/structure/table/wood/billiard/Initialize()
	. = ..()

	var/turf/my_turf = get_turf(src)
	if(start_with_balls)
		for(var/ball_num in 0 to 15)
			var/obj/item/pool_ball/new_ball = new(my_turf)
			new_ball.ball_number = ball_num
			new_ball.update_appearance()
			new_ball.pixel_x += rand(-8,8)
			new_ball.pixel_y += rand(-8,8)

	if(start_with_cues)
		for(var/i in 1 to rand(start_min_cues, start_max_cues))
			var/obj/item/pool_cue/new_cue = new(my_turf)
			new_cue.pixel_x += rand(-8,8)
			new_cue.pixel_y += rand(-8,8)

/obj/structure/table/wood/billiard/examine(mob/user)
	. = ..()
	. += "There are [length(get_balls_on_table(SOLID_BALL))] solid and [length(get_balls_on_table(STRIPED_BALL))] striped balls left."
	if(!length(get_balls_on_table(EIGHT_BALL)))
		. += span_warning("The 8-Ball has been sunk.")

/obj/structure/table/wood/billiard/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/pool_cue))
		var/cue_options = list(
			SOLID_BALL = image(icon = 'modular_darkpack/modules/billiards/icons/billiard.dmi', icon_state = "1ball"),
			STRIPED_BALL = image(icon = 'modular_darkpack/modules/billiards/icons/billiard.dmi', icon_state = "15ball"),
			EIGHT_BALL = image(icon = 'modular_darkpack/modules/billiards/icons/billiard.dmi', icon_state = "8ball"),
		)
		var/choice = show_radial_menu(user, src, cue_options, require_near = TRUE)
		if(!choice)
			return ITEM_INTERACT_BLOCKING
		if(balls_left[choice] <= 0)
			to_chat(user, span_warning("You cant aim for a [lowertext(choice)] because they are all sunk!"))
			return ITEM_INTERACT_BLOCKING
		user.visible_message(span_notice("[user] begins lining up a shot to hit a [lowertext(choice)]."), span_notice("You begin lining up a shot to hit a [lowertext(choice)]."))
		if(!do_after(user, 1 TURNS, src))
			return ITEM_INTERACT_BLOCKING
		user.visible_message(span_notice("[user] strikes a [lowertext(choice)]!"), span_notice("You strike your target!"))
		playsound(src, 'modular_darkpack/modules/billiards/sounds/poolball_strike.ogg', 75)

		#warn todo
		var/desired_modifer = 10 // user.get_total_dexterity() * 2 //SSroll.storyteller_roll(user.get_total_dexterity(), 4, FALSE, list(user))

		var/attempts = 0
		while(length(get_balls_on_table()) && (attempts <= 10))
			attempts++
			sink_ball(user, choice, desired_modifer)
			if(prob(25))
				break
			#warn do
			/*
			if(prob(100 - (user.get_total_physique() * 10)))
				break
			*/
		return ITEM_INTERACT_SUCCESS

/obj/structure/table/wood/billiard/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	to_chat(user, "You begin reseting the table to play another game of 8-Ball.")
	if(do_after(user, 1 TURNS, src))
		reset_table()
		user.visible_message(span_notice("[user] resets the table for another game of 8-Ball"), span_notice("You finish reseting the table. Ready for another game?"))
		update_appearance()
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/structure/table/wood/billiard/proc/sink_ball(mob/living/user, target_ball, desired_modifer, sunk_ball)
	if(!sunk_ball)
		sunk_ball = random_ball(target_ball, desired_modifer)

	if(!balls_left[sunk_ball] || balls_left[sunk_ball] <= 0)
		//user.visible_message(span_warning("[user] MISSED"), span_warning("You missed"))
		return
	if(sunk_ball == EIGHT_BALL)
		user.visible_message(span_warning("[user] sunk the 8-Ball.. Damn.."), span_warning("Shit.. You sunk the 8-Ball"))
	else
		user.visible_message(span_notice("[user] sinks a [lowertext(sunk_ball)]. [balls_left[sunk_ball]] left."), span_notice("You sink a [sunk_ball]!"))
	balls_left[sunk_ball] = max(0, --balls_left[sunk_ball])
	update_appearance()

/obj/structure/table/wood/billiard/proc/random_ball(desired_ball, desired_modifer = 2)
	pick(get_balls_on_table())
	/*
	var/list/ball_chances = balls_left.Copy()
	if(balls_left[desired_ball] > 0)
		//Higher chance to sink the ball type your aiming for.
		ball_chances[desired_ball] = ball_chances[desired_ball] * desired_modifer
	return pick_weight(ball_chances)
	*/

/obj/structure/table/wood/billiard/proc/reset_table()
	var/turf/my_turf = get_turf(src)
	for(var/obj/item/pool_ball/ball in contents)
		ball.forceMove(my_turf)

/obj/structure/table/wood/billiard/proc/get_balls_on_table(list/looking_for = list(SOLID_BALL, STRIPED_BALL, EIGHT_BALL))
	var/turf/my_turf = get_turf(src)

	// Lets us pass a single item and turn it into a list
	if(looking_for && !islist(looking_for))
		looking_for = list(looking_for)

	var/list/all_balls = list()
	for(var/obj/item/pool_ball/ball in my_turf)
		switch(ball.ball_number)
			if(1 to 7)
				if(!(SOLID_BALL in looking_for))
					continue
			if(9 to 15)
				if(!(STRIPED_BALL in looking_for))
					continue
			if(8)
				if(!(EIGHT_BALL in looking_for))
					continue
			if(0)
				if(!(ZERO_BALL in looking_for))
					continue
		all_balls += ball

	return all_balls

#undef SOLID_BALL
#undef STRIPED_BALL
#undef EIGHT_BALL
#undef ZERO_BALL

/mob/living/basic/pet/dog/wolf
	name = "\improper wolf"
	real_name = "wolf"
	icon_state = "wolf1"
	desc = "That's an big, scary ouppy. Might be best to steer clear."
	base_icon_state = "wolf"
	icon = 'modular_darkpack/modules/npc/icons/wolf.dmi'
	var/random_wolf_color = TRUE
	basic_mob_flags = NONE
	mobility_flags = MOBILITY_FLAGS_REST_CAPABLE_DEFAULT
	mob_size = MOB_SIZE_HUMAN // big guy

	butcher_results = list(
		/obj/item/food/meat/slab = 2,
		/obj/item/stack/sheet/bone = 2
	)

	var/sprite_eye_color = "#FFFFFF"

	maxHealth = 120
	health = 120
	obj_damage = 15
	melee_damage_lower = 7.5
	melee_damage_upper = 7.5
	attack_vis_effect = ATTACK_EFFECT_BITE
	melee_attack_cooldown = 1.2 SECONDS

	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	death_message = "snarls its last and perishes."

	attack_sound = 'sound/items/weapons/bite.ogg'
	move_force = MOVE_FORCE_WEAK
	move_resist = MOVE_FORCE_WEAK
	pull_force = MOVE_FORCE_WEAK

	ai_controller = /datum/ai_controller/basic_controller/wolf

	var/can_tame = TRUE
	/// Instructions you can give to wolves when tamed
	var/static/list/wolf_pet_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/free,
		/datum/pet_command/move,
		/datum/pet_command/good_boy/dog,
		/datum/pet_command/good_boy/wolf,
		/datum/pet_command/follow/dog,
		/datum/pet_command/attack/dog,
		/datum/pet_command/fetch,
		/datum/pet_command/play_dead,
		/datum/pet_command/protect_owner
	)

/mob/living/basic/pet/dog/wolf/Initialize(mapload)
	. = ..()
	add_verb(src, /mob/living/proc/toggle_resting)
	if(random_wolf_color)
		var/id = rand(1, 6)
		icon_state = "[base_icon_state][id]"
		icon_living = "[base_icon_state][id]"
		icon_dead = "[base_icon_state][id]_dead"
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_CLAW)
	AddElement(/datum/element/ai_flee_while_injured)
	AddElement(/datum/element/ai_retaliate)
	update_appearance(UPDATE_ICON)
//	AddComponent(/datum/component/obeys_commands, wolf_pet_commands)

/mob/living/basic/pet/dog/wolf/update_icon_state()
	. = ..()
	if(stat != DEAD)
		if(resting)
			icon_state = "[icon_living]_rest"
		else
			icon_state = "[icon_living]"

/mob/living/basic/pet/dog/wolf/update_overlays()
	. = ..()
	var/laid_down = wolfresting()

	var/mutable_appearance/eyes_overlay = mutable_appearance(icon, "eyes[laid_down ? "_rest" : ""]")
	SET_PLANE(eyes_overlay, ABOVE_LIGHTING_PLANE, src)
	eyes_overlay.color = sprite_eye_color
	. += eyes_overlay

	switch(getFireLoss()+getBruteLoss()+getAggLoss())
		if(40 to 70)
			var/mutable_appearance/damage_overlay = mutable_appearance(icon, "damage1[laid_down ? "_rest" : ""]")
			. += damage_overlay
		if(71 to 100)
			var/mutable_appearance/damage_overlay = mutable_appearance(icon, "damage2[laid_down ? "_rest" : ""]")
			. += damage_overlay
		if(101 to INFINITY)
			var/mutable_appearance/damage_overlay = mutable_appearance(icon, "damage3[laid_down ? "_rest" : ""]")
			. += damage_overlay



/mob/living/basic/pet/dog/wolf/proc/wolfresting()
	return stat > CONSCIOUS || IsSleeping() || IsParalyzed() || body_position == LYING_DOWN


#define DOGGY_ANIMATION_COOLDOWN 1 TURNS

/datum/action/cooldown/fera_transform
	name = "Transform"
	desc = "Take the form of the beast"
	background_icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/werewolf_abilities.dmi'
	background_icon_state = "bg_gift"
	button_icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/werewolf_abilities.dmi'
	button_icon_state = "hispo"
	check_flags = AB_CHECK_CONSCIOUS
	cooldown_time = DOGGY_ANIMATION_COOLDOWN
	var/list/possible_shapes = list()

/datum/action/cooldown/fera_transform/New(Target, original = TRUE, list/transformations)
	. = ..()
	if(transformations)
		possible_shapes = transformations

/datum/action/cooldown/fera_transform/Trigger(mob/clicker, trigger_flags, atom/target)
	. = ..()
	// if(!.)
		// return

	playsound(owner, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/transform.ogg', 50, FALSE)

	var/matrix/ntransform = matrix(owner.transform)
	ntransform.Scale(1.15, 1.15)
	animate(owner, transform = ntransform, color = "#000000", time = DOGGY_ANIMATION_COOLDOWN * 0.8)

	addtimer(CALLBACK(src, PROC_REF(transform)), DOGGY_ANIMATION_COOLDOWN * 0.8)

/datum/action/cooldown/fera_transform/proc/transform()
	owner.set_species(pick(possible_shapes))
	animate(owner, transform = null, color = "#FFFFFF", time = DOGGY_ANIMATION_COOLDOWN * 0.2)

#undef DOGGY_ANIMATION_COOLDOWN

#define DOGGY_ANIMATION_TIME 1 TURNS

/datum/action/cooldown/fera_transform
	name = "Transform"
	desc = "Take the form of the beast"
	background_icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/werewolf_abilities.dmi'
	background_icon_state = "bg_gift"
	button_icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/werewolf_abilities.dmi'
	button_icon_state = "hispo"
	check_flags = AB_CHECK_CONSCIOUS
	cooldown_time = DOGGY_ANIMATION_TIME
	var/list/possible_shapes = list()

/datum/action/cooldown/fera_transform/New(Target, original = TRUE, list/transformations)
	. = ..()
	if(transformations)
		possible_shapes = transformations

/datum/action/cooldown/fera_transform/PreActivate(atom/target)
	if(!iscarbon(owner))
		return
	return ..()

/datum/action/cooldown/fera_transform/Activate(atom/target_atom)
	var/mob/living/carbon/carbon_owner = owner // Saftey check in preactivate.
	var/mob_species = carbon_owner?.dna?.species?.type
	var/form_picked = tgui_input_list(owner, "Select a form", "Form selection", possible_shapes - mob_species)
	if(!form_picked)
		return

	var/datum/splat/werewolf/shifter/our_splat = isshifter(target_atom)
	our_splat.transform_fera(form_picked)

	return TRUE

// Remeber if you remove homid being species that this will break.
/datum/splat/werewolf/shifter/proc/transform_fera(datum/species/human/shifter/form_to_transform, costs_rage = FALSE, requires_roll = TRUE, force = FALSE)
	if(!form_to_transform)
		return
	if(!istype(owner))
		return
	if(!(form_to_transform in transformation_list))
		return
	if(owner?.dna?.species?.type == form_to_transform)
		return
	if(!force && !COOLDOWN_FINISHED(src, transform_cooldown))
		to_chat(owner, span_warning("Your shifting is on cooldown for one turn."))
		return

	if(ispath(get_breed_form(), form_to_transform))
		requires_roll = FALSE
	else if(costs_rage)
		if(adjust_rage(-1, TRUE))
			requires_roll = FALSE
		else
			to_chat(owner, span_warning("You don't have enough <b>RAGE</b> to do that!"))
			SEND_SOUND(owner, sound('modular_darkpack/modules/werewolf_the_apocalypse/sounds/werewolf_cast_failed.ogg', 0, 0, 50))
			return

	COOLDOWN_START(src, transform_cooldown, 1 TURNS)
	var/time_to_transform = DOGGY_ANIMATION_TIME

	#define PRIMAL_URGE_PLACEHOLDER 3
	#warn should accctually require an amount of successes equal to the forms your shifting through
	if(requires_roll)
		switch(SSroll.storyteller_roll(owner.st_get_stat(STAT_STAMINA) + PRIMAL_URGE_PLACEHOLDER, form_to_transform::shift_difficulty, list(owner), owner))
			if(ROLL_SUCCESS)
				EMPTY_BLOCK_GUARD
			if(ROLL_FAILURE, ROLL_BOTCH)
				return
	#undef PRIMAL_URGE_PLACEHOLDER

	// If it doesnt require a roll it must be instant/free action
	if(requires_roll)
		playsound(owner, transform_sound, 50, FALSE)
	else
		playsound(owner, 'modular_darkpack/modules/werewolf_the_apocalypse/icons/speedtrans.ogg', 50, FALSE)
		time_to_transform *= 0.1

	// owner.Stun(time_to_transform, ignore_canstun = TRUE)

	var/matrix/ntransform = matrix(owner.transform)
	ntransform.Scale(1.1, 1.1)
	animate(owner, transform = ntransform, color = "#000000", time = time_to_transform * 0.9)

	addtimer(CALLBACK(src, PROC_REF(transform_finish), form_to_transform, time_to_transform), time_to_transform * 0.9)

/datum/splat/werewolf/shifter/proc/revert_to_breed_form()
	transform_fera(get_breed_form(), force = TRUE)

/datum/splat/werewolf/shifter/proc/transform_finish(form_to_transform, time_taken = DOGGY_ANIMATION_TIME)
	animate(owner, transform = null, color = "#FFFFFF", time = time_taken * 0.1)
	owner.set_species(form_to_transform)

/datum/splat/werewolf/shifter/proc/is_breed_form()
	if(!owner?.dna)
		return FALSE
	if(owner.dna.species?.type != get_breed_form())
		return FALSE
	return TRUE

/datum/splat/werewolf/shifter/proc/get_breed_form()
	if(!owner?.dna)
		return
	return GLOB.fera_breeds[owner.dna.features[FEATURE_FERA_BREED]]

#undef DOGGY_ANIMATION_TIME

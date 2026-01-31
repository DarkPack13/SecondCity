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
	our_splat.transform(form_picked)

	return TRUE

/datum/splat/werewolf/shifter/proc/transform(form_to_transform)
	if(!form_to_transform)
		return
	if(!istype(owner))
		return
	if(!(form_to_transform in transformation_list))
		return
	if(owner?.dna?.species?.type == form_to_transform)
		return


	playsound(owner, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/transform.ogg', 50, FALSE)

	var/matrix/ntransform = matrix(owner.transform)
	ntransform.Scale(1.1, 1.1)
	animate(owner, transform = ntransform, color = "#000000", time = DOGGY_ANIMATION_COOLDOWN * 0.9)

	addtimer(CALLBACK(src, PROC_REF(transform_finish), form_to_transform), DOGGY_ANIMATION_COOLDOWN * 0.9)

/datum/splat/werewolf/shifter/proc/revert_to_breed_form()
	var/form = GLOB.fera_breeds[owner.dna.features[FEATURE_FERA_BREED]]

	transform(form)

/datum/splat/werewolf/shifter/proc/transform_finish(form_to_transform)
	animate(owner, transform = null, color = "#FFFFFF", time = DOGGY_ANIMATION_COOLDOWN * 0.1)
	owner.set_species(form_to_transform)

#undef DOGGY_ANIMATION_COOLDOWN

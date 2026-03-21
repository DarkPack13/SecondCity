/datum/surgery_operation/limb/height_change
	name = "height surgery"
	desc = "Change the patient's height."
	implements = list(
		TOOL_HEMOSTAT = 1.15,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/scalpel2.ogg'
	operation_flags = OPERATION_LOCKED | OPERATION_NOTABLE | OPERATION_MORBID
	time = 20 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_VESSELS_CLAMPED|SURGERY_BONE_SAWED

/datum/surgery_operation/limb/height_change/get_default_radial_image()
	return image(/obj/item/scalpel)

/datum/surgery_operation/limb/height_change/state_check(obj/item/bodypart/chest/limb)
	return limb.body_zone == BODY_ZONE_CHEST

/datum/surgery_operation/limb/height_change/on_preop(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/patient = get_patient(operating_on)
	display_results(
		surgeon,
		patient,
		span_notice("You begin to alter [patient]'s height..."),
		span_notice("[surgeon] begins to alter [patient]'s height."),
		span_notice("[surgeon] begins to make an incision in [patient]'s back."),
	)
	display_pain(patient, "You feel a slicing pain across your back!")

/datum/surgery_operation/limb/height_change/on_success(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(operating_on)

	var/list/heights = list(
		"Taller" = HUMAN_HEIGHT_TALLER,
		"Tall" = HUMAN_HEIGHT_TALL,
		"Average" = HUMAN_HEIGHT_MEDIUM,
		"Short" = HUMAN_HEIGHT_SHORT,
		"Shorter" = HUMAN_HEIGHT_SHORTEST,
		)

	var/new_height = tgui_input_list(surgeon, "Choose a height", "Height change", heights)
	new_height = heights[new_height]
	if(!new_height)
		return FALSE
	if(!IN_GIVEN_RANGE(surgeon, patient, 1))
		return FALSE
	patient.set_mob_height(new_height)
	SEND_SIGNAL(surgeon, COMSIG_MASQUERADE_VIOLATION)
	playsound(patient, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)

	display_results(
		surgeon,
		patient,
		span_notice("You alter [patient]'s spine completely."),
		span_notice("[surgeon] alters [patient]'s spine completely."),
		span_notice("[surgeon] finishes the operation on [patient]'s spine."),
	)
	display_pain(patient, "The pain fades, the world seems different!")

/datum/surgery_operation/limb/height_change/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(limb.owner)
	display_results(
		surgeon,
		patient,
		span_warning("Your screw up, leaving [patient]'s spine bruised!"),
		span_warning("[surgeon] screws up, bruising [patient]'s spine!"),
		span_notice("[surgeon] finishes the operation on [patient]'s spine."),
	)
	display_pain(patient, "Your back feels torn!")
	limb.receive_damage(rand(4, 8), wound_bonus = 10, sharpness = SHARP_EDGED, damage_source = tool)

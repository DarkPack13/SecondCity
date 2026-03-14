/datum/surgery_operation/limb/modify_hair
	name = "hair pigmentation surgery"
	desc = "Change the patient's hair color."
	implements = list(
		TOOL_HEMOSTAT = 1.15,
		TOOL_SCREWDRIVER = 2.85,
		/obj/item/pen = 6.67,
	)
	preop_sound = 'sound/items/handling/surgery/scalpel1.ogg'
	success_sound = 'sound/items/handling/surgery/scalpel2.ogg'
	operation_flags = OPERATION_LOCKED | OPERATION_NOTABLE | OPERATION_MORBID
	time = 20 SECONDS
	all_surgery_states_required = SURGERY_SKIN_OPEN|SURGERY_VESSELS_CLAMPED

/datum/surgery_operation/limb/modify_hair/get_default_radial_image()
	return image(/obj/item/scalpel)

/datum/surgery_operation/limb/modify_hair/state_check(obj/item/bodypart/chest/limb)
	return limb.body_zone == BODY_ZONE_HEAD

/datum/surgery_operation/limb/modify_hair/on_preop(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/patient = get_patient(operating_on)
	display_results(
		surgeon,
		patient,
		span_notice("You begin to alter [patient]'s hair..."),
		span_notice("[surgeon] begins to alter [patient]'s hair."),
		span_notice("[surgeon] begins to make an incision in [patient]'s head."),
	)
	display_pain(patient, "You feel a slicing pain across your head!")

/datum/surgery_operation/limb/modify_hair/on_success(atom/movable/operating_on, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(operating_on)

	var/new_style = tgui_input_list(surgeon, "Select a hairstyle", "Grooming", SSaccessories.hairstyles_list)
	if(!new_style)
		return FALSE
	if(!IN_GIVEN_RANGE(surgeon, patient, 1))
		return FALSE
	patient.set_hairstyle(new_style, update = TRUE)
	SEND_SIGNAL(surgeon, COMSIG_MASQUERADE_VIOLATION)
	playsound(patient, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(surgeon, span_notice("You finish altering the hair style of [patient]."))

	display_results(
		surgeon,
		patient,
		span_notice("You alter [patient]'s hair style."),
		span_notice("[surgeon] alters [patient]'s hair style."),
		span_notice("[surgeon] finishes the operation on [patient]'s hair."),
	)
	display_pain(patient, "The pain fades!")

	var/new_hair_color = tgui_color_picker(surgeon, "Choose a hair color", "Hair Color", patient.hair_color)
	if(!new_hair_color)
		return FALSE
	if(!IN_GIVEN_RANGE(surgeon, patient, 1))
		return FALSE
	patient.set_haircolor(sanitize_hexcolor(new_hair_color))
	patient.dna.update_ui_block(/datum/dna_block/identity/hair_color)
	SEND_SIGNAL(surgeon, COMSIG_MASQUERADE_VIOLATION)
	playsound(patient, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)

	display_results(
		surgeon,
		patient,
		span_notice("You alter [patient]'s hair color."),
		span_notice("[surgeon] alters [patient]'s hair color."),
		span_notice("[surgeon] finishes the operation on [patient]'s hair."),
	)
	display_pain(patient, "The pain fades again!")

/datum/surgery_operation/limb/modify_hair/on_failure(obj/item/bodypart/limb, mob/living/surgeon, tool, list/operation_args)
	var/mob/living/carbon/human/patient = get_patient(limb.owner)
	display_results(
		surgeon,
		patient,
		span_warning("Your screw up, leaving [patient]'s head bruised!"),
		span_warning("[surgeon] screws up, bruising [patient]'s head!"),
		span_notice("[surgeon] finishes the operation on [patient]'s head."),
	)
	display_pain(patient, "Your head feels torn!")
	limb.receive_damage(rand(4, 8), wound_bonus = 10, sharpness = SHARP_EDGED, damage_source = tool)

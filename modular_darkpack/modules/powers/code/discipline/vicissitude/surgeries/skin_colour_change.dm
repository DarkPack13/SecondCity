/*
/datum/surgery/fleshcraft/skin_colour_change
	name = "Change Skin Colour"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/retract_skin, /datum/surgery_step/modify_skin, /datum/surgery_step/close)
	possible_locs = list(BODY_ZONE_CHEST)
	replaced_by = null
	requires_tech = TRUE

//Modify Skin Tone
/datum/surgery_step/modify_skin
	name = "Change Skin Colour"
	accept_hand = TRUE
	time = 64
	repeatable = TRUE

/datum/surgery_step/modify_skin/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	display_results(
		user,
		target,
		span_notice("You begin to alter [target]'s skin..."),
		span_notice("[user] begins to alter [target]'s skin."),
		span_notice("[user] begins to press against [target]'s skin."),
	)
	display_pain(target, "Your skin stings like hell!")

/datum/surgery_step/modify_skin/success(mob/user, mob/living/carbon/human/target, target_zone, obj/item/tool, datum/surgery/surgery, default_display_results = FALSE)
	var/list/skin_tones = list()
	for(var/skin_tone as anything in GLOB.skin_tone_names)
		var/skin_tone_name = GLOB.skin_tone_names[skin_tone]
		skin_tones[skin_tone_name] = skin_tone

	var/new_s_tone = tgui_input_list(user, "Choose a skin tone", "Race change", skin_tones)
	new_s_tone = skin_tones[new_s_tone]
	if(!new_s_tone)
		return FALSE
	if(!IN_GIVEN_RANGE(user, target, 1))
		return FALSE
	target.skin_tone = new_s_tone
	target.dna.update_ui_block(/datum/dna_block/identity/skin_tone)
	target.update_body(is_creating = TRUE)
	target.update_mutations_overlay()
	SEND_SIGNAL(user, COMSIG_MASQUERADE_VIOLATION)
	playsound(target, 'modular_darkpack/modules/powers/sounds/vicissitude.ogg', 50, TRUE)
	to_chat(user, span_notice("You finish altering the race of [target]."))
	return TRUE
*/


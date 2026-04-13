/* Nyx's Bangle */
/obj/item/vtm_artifact/nyxs_bangle
	name = "silver bracelet"
	desc = "A chain bracelet made of silver."
	true_name = "Nyx's Bangle"
	true_desc = "A silver bracelet with numerous glyphs."
	icon = 'modular_zapoc/modules/apoc_items/icons/fetishes.dmi'
	worn_icon = 'modular_zapoc/modules/apoc_items/icons/fetishes_worn.dmi'
	lefthand_file = 'modular_zapoc/modules/apoc_items/icons/fetishes_lefthand.dmi'
	righthand_file = 'modular_zapoc/modules/apoc_items/icons/fetishes_righthand.dmi'
	icon_state = "bangle"
	worn_icon_state = "bangle"
	slot_flags = ITEM_SLOT_GLOVES | ITEM_SLOT_ID
	ONFLOOR_ICON_HELPER('modular_zapoc/modules/apoc_items/icons/fetishes_onfloor.dmi')
	subsystem_type = /datum/controller/subsystem/processing/fastprocess
	var/spirit_name = "Glitchimus"
	var/spirit_type = "ahelp"

/obj/item/vtm_artifact/nyxs_bangle/identificate()
	. = ..()
	say("I am [spirit_name]... Hide now, in shadow.")


/obj/item/vtm_artifact/nyxs_bangle/unbind(mob/user)
	..()
	var/mob/living/carbon/human/H = owner
	playsound(owner, 'sound/hallucinations/growl1.ogg', 5)
	H.alpha = 255


/obj/item/vtm_artifact/nyxs_bangle/process(delta_time)
	. = ..()
	if(identified && iscarbon(owner))
		var/mob/living/carbon/C = owner
		var/turf/T = get_turf(owner)
		var/light_amount = T.get_lumcount()

		if(light_amount <= 0.2)
			if(src == C.gloves || src == C.wear_id || src == C.get_active_held_item() || src == C.get_inactive_held_item())
				C.alpha = max(C.alpha-12.75, 25.5)
			else
				C.alpha = min (C.alpha+25.5, 255)
		else
			C.alpha = min (C.alpha+25.5, 255)


/obj/item/vtm_artifact/nyxs_bangle/Initialize(mapload)
	. = ..()
	spirit_type = pick(SPIRIT_NIGHT, SPIRIT_DARKNESS)
	spirit_name = generate_spirit_name(spirit_type)


/obj/item/vtm_artifact/nyxs_bangle/examine(mob/user)
	. = ..()
	if(identified)
		. += span_nicegreen("Hide everything but your bestial eyes in shadow.")
		. += span_notice("<b>EQUIP</b> [src] in the <b>ID</b> slot or <b>GLOVES</b> slot or <b>HOLD</b> it in your hand to become partially invisible in shadow.")
		. += span_purple("Imbued with [spirit_name].")

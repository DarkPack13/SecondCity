/* Nyx's Bangle */
/obj/item/occult_artifact/werewolf/nyxs_bangle
	name = "silver bracelet"
	desc = "A chain bracelet made of silver."
	true_name = "Nyx's Bangle"
	true_desc = "A silver bracelet with numerous glyphs."
	icon_state = "bangle"
	worn_icon_state = "bangle"
	slot_flags = ITEM_SLOT_GLOVES | ITEM_SLOT_ID

	subsystem_type = /datum/controller/subsystem/processing/fastprocess

	ungrant_sound = 'sound/effects/hallucinations/growl1.ogg'

/obj/item/occult_artifact/werewolf/nyxs_bangle/identify()
	. = ..()
	say("I am [spirit_name]... Hide now, in shadow.")

/obj/item/occult_artifact/werewolf/nyxs_bangle/ungrant_powers()
	. = ..()

	owner.alpha = 255


/obj/item/occult_artifact/werewolf/nyxs_bangle/process(seconds_per_tick)
	. = ..()

	var/mob/living/carbon/carbon_owner = astype(owner)
	if(identified && carbon_owner)
		var/turf/owner_turf = get_turf(owner)
		var/light_amount = owner_turf.get_lumcount()

		if(light_amount <= 0.2)
			if(src == carbon_owner.gloves || src == carbon_owner.get_active_held_item() || src == carbon_owner.get_inactive_held_item())
				carbon_owner.alpha = max(carbon_owner.alpha-12.75, 25.5)
			else
				carbon_owner.alpha = min (carbon_owner.alpha+25.5, 255)
		else
			carbon_owner.alpha = min (carbon_owner.alpha+25.5, 255)

/obj/item/occult_artifact/werewolf/nyxs_bangle/proc/get_held_mob()
	if(isnull(loc))
		return null
	if(isliving(loc))
		return loc
	var/nested_loc = loc.loc
	if (isliving(nested_loc))
		return nested_loc
	return null

/obj/item/occult_artifact/werewolf/nyxs_bangle/Initialize(mapload)
	. = ..()
	spirit_type = pick(SPIRIT_NIGHT, SPIRIT_DARKNESS)
	spirit_name = generate_spirit_name(spirit_type)


/obj/item/occult_artifact/werewolf/nyxs_bangle/examine(mob/user)
	. = ..()
	if(identified)
		. += span_nicegreen("Hide everything but your bestial eyes in shadow.")
		. += span_notice("<b>EQUIP</b> [src] in the <b>ID</b> slot or <b>GLOVES</b> slot or <b>HOLD</b> it in your hand to become partially invisible in shadow.")
		. += span_purple("Imbued with [spirit_name].")

/obj/item/knife/fomor_claws // Just a normal knife, but part of our hands!
	name = "claw"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_items48x32.dmi'
	icon_state = "claw"
	inhand_icon_state = "claw"
	lefthand_file = 'modular_darkpack/modules/fomori/icons/fomori_inhand_left.dmi'
	righthand_file = 'modular_darkpack/modules/fomori/icons/fomori_inhand_right.dmi'
	icon_angle = 0
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	throwforce = 0
	throw_speed = 0
	throw_range = 0

	abstract_type = /obj/item/knife/fomor_claws

/obj/item/knife/fomor_claws/Initialize(mapload,silent) // Largely copied from changeling armblade
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, INNATE_TRAIT)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -5)

/datum/action/cooldown/power/fomori_power/weapon/claws
	name = "Claws"
	desc = "Use the grotesque claws on your hands to slice and dice."
	button_icon_state = "claws"
	rank = 1 // of 1
	weapon_type = /obj/item/knife/fomor_claws
	unsheathe_sound = 'sound/items/weapons/parry.ogg'
	sheathe_text = "Your claws retract into your arms."

/datum/action/cooldown/power/fomori_power/weapon/claws/Activate(atom/target)
	. = ..()
	if(deployed)
		owner.visible_message(span_warning("A pair of grotesque claws extend from [owner]\'s hands!"), \
			span_warning("Your claws extend from your hands."), \
			span_hear("You hear organic matter ripping and tearing!"))

/obj/item/melee/body_barbs // Largely copied from changeling armblade
	name = "body barb"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_items48x32.dmi'
	icon_state = "body_barb"
	inhand_icon_state = "body_barb"
	lefthand_file = 'modular_darkpack/modules/fomori/icons/fomori_inhand_left.dmi'
	righthand_file = 'modular_darkpack/modules/fomori/icons/fomori_inhand_right.dmi'
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	force = 40 // Identical to Machete
	throwforce = 0
	throw_range = 0
	throw_speed = 0
	hitsound = 'sound/items/weapons/bladeslice.ogg'
	wound_bonus = 10
	exposed_wound_bonus = 10
	armour_penetration = 35
	attack_verb_continuous = list("attacks", "slashes", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "slice", "tear", "lacerate", "rip", "dice", "cut")
	sharpness = SHARP_EDGED
	wound_bonus = 10
	exposed_wound_bonus = 10
	armour_penetration = 35
	var/can_drop = FALSE
	var/fake = FALSE
	var/list/alt_continuous = list("stabs", "pierces", "impales")
	var/list/alt_simple = list("stab", "pierce", "impale")

	abstract_type = /obj/item/melee/body_barbs

/obj/item/melee/body_barbs/Initialize(mapload,silent,synthetic) // Largely copied from changeling armblade
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, "body_barbs")
	if(synthetic)
		can_drop = TRUE
	alt_continuous = string_list(alt_continuous)
	alt_simple = string_list(alt_simple)
	AddComponent(/datum/component/alternative_sharpness, SHARP_POINTY, alt_continuous, alt_simple, -5)
	AddComponent(/datum/component/butchering, \
	speed = 6 SECONDS, \
	effectiveness = 80, \
	)

/datum/action/cooldown/power/fomori_power/weapon/body_barbs
	name = "Body Barbs"
	desc = "Use the grotesque spikes on your body to amplify your brawling ability."
	button_icon_state = "body_barbs"
	rank = 1 // of 10 // Determines how many extra dice we get
	weapon_type = /obj/item/melee/body_barbs

/datum/action/cooldown/power/fomori_power/weapon/body_barbs/Activate(atom/target)
	. = ..()
	owner.visible_message(span_warning("A pair of grotesque barbs extend from [owner]\'s arms!"), \
		span_warning("Your body barbs extend from your arms."), \
		span_hear("You hear organic matter ripping and tearing!"))

/datum/action/cooldown/power/fomori_power/weapon/body_barbs/two
	rank = 2

/datum/action/cooldown/power/fomori_power/weapon/body_barbs/three
	rank = 3

/datum/action/cooldown/power/fomori_power/weapon/body_barbs/four
	rank = 4
/datum/action/cooldown/power/fomori_power/weapon/body_barbs/five
	rank = 5

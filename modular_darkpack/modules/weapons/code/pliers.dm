/obj/item/wirecutters/pliers
	name = "dental pliers"
	desc = "Meant for taking out teeth."
	icon = 'modular_darkpack/modules/weapons/icons/pliers.dmi'
	icon_state = "neat_ripper"
	lefthand_file = 'modular_darkpack/modules/weapons/icons/melee_lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/weapons/icons/melee_righthand.dmi'
	onflooricon_state = "neat_ripper"
	inhand_icon_state = "neat_ripper"
	toolspeed = 2 //isn't meant for cutting wires
	/// If pulling fangs lasts for the entire ROUND or not.
	var/permanent = TRUE
	slot_flags = NONE

/obj/item/wirecutters/pliers/bad_pliers
	name = "pliers"
	desc = "Meant for pulling wires but you could definetly crush something with these."
	icon_state = "ripper"
	onflooricon_state = "ripper"
	inhand_icon_state = "ripper"
	toolspeed = 1.2 //is an actual tool but can't actually cut
	permanent = FALSE

/obj/item/wirecutters/pliers/attack(mob/living/target, mob/living/user)
	. = ..()
	/* DARKPACK TODO - Merits/Flaws related to feeding
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		return
	if(HAS_TRAIT(target, TRAIT_BABY_TEETH))
		visible_message(usr, span_warning("[user] can't pull out the canines of [target] because they are already deformed!"))
	else
		user.visible_message(span_warning("[user] takes [src] straight to the [target]'s canines!"), span_warning("You take [src] straight to the [target]'s canines!"))
		if(!do_after(user, 30, target))
			return
		user.do_attack_animation(target)
		user.visible_message(span_warning("[user] rips out [target]'s canines!"), span_warning("You rip out [target]'s canines!"))
		target.emote("scream")
		if(target.has_quirk(/datum/quirk/permafangs))
			REMOVE_TRAIT(target, TRAIT_PERMAFANGS, ROUNDSTART_TRAIT)
		if (permanent == TRUE)
			target.apply_status_effect(STATUS_EFFECT_SEVERE_BABY_TEETH)
			visible_message(span_warning("[user] stuff's in Bone putty into [target] to stop their canines from regrowing!"))
		else
			target.apply_status_effect(STATUS_EFFECT_BABY_TEETH)
	*/

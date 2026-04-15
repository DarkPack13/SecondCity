/obj/item/wirecutters/pliers
	name = "dental pliers"
	desc = "Meant for taking out teeth."
	icon = 'modular_darkpack/modules/weapons/icons/pliers.dmi'
	icon_state = "neat_ripper"
	lefthand_file = 'modular_darkpack/modules/weapons/icons/melee_lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/weapons/icons/melee_righthand.dmi'
	inhand_icon_state = "neat_ripper"
	toolspeed = 2 //isn't meant for cutting wires
	var/permanent = FALSE // If pulling fangs lasts for the entire ROUND or not.

/obj/item/wirecutters/pliers/attack(mob/living/target, mob/living/user)
	. = ..()
	if (target.is_mouth_covered())
		user.visible_message(user, span_warning("[user] can't pull out [target]'s canines because their mouth is covered!"))
		return
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		return
	if(HAS_TRAIT(target, TRAIT_DULLFANGS))
		user.visible_message(user, span_warning("[user] can't pull out the canines of [target] because they're already deformed!"))
	else
		user.visible_message(span_warning("[user] takes [src] straight to the [target]'s canines!"), span_warning("You take [src] straight to the [target]'s canines!"))
		if(!do_after(user, 3 SECONDS, target))
			return
		user.do_attack_animation(target)
		user.visible_message(span_warning("[user] rips out [target]'s canines!"), span_warning("You rip out [target]'s canines!"))
		target.emote("scream")
		if (get_kindred_splat(target)) // Only check for kindred quirks and apply dull fangs if they're actually kindred.
			if(target.has_quirk(/datum/quirk/darkpack/permafangs))
				REMOVE_TRAIT(target, TRAIT_PERMAFANGS, ROUNDSTART_TRAIT) // Take away their permafangs until they regrow.
			if(permanent)
				target.apply_status_effect(STATUS_EFFECT_DULL_FANGS_PERMANENT)
				visible_message(span_warning("[user] stuff's in Bone putty into [target] to stop their canines from regrowing!"))
			else
				target.apply_status_effect(STATUS_EFFECT_DULL_FANGS)
		else
			target.apply_damage(15, BRUTE, BODY_ZONE_HEAD) // If they aren't kindred, just do some brute.
			return

/obj/item/wirecutters/pliers/bad
	name = "pliers"
	desc = "Meant for pulling wires but you could definitely crush something with these."
	icon_state = "ripper"
	inhand_icon_state = "ripper"
	toolspeed = 1.2 //is an actual tool but can't actually cut

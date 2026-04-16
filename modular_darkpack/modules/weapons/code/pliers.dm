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

/obj/item/wirecutters/pliers/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	. = ..()
	if(!istype(interacting_with, /mob/living/carbon/human))
		return
	var/mob/living/carbon/human/target = interacting_with
	if (target.is_mouth_covered())
		user.visible_message(user, span_warning("[user] can't pull out [target]'s canines because their mouth is covered!"))
		return
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		return
	if(HAS_TRAIT(target, TRAIT_DULLFANGS))
		user.visible_message(span_warning("[user] can't pull out the canines of [target] because they're already deformed!"))
		return
	else
		user.visible_message(span_warning("[user] takes [src] straight to the [target]'s teeth!"), span_warning("You take [src] straight to the [target]'s teeth!"))
		if(!do_after(user, 3 SECONDS, target))
			return
		user.do_attack_animation(target)
		target.emote("scream")
		if (get_kindred_splat(target)) // If the target is kindred, yank their fangs out and apply a status effect.
			if(HAS_TRAIT(target, TRAIT_PERMAFANGS) && !HAS_TRAIT(target, TRAIT_DULLFANGS)) // Take away permafangs if they have them.
				REMOVE_TRAIT(target, TRAIT_PERMAFANGS, QUIRK_TRAIT)
			if(permanent) // If the pliers are permanent, apply the permanent dull fangs status effect. Otherwise, just apply the regular one.
				target.apply_status_effect(STATUS_EFFECT_DULL_FANGS_PERMANENT)
				visible_message(span_warning("[user] rips out [target]'s canines! It doesn't look like they'll be growing back anytime soon..."))
			else
				user.visible_message(span_warning("[user] rips out [target]'s canines!"), span_warning("You rip out [target]'s canines!"))
				target.apply_status_effect(STATUS_EFFECT_DULL_FANGS)
		else // If they aren't kindred, do brute and give an alternate message.
			user.visible_message(span_warning("[user] rips out one of [target]'s teeth!"), span_warning("You rip out one of [target]'s teeth!"))
			target.apply_damage(15, BRUTE, BODY_ZONE_HEAD)

/obj/item/wirecutters/pliers/bad
	name = "pliers"
	desc = "Meant for pulling wires but you could definitely crush something with these."
	icon_state = "ripper"
	inhand_icon_state = "ripper"
	toolspeed = 1.2 //is an actual tool but can't actually cut
	permanent = TRUE

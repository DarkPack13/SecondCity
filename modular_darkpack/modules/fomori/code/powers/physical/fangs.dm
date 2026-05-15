/datum/bodypart_overlay/simple/fomor_fangs
	icon_state = "fangs"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_sprite_accessories.dmi'
	layers = MUTATIONS_LAYER

/datum/bodypart_overlay/simple/fomor_fangs/can_draw_on_bodypart(obj/item/bodypart/bodypart_owner, mob/living/carbon/owner, is_husked = FALSE)
	return ..() && !(bodypart_owner.owner?.obscured_slots & HIDEFACE)

/datum/action/cooldown/power/fomori_power/fangs
	name = "Fangs"
	desc = "Use the grotesque fangs spilling from your mouth to bite your enemies."
	button_icon_state = "fangs"
	rank = 1 // of 1

	fomor_part = /datum/bodypart_overlay/simple/fomor_fangs

/datum/action/cooldown/power/fomori_power/fangs/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/carbon_owner = astype(owner, /mob/living/carbon)
	toggle_feature(deployed)

	if(deployed)
		REMOVE_TRAITS_IN(owner, "fomor_fangs")
		deployed = FALSE
		carbon_owner.combat_bite_damages = carbon_owner::combat_bite_damages
	else
		ADD_TRAIT(owner, TRAIT_COMBAT_BITE, "fomor_fangs")
		ADD_TRAIT(owner, TRAIT_MASQUERADE_VIOLATING_FACE, "fomor_fangs")
		deployed = TRUE
		carbon_owner.combat_bite_damages = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, AGGRAVATED = 1 TTRPG_DAMAGE)
		SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)

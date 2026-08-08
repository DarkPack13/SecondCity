/obj/effect/decal/cleanable/crustie
	name = "dead skin flakes"
	desc = "Disgusting."
	beauty = -50
	icon = 'modular_darkpack/modules/fomori/icons/fomori_abilities.dmi'
	icon_state = "crusties"

/datum/action/cooldown/power/fomori_power/crusties // Freak Legion pg. 42
	name = "The Crusties"
	desc = "Expel the crusties that writhe in your flesh, tearing you apart from the inside."
	button_icon_state = "crusties"
	rank = 1
	cooldown_time = 5 SCENES // 15 minutes

	ttrpg_sources = list(/datum/source_book/freak_legion = 42)


/datum/action/cooldown/power/fomori_power/crusties/Grant(mob/granted_to)
	. = ..()

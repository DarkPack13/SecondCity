/datum/vampire_clan/tzimisce
	name = "Tzimisce"
	id = VAMPIRE_CLAN_TZIMISCE
	desc = "If someone were to call a Tzimisce inhuman and sadistic, the Tzimisce would probably commend them for their perspicacity, and then demonstrate that their mortal definition of sadism was laughably inadequate. The Tzimisce have left the human condition behind gladly, and now focus on transcending the limitations of the vampiric state. At a casual glance or a brief conversation, a Tzimisce appears to be one of the more pleasant vampires. Polite, intelligent, and inquisitive, they seem a stark contrast to the howling Sabbat mobs or even the apparently more humane Brujah or Nosferatu. However, upon closer inspection, it becomes clear that this is merely a mask hiding something alien and monstrous."
	curse = "Grounded to material domain."
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/animalism,
		// /datum/discipline/vicissitude
	)
	male_clothes = /obj/item/clothing/under/vampire/sport
	female_clothes = /obj/item/clothing/under/vampire/red
	enlightenment = TRUE
	accessories = list("spines", "spines_slim", "animal_skull", "none")
	accessories_layers = list("spines" = BODY_ADJ_LAYER, "spines_slim" = BODY_ADJ_LAYER, "animal_skull" = BODY_ADJ_LAYER, "none" = BODY_ADJ_LAYER)

/datum/action/cooldown/spell/shapeshift/tzimisce
	name = "Tzimisce Form"
	desc = "Take on the shape a beast."
	cooldown_time = 10 SECONDS
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	spell_requirements = NONE
	convert_damage = FALSE
	possible_shapes = list(/mob/living/basic/tzimisce_beast)

/datum/action/cooldown/spell/shapeshift/bloodcrawler
	name = "Blood Crawler"
	desc = "Take on the shape a beast."
	cooldown_time = 5 SECONDS
	revert_on_death = TRUE
	convert_damage = FALSE
	spell_requirements = NONE
	die_with_shapeshifted_form = FALSE
	possible_shapes = list(/mob/living/basic/bloodcrawler)

/datum/vampire_clan/tzimisce/on_join_round(mob/living/carbon/human/H)
	. = ..()

	var/obj/item/ground_heir/heirloom = new(get_turf(H))
	var/list/slots = list(
		LOCATION_LPOCKET = ITEM_SLOT_LPOCKET,
		LOCATION_RPOCKET = ITEM_SLOT_RPOCKET,
		LOCATION_BACKPACK = ITEM_SLOT_BACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	H.equip_in_one_of_slots(heirloom, slots, FALSE)
	H.AddComponent(/datum/component/needs_home_soil, heirloom)

/datum/movespeed_modifier/centipede
	multiplicative_slowdown = -0.6

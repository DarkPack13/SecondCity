/datum/subsplat/vampire_clan/salubri
	name = "Salubri"
	id = VAMPIRE_CLAN_SALUBRI
	desc = "The Salubri are one of the original 13 clans of the vampiric descendants of Caine. Salubri believe that vampiric existence is torment from which Golconda or death is the only escape. Consequently, the modern Salubri would Embrace, teach a childe the basics of the route, leave clues for the childe to follow to achieve Golconda, and then have their childe diablerize them."
	icon = "salubri"
	curse = "Hunted and consensual feeding."
	sense_the_sin_text = "is ruled by consent."
	//signature_discipline = /datum/discipline/valeren
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/fortitude,
		// /datum/discipline/valeren
	)
	clan_traits = list(
		TRAIT_CONSENSUAL_FEEDING_ONLY,
		TRAIT_IRRESISTIBLE_VITAE
	)
	male_clothes = /obj/item/clothing/under/vampire/salubri
	female_clothes = /obj/item/clothing/under/vampire/salubri/female
	enlightenment = FALSE
	subsplat_keys = /obj/item/vamp/keys/salubri

/datum/subsplat/vampire_clan/salubri/psychomania_effect(mob/living/target, mob/living/owner)
	target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh1.ogg", 50, FALSE)
	to_chat(target, span_warning("My third eye begins to reflexively open.."))
	target.visible_message(span_warning("[target] tightly grasps their forehead, trying to conceal something"), span_cult("I MUST HIDE MY NATURE"))
	target.apply_damage(50, BRUTE, BODY_ZONE_HEAD)
	target.Paralyze(6 SECONDS)


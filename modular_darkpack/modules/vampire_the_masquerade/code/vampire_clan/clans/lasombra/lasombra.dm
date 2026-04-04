/datum/subsplat/vampire_clan/lasombra
	name = "Lasombra"
	id = VAMPIRE_CLAN_LASOMBRA
	desc = "The Lasombra exist for their own success, fighting for personal victories rather than solely for a crown to wear or a throne to sit upon. They believe that might makes right, and are willing to sacrifice anything to achieve their goals. A clan that uses spirituality as a tool rather than seeking honest enlightenment, their fickle loyalties are currently highlighted by half their clan's defection from the Sabbat."
	icon = "lasombra"
	curse = "Technology refuse."
	sense_the_sin_text = "fears change itself evermore."
	clan_disciplines = list(
		/datum/discipline/potence,
		/datum/discipline/dominate,
		/datum/discipline/obtenebration
	)
	clan_traits = list(
		TRAIT_NO_MIRROR_REFLECTION,
		TRAIT_INVISIBLE_TO_CAMERA
	)
	male_clothes = /obj/item/clothing/under/vampire/emo
	female_clothes = /obj/item/clothing/under/vampire/business
	enlightenment = TRUE
	subsplat_keys = /obj/item/vamp/keys/lasombra


/datum/subsplat/vampire_clan/lasombra/psychomania_effect(mob/living/target, mob/living/owner)
	to_chat(target, span_cult("THE SHADOWS BETRAY ME, SEEKING MY LIFE"))
	target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/eldritchlaugh.ogg", 50, FALSE)
	target.Paralyze(6 SECONDS)

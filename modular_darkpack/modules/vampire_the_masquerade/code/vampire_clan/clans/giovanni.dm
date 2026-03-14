/datum/subsplat/vampire_clan/giovanni
	name = "Giovanni"
	id = VAMPIRE_CLAN_GIOVANNI
	desc = "The Giovanni are the usurpers of Clan Cappadocian and one of the youngest clans. The Giovanni has historically been both a clan and a family. They Embrace almost exclusively within their family, and are heavily focused on the goals of money and necromantic power."
	icon = "giovanni"
	curse = "Harmful bites."
	sense_the_sin_text = "never considers any action too great for their family."
	signature_discipline = /datum/discipline/necromancy
	clan_disciplines = list(
		/datum/discipline/potence,
		/datum/discipline/dominate,
		/datum/discipline/necromancy
	)
	clan_traits = list(
		TRAIT_PAINFUL_VAMPIRE_KISS
	)
	male_clothes = /obj/item/clothing/under/vampire/suit
	female_clothes = /obj/item/clothing/under/vampire/suit/female

/datum/subsplat/vampire_clan/giovanni/on_join_round(mob/living/carbon/human/joining)
	. = ..()
	joining.grant_language(/datum/language/italian)

/datum/subsplat/vampire_clan/giovanni/psychomania_effect(mob/living/target, mob/living/owner)
	to_chat(target, span_cult("A sense of profound dread enters you as soundless words enter your mind"))
	target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/eldritchlaugh.ogg", 50, FALSE)
	var/obj/effect/client_image_holder/baali_demon/spectre/demon = new(get_turf(target), list(target))
	RegisterSignal(demon, COMSIG_BAALI_DEMON_REACHED_TARGET, CALLBACK(owner, TYPE_PROC_REF(/datum/discipline_power/daimoinon/psychomania, on_demon_contact)))

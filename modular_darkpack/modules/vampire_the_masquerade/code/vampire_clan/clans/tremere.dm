/datum/subsplat/vampire_clan/tremere
	name = "Tremere"
	id = VAMPIRE_CLAN_TREMERE
	desc = "The arcane Clan Tremere were once a house of mortal mages who sought immortality but found only undeath. As vampires, they’ve perfected ways to bend their own Blood to their will, employing their sorceries to master and ensorcel both the mortal and vampire world. Their power makes them valuable, but few vampires trust their scheming ways."
	icon = "tremere"
	curse = "Blood magic."
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/dominate,
		/datum/discipline/thaumaturgy
	)
	male_clothes = /obj/item/clothing/under/vampire/tremere
	female_clothes = /obj/item/clothing/under/vampire/tremere/female

/datum/subsplat/vampire_clan/tremere/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()
	sense_the_sin_text = "[gaining_mob.name] has a sense of perfectionism by their own actions."

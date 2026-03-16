/datum/subsplat/vampire_clan/cappadocian
	name = "Cappadocian"
	id = VAMPIRE_CLAN_CAPPADOCIAN
	desc = "A presumed-to-be-extinct Clan of necromancers, the Cappadocians studied death specifically in the physical world. The Giovanni were Embraced into their line to help further their studies into the underworld. They were rewarded with Diablerie and the destruction of their Clan and founder."
	icon = "cappadocian"
	curse = "Pale and gaunt complexion that cannot be made to look more human by expending blood."
	clan_disciplines = list(
		/datum/discipline/auspex,
		/datum/discipline/fortitude,
		/datum/discipline/necromancy
	)
	alt_sprite = "rotten1"
	alt_sprite_greyscale = TRUE

	whitelisted = TRUE

/datum/subsplat/vampire_clan/cappadocian/on_gain(mob/living/carbon/human/gaining_mob, datum/splat/gaining_splat, joining_round)
	. = ..()
	apply_rot_curse(gaining_mob, gaining_mob.chronological_age)

/datum/subsplat/vampire_clan/cappadocian/proc/apply_rot_curse(mob/living/carbon/human/H, chronological_age)
	switch(chronological_age)
		if (-INFINITY to 500)
			H.rot_body(1)
		if (500 to INFINITY)
			H.rot_body(2)

/datum/subsplat/vampire_clan/cappadocian/harbinger
	name = "Harbinger of Skulls"
	id = VAMPIRE_CLAN_HARBINGER
	desc = "A bloodline of the Clan Cappadocian, and largely composed of victims of the Giovanni purge against their clan and the Feast of Folly, these Sabbat Cappadocian vampires, masters of Necromancy, brought their power over the dead with them to the underworld, where they became powerful Wraiths, biding their time and waiting for a chance to cross the Shroud to enact vengeance for their Clan."
	curse = "Extremely corpselike appearance that worsens with age, with the oldest being walking skeletal forms or ghostly, reminiscent of their time across the Shroud."
	icon = "harbinger_of_skulls"

/datum/subsplat/vampire_clan/cappadocian/harbinger/apply_rot_curse(mob/living/carbon/human/H, chronological_age)
	switch(chronological_age)
		if (-INFINITY to 100)
			H.rot_body(1)
		if (100 to 300)
			H.rot_body(2)
		if (300 to 500)
			H.rot_body(3)
		if (500 to INFINITY)
			H.rot_body(4)

/mob/living/carbon/human/Topic(href, href_list)
	// DARKPACK TODO - reimplement in a sane way.
	if(href_list["masquerade_violation"])
		if(!ismundane(usr))
			return
		var/mob/living/carbon/human/reporter = usr
		if(reporter.stat > UNCONSCIOUS)
			return
		if(usr == src)
			return
		var/reason = tgui_input_text(reporter, "Write a description of violation", "Spot a Masquerade violation", null, MAX_MESSAGE_LEN)
		if(!reason)
			return
		reason = sanitize(reason)
		if(!SEND_SIGNAL(reporter, COMSIG_SEEN_MASQUERADE_VIOLATION, src))
			return
		message_admins("[ADMIN_LOOKUPFLW(reporter)] spotted [ADMIN_LOOKUPFLW(src)]'s Masquerade violation. Description: [reason]")
		log_game("[ADMIN_LOOKUPFLW(reporter)] spotted [ADMIN_LOOKUPFLW(src)]'s Masquerade violation. Description: [reason]")
		to_chat(src, span_danger("You were found to be violating the masquereade for: [reason]"))

	if(href_list["masquerade_reinforcement"])
		if(!ismundane(usr))
			return
		var/mob/living/carbon/human/reporter = usr
		if(reporter.stat > UNCONSCIOUS)
			return
		if(usr == src)
			return
		if(!SEND_SIGNAL(reporter, COMSIG_MASQUERADE_REINFORCE, src))
			return
		message_admins("[ADMIN_LOOKUPFLW(reporter)] repaired [ADMIN_LOOKUPFLW(src)]'s Masquerade violation.")
		log_game("[ADMIN_LOOKUPFLW(reporter)] repaired [ADMIN_LOOKUPFLW(src)]'s Masquerade violation.")


	. = ..()

/mob/living/carbon/human/update_soak() //Fairly complex list here. Kindred can soak lethal with Stamina, and Agg with Fortitude. Garou can soak everything in every form except their breed form, in which they can only soak Lethal and Bashing.
	. = ..()
	if(get_kindred_splat(src))
		soak_dice_bashing = st_get_stat(STAT_STAMINA) //Stamina already has the Fortitude bonus added for Bashing and Lethal.
		soak_dice_lethal = st_get_stat(STAT_STAMINA)
		soak_dice_aggravated = 0 //Reset it beforehand in case you had leftover agg dice.
		var/datum/discipline/soak_visceratika = get_discipline(/datum/discipline/visceratika)
		var/datum/discipline/soak_fortitude = get_discipline(/datum/discipline/fortitude)
		if(soak_visceratika && soak_visceratika.level >= 4)
			soak_dice_aggravated += 1 //1 Agg and Lethal soak, 2 Bashing from Armour of Terra.
			soak_dice_lethal += 1
			soak_dice_bashing += 2
		if(soak_fortitude)
			soak_dice_aggravated += soak_fortitude.level

	if(get_shifter_splat(src))
		soak_dice_bashing = st_get_stat(STAT_STAMINA)
		soak_dice_lethal = st_get_stat(STAT_STAMINA)
		var/datum/splat/werewolf/shifter/shifter_splat = get_shifter_splat(src)
		if(shifter_splat.is_breed_form() && (shifter_splat.get_breed_form_species() != /datum/species/human/shifter/war)) //Garou don't soak Agg in breed form except for Crinos-born. Adjustment will need to be added once Corax are in for their +2 bashing soak diff.
			soak_dice_aggravated = 0
			return
		soak_dice_aggravated = st_get_stat(STAT_STAMINA)

	if(get_ghoul_splat(src))
		var/datum/discipline/soak_fortitude = src.get_discipline(/datum/discipline/fortitude)
		if(!soak_fortitude)
			return
		soak_dice_lethal = soak_fortitude.level //Ghouls can soak lethal and agg via fortitude.
		soak_dice_aggravated = soak_fortitude.level

/datum/preference/choiced/subsplat/vampire_clan
	savefile_key = "vampire_clan"
	main_feature_name = "Clan"
	relevant_inherent_trait = TRAIT_VTM_CLANS

/datum/preference/choiced/subsplat/vampire_clan/init_possible_values()
	// DARKPACK TODO - implement whitelisting
	return assoc_to_keys(GLOB.vampire_clan_list)

/datum/preference/choiced/subsplat/vampire_clan/icon_for(value)
	return uni_icon('modular_darkpack/modules/vampire_the_masquerade/icons/vampire_clans.dmi', get_vampire_clan(value).icon)

/datum/preference/choiced/subsplat/vampire_clan/apply_to_human(mob/living/carbon/human/target, value)
	var/joining_round = !isdummy(target)
	target.set_clan(value, joining_round)

/datum/preference/choiced/subsplat/vampire_clan/post_set_preference(mob/user, value)
	var/datum/subsplat/vampire_clan/clan = get_vampire_clan(value)
	if(!clan)
		return
	if(clan.desc)
		to_chat(user, span_notice("[uppertext(clan.name)]<br>[clan.desc]"))
	if(clan.roleplay_level)
		to_chat(user, span_notice("<br>ROLEPLAY LEVEL: [clan.roleplay_level] <br>Roleplay levels, or, the difficulty to play and portray a character from that clan, are as follows: Beginner Friendly, Intermediate, Advanced."))

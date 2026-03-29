/datum/quirk/darkpack/mage_blood
	name = "Mage Blood"
	desc = "Your blood is so tied to magic that you find you are unable to use any Discipline apart from Thaumaturgy and it's associated Paths. Any discipline that isn't Thaumaturgy will be removed when joining the game."
	value = -5
	icon = FA_ICON_MAGIC_WAND_SPARKLES
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_TREMERE)

/datum/quirk/darkpack/mage_blood/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	var/datum/splat/vampire/kindred/kindred = get_kindred_splat(quirk_holder)
	if(!kindred)
		return
	for(var/datum/action/discipline/action as anything in kindred.powers)
		if(!istype(action.discipline, /datum/discipline/thaumaturgy))
			kindred.remove_power(action.discipline.type)


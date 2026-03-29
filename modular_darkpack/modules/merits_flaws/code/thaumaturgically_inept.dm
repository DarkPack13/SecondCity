/datum/quirk/darkpack/thaumaturgically_inept
	name = "Thaumaturgically Inept"
	desc = "Something about you refuses to respond to Thaumaturgy. It just doesn't work for you. Thaumaturgy will be completely removed when joining the game."
	value = -5
	icon = FA_ICON_BAN
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_TREMERE)

/datum/quirk/darkpack/thaumaturgically_inept/add(client/client_source)
	var/datum/splat/vampire/kindred/vampire = get_splat_with_discipline(quirk_holder)
	if(!vampire)
		return
	vampire.remove_power(/datum/discipline/thaumaturgy)

/datum/quirk/darkpack/thaumaturgically_inept
	name = "Thaumaturgically Inept"
	desc = "Something about you refuses to respond to Thaumaturgy. It just doesn't work for you. Thaumaturgy will be completely removed when joining the game."
	value = -5
	icon = FA_ICON_BAN
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_TREMERE)

/datum/quirk/darkpack/thaumaturgically_inept/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	. = ..()
	var/datum/splat/vampire/kindred/kindred_splat = get_kindred_splat(new_holder)
	if(!kindred_splat)
		return
	kindred_splat.remove_power(/datum/discipline/thaumaturgy)

/mob/living/carbon/Initialize(mapload)
	. = ..()
	var/datum/atom_hud/abductor/hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	hud.add_to_hud(src)

/mob/living/carbon/proc/update_auspex_hud()
	var/image/holder = hud_list[GLAND_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon_state = "aura"

	if (client)
		if(a_intent == INTENT_HARM)
			holder.color = "#ff0000"
		else
			holder.color = "#0000ff"
	else if (isnpc(src))
		var/mob/living/carbon/human/npc/N = src
		if (N.danger_source)
			holder.color = "#ff0000"
		else
			holder.color = "#0000ff"

	if (iskindred(src))
		//pale aura for vampires
		holder.color = "#ffffff"
		//only Baali can get antifrenzy through selling their soul, so this gives them the unholy halo (MAKE THIS BETTER)
		if (antifrenzy)
			holder.icon = 'modular_darkpack/modules/deprecated/icons/32x64.dmi'
		//black aura for diablerists
		if (diablerist)
			holder.icon_state = "diablerie_aura"

	if(iscathayan(src))
		var/mob/living/carbon/human/H = src
		if(!H.check_kuei_jin_alive())
			holder.color = "#ffffff"

	if (isgarou(src) || iswerewolf(src))
		//garou have bright auras due to their spiritual potence
		holder.icon_state = "aura_bright"

	if (isghoul(src))
		//Pale spots in the aura, had to be done manually since holder.color will show only a type of color
		holder.overlays = null
		holder.color = null
		holder.icon_state = "aura_ghoul"

	if(mind?.holy_role >= HOLY_ROLE_PRIEST)
		holder.color = "#ffe12f"
		holder.icon_state = "aura"

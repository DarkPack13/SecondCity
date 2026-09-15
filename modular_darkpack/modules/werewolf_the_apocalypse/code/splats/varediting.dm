#define VV_HK_EDIT_RENOWN "edit_renown"

/datum/splat/werewolf/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION("", "---------")
	VV_DROPDOWN_OPTION(VV_HK_EDIT_RENOWN, "Edit Renown")

/datum/splat/werewolf/vv_do_topic(list/href_list)
	. = ..()

	if(!.)
		return

	if(href_list[VV_HK_EDIT_RENOWN])
		if(!check_rights(R_SPAWN))
			return
		var/list/options = ALL_RENOWNS
		var/result = tgui_input_list(usr, "Please choose a renown to adjust", "Renown", options)
		if(!result)
			return
		var/amount = tgui_input_number(usr, "Enter to renown add/remove.", "Renown", 1, 10, -10)
		if(isnull(amount))
			return
		adjust_renown(result, amount)


#undef VV_HK_EDIT_RENOWN

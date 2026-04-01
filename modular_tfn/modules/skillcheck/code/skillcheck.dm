// skillcheck via tgui
//example:
/*
/obj/item/fishing_rod/ui_interact(mob/user, datum/tgui/ui)
	var/datum/skillcheck/sc = new()
	sc.start(user, 3, CALLBACK(src, PROC_REF(on_skillcheck_result)))

/obj/item/fishing_rod/proc/on_skillcheck_result(mob/user, passed)
	if(passed)
		to_chat(user, span_notice("You prepare your rod with practiced ease."))
	else
		to_chat(user, span_warning("You fumble with the rod."))
*/

/datum/skillcheck
	var/difficulty = 3 // number between 1 and 5, where 5 has the largest skill check area and 1 has the smallest
	var/datum/callback/on_complete

/datum/skillcheck/proc/start(mob/living/target, diff = 3, datum/callback/callback)
	target.playsound_local(target, 'modular_tfn/modules/fishing/sound/src_audio_advertise2.ogg', 30, FALSE)
	difficulty = diff
	on_complete = callback
	var/datum/tgui/ui = SStgui.try_update_ui(target, src, null)
	if(!ui)
		ui = new(target, src, "SkillCheck", "Skill Check")
		ui.open()

/datum/skillcheck/ui_state(mob/user)
	return GLOB.always_state

/datum/skillcheck/ui_data(mob/user)
	return list("difficulty" = difficulty)

/datum/skillcheck/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("skill_check_result")
			var/passed = params["result"] == "pass"
			ui.close()
			if(on_complete)
				on_complete.Invoke(ui.user, passed)
			qdel(src)
			return TRUE

/datum/asset/simple/skillcheck_sounds
	assets = list(
		"skillcheck_good.ogg" = 'modular_tfn/modules/fishing/sound/src_audio_good.ogg',
	)

/datum/skillcheck/ui_assets(mob/user)
	return list(get_asset_datum(/datum/asset/simple/skillcheck_sounds))

/datum/bt_node/ai_behavior/human_report_crime
	time_between_perform = 5 SECONDS
	var/crime_key = BB_WITNESSED_CRIME


/datum/bt_node/ai_behavior/human_report_crime/perform(seconds_per_tick, datum/ai_controller/controller)
	var/async_flags = handle_async()
	if(async_flags)
		return async_flags

	var/mob/living/living_pawn = controller.pawn

	if(!controller.blackboard_key_exists(crime_key))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED

	if(HAS_TRAIT(living_pawn, TRAIT_RESTRAINED)) // I cant pickup my phone (i should prob just acctually try and pull it out tho..)
		return
	if(!length(living_pawn.get_all_contents_type(/obj/item/smartphone)))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED

	return start_async()

/datum/bt_node/ai_behavior/human_report_crime/perform_async(datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	var/mob/living/carbon/human/npc/npc_pawn = astype(living_pawn)
	var/datum/socialrole/my_socialrole
	if(npc_pawn)
		my_socialrole = npc_pawn.socialrole

	var/datum/crime_report/crime = controller.blackboard[crime_key]
	var/mob/living/criminal = crime.criminal?.resolve()
	// var/mob/living/victim = crime.victim?.resolve()
	// var/turf/crime_location = crime.crime_location?.resolve()
	var/crime_type = crime.crime_type

	var/clothing_desc
	var/mob/living/carbon/human/attacker = astype(criminal)
	if(attacker && (attacker in oview(DEFAULT_SIGHT_DISTANCE, living_pawn)))
		if(crime_type == CRIME_BATTERY)
			for(var/obj/item/held_item in attacker.get_held_items())
				if(!istype(held_item, /obj/item/gun))
					continue
				crime_type = CRIME_FIREFIGHT
				break

		var/list/worn = list()
		var/list/visible_items = attacker.get_visible_items()
		for(var/obj/item/worn_item in attacker.get_equipped_items())
			if(worn_item in visible_items)
				var/importance = 1
				if(worn_item in list(attacker.head, attacker.wear_suit, attacker.w_uniform))
					importance = 5
				worn[worn_item] = importance

		var/list/seen_items = list()
		var/items_to_spot = rand(1, living_pawn.st_get_stat(STAT_PERCEPTION))
		for(var/i in 1 to items_to_spot)
			if(!length(worn))
				break
			var/obj/item/picked_item = pick_weight(worn)
			worn[picked_item] = null
			seen_items += picked_item.name
		if(length(seen_items))
			clothing_desc = english_list(seen_items)

	if(clothing_desc)
		living_pawn.realistic_say("[pick("Police!", "Hello, police?!")] [pick(pick(my_socialrole.help_phrases), "Wearing [clothing_desc]!")]")
	else
		living_pawn.realistic_say("[pick("Police!", "Hello, police?!")] [pick(my_socialrole.help_phrases)]")

	if(!do_after(living_pawn, rand(4.5 SECONDS, 5.5 SECONDS), cog_icon = 'modular_darkpack/modules/phones/icons/phone.dmi', cog_iconstate = "phone_old_on"))
		finish_async(AI_BEHAVIOR_FAILED)
		return

	if(!async_still_valid())
		return

	if(clothing_desc)
		crime.clothing_desc = clothing_desc
	SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, crime)

	controller.clear_blackboard_key(crime_key)
	finish_async(AI_BEHAVIOR_SUCCEEDED)

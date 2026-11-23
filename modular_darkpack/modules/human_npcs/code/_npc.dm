/mob/living/carbon/human/npc
	faction = list(FACTION_NPC)
	ai_controller = /datum/ai_controller/npc
	move_intent = MOVE_INTENT_WALK

	// NPC humans get the area of effect, player humans dont.
	violation_aoe = TRUE

	COOLDOWN_DECLARE(car_dodge)

	/// Used to hold a bunch of global lists for stuff like speech
	var/datum/socialrole/socialrole
	/// Default path to use for social role
	var/datum/socialrole/socialrole_type

/mob/living/carbon/human/npc/Initialize(mapload)
	. = ..()
	GLOB.human_npc_list += src
	GLOB.alive_human_npc_list += src

	var/using_role = get_socialrole_type()
	if(ispath(using_role))
		assign_socialrole(using_role)

	AddElement(/datum/element/ai_retaliate)

	// all npcs are masquerade violators by default so flip it to true
	toggle_masquerade_sensitivity(TRUE)

	#warn put somewhere else..
	var/datum/preference/preference = GLOB.preference_entries[/datum/preference/choiced/country_of_origin]
	preference.apply_to_human(src, preference.create_informed_default_value())
	if(country_of_origin == "United States")
		preference = GLOB.preference_entries[/datum/preference/choiced/state_of_origin]
		preference.apply_to_human(src, preference.create_informed_default_value())
	if(country_of_origin == "Canada")
		preference = GLOB.preference_entries[/datum/preference/choiced/province_of_origin]
		preference.apply_to_human(src, preference.create_informed_default_value())
	if(country_of_origin == "United Kingdom")
		preference = GLOB.preference_entries[/datum/preference/choiced/nation_of_origin]
		preference.apply_to_human(src, preference.create_informed_default_value())


/mob/living/carbon/human/npc/Destroy()
	. = ..()
	GLOB.human_npc_list -= src
	GLOB.alive_human_npc_list -= src

/mob/living/carbon/human/npc/revive(full_heal_flags, excess_healing, force_grab_ghost)
	. = ..()
	GLOB.alive_human_npc_list |= src

/mob/living/carbon/human/npc/death(gibbed)
	. = ..()
	GLOB.alive_human_npc_list -= src

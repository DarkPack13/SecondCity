/mob/living/carbon/human/npc
	name = "NPC"

	// NPCs normally walk around slowly
	move_intent = MOVE_INTENT_WALK

	var/datum/socialrole/socialrole

	var/is_talking = FALSE
	COOLDOWN_DECLARE(car_dodge)
	var/hostile = FALSE
	var/aggressive = FALSE
	var/last_antagonised = 0
	var/mob/living/danger_source
	var/obj/effect/abstract/turf_fire/afraid_of_fire
	var/mob/living/last_attacker
	var/last_health = 100
	var/mob/living/last_damager

	var/turf/walktarget	//dlya movementa


	var/tupik_steps = 0
	var/tupik_loc

	var/stopturf = 1

	var/extra_mags = 2
	var/extra_loaded_rounds = 10

	var/has_weapon = FALSE

	var/my_weapon_type = null
	var/obj/item/my_weapon = null

	var/my_backup_weapon_type = null
	var/obj/item/my_backup_weapon = null

	var/spawned_weapon = FALSE

	var/spawned_backup_weapon = FALSE

	var/staying = FALSE

	var/lifespan = 0	//How many cycles. He'll be deleted if over than a ten thousand
	var/old_movement = FALSE

	var/list/spotted_bodies = list()

	var/is_criminal = FALSE

	var/list/drop_on_death_list = null

/mob/living/carbon/human/npc/Initialize(mapload)
	. = ..()

	GLOB.human_npc_list += src
	GLOB.alive_human_npc_list += src

	AddElement(/datum/element/relay_attackers)
	RegisterSignal(src, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(handle_attacked))

	// all npcs are masquerade violators by default so flip it to true
	toggle_masquerade_sensitivity(TRUE)

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

	return INITIALIZE_HINT_LATELOAD

/mob/living/carbon/human/npc/LateInitialize()
	if (role_weapons_chances.Find(type))
		for(var/weapon in role_weapons_chances[type])
			if(prob(role_weapons_chances[type][weapon]))
				my_weapon = new weapon(src)
				break

	if (!my_weapon && my_weapon_type)
		my_weapon = new my_weapon_type(src)

	if (my_weapon)
		has_weapon = TRUE
		equip_to_appropriate_slot(my_weapon)
		if(istype(my_weapon, /obj/item/gun/ballistic))
			RegisterSignal(my_weapon, COMSIG_GUN_FIRED, PROC_REF(handle_gun))
			RegisterSignal(my_weapon, COMSIG_GUN_EMPTY, PROC_REF(handle_empty_gun))
		register_sticky_item(my_weapon)

	if (my_backup_weapon_type)
		my_backup_weapon = new my_backup_weapon_type(src)
		equip_to_appropriate_slot(my_backup_weapon)
		register_sticky_item(my_backup_weapon)

/mob/living/carbon/human/npc/Destroy()
	UnregisterSignal(src, list(COMSIG_ATOM_WAS_ATTACKED, COMSIG_LIVING_MOB_BUMPED, COMSIG_CARBON_HELP_ACT))
	danger_source = null
	QDEL_NULL(afraid_of_fire)
	last_attacker = null
	last_damager = null
	walktarget = null
	tupik_loc = null
	my_weapon_type = null
	my_weapon = null
	my_backup_weapon_type = null
	my_backup_weapon = null
	spotted_bodies = null
	drop_on_death_list = null
	GLOB.npc_list -= src
	GLOB.alive_npc_list -= src
	SShumannpcpool.currentrun -= src
	SShumannpcpool.try_repopulate()
	return ..()

//====================Sticky Item Handling====================
/mob/living/carbon/human/npc/proc/register_sticky_item(obj/item/my_item)
	ADD_TRAIT(my_item, TRAIT_NODROP, NPC_ITEM_TRAIT)
	if(!drop_on_death_list?.len)
		drop_on_death_list = list()
	drop_on_death_list += my_item

/mob/living/carbon/human/npc/death(gibbed)
	. = ..()

	if (!LAZYLEN(drop_on_death_list))
		return

	for (var/obj/item/dropping_item in drop_on_death_list)
		LAZYREMOVE(drop_on_death_list, dropping_item)
		REMOVE_TRAIT(dropping_item, TRAIT_NODROP, NPC_ITEM_TRAIT)
		dropItemToGround(dropping_item, TRUE)

//============================================================

/mob/living/carbon/human/npc/proc/handle_bumped(mob/living/carbon/human/npc/source, mob/living/bumping)
	SIGNAL_HANDLER

	if (bumping.can_mobswap_with(source) && prob(25))
		return

	source.Annoy(bumping)

/mob/living/carbon/human/npc/proc/handle_helped(mob/living/carbon/human/npc/source, mob/living/helper)
	SIGNAL_HANDLER

	source.Annoy(helper)

/mob/living/carbon/human/npc/Move(NewLoc, direct)
	if (!can_npc_move())
		GLOB.move_manager.stop_looping(src)

	var/getaway = stopturf + 1

	if (!old_movement)
		getaway = 2

	if (get_dist(src, walktarget) <= getaway)
		GLOB.move_manager.stop_looping(src)
		walktarget = null

	. = ..()




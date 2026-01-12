/obj/item/vtm_artifact/pickup(mob/user)
	. = ..()
	if(identified)
		owner = user
		START_PROCESSING(SSobj, src)
		get_powers()

/obj/item/vtm_artifact/dropped(mob/user)
	. = ..()
	if(identified)
		if(isturf(loc))
			STOP_PROCESSING(SSobj, src)
			if(owner)
				remove_powers()
				owner = null

/obj/item/vtm_artifact/process(delta_time)
	if(owner != loc && owner != loc.loc)
		forceMove(get_turf(src))
		STOP_PROCESSING(SSobj, src)
		if(owner)
			remove_powers()
			owner = null

/obj/item/vtm_artifact
	name = "unidentified occult fetish"
	desc = "Who knows what secrets it could contain..."
	icon_state = "arcane"
	icon = 'modular_darkpack/modules/occult_artifacts/icons/artifacts.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/occult_artifacts/icons/artifacts_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL
	var/mob/living/owner
	var/true_name = "artifact"
	var/true_desc = "Debug"
	var/identified = FALSE
	var/gained_boosts = FALSE
	var/research_value = 0

/obj/item/vtm_artifact/proc/identify()
	if(!identified)
		name = true_name
		desc = true_desc
		identified = TRUE

/obj/item/vtm_artifact/proc/get_powers()
	if(!identified)
		return

/obj/item/vtm_artifact/proc/remove_powers()
	if(!identified)
		return

/datum/armor/weekapaug_thistle
	melee = 10
	bullet = 10

/obj/item/vtm_artifact/weekapaug_thistle
	true_name = "Weekapaug Thistle"
	true_desc = "Increases combat defense."
	icon_state = "w_thistle"
	research_value = 10

/obj/item/vtm_artifact/weekapaug_thistle/get_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	H.physiology.armor = H.physiology.armor.add_other_armor(/datum/armor/weekapaug_thistle)

/obj/item/vtm_artifact/weekapaug_thistle/remove_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	H.physiology.armor = H.physiology.armor.subtract_other_armor(/datum/armor/weekapaug_thistle)

/obj/item/vtm_artifact/tarulfang
	true_name = "Tarulfang"
	true_desc = "Decreases chance of frenzy."
	icon_state = "tarulfang"

/obj/item/vtm_artifact/weekapaug_thistle/get_powers()
	. = ..()
	owner.frenzy_chance_boost = 5

/obj/item/vtm_artifact/weekapaug_thistle/remove_powers()
	. = ..()
	owner.frenzy_chance_boost = 10

/obj/item/vtm_artifact/mummywrap_fetish
	true_name = "Mummywrap Fetish"
	true_desc = "Passive health regeneration."
	icon_state = "m_fetish"
	var/last_regen = 0
	research_value = 10

/obj/item/vtm_artifact/mummywrap_fetish/process(delta_time)
	. = ..()
	if(identified && owner)
		if(last_regen+60 < world.time)
			last_regen = world.time
			owner.adjust_brute_loss(-5)
			owner.adjust_fire_loss(-5)

/obj/item/vtm_artifact/galdjum
	true_name = "Galdjum"
	true_desc = "Increases disciplines duration."
	icon_state = "galdjum"
	research_value = 10

/obj/item/vtm_artifact/galdjum/get_powers()
	. = ..()
	owner.discipline_time_plus = 25

/obj/item/vtm_artifact/galdjum/remove_powers()
	. = ..()
	owner.discipline_time_plus = 0

/datum/movespeed_modifier/fae_charm
	multiplicative_slowdown = -0.20

/obj/item/vtm_artifact/fae_charm
	true_name = "Fae Charm"
	true_desc = "Dexterity boost."
	icon_state = "fae_charm"
	research_value = 35

/obj/item/vtm_artifact/fae_charm/get_powers()
	. = ..()
	owner.st_add_stat_mod(STAT_DEXTERITY, 1, type)

/obj/item/vtm_artifact/fae_charm/remove_powers()
	. = ..()
	owner.st_remove_stat_mod(STAT_DEXTERITY, 1, type)

/obj/item/vtm_artifact/heart_of_eliza
	true_name = "Heart of Eliza"
	true_desc = "Melee damage boost."
	icon_state = "h_eliza"
	research_value = 30

/obj/item/vtm_artifact/heart_of_eliza/get_powers()
	. = ..()
	owner.st_add_stat_mod(STAT_STRENGTH, 1, type)

/obj/item/vtm_artifact/heart_of_eliza/remove_powers()
	. = ..()
	owner.st_remove_stat_mod(STAT_STRENGTH, 1, type)

/obj/item/vtm_artifact/bloodstar
	true_name = "Bloodstar"
	true_desc = "Increases Bloodpower duration."
	icon_state = "bloodstar"
	research_value = 10

/obj/item/vtm_artifact/bloodstar/get_powers()
	. = ..()
	owner.bloodpower_time_plus = 50

/obj/item/vtm_artifact/bloodstar/remove_powers()
	. = ..()
	owner.bloodpower_time_plus = 0

/obj/item/vtm_artifact/daimonori
	true_name = "Daimonori"
	true_desc = "Increases thaumaturgy damage."
	icon_state = "daimonori"
	research_value = 20

/obj/item/vtm_artifact/daimonori/get_powers()
	. = ..()
	owner.thaum_damage_plus = 20

/obj/item/vtm_artifact/daimonori/remove_powers()
	. = ..()
	owner.thaum_damage_plus = 0

/obj/item/vtm_artifact/key_of_alamut
	true_name = "Key of Alamut"
	true_desc = "Decreases incoming damage."
	icon_state = "k_alamut"
	research_value = 30

/obj/item/vtm_artifact/key_of_alamut/get_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.dna.species.damage_modifier >= 70)
		return
	if(H.dna)
		H.dna.species.damage_modifier = H.dna.species.damage_modifier+20

/obj/item/vtm_artifact/key_of_alamut/remove_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.dna.species.damage_modifier >= 50)
		return
	if(H.dna)
		H.dna.species.damage_modifier = H.dna.species.damage_modifier-20

/obj/item/vtm_artifact/odious_chalice
	true_name = "Odious Chalice"
	true_desc = "Stores blood from every attack."
	icon_state = "o_chalice"
	var/stored_blood = 0
	research_value = 30

/obj/item/vtm_artifact/odious_chalice/examine(mob/user)
	. = ..()
	. += "[src] contains [stored_blood] blood points..."

/obj/item/vtm_artifact/odious_chalice/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!iskindred(M))
		return
	if(!stored_blood)
		return
	if(!identified)
		return
	M.adjust_brute_loss(-5*stored_blood, TRUE)
	M.adjust_fire_loss(-5*stored_blood, TRUE)
	M.update_damage_overlays()
	M.update_health_hud()
	M.update_blood_hud()
	playsound(M.loc,'sound/items/drink.ogg', 50, TRUE)
	return

/obj/item/vtm_artifact/bloodstone
	true_name = "bloodstone"
	true_desc = "A pulsing crimson stone that creates a mystical bond with its identifier."
	icon = 'modular_darkpack/modules/paths/icons/bloodstone_artifact.dmi'
	onflooricon = 'modular_darkpack/modules/paths/icons/bloodstone_artifact.dmi'
	icon_state = "bloodstone"
	var/datum/weakref/bound_identifier // Who identified it first
	var/datum/action/bloodstone_track/tracking_action
	research_value = 15

/obj/item/vtm_artifact/bloodstone/identify()
	. = ..()
	if(identified && !bound_identifier)
		var/mob/living/carbon/human/user = usr
		if(ishuman(user))
			bound_identifier = WEAKREF(user)
			to_chat(user, span_warning("The bloodstone pulses with dark energy as it bonds to your essence. You will always know its location."))

			tracking_action = new /datum/action/bloodstone_track(user, src)
			tracking_action.Grant(user)

/obj/item/vtm_artifact/bloodstone/Destroy()
	if(tracking_action)
		var/mob/living/carbon/human/user = bound_identifier.resolve()
		if(user)
			tracking_action.Remove(user)
		QDEL_NULL(tracking_action)
	bound_identifier = null
	return ..()

/datum/action/bloodstone_track
	name = "Track Bloodstone"
	desc = "Sense the location of your bound bloodstone."
	button_icon = 'modular_darkpack/modules/paths/icons/bloodstone_artifact.dmi'
	button_icon_state = "bloodstone_track"
	check_flags = AB_CHECK_CONSCIOUS
	var/datum/weakref/tracked_stone

/datum/action/bloodstone_track/New(Target, obj/item/vtm_artifact/bloodstone/stone)
	. = ..()
	tracked_stone = WEAKREF(stone)

/datum/action/bloodstone_track/Trigger(trigger_flags)
	var/obj/item/vtm_artifact/bloodstone/bloodstone = tracked_stone.resolve()
	if(!bloodstone)
		to_chat(owner, span_warning("The bloodstone bond has been severed."))
		Remove(owner)
		qdel(src)
		return FALSE

	var/turf/stone_turf = get_turf(bloodstone)
	if(!stone_turf)
		to_chat(owner, span_warning("You cannot sense the bloodstone's location."))
		return FALSE

	var/area/stone_area = get_area(bloodstone)
	to_chat(owner, span_notice("The bloodstone whispers its location: [stone_area.name] ([stone_turf.x], [stone_turf.y])"))
	return TRUE

/obj/effect/spawner/random/occult
	name = "occult spawner"
	icon = 'modular_darkpack/modules/occult_artifacts/icons/artifacts.dmi'
	icon_state = "art_rand"

/obj/effect/spawner/random/occult/artifact
	name = "random occult fetish"
	spawn_loot_chance = 50
	loot_subtype_path = /obj/item/vtm_artifact

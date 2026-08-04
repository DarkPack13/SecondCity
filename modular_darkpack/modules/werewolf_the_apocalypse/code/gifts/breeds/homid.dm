/datum/action/cooldown/power/gift/city_running
	name = "City Running"
	desc = {"The player spends a point of Rage. For the rest of the scene, the character may climb at her full movement speed,
	and the difficulty of all Athletics rolls to navigate is reduced by two."}
	rank = 1
	rage_cost = 1

/datum/action/cooldown/power/gift/city_running/Activate(atom/target)
	. = ..()
	var/mob/living/living_owner = astype(owner)
	living_owner?.apply_status_effect(/datum/status_effect/city_running)


/datum/status_effect/city_running
	id = "city_running"
	duration = 1 SCENES
	status_type = STATUS_EFFECT_REPLACE
	alert_type = /atom/movable/screen/alert/status_effect/gift/city_running

/atom/movable/screen/alert/status_effect/gift/city_running
	name = /datum/action/cooldown/power/gift/city_running::name
	desc = /datum/action/cooldown/power/gift/city_running::desc
	overlay_state = /datum/action/cooldown/power/gift/city_running::button_icon_state


/*
 * Once humans tamed fire to keep them warm and to drive off the wild beasts,
 * they were humanity’s ancient pact with the spirits of fire.
 * The spirits of flame agree to hold back their hunger when the werewolf touches them. An ancestor spirit or a fire-spirit grants this Gift.

 * This Gift allows a werewolf to heal fire damage as if it were bashing.
 * This requires the expenditure of a Gnosis point; the effects last for a scene.
*/
/datum/action/cooldown/power/gift/master_of_fire
	name = "Master of Fire"
	desc = "The spirits of flame agree to hold back their hunger, letting you regenerate fire damage for a scene."
	#warn placeholder asset.
	button_icon_state = "master_of_fire" // TODO: get an icon for this
	rank = 1
	gnosis_cost = 1

/datum/action/cooldown/power/gift/master_of_fire/Activate(atom/target)
	var/datum/splat/werewolf/shifter/shifter_splat = get_shifter_splat(owner)
	if(isnull(shifter_splat))
		return FALSE // huh?

	shifter_splat.adjust_gnosis(-1)
	shifter_splat.owner.apply_status_effect(/datum/status_effect/master_of_fire)
	StartCooldown()
	return TRUE

/datum/status_effect/master_of_fire
	id = "master_of_fire"
	duration = 1 SCENES

	status_type = STATUS_EFFECT_REPLACE

	alert_type = /atom/movable/screen/alert/status_effect/master_of_fire

/datum/status_effect/master_of_fire/on_apply()
	to_chat(owner, span_notice("The spirits of flame agree to hold back their hunger, for a while."))
	return TRUE

/datum/status_effect/master_of_fire/on_remove()
	to_chat(owner, span_warning("The spirits of flame grow hungry yet again."))

/atom/movable/screen/alert/status_effect/master_of_fire
	name = "Master of Fire"
	desc = "Lets you heal fire damage as if it were bashing."
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	#warn placeholder asset.
	icon_state = "riddle" // TODO: get an icon for this

/* • Visage of Fenris - W20 p.180
 *
 * The Get appears larger and more fearsome, commanding respect from peers
 * and cowing his foes. A wolf or toad spirit teaches this Gift.
 *
 * Simple slowdown AOE.
 *
 * TODO: distinguish between friend and foe for the -1 social check thing
 *
 * TODO: less placeholder sound
*/

/datum/storyteller_roll/visage_of_fenris
	bumper_text = "Visage of Fenris"
	applicable_stats = list(STAT_CHARISMA, STAT_INTIMIDATION)
	numerical = TRUE
	roll_output_type = ROLL_PUBLIC

/datum/movespeed_modifier/visage_of_fenris
	multiplicative_slowdown = 0.75

/datum/action/cooldown/power/gift/visage_of_fenris
	name = "Visage of Fenris"
	desc = "Appear larger and more fearsome to your foes, rooting them to the spot in awe."
	button_icon_state = "visage_of_fenris"
	rank = 1
	cooldown_time = 1 SCENES
	var/list/affected = list()

/datum/action/cooldown/power/gift/visage_of_fenris/Activate(atom/target)
	. = ..()
	var/datum/splat/werewolf/our_splat = get_werewolf_splat(owner)

	var/datum/storyteller_roll/visage_of_fenris/roll_datum = new()
	var/successes = roll_datum.st_roll(owner)

	var/obj/effect/temp_visual/decoy/D = new /obj/effect/temp_visual/decoy(owner.loc, owner)
	animate(D, alpha = 0, color = COLOR_RED, transform = matrix()*2, time = 3)

	playsound(owner, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/visage_of_fenris.ogg', 75, FALSE)

	for(var/mob/living/guy in viewers(world.view, owner))
		if(guy == owner)
			continue

		var/datum/splat/werewolf/guy_splat
		var/difference = 0
		if(get_werewolf_splat(guy))
			guy_splat = get_werewolf_splat(guy)
			if(guy_splat && (our_splat.renown_rank < guy_splat.renown_rank))
				difference = guy_splat.renown_rank-our_splat.renown_rank
		if(successes && (successes >= difference*2))
			guy.apply_status_effect(/datum/status_effect/visage_of_fenris)

	StartCooldown()
	return TRUE

/datum/status_effect/visage_of_fenris
	id = "visage_of_fenris"
	duration = 6 TURNS // Nonstandard amount of time but 3 minutes of slowdown sucks.

	status_type = STATUS_EFFECT_REPLACE

	alert_type = /atom/movable/screen/alert/status_effect/visage_of_fenris

/datum/status_effect/visage_of_fenris/on_apply() // TODO: make this a signal handler that turns the slowdown off when can't see the get for N seconds
	owner.add_movespeed_modifier(/datum/movespeed_modifier/visage_of_fenris)
	to_chat(owner, span_userdanger("You are consumed with terror, rooting you to the spot!"))

	if(prob(50))
		owner.emote("gasp")
	else
		owner.emote("scream")

	return TRUE

/datum/status_effect/visage_of_fenris/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/visage_of_fenris)

/atom/movable/screen/alert/status_effect/visage_of_fenris
	name = "Visage of Fenris"
	desc = "You are consumed with terror, rooting you to the spot!"
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	icon_state = "fear" // TODO: get an icon for this

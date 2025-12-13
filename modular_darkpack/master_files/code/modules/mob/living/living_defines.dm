/mob/living
	var/mob/living/lastattacked

	var/bloodquality = 1

	var/list/drunked_of = list()

	var/discipline_time_plus = 0
	var/bloodpower_time_plus = 0
	var/thaum_damage_plus = 0

	var/resistant_to_disciplines = FALSE

	var/dancing = FALSE

	var/frenzy_chance_boost = 10

	COOLDOWN_DECLARE(drinkblood_use_cd)
	COOLDOWN_DECLARE(drinkblood_click_cd)

	var/bloodpool = 5
	var/maxbloodpool = 5
	var/generation = 13
	var/humanity = 7
	var/masquerade_score = 5
	var/warrant = FALSE
	var/ignores_warrant = FALSE

	//Damage related vars, NOTE: THESE SHOULD ONLY BE MODIFIED BY PROCS
	///Aggravated damage caused by supernatural attacks.
	var/aggloss = 0

	var/datum/storyteller_stats/storyteller_stat_holder

	//beastmaster
	var/list/beastmaster_minions = list()
	var/list/datum/component/obeys_commands/minion_command_components = list()

	var/obj/grabbed_by_tentacle = null
	var/escape_attempt = 0
	var/tentacle_aggro_mode = "Aggressive"

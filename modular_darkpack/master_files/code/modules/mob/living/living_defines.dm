/mob/living
	var/mob/living/lastattacked

	var/bloodquality = 1

	var/list/drunked_of = list()

	var/total_cleaned = 0

	var/info_known

	var/last_message
	var/total_erp = 0

	var/experience_plus = 0
	var/discipline_time_plus = 0
	var/bloodpower_time_plus = 0
	var/thaum_damage_plus = 0

	var/resistant_to_disciplines = FALSE
	var/auspex_examine = FALSE

	var/dancing = FALSE

	var/temporis_visual = FALSE
	var/temporis_blur = FALSE

	var/frenzy_chance_boost = 10

	var/last_bloodpool_restore = 0

	var/list/knowscontacts = list()

	var/mysticism_knowledge = FALSE

	var/thaumaturgy_knowledge = FALSE

	var/elysium_checks = 0
	var/bloodhunted = FALSE

	var/stakeimmune = FALSE

	var/isfishing = FALSE

	var/mob/parrying = null
	var/parry_class = WEIGHT_CLASS_TINY
	var/parry_cd = 0
	var/blocking = FALSE
	var/last_move_intent = MOVE_INTENT_RUN
	COOLDOWN_DECLARE(drinkblood_use_cd)
	COOLDOWN_DECLARE(drinkblood_click_cd)

	var/last_bloodpower_click = 0

	var/harm_focus = SOUTH
	var/flavor_text
	var/true_real_name
	var/died_already = FALSE

	var/bloodpool = 5
	var/maxbloodpool = 5
	var/generation = 13
	var/humanity = 7
	var/masquerade_score = 5
	var/last_nonraid = 0
	var/warrant = FALSE
	var/ignores_warrant = FALSE

	var/obj/overlay/gnosis

	var/total_contracted = 0

	///If this mob can strip people from range with a delay of 0.1 seconds. Currently only activated by Mytherceria 2.
	var/enhanced_strip = FALSE

	//Damage related vars, NOTE: THESE SHOULD ONLY BE MODIFIED BY PROCS
	///Aggravated damage caused by supernatural attacks.
	var/aggloss = 0

	var/datum/storyteller_stats/storyteller_stat_holder
	// TODO, replace with social/leadership
	var/more_companions = 0

	//beastmaster
	var/list/beastmaster_minions = list()
	var/list/datum/component/obeys_commands/minion_command_components = list()

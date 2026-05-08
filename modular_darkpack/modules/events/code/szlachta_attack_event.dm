/datum/round_event_control/darkpack/szlachta
	name = "Szlachta Attack"
	typepath = /datum/round_event/szlachta
	weight = 3
	min_players = 10
	max_occurrences = 2
	earliest_start = 90 MINUTES
	category = EVENT_CATEGORY_INVASION
	description = "Roving, loose szlachta have found their way into the city."
	darkpack_allowed = TRUE

/datum/round_event/szlachta
	start_when = 1
	announce_when = 5

/datum/round_event/szlachta/announce(fake)
	//end_post(
	//	"A breaking news notification has appeared on your phone - rolling szlachtas are affecting your area due to inclement weather.",
	//	"Local BREAKING NEWS Alert",
	//	'modular_darkpack/modules/events/sounds/news_notification.ogg',
	//	ANNOUNCEMENT_TYPE_PRIORITY,
	//	color_override = "red",
	//)

/datum/round_event/szlachta/start()
	var/list/szlachta_spawns = list()
	for(var/obj/effect/landmark/event_spawn/szlachta/landmark in GLOB.generic_event_spawns)
		szlachta_spawns += landmark

	if(!length(szlachta_spawns))
		return

	for(var/obj/effect/landmark/event_spawn/szlachta/landmark in szlachta_spawns)
		if(!prob(20))
			continue
		var/turf/spawn_turf = get_turf(landmark)
		if(!spawn_turf)
			continue

		// dont spawn if a player is nearby we don't need them popping in unrealistically
		var/player_nearby = FALSE
		for(var/mob/living/nearby_mob in view(DEFAULT_SIGHT_DISTANCE, spawn_turf))
			if(nearby_mob.client)
				player_nearby = TRUE
				break
		if(player_nearby)
			continue

		new /mob/living/basic/szlachta(spawn_turf)
		new /mob/living/basic/szlachta/fister(spawn_turf)
		if(prob(40))
			new /mob/living/basic/szlachta(spawn_turf)

		var/vozhd_type = (rand(1, 100) <= 80) ? /mob/living/basic/szlachta/tanker : /mob/living/basic/szlachta/otherthing
		new vozhd_type(spawn_turf)

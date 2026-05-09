/datum/round_event_control/darkpack/sarcophagus
	name = "Sarcophagus"
	typepath = /datum/round_event/sarcophagus
	weight = 1
	min_players = 20
	max_occurrences = 1
	earliest_start = 70 MINUTES
	category = EVENT_CATEGORY_INVASION
	description = "A strange sarcophagus has appeared in the city..."
	darkpack_allowed = TRUE

/datum/round_event_control/darkpack/sarcophagus/can_spawn_event(players_amt, allow_magic)
	. = ..()
	if(!locate(/obj/effect/landmark/event_spawn/sarcophagus) in GLOB.generic_event_spawns)
		return FALSE

/datum/round_event/sarcophagus
	start_when = 1
	announce_when = 5

/datum/round_event/sarcophagus/announce(fake)
	priority_announce(
		"You receive a notification about a viral Endpost - a respected archaeologist notes that the location of a long-lost Assyrian sarcophagus alongside it's key, which was famously stolen, seems to be in your city according to newly published criminological records tracking the suspected thief.",
		"Viral News Story",
		'modular_darkpack/modules/events/sounds/news_notification.ogg',
		ANNOUNCEMENT_TYPE_PRIORITY,
		color_override = "yellow",
	)

/datum/round_event/sarcophagus/start()
	var/list/landmarks = list()
	for(var/obj/effect/landmark/event_spawn/sarcophagus/L in GLOB.generic_event_spawns)
		landmarks += L

	if(length(landmarks) < 2)
		return

	var/obj/effect/landmark/event_spawn/sarcophagus/sarcophagus_landmark = pick(landmarks)
	landmarks -= sarcophagus_landmark
	var/obj/effect/landmark/event_spawn/sarcophagus/key_landmark = pick(landmarks)

	var/sarcophagus_type = prob(50) ? /obj/sarcophagus/bomb : /obj/sarcophagus
	new sarcophagus_type(sarcophagus_landmark.loc)
	new /obj/item/sarcophagus_key(key_landmark.loc)

/datum/round_event_control/blackout
	name = "Blackout"
	typepath = /datum/round_event/blackout
	weight = 6
	min_players = 0
	max_occurrences = 2
	earliest_start = 1 MINUTES
	category = EVENT_CATEGORY_ENGINEERING
	description = "A cascading failure in the city's power grid."

/datum/round_event/blackout
	start_when = 1
	announce_when = 5

/datum/round_event/blackout/announce(fake)
	priority_announce(
		"A breaking news notification has appeared on your phone - rolling blackouts are affecting your area due to inclement weather.",
		"Local BREAKING NEWS Alert",
		'modular_darkpack/modules/events/sounds/news_notification.ogg',
		ANNOUNCEMENT_TYPE_PRIORITY
	)

/datum/round_event/blackout/start()
	for(var/obj/fusebox/F in GLOB.fuseboxes)
		if(prob(50))
			continue

		F.atom_integrity = 0
		F.power_off()

/datum/round_event_control/darkpack/blackout
	name = "Blackout"
	typepath = /datum/round_event/blackout
	weight = 6
	min_players = 5
	max_occurrences = 2
	earliest_start = 10 MINUTES
	category = EVENT_CATEGORY_ENGINEERING
	description = "A cascading failure in the city's power grid."
	darkpack_allowed = TRUE

/datum/round_event/blackout
	start_when = 1
	announce_when = 5

/datum/round_event/blackout/announce(fake)
	priority_announce(
		"A breaking news notification has appeared on your phone - rolling blackouts are affecting your area due to inclement weather.",
		"Local BREAKING NEWS Alert",
		'modular_darkpack/modules/events/sounds/news_notification.ogg',
		ANNOUNCEMENT_TYPE_PRIORITY,
		color_override = "red",
	)

/datum/round_event/blackout/start()
	for(var/obj/fusebox/F in GLOB.fuseboxes)
		if(prob(50))
			continue
		F.take_damage(101)
		F.power_off()

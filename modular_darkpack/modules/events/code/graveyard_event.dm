/datum/round_event_control/darkpack/graveyard
	name = "Graveyard "
	typepath = /datum/round_event/graveyard
	weight = 3
	min_players = 10
	max_occurrences = 2
	earliest_start = 90 MINUTES
	category = EVENT_CATEGORY_INVASION
	description = "Roving, loose graveyard have found their way into the city."
	darkpack_allowed = TRUE

/datum/round_event_control/darkpack/graveyard/can_spawn_event(players_amt, allow_magic)
	. = ..()
	if(!locate(/obj/vampgrave) in GLOB.generic_event_spawns)
		return FALSE

/datum/round_event/graveyard
	start_when = 1
	announce_when = 5

/datum/round_event/graveyard/announce(fake)
	var/endpost_graveyard_author = pick("thesupernaturalguy71", "mhaley71", "justplumbin92", "illuminati_truther777", "satanwatch_now")
	var/endpost_graveyard_post = pick("saw something soooo weird... :) new video coming soon on my channel", "just had the most terrifying moment of my life. saw some kind of monster.", "Yeap, whatever I saw, I'm just goin' right the fuck home.", "(the post has an extremely blurry image attached of what looks to be some kind monster. is it photoshopped?)")
	endpost_announce(endpost_graveyard_post, endpost_graveyard_author)

/datum/round_event/graveyard/start()
	for(var/obj/vampgrave in GLOB.generic_event_spawns)
		if(!prob(20))
			continue

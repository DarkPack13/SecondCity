/datum/round_event_control/darkpack/hunter_event
	name = "Hunter NPCs"
	typepath = /datum/round_event/hunter_event
	weight = 6
	min_players = 5
	max_occurrences = 5
	earliest_start = 10 MINUTES
	category = EVENT_CATEGORY_INVASION
	description = "An independent hunter walks the night..."

/datum/round_event_control/darkpack/hunter_event/can_spawn_event(players_amt, allow_magic)
	. = ..()
	if(!.)
		return FALSE

	var/found_spawn = FALSE
	for(var/obj/effect/landmark/npcactivity/L in GLOB.npc_activities)
		if(istype(L, /obj/effect/landmark/npcactivity))
			found_spawn = TRUE
			break

	if(!found_spawn)
		message_admins("ERROR: Hunter event called but coulnd't find an npcactivity spawn landmark. Tell Nimi.")
		return FALSE
	if(length(GLOB.living_hunters) >= 10)
		return FALSE
	if(SSmasquerade.masquerade_level == MASQUERADE_MAX_LEVEL)
		return FALSE
	return TRUE

/datum/round_event/hunter_event
	start_when = 1
	announce_when = 5
	var/list/hunter_spawns = list()
	var/hunter_count
	var/obj/effect/landmark/npcactivity/entry_point
	var/area/spawn_area

/datum/round_event/hunter_event/setup()
	. = ..()
	for(var/obj/effect/landmark/npcactivity/L in GLOB.npc_activities)
		if(istype(L, /obj/effect/landmark/npcactivity))
			hunter_spawns += L

	entry_point = pick(hunter_spawns)
	spawn_area = get_area(entry_point)

	hunter_count = 0
	switch(SSmasquerade.masquerade_level)
		if(21 to MASQUERADE_MAX_LEVEL - 1)
			hunter_count = rand(1, 2)
		if(11 to 20)
			hunter_count = rand(3, 5)
		if(0 to 10)
			hunter_count = rand(5, 10)
	return TRUE

/datum/round_event/hunter_event/announce(fake)
	var/list/warning = list("peeps...", "YOOOOO", "wtf", "Holy shit", "Wow", "ok", "crazy", "epic", "actually so annoying")
	var/list/random_description = list("saw a weird religious guy mumbling to himself",	"weird night, and now weird religious guys are out too", \
	"i swear that guy had a stake in his pocket", \
	"so [pick("weird","creepy","gross","icky","strange","bizare","odd")], a pastor \
	[pick("bumped into me", "shoved me", "held a weird thing up to my face", "wiggled a jewel at me", \
	"is walking around with an EMF reader like a ghost buster and just straight up knocked me down", \
	"yelled bible verses at me")] [pick("and didnt even apologize after", " ")]" \
	)
	message_admins("EVENT: The hunter event automatically triggered in [ADMIN_VERBOSEJMP(entry_point.loc)][spawn_area?.name].")
	endpost_announce("[pick(warning)], [pick(random_description)][pick(".","..."," ")]", pick("friedman1990", "mel0nman","y3ll0wgl0v3s","d3bofn1ght"))


/datum/round_event/hunter_event/start()
	for(var/i in 1 to hunter_count)
		var/mob/living/carbon/human/npc/walkby/hunter/spawned = new(entry_point.loc)
		SSpoints_of_interest.make_point_of_interest(spawned)


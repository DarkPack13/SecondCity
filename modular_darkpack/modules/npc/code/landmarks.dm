/obj/effect/landmark/npcbeacon
	name = "NPC landmark"
	icon_state = "x3"

/obj/effect/landmark/ai_avoid_turf
	name = "AI avoidant turf landmark"
	icon_state = "x"
	can_astar_pass = CANASTARPASS_ALWAYS_PROC

/obj/effect/landmark/ai_avoid_turf/CanAStarPass(to_dir, datum/can_pass_info/pass_info)
	return FALSE

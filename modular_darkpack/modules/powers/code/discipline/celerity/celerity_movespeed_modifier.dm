/datum/movespeed_modifier/celerity
	multiplicative_slowdown = -0.5
	conflicts_with = list(
		/datum/movespeed_modifier/celerity2,
		/datum/movespeed_modifier/celerity3,
		/datum/movespeed_modifier/celerity4,
		/datum/movespeed_modifier/celerity5
	)

/datum/movespeed_modifier/celerity2
	multiplicative_slowdown = -0.75
	conflicts_with = list(
		/datum/movespeed_modifier/celerity,
		/datum/movespeed_modifier/celerity3,
		/datum/movespeed_modifier/celerity4,
		/datum/movespeed_modifier/celerity5
	)

/datum/movespeed_modifier/celerity3
	multiplicative_slowdown = -1
	conflicts_with = list(
		/datum/movespeed_modifier/celerity,
		/datum/movespeed_modifier/celerity2,
		/datum/movespeed_modifier/celerity4,
		/datum/movespeed_modifier/celerity5
	)

/datum/movespeed_modifier/celerity4
	multiplicative_slowdown = -1.25
	conflicts_with = list(
		/datum/movespeed_modifier/celerity,
		/datum/movespeed_modifier/celerity2,
		/datum/movespeed_modifier/celerity3,
		/datum/movespeed_modifier/celerity5
	)

/datum/movespeed_modifier/celerity5
	multiplicative_slowdown = -1.5
	conflicts_with = list(
		/datum/movespeed_modifier/celerity,
		/datum/movespeed_modifier/celerity2,
		/datum/movespeed_modifier/celerity3,
		/datum/movespeed_modifier/celerity4
	)

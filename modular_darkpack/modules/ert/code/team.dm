/datum/ert/darkpack
	abstract_type = /datum/ert/darkpack

/datum/ert/darkpack/swat
	leader_role = /datum/antagonist/ert/darkpack/swat/leader
	roles = list(/datum/antagonist/ert/darkpack/swat/medic, /datum/antagonist/ert/darkpack/swat/rifleman, /datum/antagonist/ert/darkpack/swat/negotiations)
	rename_team = "SWAT Unit"
	mission = "Assess the situation and assist the Police Department. Ensure that law and order is restored in the City."
	polldesc = "the City's Special Weapons and Tactics Unit"

/datum/ert/darkpack/national_guard
	leader_role = /datum/antagonist/ert/darkpack/national_guard/leader
	roles = list(/datum/antagonist/ert/darkpack/national_guard/medic, /datum/antagonist/ert/darkpack/national_guard/rifleman, /datum/antagonist/ert/darkpack/national_guard/explosives)
	rename_team = "National Guard Platoon"
	mission = "Stabilize the area. Establish a curfew. Disperse the riots. Ensure safety and restore order immediately - by any means."
	polldesc = "the National Guard Emergency Response Unit"

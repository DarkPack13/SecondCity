/datum/ert/darkpack
	abstract_type = /datum/ert/darkpack

// /datum/ert/darkpack/swat
//TODO: Get the SWAT Icons from Bomby & reimplement SWAT using the normal ert system
// /datum/ert/darkpack/national_guard
//TODO: Get new assets & reimplement the national guard using the normal ERT system

/datum/ert/darkpack/pentex
	leader_role = /datum/antagonist/ert/darkpack/pentex/leader
	roles = list(/datum/antagonist/ert/darkpack/pentex/medic, /datum/antagonist/ert/darkpack/pentex/exterminator, /datum/antagonist/ert/darkpack/pentex/specialist)
	rename_team = "First Team"
	mission = "Liquidate all hostile anomolous entities"
	polldesc = "an elite FIRST Team"

/datum/ert/darkpack/pentex/budget
	leader_role = /datum/antagonist/ert/darkpack/pentex/budget_leader
	roles = list(/datum/antagonist/ert/darkpack/pentex/budget_intern, /datum/antagonist/ert/darkpack/pentex/budget_medic)
	rename_team = "First Team" //For when you need a death-squad on a budget
	mission = "Remove all hostile anomolous entities"
	polldesc = "an 'elite' FIRST Team"

/// Inits GLOB.auspice_list
/proc/init_auspices()
	var/auspice_list = list()
	for(var/path in valid_subtypesof(/datum/auspice))
		var/datum/auspice/S = path
		auspice_list[S.name] = S
	return auspice_list

/datum/auspice
	abstract_type = /datum/auspice
	var/name
	var/desc

	var/start_rage

	var/moons_born_under = list()

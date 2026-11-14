/area
	var/fire_controled = FALSE
	var/fire_controling = FALSE

	// START - AMBIENCE
	var/music_index
	/// Equivelent to ambientsounds, A list of music tracks to pick from every so often to play to clients.
	var/list/musictracks
	///Does this area immediately play a music track upon enter?
	var/forced_music = FALSE
	///Used to decide what the minimum time between music tracks is
	var/min_music_cooldown = 1 MINUTES
	///Used to decide what the maximum time between music tracks is
	var/max_music_cooldown = 2 MINUTES
	// END - AMBIENCE

	var/show_area_name = TRUE // AREAS

	/// Decimal representing how strongly we effect the global triatic influence. 1 = 100%, 0.5 = 50%, etc.
	var/triatic_influence_mod = 0

/area/Initialize(mapload)
	// START - AMBIENCE
	if(!musictracks)
		musictracks = GLOB.music_assoc[music_index]
	// END - AMBIENCE

	. = ..()


/area/proc/get_average_area_taints()
	var/list/our_tainted_atoms = list()

	var/list/wyrm_taints = list()
	var/list/weaver_taints = list()
	var/list/wyld_taints = list()

	var/list/turf_wyrm_taints = list()
	var/list/turf_weaver_taints = list()
	var/list/turf_wyld_taints = list()

	for(var/atom/tainted_atom in SStaint.tainted_atoms)
		if(get_area(tainted_atom) == src)
			our_tainted_atoms += tainted_atom

	for(var/turf/tainted_turf_in_list in our_tainted_atoms)
		turf_wyrm_taints[tainted_turf_in_list] = tainted_turf_in_list.taint_wyrm
		turf_weaver_taints[tainted_turf_in_list] = tainted_turf_in_list.taint_weaver
		turf_wyld_taints[tainted_turf_in_list] = tainted_turf_in_list.taint_wyld

	for(var/atom/movable/tainted_atom_in_list in our_tainted_atoms)
		wyrm_taints[tainted_atom_in_list] = tainted_atom_in_list.taint_wyrm
		weaver_taints[tainted_atom_in_list] = tainted_atom_in_list.taint_weaver
		wyld_taints[tainted_atom_in_list] = tainted_atom_in_list.taint_wyld

	var/average_wyrm_taint = (values_sum(wyrm_taints)+values_sum(turf_wyrm_taints))/max(wyrm_taints.len+turf_wyrm_taints.len, 1)
	var/average_weaver_taint = (values_sum(weaver_taints)+values_sum(turf_weaver_taints))/max(weaver_taints.len+turf_weaver_taints.len, 1)
	var/average_wyld_taint = (values_sum(wyld_taints)+values_sum(turf_wyld_taints))/max(wyld_taints.len+turf_wyld_taints.len, 1)
	to_chat(world, "[name]: wyrm = [average_wyrm_taint] | weaver = [average_weaver_taint] | wyld = [average_wyld_taint]")
	return list("wyrm" = average_wyrm_taint, "weaver" = average_weaver_taint, "wyld" = average_wyld_taint)

// This system handles the 'average' taint of objects within areas, and also the global average.
SUBSYSTEM_DEF(taint)
	name = "Triatic Taint"
	wait = 1 MINUTES

	var/list/tainted_atoms = list()
	var/list/global_taint = list()


/datum/controller/subsystem/taint/Initialize()
	for(var/atom/tainted_atom in world)
		tainted_atom.has_taint()

	return SS_INIT_SUCCESS

/datum/controller/subsystem/taint/fire()
	global_taint = get_global_triatic_taint()

/datum/controller/subsystem/taint/proc/get_global_triatic_taint() // basically a higher level dupe of /area/proc/get_average_area_taints()
	var/list/wyrm_taints = list()
	var/list/weaver_taints = list()
	var/list/wyld_taints = list()

	for(var/area/tainted_area in GLOB.areas)
		tainted_area.get_average_area_taints() // let's collate all of our taints rq
		wyrm_taints[tainted_area] = tainted_area.taint_wyrm
		weaver_taints[tainted_area] = tainted_area.taint_weaver
		wyld_taints[tainted_area] = tainted_area.taint_wyld

	var/average_wyrm_taint = values_sum(wyrm_taints)/max(wyrm_taints.len, 1)
	var/average_weaver_taint = values_sum(weaver_taints)/max(weaver_taints.len, 1)
	var/average_wyld_taint = values_sum(wyld_taints)/max(wyld_taints.len, 1)

	return list("wyrm" = average_wyrm_taint, "weaver" = average_weaver_taint, "wyld" = average_wyld_taint)

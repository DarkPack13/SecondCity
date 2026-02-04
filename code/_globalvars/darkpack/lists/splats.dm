/// An assoc list of splat IDs to type paths
GLOBAL_LIST_INIT(splat_list, init_splat_list())
/// List of all splat prototypes to reference, assoc [type] = prototype
GLOBAL_LIST_INIT_TYPED(splat_prototypes, /datum/splat, init_subtypes_w_path_keys(/datum/splat, list()))

/proc/init_splat_list()
	var/list/splat_list = list()
	for(var/datum/splat/splat_path as anything in valid_subtypesof(/datum/splat))
		splat_list[splat_path::id] = splat_path
	return splat_list

/// An assoc list of species types to their features (from get_features())
GLOBAL_LIST_EMPTY(features_by_splats)


/// Creates an assoc list indexed by the name of the subsplat
/proc/init_subsplat_list(path = /datum/subsplat)
	var/list/subsplat_list = list()
	for (var/datum/subsplat/subsplat as anything in valid_subtypesof(path))
		subsplat_list[subsplat::name] = subsplat
	//subsplat_list = sort_list(subsplat_list)
	return subsplat_list

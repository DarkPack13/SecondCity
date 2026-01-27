/// An assoc list of splat IDs to type paths
GLOBAL_LIST_INIT(splat_list, init_splat_list())
/// List of all splat prototypes to reference, assoc [type] = prototype
GLOBAL_LIST_INIT_TYPED(splat_prototypes, /datum/splat, init_splat_prototypes())

/proc/init_splat_list()
	var/list/splat_list = list()
	for(var/datum/splat/splat_path as anything in valid_subtypesof(/datum/splat))
		splat_list[splat_path::id] = splat_path
	return splat_list

/proc/init_splat_prototypes()
	var/list/splat_list = list()
	for(var/splat_type in valid_subtypesof(/datum/splat))
		splat_list[splat_type] = new splat_type()
	return splat_list

/// An assoc list of species types to their features (from get_features())
GLOBAL_LIST_EMPTY(features_by_splats)

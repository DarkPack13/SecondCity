/// Associative list of Discipline names to typepaths
GLOBAL_LIST_INIT(discipline_list, init_subsplat_list(/datum/discipline))

/// Associative list of Discipline typepaths to singletons
GLOBAL_LIST_INIT_TYPED(disciplines, /datum/discipline, init_subtypes_w_path_keys(/datum/discipline, list()))

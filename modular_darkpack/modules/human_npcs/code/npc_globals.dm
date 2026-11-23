/// All human NPCs, living or dead
GLOBAL_LIST_EMPTY(human_npc_list)
/// All living human NPCs
GLOBAL_LIST_EMPTY(alive_human_npc_list)


/// Landmarks that NPCs will spawn at
GLOBAL_LIST_EMPTY(npc_spawn_points)
GLOBAL_LIST_EMPTY(npc_beacons)


/// Assoc list of npc social rolls by paths: instances
GLOBAL_LIST_INIT_TYPED(npc_social_roles, /datum/socialrole, init_subtypes_w_path_keys(/datum/socialrole, list()))

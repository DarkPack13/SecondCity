/// List of Kindred in the city.
GLOBAL_LIST_EMPTY(kindred_list)
/// List of living Sabbat members in the city
GLOBAL_LIST_EMPTY(sabbatites)

// TODO: [Rebase] - GAROU - Make this affect anything about garou
GLOBAL_VAR_INIT(moon_state, pick("New", "Crescent", "Half", "Gibbous", "Full"))

/// Current phase of the moon, randomly chosen
GLOBAL_VAR_INIT(moon_state, pick("New", "Crescent", "Half", "Gibbous", "Full"))

/// List of all Tribe totems
GLOBAL_LIST_EMPTY(totems)

GLOBAL_LIST_INIT(glyph_list, init_glyphs())

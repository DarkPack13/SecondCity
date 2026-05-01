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

/area/Initialize(mapload)
	// START - AMBIENCE
	if(!musictracks)
		musictracks = GLOB.music_assoc[music_index]
	// END - AMBIENCE

	. = ..()

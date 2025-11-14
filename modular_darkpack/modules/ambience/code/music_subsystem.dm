/// Controls music volume
/datum/preference/numeric/volume/sound_music_volume
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "sound_music_volume"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/numeric/volume/sound_music_volume/apply_to_client(client/client, value)
	client.update_music_pref(value)

/client/proc/update_music_pref(value)
	if(value)
		if(SSmusic.music_listening_clients[src] > world.time)
			return // If already properly set we don't want to reset the timer.
		SSmusic.music_listening_clients[src] = world.time + 10 SECONDS //Just wait 10 seconds before the next one aight mate? cheers.
	else
		SSmusic.remove_music_client(src)

/datum/client_interface/proc/update_music_pref()
	return

/// The subsystem used to play music to users every now and then, makes them real excited. copy-pasta from SSambience
SUBSYSTEM_DEF(music)
	name = "Music"
	flags = SS_BACKGROUND|SS_NO_INIT
	priority = FIRE_PRIORITY_AMBIENCE
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 1 SECONDS
	///Assoc list of listening client - next music time
	var/list/music_listening_clients = list()
	var/list/client_old_areas = list()
	///Cache for sanic speed :D
	var/list/currentrun = list()

/datum/controller/subsystem/music/fire(resumed)
	if(!resumed)
		currentrun = music_listening_clients.Copy()
	var/list/cached_clients = currentrun

	if(!CLIENT_COOLDOWN_FINISHED(GLOB, web_sound_cooldown))
		return

	while(cached_clients.len)
		var/client/client_iterator = cached_clients[cached_clients.len]
		cached_clients.len--

		//Check to see if the client exists and isn't held by a new player
		var/mob/client_mob = client_iterator?.mob
		if(isnull(client_iterator) || !client_mob || isnewplayer(client_mob))
			music_listening_clients -= client_iterator
			client_old_areas -= client_iterator
			continue

		// These are non-diagetic
		//if(!client_mob.can_hear()) //WHAT? I CAN'T HEAR YOU
		//	continue

		//Check to see if the client-mob is in a valid area
		var/area/current_area = get_area(client_mob)
		if(!current_area) //Something's gone horribly wrong
			stack_trace("[key_name(client_mob)] has somehow ended up in nullspace. WTF did you do")
			remove_music_client(client_iterator)
			continue

		if(music_listening_clients[client_iterator] > world.time)
			if(!(current_area.forced_music && (client_old_areas?[client_iterator] != current_area) && prob(5)))
				continue

		//Run play_music() on the client-mob and set a cooldown
		music_listening_clients[client_iterator] = world.time + current_area.play_music(client_mob)

		//We REALLY don't want runtimes in SSmusic
		if(client_iterator)
			client_old_areas[client_iterator] = current_area

		if(MC_TICK_CHECK)
			return

///Attempts to play an ambient sound to a mob, returning the cooldown in deciseconds
/area/proc/play_music(mob/M, sound/override_sound, volume = 27)
	var/sound/new_sound = override_sound || pick(musictracks)
	if(!new_sound) // Dont try to play a sound if we dont have any, required by darkpack as not every area has a sound.
		return 1 MINUTES
	/// volume modifier for music as set by the player in preferences.
	var/volume_modifier = (M.client?.prefs.read_preference(/datum/preference/numeric/volume/sound_music_volume))/100
	new_sound = sound(new_sound, repeat = 0, wait = 0, volume = volume*volume_modifier, channel = CHANNEL_MUSIC)
	SEND_SOUND(M, new_sound)

	var/sound_length = SSsounds.get_sound_length(new_sound.file)
	if(!sound_length)
		// This will cause sounds to cut into eachother if the sound is longer then the min_ambience_cooldown
		stack_trace("play_music failed to get soundlength from [new_sound] with a file of [new_sound.file].")
	return sound_length + rand(min_music_cooldown, max_music_cooldown)

/datum/controller/subsystem/music/proc/remove_music_client(client/to_remove)
	music_listening_clients -= to_remove
	client_old_areas -= to_remove
	currentrun -= to_remove

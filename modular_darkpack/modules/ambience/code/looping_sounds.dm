/datum/looping_sound/light_hum
	mid_sounds = list(
		'modular_darkpack/modules/ambience/sounds/ambient_objects/light_hum-01.ogg',
		'modular_darkpack/modules/ambience/sounds/ambient_objects/light_hum-02.ogg',
		'modular_darkpack/modules/ambience/sounds/ambient_objects/light_hum-03.ogg',
		'modular_darkpack/modules/ambience/sounds/ambient_objects/light_hum-04.ogg',
		'modular_darkpack/modules/ambience/sounds/ambient_objects/light_hum-05.ogg',
		'modular_darkpack/modules/ambience/sounds/ambient_objects/light_hum-06.ogg',
		'modular_darkpack/modules/ambience/sounds/ambient_objects/light_hum-07.ogg',
		'modular_darkpack/modules/ambience/sounds/ambient_objects/light_hum-08.ogg',
	)
	volume = 6
	falloff_exponent = 5 //Ultra quiet very fast
	extra_range = -12
	falloff_distance = 1 //Instant falloff after initial tile


/datum/looping_sound/slow_drip
	mid_sounds = list(
		'modular_darkpack/modules/ambience/sounds/ambient_objects/drip-01.ogg'
		'modular_darkpack/modules/ambience/sounds/ambient_objects/drip-02.ogg'
		'modular_darkpack/modules/ambience/sounds/ambient_objects/drip-03.ogg'
		'modular_darkpack/modules/ambience/sounds/ambient_objects/drip-04.ogg'
		'modular_darkpack/modules/ambience/sounds/ambient_objects/drip-05.ogg'
		'modular_darkpack/modules/ambience/sounds/ambient_objects/drip-06.ogg'
	)
	mid_length = 20 SECONDS
	mid_length_vary = 3 SECONDS
	volume = 45
	vary = TRUE
	ignore_walls = FALSE
	falloff_distance = 5

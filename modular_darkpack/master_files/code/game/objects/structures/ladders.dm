/obj/structure/ladder
	icon = 'modular_darkpack/modules/z_travel/icons/ladders.dmi'
	/// Played after the do_after is finished
	var/travel_sound
	// Requires a sister ladder to link up with us else we runtime
	var/requires_friend = FALSE
	/// If we DONT update our icon state based off our linked ladders, used for manholes.
	var/static_appearance = FALSE

	// Both of these only matter for the sake of late init to save on time searching
	/// Determines if it will try and locate its up during late init, useful if you know there wont ever be one (Manholes)
	var/connect_up = TRUE
	/// Determines if it will try and locate its down during late init, useful if you know there wont ever be one (Manholes)
	var/connect_down = TRUE

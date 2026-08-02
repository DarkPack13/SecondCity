/datum/quirk
	var/darkpack_allowed = FALSE // MERITS/FLAWS
	// I would like to highlight these to admins or players but for now it lets them be controlled via config
	/// If the quirk has 0 mechnaical effect.
	var/roleplay_only = FALSE
	var/hide_in_setup = FALSE // should this quirk specifically be hidden from character setup but still have unit tests, whereas darkpack_allowed doesnt show it AND doesnt run unit tests

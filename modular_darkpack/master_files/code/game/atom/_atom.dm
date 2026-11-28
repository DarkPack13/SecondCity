/atom
	var/taint_wyrm = 0
	var/taint_weaver = 0
	var/taint_wyld = 0

/atom/Initialize(mapload, ...)
	. = ..()
	has_taint()

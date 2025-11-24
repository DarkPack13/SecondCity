/datum/element/swaying
	var/sway_angle
	var/sway_time
	var/pivot_offset

/datum/element/swaying/Attach(atom/target, sway_angle = 4, sway_time = 2 SECONDS, pivot_offset = 0)
	. = ..()
	src.sway_angle = sway_angle
	src.sway_time = sway_time
	src.pivot_offset = pivot_offset

	var/atom/atom_target = target
	var/area/target_area = get_area(atom_target)

	if(!istype(target_area) || !target_area.outdoors)
		return

	start_swaying(atom_target)

/datum/element/swaying/proc/start_swaying(atom/target)
	var/matrix/M1 = matrix()
	var/matrix/M2 = matrix()

	if(pivot_offset)
		M1.Translate(0, pivot_offset)
		M1.Turn(sway_angle)
		M1.Translate(0, -pivot_offset)

		M2.Translate(0, pivot_offset)
		M2.Turn(-sway_angle)
		M2.Translate(0, -pivot_offset)
	else
		M1.Turn(sway_angle)
		M2.Turn(-sway_angle)

	if(prob(50))
		animate(target, transform = M1, time = sway_time, loop = -1, easing = SINE_EASING, delay = rand(1, 15))
		animate(transform = M2, time = sway_time)
	else
		animate(target, transform = M2, time = sway_time, loop = -1, easing = SINE_EASING, delay = rand(1, 15))
		animate(transform = M1, time = sway_time)

/datum/element/swaying/Detach(atom/target)
	. = ..()
	if(isatom(target))
		animate(target)
		var/atom/atom_target = target
		atom_target.transform = matrix()

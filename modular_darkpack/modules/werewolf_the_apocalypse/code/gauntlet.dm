/atom/proc/get_gauntlet_rating()
	var/area/vtm/my_area = astype(get_area(src))
	if(my_area)
		return my_area.gauntlet_rating
	return 7


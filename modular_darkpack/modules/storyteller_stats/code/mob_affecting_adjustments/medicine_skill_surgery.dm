/mob/living/proc/check_medicine_wound_tending(datum/source, atom/movable/operating_on, list/possible_operations)
	SIGNAL_HANDLER
	var/medicine = st_get_stat(STAT_MEDICINE)
	if(medicine >= 4)
		possible_operations += /datum/surgery_operation/basic/tend_wounds/combo/upgraded
	else if(medicine >= 3)
		possible_operations += /datum/surgery_operation/basic/tend_wounds/combo

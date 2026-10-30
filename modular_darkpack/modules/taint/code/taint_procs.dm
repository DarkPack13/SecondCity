/atom/proc/has_taint(return_list = FALSE) // Truthy if we have taint, returns an alist of our taints if return_list = TRUE
	if(taint_wyrm || taint_weaver || taint_wyld)
		if(!(src in SStaint.tainted_atoms))
			SStaint.tainted_atoms += src
			if(taint_wyrm > 10 || taint_weaver > 10 || taint_wyld > 10)
				WARNING("One or more taint values on [src] is above 10")
		if(return_list)
			return list(TRIAT_WYRM = taint_wyrm, TRIAT_WEAVER = taint_weaver, TRIAT_WYLD = taint_wyld)
		else
			return TRUE
	else
		return FALSE

/atom/proc/has_taint_wyrm() // Truthy if we have wyrm taint
	if(taint_wyrm)
		return taint_wyrm
	else
		return FALSE

/atom/proc/has_taint_weaver() // Truthy if we have weaver taint
	if(taint_weaver)
		return taint_weaver
	else
		return FALSE

/atom/proc/has_taint_wyld() // Truthy if we have wyld taint
	if(taint_wyld)
		return taint_wyld
	else
		return FALSE

/atom/proc/get_taints()
	return list(TRIAT_WYRM = taint_wyrm, TRIAT_WEAVER = taint_weaver, TRIAT_WYLD = taint_wyld)

/**
 * ### Triatic Influence
 * Adjusts our triatic taints and checks whether or not we belong in SStaint's tainted_atoms list. Returns TRUE if we're added to the list, FALSE otherwise
 *
 * wyrm - wyrm taint to adjust by
 * weaver - weaver taint to adjust by
 * wyld - wyld taint to adjust by
 * set_to - Whether or not we are adjusting or setting. Strips signs if TRUE. Default: FALSE
 */
/atom/proc/adjust_taint(wyrm = 0, weaver = 0, wyld = 0, set_to = FALSE)
	if(set_to)
		taint_wyrm = wyrm
		taint_weaver = weaver
		taint_wyld = wyld
	else
		taint_wyrm += clamp(taint_wyrm+wyrm, 0, 10)
		taint_weaver += clamp(taint_weaver+weaver, 0, 10)
		taint_wyld += clamp(taint_wyld+wyld, 0, 10)

	if(!(src in SStaint.tainted_atoms) && taint_wyrm > 0 || taint_weaver > 0 || taint_wyld > 0)
		SStaint.tainted_atoms += src
		return TRUE
	else if((src in SStaint.tainted_atoms) && taint_wyrm == 0 && taint_weaver == 0 && taint_wyld == 0)
		SStaint.tainted_atoms -= src

	return FALSE

/atom/proc/adjust_specific_taint(taint, amount = 0, set_to = FALSE)
	switch(taint)
		if(TRIAT_WYRM)
			adjust_taint(wyrm = amount, set_to = set_to)
		if(TRIAT_WEAVER)
			adjust_taint(weaver = amount, set_to = set_to)
		if(TRIAT_WYLD)
			adjust_taint(wyld = amount, set_to = set_to)

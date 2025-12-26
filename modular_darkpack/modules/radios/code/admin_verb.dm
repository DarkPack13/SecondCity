ADMIN_VERB(report_crime, R_ADMIN, "Report Crime", "Report a crime to be happening.", ADMIN_CATEGORY_EVENTS)
	var/answer = tgui_input_list(user, "What kind of crime?", "Crime", list(CRIME_BURGLARY, CRIME_FIREFIGHT, CRIME_GUNSHOTS, CRIME_MURDER, CRIME_EMERGENCY))
	if(!answer)
		return
	SEND_SIGNAL(SSdcs, COMSIG_GLOB_REPORT_CRIME, answer, get_turf(user))
	to_chat(user, span_adminnotice("Crime reported: [answer]!"))

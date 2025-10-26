/datum/job_department/citizen
	department_name = DEPARTMENT_CITIZEN
	department_bitflags = DEPARTMENT_BITFLAG_CITIZEN
	// Don't add department_head! citizens names should not be in bold.

/// A special prince only department, for use by the preferences menu
/datum/job_department/prince
	department_name = DEPARTMENT_PRINCE
	department_bitflags = DEPARTMENT_BITFLAG_PRINCE
	department_head = /datum/job/vampire/prince

/datum/job_department/camarilla
	department_name = DEPARTMENT_CAMARILLA
	department_bitflags = DEPARTMENT_BITFLAG_CAMARILLA
	department_head = /datum/job/vampire/prince
	department_experience_type = EXP_TYPE_CAMARILLA
	display_order = 1
	label_class = "camarilla"
	ui_color = "#6681a5"

/datum/job_department/church
	department_name = DEPARTMENT_CHURCH
	department_bitflags = DEPARTMENT_BITFLAG_CHURCH
	department_head = /datum/job/vampire/prince
	department_experience_type = EXP_TYPE_CHURCH
	display_order = 1
	label_class = "camarilla"
	ui_color = "#6681a5"

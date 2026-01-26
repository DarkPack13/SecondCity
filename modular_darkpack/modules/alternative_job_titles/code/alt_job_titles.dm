/**
 * This is the file you should use to add alternate titles for each job, just
 * follow the way they're done here, it's easy enough and shouldn't take any
 * time at all to add more or add some for a job that doesn't have any.
 */

/datum/job
	/// The list of alternative job titles people can pick from, null by default.
	var/list/alt_titles = null


/datum/job/vampire/citizen
	alt_titles = list(
		"Citizen",
		"Private Investigator",
		"Private Security",
		"Tourist",
		"Visitor",
		"Entertainer",
		"Entrepreneur",
		"Contractor",
		"Fixer",
		"Lawyer",
		"Attorney",
		"Paralegal",
	)

/datum/job/vampire/doctor
	alt_titles = list(
		"Doctor",
		"Medical Student",
		"Intern",
		"Nurse",
		"Resident",
		"General Practitioner",
		"Surgeon",
		"Physician",
		"Paramedic",
		"EMT",
	)

/datum/job/vampire/police_officer
	alt_titles = list(
		"Police Officer",
		"Police Cadet",
		"Senior Police Officer",
	)

/datum/job/vampire/police_sergeant
	alt_titles = list(
		"Police Sergeant",
		"Police Supervisor",
		"Training Officer",
		"Detective",
	)

/datum/job/vampire/priest
	alt_titles = list(
		"Priest",
		"Nun",
		"Mother",
		"Father",
		"Imam",
		"Monk",
		"Reverend",
		"Preacher",
		"Rabbi",
	)

/datum/job/vampire/club_worker
	alt_titles = list(
		"Club Worker",
		"Stripper",
		"Club Bouncer",
		"Club Bartender",
		"Club Attendant"
	)

/datum/job/vampire/towerwork
	alt_titles = list(
		"Tower Employee",
		"Tower Cleaner",
		"Tower Assistant",
		"Tower Security Guard",
		"Tower Personal Driver",
		"Tower Personal Attendant"
	)

/datum/job/vampire/tapster
	alt_titles = list(
		"Bartender"
		"Barkeeper",
		"Tapster",
		"Server",
		"Soda Jerk", //I always loved this as a title and I am mad it isn't in common use anymore.
		"Waiter",
		"Waitress"
	)

/datum/job/vampire/employee
	alt_titles = list(
		"Endron Employee",
		"Endron Janitor",
		"Endron Secretary",
		"Endron Researcher",
		"Endron Labourer"
	)

/datum/job/vampire/branch_lead
	alt_titles = list(
		"Endron Branch Lead",
		"Endron Branch Director",
		"Endron Regional Director",
		"Endron Operations Director"
	)

/datum/job/vampire/executive
	alt_titles = list(
		"Endron Executive",
		"Endron Regional Manager",
		"Endron Manager",
		"Endron Marketing Director",
		"Endron Public Relations Manager",
		"Endron Deputy Branch Director",
		"Endron Chief Innovation Officer",
		"Endron Chief Science Officer",
		"Endron Chief Financial Officer"
	)

/datum/job/vampire/bruiser
	alt_titles = list(
	"Bouncer",
	"Coyote",
	"Piper",
	"Rotten Apple",
	"Houdini",
	"Prospect",
	"Cleaver",
	"Molotov",
	)

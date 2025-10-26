
/datum/job/vampire/vdoctor
	title = JOB_DOCTOR
	department_head = list("Clinic Director")
	faction = FACTION_CITY
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Camarilla or the Anarchs"

	exp_required_type_department = EXP_TYPE_CLINIC


	outfit = /datum/outfit/job/vdoctor








	allowed_species = list(SPECIES_KINDRED, SPECIES_GHOUL, SPECIES_HUMAN)
	display_order = JOB_DISPLAY_ORDER_DOCTOR


	description = "Help your fellow kindred in all matters medicine related. Sell blood. Keep your human colleagues ignorant."
	description = "Collect blood by helping mortals at the Clinic."

	allowed_clans = list(VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_SALUBRI, VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_KIASYD)
	known_contacts = list("Clinic Director")

/datum/outfit/job/vdoctor
	name = "Doctor"
	jobtype = /datum/job/vampire/vdoctor

	ears = /obj/item/p25radio
	id = /obj/item/card/clinic
	uniform = /obj/item/clothing/under/vampire/nurse
	shoes = /obj/item/clothing/shoes/vampire/white
	suit =  /obj/item/clothing/suit/vampire/labcoat
	gloves = /obj/item/clothing/gloves/vampire/latex
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/clinic
	backpack_contents = list(/obj/item/passport=1, /obj/item/watch=1, /obj/item/flashlight=1, /obj/item/card/credit=1, /obj/item/storage/medkit/darkpack/doctor=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	skillchips = list(/obj/item/skillchip/entrails_reader, /obj/item/skillchip/quickcarry)

/obj/effect/landmark/start/vdoctor
	name = "Doctor"
	icon_state = "Doctor"


/datum/job/vampire/vdirector
	title = JOB_CLINIC_DIRECTOR
	department_head = list("Seneschal")
	faction = FACTION_CITY
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Camarilla or the Anarchs"

	exp_required_type_department = EXP_TYPE_CLINIC


	outfit = /datum/outfit/job/vdirector








	allowed_species = list(SPECIES_KINDRED, SPECIES_GHOUL, SPECIES_HUMAN)
	display_order = JOB_DISPLAY_ORDER_CLINICS_DIRECTOR


	description = "Keep Saint John's clinic up and running. Sell blood. Keep your human colleagues ignorant."
	description = "Keep Saint John's clinic up and running. Collect blood by helping mortals at the Clinic."

	allowed_clans = list(VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY, VAMPIRE_CLAN_SALUBRI, VAMPIRE_CLAN_BAALI, VAMPIRE_CLAN_BRUJAH, VAMPIRE_CLAN_TREMERE, VAMPIRE_CLAN_VENTRUE, VAMPIRE_CLAN_NOSFERATU, VAMPIRE_CLAN_GANGREL, VAMPIRE_CLAN_TOREADOR, VAMPIRE_CLAN_MALKAVIAN, VAMPIRE_CLAN_BANU_HAQIM, VAMPIRE_CLAN_GIOVANNI, VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_TZIMISCE, VAMPIRE_CLAN_LASOMBRA, VAMPIRE_CLAN_CAITIFF, VAMPIRE_CLAN_KIASYD)

/datum/outfit/job/vdirector
	name = "Clinic Director"
	jobtype = /datum/job/vampire/vdirector

	ears = /obj/item/p25radio
	id = /obj/item/card/clinic/director
	uniform = /obj/item/clothing/under/vampire/nurse
	shoes = /obj/item/clothing/shoes/vampire/white
	suit =  /obj/item/clothing/suit/vampire/labcoat/director
	gloves = /obj/item/clothing/gloves/vampire/latex
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/clinics_director
	backpack_contents = list(/obj/item/passport=1, /obj/item/watch=1, /obj/item/flashlight=1, /obj/item/card/credit=1, /obj/item/storage/medkit/darkpack/doctor=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	skillchips = list(/obj/item/skillchip/entrails_reader, /obj/item/skillchip/quickcarry)

/obj/effect/landmark/start/vdirector
	name = "Director"
	icon_state = "Doctor"

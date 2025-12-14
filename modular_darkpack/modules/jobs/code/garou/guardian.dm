/datum/job/vamp/garou/amberglade/guardian
	title = "Amberglade Guardian"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("The Litany")

	selection_color = "#69e430"
	faction = "Vampire"
	allowed_species = list("Werewolf")
	allowed_tribes = AMBERGLADE_ALLOWED_TRIBES

	total_positions = 5
	spawn_positions = 5
	supervisors = "The Litany and the Council" // APOC EDIT CHANGE

	req_admin_notify = 1
	minimal_player_age = 25
	exp_requirements = 50
	exp_type_department = EXP_TYPE_AMBERGLADE

	outfit = /datum/outfit/job/garou/gladeguardian

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_MECH_SECURITY, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_AMBERGLADE

	minimal_masquerade = 3

	known_contacts = null

	v_duty = "You have put yourself forward as a force for the Sept. Working under the Warder, your duty is to defend and protect the sacred grounds of Gaia, and assist in bringing to heel those who have breached the veil for the Truthcatcher."

/datum/outfit/job/garou/gladeguardian
	name = "City Sept Guardian"
	jobtype = /datum/job/vamp/garou/amberglade/guardian

	id = /obj/item/card/id/garou/glade/guardian
	uniform =  /obj/item/clothing/under/vampire/biker
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	head = /obj/item/clothing/head/vampire/baseballcap
	belt = /obj/item/melee/classic_baton/vampire
	gloves = /obj/item/clothing/gloves/vampire/leather
	suit = /obj/item/clothing/suit/vampire/jacket
	l_pocket = /obj/item/vamp/phone
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/card/credit=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

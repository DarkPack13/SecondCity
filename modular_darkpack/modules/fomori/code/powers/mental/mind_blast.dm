/obj/item/ammo_casing/magic/fomor_mind_blast
	projectile_type = /obj/projectile/mind_blast
	icon_state = ""

/obj/projectile/mind_blast
	name = "mind blast"
	icon_state = "scatterdisabler" // Could prob get a better icon for this
	damage = 0
	alpha = 128

/datum/storyteller_roll/mind_blast
	bumper_text = "mind blast"
	difficulty = 6
	applicable_stats = list(STAT_WITS, STAT_INTIMIDATION)
	numerical = TRUE
	roll_output_type = ROLL_PRIVATE

/datum/storyteller_roll/mind_blast/defender
	bumper_text = "willpower"
	applicable_stats = list(STAT_TEMPORARY_WILLPOWER)
	numerical = TRUE

/datum/action/cooldown/power/fomori_power/mind_blast
	name = "Mind Blast"
	desc = "Spend a willpower point to shock the mind of a victim."
	button_icon_state = "mind_blast"
	rank = 1 // of 1
	click_to_activate = TRUE
	willpower_cost = 1

/datum/action/cooldown/power/fomori_power/mind_blast/Activate(atom/target)
	if(!isliving(target))
		return FALSE

	var/mob/living/victim = target

	. = ..()

	var/datum/storyteller_roll/roll_datum = new /datum/storyteller_roll/mind_blast
	var/ourpower = roll_datum.st_roll(owner)

	var/datum/storyteller_roll/defender_datum = new /datum/storyteller_roll/mind_blast/defender
	var/theirpower = defender_datum.st_roll(target)


	if(ourpower > theirpower)
		var/obj/item/ammo_casing/magic/fomor_mind_blast/casing = new (owner.loc)
		casing.fire_casing(victim, owner, null, null, null, ran_zone(), 0,  owner)
		if(ishuman(victim))
			victim.emote("groan")

		victim.Stun((ourpower TURNS)) // TODO: Make this an actual skillshot

	StartCooldown()
	return TRUE



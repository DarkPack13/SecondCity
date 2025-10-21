/datum/discipline/animalism
	name = "Animalism"
	desc = "Summons spectral animals over your targets. Violates Masquerade."
	icon_state = "animalism"
	power_type = /datum/discipline_power/animalism

/datum/discipline_power/animalism
	name = "Animalism power name"
	desc = "Animalism power description"

	effect_sound = 'modular_darkpack/modules/deprecated/sounds/wolves.ogg'

//SUMMON RAT
/datum/discipline_power/animalism/summon_rat
	name = "Skittering Critters"
	desc = "Summons rats to follow you and gnaw on your enemies."

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

	level = 1
	violates_masquerade = FALSE

	cooldown_length = 8 SECONDS

/datum/discipline_power/animalism/summon_rat/activate()
	. = ..()

	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner

	// add_beastmaster_minion handles the limit check and returns FALSE if at limit
	// So we need to manually remove one if we're at the limit
	var/max_minions = H.st_get_stat(STAT_LEADERSHIP) + 1
	if(length(H.beastmaster_minions) >= max_minions)
		// Remove oldest minion
		var/mob/living/oldest = H.beastmaster_minions[1]
		if(oldest)
			qdel(oldest)
		H.add_beastmaster_minion(/mob/living/basic/mouse/rat)

//SUMMON CAT
/datum/discipline_power/animalism/summon_cat
	name = "Clawing Felines"
	desc = "Summons very cute cats to accompany you in the night."

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

	level = 2
	violates_masquerade = FALSE

	cooldown_length = 8 SECONDS

/datum/discipline_power/animalism/summon_cat/activate()
	. = ..()

	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner

	var/max_minions = H.st_get_stat(STAT_LEADERSHIP) + 1
	if(length(H.beastmaster_minions) >= max_minions)
		var/mob/living/oldest = H.beastmaster_minions[1]
		if(oldest)
			qdel(oldest)
	H.add_beastmaster_minion(/mob/living/basic/pet/cat/darkpack)

//SUMMON WOLF
/datum/discipline_power/animalism/summon_wolf
	name = "Spectral Wolf"
	desc = "Summons a phantasmal wolf to attack the target."

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

	level = 3
	violates_masquerade = TRUE

	cooldown_length = 8 SECONDS

/datum/discipline_power/animalism/summon_wolf/activate()
	. = ..()

	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner

	var/max_minions = H.st_get_stat(STAT_LEADERSHIP) + 1
	if(length(H.beastmaster_minions) >= max_minions)
		var/mob/living/oldest = H.beastmaster_minions[1]
		if(oldest)
			qdel(oldest)
	H.add_beastmaster_minion(/mob/living/basic/pet/dog/darkpack)

//SUMMON BAT
/datum/discipline_power/animalism/summon_bat
	name = "Bloodsucker's Communion"
	desc = "Summons a swarm of bats to drain blood from the victim and transfer it to you."

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

	level = 4
	violates_masquerade = TRUE

	cooldown_length = 8 SECONDS

/datum/discipline_power/animalism/summon_bat/activate()
	. = ..()

	if(!ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner

	var/max_minions = H.st_get_stat(STAT_LEADERSHIP) + 1
	if(length(H.beastmaster_minions) >= max_minions)
		var/mob/living/oldest = H.beastmaster_minions[1]
		if(oldest)
			qdel(oldest)
	H.add_beastmaster_minion(/mob/living/basic/bat/vampire)

// RAT SHAPESHIFT
/datum/action/cooldown/spell/shapeshift/animalism
	name = "Animalism Form"
	desc = "Take on the shape of a rat."
	button_icon_state = "shapeshift"

	cooldown_time = 5 SECONDS

	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	convert_damage = TRUE
	convert_damage_type = BRUTE

	shapeshift_type = /mob/living/basic/mouse/rat
	possible_shapes = list(/mob/living/basic/mouse/rat)

/datum/discipline_power/animalism/rat_shapeshift
	name = "Skitter"
	desc = "Become one of the rats that crawl beneath the city."

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

	level = 5
	violates_masquerade = TRUE

	cooldown_length = 8 SECONDS
	duration_length = 20 SECONDS

	/// The shapeshift spell we grant to the owner
	var/datum/action/cooldown/spell/shapeshift/animalism/shapeshift_spell

/datum/discipline_power/animalism/rat_shapeshift/activate()
	. = ..()

	if(!ishuman(owner))
		return

	// Grant the shapeshift spell if we don't have it yet
	if(!shapeshift_spell)
		shapeshift_spell = new /datum/action/cooldown/spell/shapeshift/animalism()
		shapeshift_spell.Grant(owner)

	// Cast the spell to transform
	shapeshift_spell.cast(owner)

/datum/discipline_power/animalism/rat_shapeshift/deactivate()
	. = ..()

	if(!owner || owner.stat == DEAD)
		return

	// If we're still shifted, unshift them
	if(shapeshift_spell && is_type_in_list(owner, shapeshift_spell.possible_shapes))
		shapeshift_spell.cast(owner) // Casting again will unshift
		owner.Stun(1.5 SECONDS)

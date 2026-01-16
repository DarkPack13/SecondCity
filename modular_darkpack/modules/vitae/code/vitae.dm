/datum/reagent/blood/vitae
	name = "Glowing blood"
	description = "It seems to be slightly glowing blood."
	color = "#fc0000"
	self_consuming = TRUE
	metabolization_rate = 100 * REAGENTS_METABOLISM // Vitae is supposed to instantly be consumed by the organism.

/datum/reagent/blood/vitae/expose_mob(mob/living/exposed_mob, methods, reac_volume, show_message, touch_protection)
	. = ..()

	if(!ishuman(exposed_mob)) //We do not have vitae implementations for non-human mobs.
		return
	var/mob/living/carbon/human/victim = exposed_mob
	var/datum/weakref/embracer_weakref = data["donor"]
	var/mob/living/carbon/human/embracer = embracer_weakref?.resolve()

	//if(isgarou(victim)) //Are we a garou species? DARKPACK TODO - GAROU
	//	attempt_abomination_embrace(childe)
	//	victim.rollfrenzy()
	//	return

	if(methods & INGEST)
		if(has_vitae(victim))
			//100u of vitae = 1bp, keeping consistent w/ give vitae action. 200u of normal blood = 1 bp
			victim.adjust_blood_pool(reac_volume * 0.01)

	if(ismundane(victim) || isghoul(victim))
		if(victim.stat == DEAD)
			if(!embracer)
				return
			embracer.attempt_embrace_target(victim, (usr == embracer) ? null : usr)
			return
		else if (isghoul(victim) && victim.stat != DEAD)
			victim.send_ghoul_vitae_consumption_message(embracer)
		else
			victim.ghoulificate(embracer)
			//victim.prompt_permenant_ghouling()
			return

	if(iskindred(victim)) //Are we a kindred species?
		if(embracer && embracer != victim)
			victim.blood_bond(embracer)


/datum/reagent/blood/vitae/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(isghoul(affected_mob) || iskindred(affected_mob))
		return
	return ..()

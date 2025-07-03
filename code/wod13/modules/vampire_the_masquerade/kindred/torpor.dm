/mob/living/proc/torpor(source)
	if (HAS_TRAIT(src, TRAIT_TORPOR))
		return

	fakedeath(source)

	to_chat(src, span_danger("You have fallen into Torpor. Use the button in the top right to learn more, or attempt to wake up."))
	throw_alert(ALERT_UNTORPOR, /atom/movable/screen/alert/untorpor)
	ADD_TRAIT(src, TRAIT_TORPOR, source)
	if (iskindred(src))
		var/mob/living/carbon/human/vampire = src
		var/datum/species/human/kindred/vampire_species = vampire.dna.species
		var/torpor_length = 5 MINUTES
		switch (humanity)
			if (10)
				torpor_length = 1 MINUTES
			if (9)
				torpor_length = 3 MINUTES
			if (8)
				torpor_length = 4 MINUTES
			if (7)
				torpor_length = 5 MINUTES
			if (6)
				torpor_length = 10 MINUTES
			if (5)
				torpor_length = 15 MINUTES
			if (4)
				torpor_length = 30 MINUTES
			if (3)
				torpor_length = 1 HOURS
			if (2)
				torpor_length = 2 HOURS
			if (1)
				torpor_length = 3 HOURS
		COOLDOWN_START(vampire_species, torpor_timer, torpor_length)
	// TODO: [Lucia] implement kuei-jin
	/*
	if (iscathayan(src))
		var/mob/living/carbon/human/cathayan = src
		var/datum/dharma/dharma = cathayan.mind.dharma
		var/torpor_length = 1 MINUTES * max_yin_chi
		COOLDOWN_START(dharma, torpor_timer, torpor_length)
	*/

/mob/living/proc/cure_torpor(source)
	if (!HAS_TRAIT(src, TRAIT_TORPOR))
		return

	// Heal to a tiny bit above crit, with less severe damage types being healed first
	var/amount_to_heal = HEALTH_THRESHOLD_CRIT + 5 - health
	if (amount_to_heal > 0)
		heal_ordered_damage(amount_to_heal, list(STAMINA, OXY, BRUTE, TOX, BURN))

	cure_fakedeath(source)
	clear_alert(ALERT_UNTORPOR)
	REMOVE_TRAIT(src, TRAIT_TORPOR, source)
	if (iskindred(src))
		to_chat(src, span_notice("You have awoken from your Torpor."))
	// TODO: [Lucia] implement kuei-jin
	/*
	if(iscathayan(src))
		to_chat(src, "<span class='notice'>You have awoken from your Little Death.</span>")
	*/

/mob/living/proc/untorpor()
	if (!HAS_TRAIT(src, TRAIT_TORPOR))
		return

	if (iskindred(src))
		if (bloodpool > 0)
			bloodpool -= 1
			cure_torpor()
			to_chat(src, span_notice("You have awoken from your Torpor."))
		else
			to_chat(src, span_warning("You have no blood to re-awaken with..."))
	// TODO: [Lucia] implement kuei-jin
	/*
	if (iscathayan(src))
		if (yang_chi > 0)
			yang_chi -= 1
			cure_torpor()
			to_chat(src, "<span class='notice'>You have awoken from your Little Death.</span>")
		else if (yin_chi > 0)
			yin_chi -= 1
			cure_torpor()
			to_chat(src, "<span class='notice'>You have awoken from your Little Death.</span>")
		else
			to_chat(src, "<span class='warning'>You have no Chi to re-awaken with...</span>")
	*/

/atom/movable/screen/alert/untorpor
	name = "Awaken"
	desc = "Free yourself of your Torpor."
	icon = 'icons/wod13/hud/screen_alert.dmi'
	icon_state = "awaken"

/atom/movable/screen/alert/untorpor/Click()
	. = ..()
	if (!.)
		return

	if (!isliving(owner))
		return
	var/mob/living/living_owner = owner

	if (living_owner.stat == DEAD)
		to_chat(living_owner, span_warning("You have suffered Final Death. You will not wake up."))
		return

	if (iskindred(living_owner))
		var/mob/living/carbon/human/vampire = living_owner
		var/datum/species/human/kindred/kindred_species = vampire.dna.species
		if (COOLDOWN_FINISHED(kindred_species, torpor_timer) && (vampire.bloodpool > 0))
			vampire.untorpor()
		else
			to_chat(owner, span_purple("<i>You are in Torpor, the sleep of death that vampires go into when injured, starved, or exhausted.</i>"))
			if (vampire.bloodpool > 0)
				to_chat(owner, span_purple("<i>You will be able to awaken in <b>[DisplayTimeText(COOLDOWN_TIMELEFT(kindred_species, torpor_timer))]</b>.</i>"))
				to_chat(owner, span_purple("<i>The time to re-awaken depends on your [(vampire.humanity > 5) ? "high" : "low"] [kindred_species.enlightenment ? "Enlightenment" : "Humanity"] rating of [vampire.humanity].</i>"))
			else
				to_chat(owner, span_danger("<i>You will not be able to re-awaken, because you have no blood available to do so.</i>"))
	// TODO: [Lucia] implement kuei-jin
	/*
	if(iscathayan(living_owner))
		var/mob/living/carbon/human/vampire = living_owner
		var/datum/dharma/dharma = vampire.mind.dharma
		if (COOLDOWN_FINISHED(dharma, torpor_timer) && (vampire.yang_chi > 0 || vampire.yin_chi > 0))
			vampire.untorpor()
			spawn()
				vampire.clear_alert("succumb")
		else
			to_chat(usr, "<span class='purple'><i>You are in the Little Death, the state that Kuei-Jin go into when injured or exhausted.</i></span>")
			if (vampire.yang_chi > 0 || vampire.yin_chi > 0)
				to_chat(usr, "<span class='purple'><i>You will be able to awaken in <b>[DisplayTimeText(COOLDOWN_TIMELEFT(dharma, torpor_timer))]</b>.</i></span>")
				to_chat(usr, "<span class='purple'><i>The time to re-awaken depends on your [vampire.max_yin_chi <= 4 ? "low" : "high"] permanent Yin Chi rating of [vampire.max_yin_chi].</i></span>")
			else
				to_chat(usr, "<span class='danger'><i>You will not be able to re-awaken, because you have no Chi available to do so.</i></span>")
	*/

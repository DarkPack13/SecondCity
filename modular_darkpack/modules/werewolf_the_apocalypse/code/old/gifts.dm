/datum/action/cooldown/power/gift/falling_touch
	name = "Falling Touch"
	desc = "This Gift allows the Garou to send her foe sprawling with but a touch."
	button_icon_state = "falling_touch"
	rage_req = 1

/datum/action/cooldown/power/gift/falling_touch/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/H = owner
		playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/falling_touch.ogg', 75, FALSE)
		H.put_in_active_hand(new /obj/item/melee/touch_attack/werewolf(H))

/datum/action/cooldown/power/gift/inspiration
	name = "Inspiration"
	desc = "The Garou with this Gift lends new resolve and righteous anger to his brethren."
	button_icon_state = "inspiration"
	rage_req = 1

/mob/living/carbon/Life()
	. = ..()
	if(inspired)
		if(stat != DEAD)
			adjust_brute_loss(-10, TRUE)
			var/obj/effect/celerity/C = new(get_turf(src))
			C.appearance = appearance
			C.dir = dir
			var/matrix/ntransform = matrix(C.transform)
			ntransform.Scale(2, 2)
			animate(C, transform = ntransform, alpha = 0, time = 3)

/mob/living/carbon/proc/inspired()
	inspired = TRUE
	to_chat(src, span_notice("You feel inspired..."))
	spawn(150)
		to_chat(src, span_warning("You no longer feel inspired..."))
		inspired = FALSE

/datum/action/cooldown/power/gift/inspiration/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/H = owner
		playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/inspiration.ogg', 75, FALSE)
		H.emote("scream")
		for(var/mob/living/carbon/C in range(5, owner))
			if(iswerewolf(C) || isgarou(C))
				if(C.auspice.tribe == H.auspice.tribe)
					C.inspired()

/datum/action/cooldown/power/gift/razor_claws
	name = "Razor Claws"
	desc = "By raking his claws over stone, steel, or another hard surface, the Ahroun hones them to razor sharpness."
	button_icon_state = "razor_claws"
	rage_req = 1

/datum/action/cooldown/power/gift/razor_claws/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		if(ishuman(owner))
			playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/razor_claws.ogg', 75, FALSE)
			var/mob/living/carbon/human/H = owner
			H.dna.species.attack_verb = "slash"
			H.dna.species.attack_sound = 'sound/items/weapons/slash.ogg'
			H.dna.species.miss_sound = 'sound/items/weapons/slashmiss.ogg'
			H.dna.species.punchdamagelow = 20
			H.dna.species.punchdamagehigh = 20
			H.agg_damage_plus = 5
			to_chat(owner, span_notice("You feel your claws sharpening..."))
			spawn(150)
				H.dna.species.attack_verb = initial(H.dna.species.attack_verb)
				H.dna.species.attack_sound = initial(H.dna.species.attack_sound)
				H.dna.species.miss_sound = initial(H.dna.species.miss_sound)
				H.dna.species.punchdamagelow = initial(H.dna.species.punchdamagelow)
				H.dna.species.punchdamagehigh = initial(H.dna.species.punchdamagehigh)
				H.agg_damage_plus = 0
				to_chat(owner, span_warning("Your claws are not sharp anymore..."))
		else
			playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/razor_claws.ogg', 75, FALSE)
			var/mob/living/carbon/H = owner
			H.melee_damage_lower = H.melee_damage_lower+15
			H.melee_damage_upper = H.melee_damage_upper+15
			H.agg_damage_plus = 3
			to_chat(owner, span_notice("You feel your claws sharpening..."))
			spawn(150)
				H.melee_damage_lower = initial(H.melee_damage_lower)
				H.melee_damage_upper = initial(H.melee_damage_upper)
				H.agg_damage_plus = 0
				to_chat(owner, span_warning("Your claws are not sharp anymore..."))

/datum/action/cooldown/power/gift/resist_pain
	name = "Resist Pain"
	desc = "Through force of will, the Philodox is able to ignore the pain of his wounds and continue acting normally."
	button_icon_state = "resist_pain"
	rage_req = 2

/datum/action/cooldown/power/gift/resist_pain/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		if(ishuman(owner))
			playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/resist_pain.ogg', 75, FALSE)
			var/mob/living/carbon/human/H = owner
			H.physiology.armor.melee = 40
			H.physiology.armor.bullet = 25
			to_chat(owner, span_notice("You feel your skin thickering..."))
			spawn(15 SECONDS)
				H.physiology.armor.melee = initial(H.physiology.armor.melee)
				H.physiology.armor.bullet = initial(H.physiology.armor.bullet)
				to_chat(owner, span_warning("Your skin is thin again..."))
		else
			playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/resist_pain.ogg', 75, FALSE)
			var/mob/living/carbon/werewolf/H = owner
			H.werewolf_armor = 40
			to_chat(owner, span_notice("You feel your skin thickering..."))
			spawn(15 SECONDS)
				H.werewolf_armor = initial(H.werewolf_armor)
				to_chat(owner, span_warning("Your skin is thin again..."))

/datum/action/cooldown/power/gift/scent_of_the_true_form
	name = "Scent Of The True Form"
	desc = "This Gift allows the Garou to determine the true nature of a person."
	button_icon_state = "scent_of_the_true_form"
	rage_req = 1
	//gnosis_req = 1

/datum/action/cooldown/power/gift/scent_of_the_true_form/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
		abductor_hud.add_hud_to(owner)
		spawn(200)
			abductor_hud.remove_hud_from(owner)

/datum/action/cooldown/power/gift/truth_of_gaia
	name = "Truth Of Gaia"
	desc = "As judges of the Litany, Philodox have the ability to sense whether others have spoken truth or falsehood."
	button_icon_state = "truth_of_gaia"
//	rage_req = 1

/datum/action/cooldown/power/gift/sense_wyrm
	name = "Sense Wyrm"
	desc = "This Gift allows the werewolf to sense the presence of Wyrm."
	button_icon_state = "sense_wyrm"
	rage_req = 1

/datum/action/cooldown/power/gift/sense_wyrm/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		C.sight = SEE_MOBS|SEE_OBJS
		playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/sense_wyrm.ogg', 75, FALSE)
		to_chat(owner, span_notice("You feel your sense sharpening..."))
		spawn(200)
			C.sight = initial(C.sight)
			to_chat(owner, span_warning("You no longer sense anything more than normal..."))

/datum/action/cooldown/power/gift/spirit_speech
	name = "Spirit Speech"
	desc = "This Gift allows the Garou to communicate with encountered spirits."
	button_icon_state = "spirit_speech"
	//gnosis_req = 1

/datum/action/cooldown/power/gift/spirit_speech/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		C.see_invisible = SEE_INVISIBLE_OBSERVER
		spawn(200)
			C.see_invisible = initial(C.see_invisible)

/datum/action/cooldown/power/gift/rage_heal
	name = "Rage Heal"
	desc = "This Gift allows the Garou to heal severe injuries with rage."
	button_icon_state = "rage_heal"
	rage_req = 1
	check_flags = null

/datum/action/cooldown/power/gift/rage_heal/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		if(C.stat != DEAD)
			SEND_SOUND(owner, sound('modular_darkpack/modules/werewolf_the_apocalypse/sounds/rage_heal.ogg', volume = 50))
			C.adjust_brute_loss(-40*C.auspice.level, TRUE)
			C.adjust_fire_loss(-30*C.auspice.level, TRUE)
			C.adjust_agg_loss(-10*C.auspice.level, TRUE)
			C.adjustToxLoss(-10*C.auspice.level, TRUE)
			C.adjust_oxy_loss(-20*C.auspice.level, TRUE)
			C.adjust_blood_pool(C.auspice.level)
			C.blood_volume = min(C.blood_volume + 56 * C.auspice.level, BLOOD_VOLUME_NORMAL)
			if(ishuman(owner))
				var/mob/living/carbon/human/BD = owner
				if(length(BD.all_wounds))
					var/datum/wound/W = pick(BD.all_wounds)
					W.remove_wound()
				if(length(BD.all_wounds))
					var/datum/wound/W = pick(BD.all_wounds)
					W.remove_wound()
				if(length(BD.all_wounds))
					var/datum/wound/W = pick(BD.all_wounds)
					W.remove_wound()
				if(length(BD.all_wounds))
					var/datum/wound/W = pick(BD.all_wounds)
					W.remove_wound()
				if(length(BD.all_wounds))
					var/datum/wound/W = pick(BD.all_wounds)
					W.remove_wound()

/datum/action/change_apparel
	name = "Change Apparel"
	desc = "Choose the clothes of your Crinos form."
	button_icon_state = "choose_apparel"
	icon_icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/werewolf_abilities.dmi'
	check_flags = AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS

/datum/action/change_apparel/Activate(atom/target)
	. = ..()
	var/mob/living/carbon/werewolf/crinos/C = owner
	if(C.stat == CONSCIOUS)
		if(C.sprite_apparel == 4)
			C.sprite_apparel = 0
		else
			C.sprite_apparel = min(4, C.sprite_apparel+1)

/datum/action/cooldown/power/gift/hispo
	name = "Hispo Form"
	desc = "Change your Lupus form into Hispo and backwards."
	button_icon_state = "hispo"

/datum/action/cooldown/power/gift/hispo/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/werewolf/lupus/H = owner
		playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/transform.ogg', 50, FALSE)
		if(H.hispo)
			H.icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/werewolf_lupus.dmi'
			H.pixel_w = 0
			H.pixel_z = 0
			H.melee_damage_lower = initial(H.melee_damage_lower)
			H.melee_damage_upper = initial(H.melee_damage_upper)
			H.hispo = FALSE
			H.update_icons()
			H.remove_movespeed_modifier(/datum/movespeed_modifier/crinosform)
			H.add_movespeed_modifier(/datum/movespeed_modifier/lupusform)
		else
			H.icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/hispo.dmi'
			H.pixel_w = -16
			H.pixel_z = -16
			H.melee_damage_lower = 35
			H.melee_damage_upper = 55
			H.hispo = TRUE
			H.update_icons()
			H.remove_movespeed_modifier(/datum/movespeed_modifier/lupusform)
			H.add_movespeed_modifier(/datum/movespeed_modifier/crinosform)

/datum/action/cooldown/power/gift/glabro
	name = "Glabro Form"
	desc = "Change your Homid form into Glabro and backwards."
	button_icon_state = "glabro"

/datum/action/cooldown/power/gift/glabro/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/human/H = owner
		var/datum/species/garou/G = H.dna.species
		playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/transform.ogg', 50, FALSE)
		if(G.glabro)
			H.remove_overlay(PROTEAN_LAYER)
			G.punchdamagelow -= 15
			G.punchdamagehigh -= 15
			H.st_remove_stat_mod(STAT_STRENGTH, "glabro_form")
			H.physiology.armor.melee -= 15
			H.physiology.armor.bullet -= 15
			var/matrix/M = matrix()
			M.Scale(1)
			animate(H, transform = M, time = 1 SECONDS)
			G.glabro = FALSE
			H.update_icons()
		else
			H.remove_overlay(PROTEAN_LAYER)
			var/mutable_appearance/glabro_overlay = mutable_appearance('modular_darkpack/modules/werewolf_the_apocalypse/icons/garou_forms/werewolf_abilities.dmi', H.transformator.crinos_form?.sprite_color, -PROTEAN_LAYER)
			H.overlays_standing[PROTEAN_LAYER] = glabro_overlay
			H.apply_overlay(PROTEAN_LAYER)
			G.punchdamagelow += 15
			G.punchdamagehigh += 15
			H.st_add_stat_mod(STAT_STRENGTH, 3, "glabro_form")
			H.physiology.armor.melee += 15
			H.physiology.armor.bullet += 15
			var/matrix/M = matrix()
			M.Scale(1.23)
			animate(H, transform = M, time = 1 SECONDS)
			G.glabro = TRUE
			H.update_icons()

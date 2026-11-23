/mob/living/carbon/human/npc/proc/get_socialrole_type()
	return socialrole_type

/datum/socialrole
	//For randomizing
	var/list/s_tones
	var/min_age = 18
	var/max_age = 85
	var/preferred_gender
	var/list/male_names = list(
		"Jack",
		"Robert",
		"Cornelius",
		"Tyler"
	)
	var/list/female_names = list(
		"Marla"
	)
	var/list/surnames = list(
		"Durden",
		"Polson",
		"Singer"
	)

	//Hair shit
	var/list/hair_colors = list(
		"#040404", //Black
		"#120b05", //Dark Brown
		"#342414", //Brown
		"#554433", //Light Brown
		"#695c3b", //Dark Blond
		"#ad924e", //Blond
		"#dac07f", //Light Blond
		"#802400", //Ginger
		"#a5380e", //Ginger alt
		"#ffeace", //Albino
		"#650b0b", //Punk Red
		"#14350e", //Punk Green
		"#080918", //Punk Blue
	)
	var/list/male_hair
	var/list/male_facial
	var/list/female_hair

	// TODO: refactor this into a premade outfit
	var/list/backpacks = list(
		/obj/item/storage/backpack/satchel,
		/obj/item/storage/backpack/satchel/leather
	)
	var/list/shoes = list()
	var/list/uniforms = list()
	var/list/belts = list()
	var/list/suits = list()
	var/list/hats = list()
	var/list/gloves = list()
	var/list/masks = list()
	var/list/neck = list()
	var/list/ears = list()
	var/list/glasses = list()
	var/list/inhand_items = list()
	var/list/pockets = list()

	//For workers and police
	var/obj/item/card/id/id_type

	//What will npc use in fight, if so
	var/list/primary_weapons
	var/list/secondary_weapons

	//For reaction
	var/list/male_phrases = list(
		"My wife is waiting for me at home...",
		"Sorry, pal, not today.",
		"Go find yourself someone at the bar, I'm busy.",
	)
	var/list/female_phrases = list(
		"Buy yourself a watch.",
		"I'm going to scream if you keep it up!",
		"Don't touch me.",
	)
	var/list/neutral_phrases = list(
		"Fuck off.",
		"Go on your way.",
		"Not the best time to talk right now, pal.",
		"Mgmmph...",
		"Do I know you?",
		"I don't have much time.",
	)
	var/list/random_phrases = list(
		"You a foreigner?...",
		"It seems I've been going around here in circles for the third time, already.",
		"Watch where you're walkin'!",
		"Go back to the drains where you came from.",
		"Tourists... Pheh.",
		"Rumors travel fast.",
	)
	var/list/answer_phrases = list(
		"I agree.",
		"Yes-yes...",
		"Exactly.",
		"Maybe.",
		"Exactly.",
		"Affirmative..",
	)
	var/list/help_phrases = list(
		"Help!",
		"Help Me!!",
		"What the hell's going on here!?",
		"Shoot!!",
	)
	var/list/car_dodged = list(
		"WOAH!",
		"Watch where you're going!",
		"Holy shit!",
		"Watch it!",
		"Learn to drive!",
		"You almost ran me over!",
		"What the fuck!?",
	)

	// var/is_criminal = FALSE

/datum/socialrole/proc/get_annoyed_phrase(mob/living/speaker)
	if(prob(50))
		if(speaker.gender == MALE && length(male_phrases))
			return pick(male_phrases)
		else if(speaker.gender == FEMALE && length(female_phrases))
			return pick(female_phrases)
	return pick(neutral_phrases)


/mob/living/carbon/human/npc/proc/assign_socialrole(datum/socialrole/social_role_type, dont_random)
	socialrole = GLOB.npc_social_roles[social_role_type]

	fully_replace_character_name(name, real_name)


	// maxHealth = round(initial(maxHealth)+(initial(maxHealth)/3)*(st_get_stat(STAT_STAMINA)))
	// health = round(initial(health)+(initial(health)/3)*(st_get_stat(STAT_STAMINA)))
	// last_health = health

	// is_criminal = socialrole.is_criminal

	if(!dont_random)
		if(socialrole.preferred_gender)
			gender = socialrole.preferred_gender
		else
			gender = pick(MALE, FEMALE) // Dont we already do this..?
		physique = gender // Dont we already do this..?
		var/list/m_names = list()
		var/list/f_names = list()
		var/list/s_names = list()
		var/random_name
		if(socialrole.male_names)
			m_names = socialrole.male_names
		else
			m_names = GLOB.first_names_male
		if(socialrole.female_names)
			f_names = socialrole.female_names
		else
			f_names = GLOB.first_names_female
		if(socialrole.surnames)
			s_names = socialrole.surnames
		else
			s_names = GLOB.last_names
		age = rand(socialrole.min_age, socialrole.max_age)
		if(length(socialrole.s_tones))
			skin_tone = pick(socialrole.s_tones)

		if (age >= 55)
			set_haircolor("#a2a2a2")
			set_facial_haircolor(hair_color)
		else
			set_haircolor(pick(socialrole.hair_colors))
			set_facial_haircolor(hair_color)
		if (gender == MALE)
			set_hairstyle(pick(socialrole.male_hair))
			if (prob(25) || age >= 25)
				set_facial_hairstyle(pick(socialrole.male_facial))
			else
				set_facial_hairstyle("Shaved")
			random_name = "[pick(m_names)] [pick(s_names)]"
			fully_replace_character_name(newname = random_name)
		else
			set_hairstyle(pick(socialrole.female_hair))
			set_facial_hairstyle("Shaved")
			random_name = "[pick(f_names)] [pick(s_names)]"
			fully_replace_character_name(newname = random_name)

		set_eye_color(random_eye_color())
		update_visible_name()
		underwear = random_underwear(gender)
		if (prob(50))
			underwear_color = eye_color_left
		if (prob(50) || gender == FEMALE)
			undershirt = random_undershirt(gender)
		if (prob(25))
			socks = random_socks()

		update_body()

	// this should be refactored into just... applying a premade outfit
	var/datum/outfit/O = new()
	if(length(socialrole.backpacks))
		O.back = pick(socialrole.backpacks)
	if(length(socialrole.uniforms))
		O.uniform = pick(socialrole.uniforms)
	if(length(socialrole.belts))
		O.belt = pick(socialrole.belts)
	if(length(socialrole.suits))
		O.suit = pick(socialrole.suits)
	if(length(socialrole.gloves))
		O.gloves = pick(socialrole.gloves)
	if(length(socialrole.shoes))
		O.shoes = pick(socialrole.shoes)
	if(length(socialrole.hats))
		O.head = pick(socialrole.hats)
	if(length(socialrole.masks))
		O.mask = pick(socialrole.masks)
	if(length(socialrole.neck))
		O.neck = pick(socialrole.neck)
	if(length(socialrole.ears))
		O.ears = pick(socialrole.ears)
	if(length(socialrole.glasses))
		O.glasses = pick(socialrole.glasses)
	if(length(socialrole.inhand_items))
		O.r_hand = pick(socialrole.inhand_items)

	if (check_holidays(FESTIVE_SEASON))
		if (!length(O.suit))
			O.suit = list(
				/obj/item/clothing/suit/vampire/coat/winter,
				/obj/item/clothing/suit/vampire/coat/winter/alt
			)
		if (!length(O.neck) && prob(50))
			O.neck = list(
				/obj/item/clothing/neck/vampire/scarf/red,
				/obj/item/clothing/neck/vampire/scarf,
				/obj/item/clothing/neck/vampire/scarf/blue,
				/obj/item/clothing/neck/vampire/scarf/green,
				/obj/item/clothing/neck/vampire/scarf/white
			)

	if(socialrole.id_type)
		O.id = socialrole.id_type
	if(O.uniform && length(socialrole.pockets))
		O.l_pocket = pick(socialrole.pockets)
		if(length(socialrole.pockets) > 1 && prob(50))
			var/list/another_pocket = socialrole.pockets.Copy()
			another_pocket -= O.l_pocket
			O.r_pocket = pick(another_pocket)
	equipOutfit(O)
	qdel(O)

	bind_weapon(pick_weight(socialrole.primary_weapons))
	bind_weapon(pick_weight(socialrole.secondary_weapons))

	dna.update_dna_identity()


/mob/living/carbon/human/npc/proc/bind_weapon(obj/item/weapon_type,	extra_loaded_rounds = 6, extra_mags = 2)
	if(!ispath(weapon_type))
		return
	var/obj/item/my_weapon = new weapon_type(src)

	if(!src.put_in_hands(my_weapon))
		my_weapon.equip_to_best_slot(src)

	ai_controller.add_blackboard_key_lazylist(BB_HUMAN_OWNED_WEAPONS, my_weapon)

	var/obj/item/gun/ballistic/firearm = astype(my_weapon)
	if(firearm)
		if(istype(firearm.magazine, /obj/item/ammo_box/magazine/internal))
			var/obj/item/ammo_box/magazine/internal_mag = firearm.magazine
			for(var/i in 1 to extra_loaded_rounds)
				var/obj/item/boolet = new internal_mag.ammo_type(src)
				equip_to_appropriate_slot(boolet)
		else
			for(var/i in 1 to extra_mags)
				var/obj/item/maggy = new firearm.spawn_magazine_type(src)
				equip_to_appropriate_slot(maggy)

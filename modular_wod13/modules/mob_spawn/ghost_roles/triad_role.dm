/obj/effect/mob_spawn/human/triad_soldier
	name = "a triad soldier"
	desc = "A humming sleeper with a silhouetted occupant inside. Its stasis function is broken and it's likely being used as a bed."
	mob_name = "a triad soldier"
	icon = 'icons/obj/lavaland/spawners.dmi'
	icon_state = "cryostasis_sleeper"
	outfit = /datum/outfit/job/triad_soldier
	roundstart = FALSE
	death = FALSE
	random = FALSE
	mob_species = /datum/species/human
	short_desc = "You were sleeping. But you can't anymore."
	flavour_text = "You woke up because of the stupid washing machines. Probably better that you go and check what the gang's up to..."
	assignedrole = "Triad Soldier"

/obj/effect/mob_spawn/human/triad_soldier/special(mob/living/new_spawn)
	var/my_name = "Tyler"
	if(new_spawn.gender == MALE)
		my_name = pick(GLOB.first_names_male_triad)
	else
		my_name = pick(GLOB.first_names_female_triad)
	var/my_surname = pick(GLOB.last_names_triad)
	new_spawn.fully_replace_character_name(null,"[my_name] [my_surname]")

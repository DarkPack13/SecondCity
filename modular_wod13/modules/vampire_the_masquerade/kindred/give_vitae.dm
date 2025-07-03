/datum/action/give_vitae
	name = "Give Vitae"
	desc = "Give your vitae to someone, make the Blood Bond."
	button_icon_state = "vitae"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/giving = FALSE

/datum/action/give_vitae/Trigger(trigger_flags)
	if(istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = owner
		if(H.bloodpool < 2)
			to_chat(owner, "<span class='warning'>You don't have enough <b>BLOOD</b> to do that!</span>")
			return
		if(istype(H.pulling, /mob/living/simple_animal))
			var/mob/living/L = H.pulling
			L.bloodpool = min(L.maxbloodpool, L.bloodpool+2)
			H.bloodpool = max(0, H.bloodpool-2)
			L.adjustBruteLoss(-25)
			L.adjustFireLoss(-25)
		if(istype(H.pulling, /mob/living/carbon/human))
			var/mob/living/carbon/human/BLOODBONDED = H.pulling
			if(iscathayan(BLOODBONDED))
				to_chat(owner, "<span class='warning'>[BLOODBONDED] vomits the vitae back!</span>")
				return
			if(!BLOODBONDED.client && !istype(H.pulling, /mob/living/carbon/human/npc))
				to_chat(owner, "<span class='warning'>You need [BLOODBONDED]'s attention to do that!</span>")
				return
			if(BLOODBONDED.stat == DEAD)
				if(!BLOODBONDED.key)
					to_chat(owner, "<span class='warning'>You need [BLOODBONDED]'s mind to Embrace!</span>")
					return
				message_admins("[ADMIN_LOOKUPFLW(H)] is Embracing [ADMIN_LOOKUPFLW(BLOODBONDED)]!")
			if(giving)
				return
			giving = TRUE
			owner.visible_message("<span class='warning'>[owner] tries to feed [BLOODBONDED] with their own blood!</span>", "<span class='notice'>You started to feed [BLOODBONDED] with your own blood.</span>")
			if(do_mob(owner, BLOODBONDED, 10 SECONDS))
				H.bloodpool = max(0, H.bloodpool-2)
				giving = FALSE

				var/new_master = FALSE
				BLOODBONDED.drunked_of |= "[H.dna.real_name]"

				if(BLOODBONDED.stat == DEAD && !iskindred(BLOODBONDED))
					if (!BLOODBONDED.can_be_embraced)
						to_chat(H, "<span class='notice'>[BLOODBONDED.name] doesn't respond to your Vitae.</span>")
						return

					if((BLOODBONDED.timeofdeath + 5 MINUTES) > world.time)
						if (BLOODBONDED.auspice?.level) //here be Abominations
							if (BLOODBONDED.auspice.force_abomination)
								to_chat(H, "<span class='danger'>Something terrible is happening.</span>")
								to_chat(BLOODBONDED, "<span class='userdanger'>Gaia has forsaken you.</span>")
								message_admins("[ADMIN_LOOKUPFLW(H)] has turned [ADMIN_LOOKUPFLW(BLOODBONDED)] into an Abomination through an admin setting the force_abomination var.")
								log_game("[key_name(H)] has turned [key_name(BLOODBONDED)] into an Abomination through an admin setting the force_abomination var.")
							else
								switch(storyteller_roll(BLOODBONDED.auspice.level))
									if (ROLL_BOTCH)
										to_chat(H, "<span class='danger'>Something terrible is happening.</span>")
										to_chat(BLOODBONDED, "<span class='userdanger'>Gaia has forsaken you.</span>")
										message_admins("[ADMIN_LOOKUPFLW(H)] has turned [ADMIN_LOOKUPFLW(BLOODBONDED)] into an Abomination.")
										log_game("[key_name(H)] has turned [key_name(BLOODBONDED)] into an Abomination.")
									if (ROLL_FAILURE)
										BLOODBONDED.visible_message("<span class='warning'>[BLOODBONDED.name] convulses in sheer agony!</span>")
										BLOODBONDED.Shake(15, 15, 5 SECONDS)
										playsound(BLOODBONDED.loc, 'sound/wod13/vicissitude.ogg', 100, TRUE)
										BLOODBONDED.can_be_embraced = FALSE
										return
									if (ROLL_SUCCESS)
										to_chat(H, "<span class='notice'>[BLOODBONDED.name] does not respond to your Vitae...</span>")
										BLOODBONDED.can_be_embraced = FALSE
										return

						log_game("[key_name(H)] has Embraced [key_name(BLOODBONDED)].")
						message_admins("[ADMIN_LOOKUPFLW(H)] has Embraced [ADMIN_LOOKUPFLW(BLOODBONDED)].")
						giving = FALSE
						var/save_data_v = FALSE
						if(BLOODBONDED.revive(full_heal = TRUE, admin_revive = TRUE))
							BLOODBONDED.grab_ghost(force = TRUE)
							to_chat(BLOODBONDED, "<span class='userdanger'>You rise with a start, you're alive! Or not... You feel your soul going somewhere, as you realize you are embraced by a vampire...</span>")
							var/response_v = input(BLOODBONDED, "Do you wish to keep being a vampire on your save slot?(Yes will be a permanent choice and you can't go back!)") in list("Yes", "No")
							if(response_v == "Yes")
								save_data_v = TRUE
							else
								save_data_v = FALSE
						BLOODBONDED.set_species(/datum/species/human/kindred)
						BLOODBONDED.set_clan(null)
						if(H.generation < 13)
							BLOODBONDED.generation = 13
							BLOODBONDED.skin_tone = get_vamp_skin_color(BLOODBONDED.skin_tone)
							BLOODBONDED.update_body()
							if (H.clan.whitelisted)
								if (!SSwhitelists.is_whitelisted(BLOODBONDED.ckey, H.clan.name))
									if(H.clan.name == "True Brujah")
										BLOODBONDED.set_clan(/datum/vampire_clan/brujah)
										to_chat(BLOODBONDED,"<span class='warning'> You don't got that whitelist! Changing to the non WL Brujah</span>")
									else if(H.clan.name == "Tzimisce")
										BLOODBONDED.set_clan(/datum/vampire_clan/old_clan_tzimisce)
										to_chat(BLOODBONDED,"<span class='warning'> You don't got that whitelist! Changing to the non WL Old Tzmisce</span>")
									else
										to_chat(BLOODBONDED,"<span class='warning'> You don't got that whitelist! Changing to a random non WL clan.</span>")
										var/list/non_whitelisted_clans = list(/datum/vampire_clan/brujah, /datum/vampire_clan/malkavian, /datum/vampire_clan/nosferatu, /datum/vampire_clan/gangrel, /datum/vampire_clan/giovanni, /datum/vampire_clan/ministry, /datum/vampire_clan/salubri, /datum/vampire_clan/toreador, /datum/vampire_clan/tremere, /datum/vampire_clan/ventrue)
										var/random_clan = pick(non_whitelisted_clans)
										BLOODBONDED.set_clan(random_clan)
								else
									BLOODBONDED.set_clan(H.clan)
							else
								BLOODBONDED.set_clan(H.clan)

							if(BLOODBONDED.clan.alt_sprite)
								BLOODBONDED.skin_tone = "albino"
								BLOODBONDED.update_body()

							//Gives the Childe the Sire's first three Disciplines

							var/list/disciplines_to_give = list()
							for (var/i in 1 to min(3, H.client.prefs.discipline_types.len))
								disciplines_to_give += H.client.prefs.discipline_types[i]
							BLOODBONDED.create_disciplines(FALSE, disciplines_to_give)

							BLOODBONDED.maxbloodpool = 10+((13-min(13, BLOODBONDED.generation))*3)
						else
							BLOODBONDED.maxbloodpool = 10+((13-min(13, BLOODBONDED.generation))*3)
							BLOODBONDED.generation = 14
							BLOODBONDED.set_clan(/datum/vampire_clan/caitiff)

						//Verify if they accepted to save being a vampire
						if (iskindred(BLOODBONDED) && save_data_v)
							var/datum/preferences/BLOODBONDED_prefs_v = BLOODBONDED.client.prefs

							BLOODBONDED_prefs_v.pref_species.id = "kindred"
							BLOODBONDED_prefs_v.pref_species.name = "Vampire"
							if(H.generation < 13)

								BLOODBONDED_prefs_v.clan = BLOODBONDED.clan
								BLOODBONDED_prefs_v.generation = 13
								BLOODBONDED_prefs_v.skin_tone = get_vamp_skin_color(BLOODBONDED.skin_tone)
								BLOODBONDED_prefs_v.enlightenment = H.clan.enlightenment


								//Rarely the new mid round vampires get the 3 brujah skil(it is default)
								//This will remove if it happens
								// Or if they are a ghoul with abunch of disciplines
								if(BLOODBONDED_prefs_v.discipline_types.len > 0)
									for (var/i in 1 to BLOODBONDED_prefs_v.discipline_types.len)
										var/removing_discipline = BLOODBONDED_prefs_v.discipline_types[1]
										if (removing_discipline)
											var/index = BLOODBONDED_prefs_v.discipline_types.Find(removing_discipline)
											BLOODBONDED_prefs_v.discipline_types.Cut(index, index + 1)
											BLOODBONDED_prefs_v.discipline_levels.Cut(index, index + 1)

								if(BLOODBONDED_prefs_v.discipline_types.len == 0)
									for (var/i in 1 to 3)
										BLOODBONDED_prefs_v.discipline_types += BLOODBONDED_prefs_v.clan.clan_disciplines[i]
										BLOODBONDED_prefs_v.discipline_levels += 1
								BLOODBONDED_prefs_v.save_character()

							else
								BLOODBONDED_prefs_v.generation = 13 // Game always set to 13 anyways, 14 is not possible.
								BLOODBONDED_prefs_v.clan = get_vampire_clan(VAMPIRE_CLAN_CAITIFF)
								BLOODBONDED_prefs_v.save_character()

					else

						to_chat(owner, "<span class='notice'>[BLOODBONDED] is totally <b>DEAD</b>!</span>")
						giving = FALSE
						return
				else
					if(BLOODBONDED.has_status_effect(STATUS_EFFECT_INLOVE))
						BLOODBONDED.remove_status_effect(STATUS_EFFECT_INLOVE)
					BLOODBONDED.apply_status_effect(STATUS_EFFECT_INLOVE, owner)
					to_chat(owner, "<span class='notice'>You successfuly fed [BLOODBONDED] with vitae.</span>")
					to_chat(BLOODBONDED, "<span class='userlove'>You feel good when you drink this <b>BLOOD</b>...</span>")

					message_admins("[ADMIN_LOOKUPFLW(H)] has bloodbonded [ADMIN_LOOKUPFLW(BLOODBONDED)].")
					log_game("[key_name(H)] has bloodbonded [key_name(BLOODBONDED)].")

					if(H.reagents)
						if(length(H.reagents.reagent_list))
							H.reagents.trans_to(BLOODBONDED, min(10, H.reagents.total_volume), transfered_by = H, methods = VAMPIRE)
					BLOODBONDED.adjustBruteLoss(-25, TRUE)
					if(length(BLOODBONDED.all_wounds))
						var/datum/wound/W = pick(BLOODBONDED.all_wounds)
						W.remove_wound()
					BLOODBONDED.adjustFireLoss(-25, TRUE)
					BLOODBONDED.bloodpool = min(BLOODBONDED.maxbloodpool, BLOODBONDED.bloodpool+2)
					giving = FALSE

					if (iskindred(BLOODBONDED))
						var/datum/species/human/kindred/species = BLOODBONDED.dna.species
						if (HAS_TRAIT(BLOODBONDED, TRAIT_TORPOR) && COOLDOWN_FINISHED(species, torpor_timer))
							BLOODBONDED.untorpor()

					if(!isghoul(H.pulling) && istype(H.pulling, /mob/living/carbon/human/npc))
						var/mob/living/carbon/human/npc/NPC = H.pulling
						if(NPC.ghoulificate(owner))
							new_master = TRUE
					if(BLOODBONDED.mind)
						if(BLOODBONDED.mind.enslaved_to != owner)
							BLOODBONDED.mind.enslave_mind_to_creator(owner)
							to_chat(BLOODBONDED, "<span class='userdanger'><b>AS PRECIOUS VITAE ENTER YOUR MOUTH, YOU NOW ARE IN THE BLOODBOND OF [H]. SERVE YOUR REGNANT CORRECTLY, OR YOUR ACTIONS WILL NOT BE TOLERATED.</b></span>")
							new_master = TRUE
					if(isghoul(BLOODBONDED))
						var/datum/species/ghoul/G = BLOODBONDED.dna.species
						G.master = owner
						G.last_vitae = world.time
						if(new_master)
							G.changed_master = TRUE
					else if(!iskindred(BLOODBONDED) && !isnpc(BLOODBONDED))
						var/save_data_g = FALSE
						BLOODBONDED.set_species(/datum/species/ghoul)
						BLOODBONDED.set_clan(null)
						var/response_g = input(BLOODBONDED, "Do you wish to keep being a ghoul on your save slot?(Yes will be a permanent choice and you can't go back)") in list("Yes", "No")
						var/datum/species/ghoul/G = BLOODBONDED.dna.species
						G.master = owner
						G.last_vitae = world.time
						if(new_master)
							G.changed_master = TRUE
						if(response_g == "Yes")
							save_data_g = TRUE
						else
							save_data_g = FALSE
						if(save_data_g)
							var/datum/preferences/BLOODBONDED_prefs_g = BLOODBONDED.client.prefs
							if(BLOODBONDED_prefs_g.discipline_types.len == 3)
								for (var/i in 1 to 3)
									var/removing_discipline = BLOODBONDED_prefs_g.discipline_types[1]
									if (removing_discipline)
										var/index = BLOODBONDED_prefs_g.discipline_types.Find(removing_discipline)
										BLOODBONDED_prefs_g.discipline_types.Cut(index, index + 1)
										BLOODBONDED_prefs_g.discipline_levels.Cut(index, index + 1)
							BLOODBONDED_prefs_g.pref_species.name = "Ghoul"
							BLOODBONDED_prefs_g.pref_species.id = "ghoul"
							BLOODBONDED_prefs_g.save_character()
			else
				giving = FALSE

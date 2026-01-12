//this code is what should be called every time blood drinking is used on a character
/mob/living/carbon/human/proc/vamp_bite()
	update_blood_hud()
	if(!COOLDOWN_FINISHED(src, drinkblood_use_cd) || !COOLDOWN_FINISHED(src, drinkblood_click_cd))
		return
	COOLDOWN_START(src, drinkblood_click_cd, 1 SECONDS)
	if(grab_state > GRAB_PASSIVE)
		if(ishuman(pulling))
			var/mob/living/carbon/human/PB = pulling
			if(isghoul(src))
				if(!iskindred(PB))
					SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(src, span_warning("You're not desperate enough to try <i>that</i>."))
					return
			if(!isghoul(src) && !iskindred(src))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("You're not desperate enough to try <i>that</i>."))
				return
			if(PB.stat == DEAD && !HAS_TRAIT(src, TRAIT_GULLET))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("Your Beast requires life, not the tepid swill of corpses."))
				return
			if(PB.blood_volume <= 50 && (!iskindred(pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("This vessel is empty. You'll have to find another."))
				return
			if(PB.bloodpool <= 0 && (!iskindred(pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("This vessel is empty. You'll have to find another."))
				return
			if(iskindred(src))
				PB.emote("groan")
			if(isghoul(src))
				PB.emote("scream")
			PB.add_bite_animation()
		if(isliving(pulling))
			if(!iskindred(src))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("You're not desperate enough to try <i>that</i>."))
				return
			var/mob/living/LV = pulling
			if(LV.blood_volume <= 50 && (!iskindred(pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("This vessel is empty. You'll have to find another."))
			if(LV.bloodpool <= 0 && (!iskindred(pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, span_warning("This vessel is empty. You'll have to find another."))
				return
			if(LV.stat == DEAD && !HAS_TRAIT(src, TRAIT_GULLET))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src,span_warning("Your Beast requires life, not the tepid swill of corpses."))
				return
			var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
			if(!skipface)
				if(iskindred(src) && HAS_TRAIT(src, TRAIT_NEEDS_BLOOD))
					var/datum/splat/vampire/kindred/kindred_species = iskindred(src)
					var/stat_to_roll = kindred_species.enlightenment ? STAT_INSTINCT : STAT_SELF_CONTROL
					var/frenzy_check = SSroll.storyteller_roll(st_get_stat(stat_to_roll), 6, src)
					if(frenzy_check != ROLL_SUCCESS)
						to_chat(src, span_userdanger("The taste of blood sends you into a frenzy as you feed!"))
						// DARKPACK TODO: frenzy, please put the call here
					else
						to_chat(src, span_green("The taste of fresh blood while hungry almost drives you into frenzy!"))

				if(!HAS_TRAIT(src, TRAIT_BLOODY_LOVER))
					playsound(src, 'modular_darkpack/modules/blood_drinking/sounds/drinkblood1.ogg', 50, TRUE)
					LV.visible_message(span_warning(span_bold("[src] bites [LV]'s neck!")), span_warning(span_bold("[src] bites your neck!")))
				if(!HAS_TRAIT(src, TRAIT_BLOODY_LOVER))
					SEND_SIGNAL(src, COMSIG_MASQUERADE_VIOLATION)
				else
					playsound(src, 'modular_darkpack/modules/blood_drinking/sounds/kiss.ogg', 50, TRUE)
					LV.visible_message(span_italics(span_bold("[src] kisses [LV]!")), span_userlove(span_bold("[src] kisses you!")))
				drinksomeblood(LV, TRUE)

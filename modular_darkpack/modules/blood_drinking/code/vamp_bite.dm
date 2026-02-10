//this code is what should be called every time blood drinking is used on a character
/mob/living/carbon/human/proc/vamp_bite()
	if(!COOLDOWN_FINISHED(src, drinkblood_use_cd) || !COOLDOWN_FINISHED(src, drinkblood_click_cd))
		return
	COOLDOWN_START(src, drinkblood_click_cd, 1 SECONDS)
	if(grab_state > GRAB_PASSIVE)
		if(isliving(pulling))
			var/mob/living/bit_living = pulling
			if(!isvampiresplat(src))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', volume = 75))
				to_chat(src, span_warning("You're not desperate enough to try <i>that</i>."))
				return
			// Allow ghouls to steal viate?
			if(isghoul(src))
				if(!iskindred(bit_living))
					SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', volume = 75))
					to_chat(src, span_warning("You're not desperate enough to try <i>that</i>."))
					return
			// Prevent drinking from corspes... Not V20 accurate as far as I can tell?
			if(bit_living.stat == DEAD && !HAS_TRAIT(src, TRAIT_GULLET))
				SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', volume = 75))
				to_chat(src,span_warning("Your Beast requires life, not the tepid swill of corpses."))
				return
			// Allow for diablor?
			if(!iskindred(bit_living) || !iskindred(src))
				if(!CAN_HAVE_BLOOD(bit_living) || (bit_living.blood_volume <= 50) || (bit_living.bloodpool <= 0))
					SEND_SOUND(src, sound('modular_darkpack/modules/blood_drinking/sounds/need_blood.ogg', volume = 75))
					to_chat(src, span_warning("This vessel is empty. You'll have to find another."))
					return

			if(iskindred(src))
				bit_living.emote("groan")
			else if(isghoul(src))
				bit_living.emote("scream")

			if(ishuman(bit_living))
				var/mob/living/carbon/human/bit_human = bit_living
				bit_human.add_bite_animation()

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
					bit_living.visible_message(span_warning(span_bold("[src] bites [bit_living]'s neck!")), span_warning(span_bold("[src] bites your neck!")))
				if(!HAS_TRAIT(src, TRAIT_BLOODY_LOVER))
					SEND_SIGNAL(src, COMSIG_MASQUERADE_VIOLATION)
				else
					playsound(src, 'modular_darkpack/modules/blood_drinking/sounds/kiss.ogg', 50, TRUE)
					bit_living.visible_message(span_italics(span_bold("[src] kisses [bit_living]!")), span_userlove(span_bold("[src] kisses you!")))
				drinksomeblood(bit_living, TRUE)

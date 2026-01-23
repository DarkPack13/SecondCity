GLOBAL_LIST_INIT(sarcophagus_passwords, list(
	"AMARANTH",
	"ANTEDILUVIAN",
	"PROMETHEAN",
	"NEMESIS",
	"GEHENNA",
	"JYHAD",
	"CARTHAGOS",
	"ENOCH",
	"IRAD",
	"ZILLAH",
	"CAPPADOCIAN",
	"NODDIST",
	"USURPERS",
	"DELUGE",
	"SHADOWLANDS",
	"LILITH",
	"FORGIVENESS",
	"DARKFATHER"
))
GLOBAL_LIST_INIT(caesar_cipher, list(
	"A" = 1,
	"B" = 2,
	"C" = 3,
	"D" = 4,
	"E" = 5,
	"F" = 6,
	"G" = 7,
	"H" = 8,
	"I" = 9,
	"J" = 10,
	"K" = 11,
	"L" = 12,
	"M" = 13,
	"N" = 14,
	"O" = 15,
	"P" = 16,
	"Q" = 17,
	"R" = 18,
	"S" = 19,
	"T" = 20,
	"U" = 21,
	"V" = 22,
	"W" = 23,
	"X" = 24,
	"Y" = 25,
	"Z" = 26
))

/proc/get_encipher_num(letter, password)
	var/num = GLOB.caesar_cipher[letter]
	var/enciphed = num+password
	if(num+password > 26)
		enciphed = (num+password)-26
	return GLOB.caesar_cipher[enciphed]

/proc/get_uncipher_num(letter, password)
	var/num = GLOB.caesar_cipher[letter]
	var/unciphed = num-password
	if(num-password < 0)
		unciphed = (num-password)+26
	return GLOB.caesar_cipher[unciphed]

/proc/encipher(message, password)
	if(message)
		message = uppertext(message)
		var/final_message = ""
		for(var/i in 1 to length_char(message))
			var/letter = message[i]
			final_message += "[get_encipher_num(letter, password)]"
		return final_message

/proc/uncipher(message, password)
	if(message)
		message = uppertext(message)
		var/final_message = ""
		for(var/i in 1 to length_char(message))
			var/letter = message[i]
			final_message += "[get_uncipher_num(letter, password)]"
		return final_message



/obj/sarcophagus
	name = "unknown sarcophagus"
	desc = "A shiver runs down your spine just looking at it..."
	icon = 'modular_darkpack/modules/antediluvian_sarcophagus/icons/sarcophagus.dmi'
	icon_state = "b_sarcophagus"
	// layer = CAR_LAYER
	density = TRUE
	anchored = TRUE
	pixel_w = -8
	COOLDOWN_DECLARE(roll_cooldown)
	var/password = "Brongus"
	var/passkey = 5

/obj/sarcophagus/Initialize(mapload)
	. = ..()
	password = pick(GLOB.sarcophagus_passwords)
	if(prob(50))
		passkey = rand(5, 15)
	else
		passkey = rand(-15, -5)
	//to_chat(world, span_userdanger("<b>UNKNOWN SARCOPHAGUS POSITION HAS BEEN LEAKED</b>"))
	SEND_SOUND(world, sound('modular_darkpack/master_files/sounds/announce.ogg'))

/obj/sarcophagus/examine(mob/user)
	. = ..()
	var/message = "You see an engraved text on it: <b>[encipher(password, passkey)]</b>."
	if(isliving(user) && COOLDOWN_FINISHED(src, roll_cooldown))
		COOLDOWN_START(src, roll_cooldown, 1 SCENES)
		var/mob/living/living_user = user
		var/roll_result = SSroll.storyteller_roll(living_user.st_get_stat(STAT_INTELLIGENCE) + living_user.st_get_stat(STAT_OCCULT), 10, list(user), user)
		if(roll_result == ROLL_SUCCESS)
			message += " It's an ancient cipher. You shift letters in your head till you end up with [uppertext(password)]."
		else
			message += " You have no clue what that could possibly mean..."
	. += message

#define OPEN_SOUND 'modular_darkpack/modules/antediluvian_sarcophagus/sounds/mp_hello.ogg'
/obj/sarcophagus/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/sarcophagus_key))
		var/pass = tgui_input_text(user, "???", "???")
		if(!pass)
			return ITEM_INTERACT_BLOCKING
		if(password == uppertext(pass))
			icon_state = "b_sarcophagus-open1"
			to_chat(world, span_userdanger("<b>UNKNOWN SARCOPHAGUS HAS BEEN OPENED</b>"))
			SEND_SOUND(world, sound('modular_darkpack/master_files/sounds/announce.ogg'))
			var/sound_length = SSsounds.get_sound_length(OPEN_SOUND)
			playsound(src, OPEN_SOUND, 100, FALSE)
			spawn(sound_length)
				icon_state = "b_sarcophagus-open0"
				new /mob/living/simple_animal/hostile/megafauna/wendigo/antediluvian(loc)
		return ITEM_INTERACT_SUCCESS
#undef OPEN_SOUND

/obj/fake_sarcophagus
	name = "unknown sarcophagus"
	desc = "A shiver runs down your spine just looking at it..."
	icon = 'modular_darkpack/modules/antediluvian_sarcophagus/icons/sarcophagus.dmi'
	icon_state = "b_sarcophagus"
	density = TRUE
	anchored = TRUE
	pixel_w = -8

/obj/fake_sarcophagus/voivode
	name = "\improper Voivode-in-Waiting's Sarcophagus"
	desc = "The Voivode-in-Waiting lies here."

/obj/item/sarcophagus_key
	name = "sarcophagus key"
	desc = "Something strange and ancient..."
	icon_state = "sarcophagus_key"
	icon = 'modular_darkpack/modules/antediluvian_sarcophagus/icons/key.dmi'
	w_class = WEIGHT_CLASS_SMALL

/// Sends the target a fake adminhelp sound
/datum/smite/fake_bwoink
	name = "Fake bwoink"

/datum/smite/fake_bwoink/effect(client/user, mob/living/target)
	. = ..()
	SEND_SOUND(target, 'modular_darkpack/master_files/sounds/adminhelp.ogg') // DARKPACK EDIT CHANGE

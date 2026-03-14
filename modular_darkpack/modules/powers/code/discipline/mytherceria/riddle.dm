/datum/riddle
	name = "riddle"
	desc = "A riddle created with The Riddle Phantastique, Mytherceria 5."

	// The question to ask as a string. Seperate from name so we can modify it more freely.
	var/question = "Who made the mistake of letting this error get on to the live server?"
	// The answers indexed in the order they will appear to the victim
	var/list/answers = list(
		"Maintainers",
		"Maptainers",
		"Spritetainers",
		"Flavrius",
		"5th answer to demonstrate the maximum amount of answers allowed in a riddle, which is 5 by the way. We should probably put a character limit on this."
		)
	// A subset of var/answers that contains only answers that will break the curse
	var/list/correct_answers = list(
		"Maintainers",
		"Flavrius"
		)

	// The 'owner' of this riddle. If they say the correct answer, the curse is broken.
	var/mob/living/carbon/riddler
	// The amount of successes the riddler got when rolling. The victim must triple this number to break the curse without answering.
	var/riddler_successes = 1
	// The victim of the riddle. If they say anything other than the correct answer they take damage.
	var/mob/living/carbon/victim
	// The amount of successes the victim currently has. They must triple var/riddle_successes to break the curse without answering. Reset to 0 on botch.
	var/riddled_successes = 0

/datum/riddle/proc/delete_riddle()

/datum/riddle/proc/create_riddle(new_question, list/new_answers, list/new_correct_answers, successes)

/datum/riddle/proc/edit_riddle(new_question, list/new_answers, list/new_correct_answers)

/datum/riddle/proc/break_curse(target)

/datum/riddle/proc/punishment(target)


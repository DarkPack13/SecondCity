// VTM Ghouls and Revenants pg. 136-137
/datum/quirk/darkpack/seizures
	name = "Seizures"
	desc = {"Your character suffers from seizures, most commonly triggered by stress.
Though many types of seizures can be controlled, some people refuse or are unable to be treated for oen reason or another."}
	icon = FA_ICON_FACE_DIZZY
	value = -3 // Debate on this cost. Might be too high bc it's not as bad as tabletop?
	gain_text = span_notice("You feel dizzy.")
	lose_text = span_notice("The dizziness fades.")
	failure_message = span_notice("The dizziness fades.")

/*Seizures tend to occur during moments of duress, and
few mortals have a more stressful or terrifying existence
than ghouls. The affliction of the Seizures Flaw can also
be more pronounced in revenant families whose members
suffer from a limited genetic pool. Many types of seizures
can be controlled or mitigated with medication following
thorough medical tests or examinations. However, some
ghouls and revenants aren’t willing to risk their lives by
seeking the advice of a doctor, and these Seizures are often
not related to a diagnosed illness. This Flaw is a side effect
of the many horrors ghouls and revenants witness over
the course of their lives.

Seizures can potentially be disastrous, especially if they
occur in the presence of a vampire or at an inopportune
moment. Under any stressful circumstances related to
combat, physical or verbal threats, or witnessing a terrifying,
bloody sight the character with this Flaw will need to make
a Frenzy roll. A success means a seizure was not triggered,
and you’ve managed to regain control.

Failure indicates your body was not able to cope with
the stress and something has happened. If you roll a
critical failure, your character suffers a full-blown grand
mal seizure. You will have fallen to the ground and will
thrash uncontrollably for a number of minutes equal to
the number of 1s rolled on the Frenzy check. Your actions
may wind up getting yourself, or others, hurt as your finger
might accidentally pull the trigger, or you may slip and
fall. A less than critical failure may likely result in your
character blacking out until the next round. Depending
on the needs of your story, your ghoul may pass out and
drop to the ground, your vision might turn black for a
few seconds, or your arm might tremble and you cannot
regain control*/

/datum/quirk/darkpack/seizures/add_to_holder(mob/living/new_holder, quirk_transfer, client/client_source, unique, announce)
	var/mob/living/carbon/human/human_holder = new_holder
	human_holder.dna.add_mutation(/datum/mutation/epilepsy, MUTATION_SOURCE_ACTIVATED)

/datum/quirk/darkpack/seizures/remove(mob/living/new_holder)
	. = ..()
	var/mob/living/carbon/human/human_holder = new_holder
	human_holder.dna.remove_mutation(/datum/mutation/epilepsy, MUTATION_SOURCE_ACTIVATED)

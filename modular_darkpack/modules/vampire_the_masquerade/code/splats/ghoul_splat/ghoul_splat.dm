/datum/splat/vampire/ghoul
	name = "Ghoul"
	desc = "Mortals empowered by and addicted to the supernatural blood of \
			Kindred. While not as powerful as true Kindred, they retain their \
			humanity and suffer none of the weaknesses of the Kindred, making \
			them ideal servants to their domitors."
	id = SPLAT_GHOUL

	splat_actions = list(
		/datum/action/cooldown/blood_power,
	)

	/// The Kindred this ghoul is blood bonded to
	var/mob/living/domitor

/datum/splat/vampire/ghoul/New(mob/living/domitor)
	src.domitor = domitor

/datum/splat/vampire/ghoul/on_gain()
	owner.give_st_power(/datum/discipline/bloodheal, 1)

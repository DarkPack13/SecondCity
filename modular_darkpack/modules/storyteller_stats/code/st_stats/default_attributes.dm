/datum/st_stat/attribute/physical
	abstract_type = /datum/st_stat/attribute/physical
	subcategory = STAT_SUBCATEGORY_PHYSICAL

/datum/st_stat/attribute/physical/strength
	name = "Strength"
	description = "Affects your unarmed attack damage multiplier. Increases your chances to knock down an opponent in unarmed combat."
	subcategory = "Physical"

/datum/st_stat/attribute/physical/dexterity
	name = "Dexterity"
	description = "Affects your speed and melee weapon accuracy. Increases your defense against being knocked down in unarmed combat. Increases the speed of certain actions."
	stat_flags = AFFECTS_SPEED

/datum/st_stat/attribute/physical/stamina
	name = "Stamina"
	description = "Affects your maximum health. Used in Quietus."
	subcategory = "Physical"
	stat_flags = AFFECTS_HEALTH


/datum/st_stat/attribute/social
	abstract_type = /datum/st_stat/attribute/social
	subcategory = STAT_SUBCATEGORY_SOCIAL

/datum/st_stat/attribute/social/charisma
	name = "Charisma"
	description = "A character's ability to entice and please others through their personality. Used in Dementation, Dominate and Presence."

/datum/st_stat/attribute/social/manipulation
	name = "Manipulation"
	description = "A character's ability for self-expression in the interests of getting others to share their outlook or follow their whims. Used in social and mental disciplines."

/datum/st_stat/attribute/social/appearance
	name = "Appearance"
	description = "A measure of how well a character makes a first impression. Used in social disciplines and makes your character more attractive."


/datum/st_stat/attribute/mental
	abstract_type = /datum/st_stat/attribute/mental
	subcategory = STAT_SUBCATEGORY_MENTAL

/datum/st_stat/attribute/mental/perception
	name = "Perception"
	description = "A character's ability to observe their environment. Increases your examine speed. Used in Auspex."

/datum/st_stat/attribute/mental/intelligence
	name = "Intelligence"
	description = "A character's grasp of facts and knowledge. It also governs a character's ability to reason, solve problems, and evaluate situations. Used in magic disciplines and rituals."

/datum/st_stat/attribute/mental/wits
	name = "Wits"
	description = "A character's ability to think on her feet and react quickly to a certain situation. It also reflects a character's general cleverness. Used in Necromancy."

// Talents
/datum/st_stat/ability/talent
	abstract_type = /datum/st_stat/ability/talent
	subcategory = STAT_SUBCATEGORY_TALENTS

/datum/st_stat/ability/talent/alertness
	name = "Alertness"
	description = "Affects your character's intuition."

/datum/st_stat/ability/talent/athletics
	name = "Athletics"
	description = "Affects your character's physical wellbeing and endurance, as well as their ability to climb walls and jump."


/datum/st_stat/ability/talent/awareness
	name = "Awareness"
	description = "Awareness is an instinctual reaction to the presence of the supernatural. Used in vampiric disciplines."

// Awareness is functionally equivelent and replaced by primal urge.
/datum/st_stat/ability/talent/awareness/can_have_stat(mob/owner)
	if(get_werewolf_splat(owner))
		return FALSE
	return TRUE


/datum/st_stat/ability/talent/brawl
	name = "Brawl"
	description = "Affects your character's fist-fighting ability and the 'floor' of your unarmed damage."

/datum/st_stat/ability/talent/empathy
	name = "Empathy"
	description = "Affects your character's ability to understand someone else's emotions and state of mind."

/datum/st_stat/ability/talent/expression
	name = "Expression"
	description = "Affects your character's ability to emote and express themselves."

/datum/st_stat/ability/talent/intimidation
	name = "Intimidation"
	description = "Affects your character's ability to persuade via coercion and violence. Used in Dominate, Presence and other mental and social disciplines."

/datum/st_stat/ability/talent/leadership
	name = "Leadership"
	description = "Affects your character's natural affinity to lead, direct, take responsibility, and strategize. Increases your maximum follower/minion limit."


/datum/st_stat/ability/talent/primary_urge
	name = "Primal-Urge"
	description = "Your characters connection to their bestial nature, and a measure of their gut feeling and insticts."

/datum/st_stat/ability/talent/primary_urge/can_have_stat(mob/owner)
	if(!get_werewolf_splat(owner))
		return FALSE
	return TRUE


/datum/st_stat/ability/talent/streetwise
	name = "Streetwise"
	description = "Affects your character's familiarity with the criminal underworld and connections to lower-income communities."

/datum/st_stat/ability/talent/subterfuge
	name = "Subterfuge"
	description = "Affects your character's ability to sabotage and strike with stealth and deception. Used in Dominate, Presence, and Obfuscate."


// Skills
/datum/st_stat/ability/skill
	abstract_type = /datum/st_stat/ability/skill
	subcategory = STAT_SUBCATEGORY_SKILLS

/datum/st_stat/ability/skill/animal_ken
	name = "Animal Ken"
	description = "Affects your character's affinity with animals and creatures."

/datum/st_stat/ability/skill/crafts
	name = "Crafts"
	description = "Affects your character's ability to craft certain items."

/datum/st_stat/ability/skill/drive
	name = "Drive"
	description = "Determines how well your character can drive. At 0 points, you won't be able to drive at all."

/datum/st_stat/ability/skill/etiquette
	name = "Etiquette"
	description = "Affects your character's ability to be perceived as pleasant in attitude."

/datum/st_stat/ability/skill/firearms
	name = "Firearms"
	description = "Affects your character's skill with guns. Lowers the recoil of certain weapons. Each dot grants a 10% chance you deal 40% more damage from each bullet you shoot to a maximum of 50%."

/datum/st_stat/ability/skill/larceny
	name = "Larceny"
	description = "Affects your character's ability to steal and lockpick. At 0 points, you won't be able to use lockpicks at all."

/datum/st_stat/ability/skill/melee
	name = "Melee"
	description = "Affects your character's damage with all melee weapons."

/datum/st_stat/ability/skill/performance
	name = "Performance"
	description = "Affects your character's ability to act with talent. Used in Presence and Obfuscate."

/datum/st_stat/ability/skill/stealth
	name = "Stealth"
	description = "Affects your character's ability to sneak and go unnoticed. Used in Obfuscate."

/datum/st_stat/ability/skill/survival
	name = "Survival"
	description = "Affects your character's ability to be survive on their own - whether thats in the wild or on cold, unforgiving city streets."


// Knowledges
/datum/st_stat/ability/knowledge
	abstract_type = /datum/st_stat/ability/knowledge
	subcategory = STAT_SUBCATEGORY_KNOWLEDGES

/datum/st_stat/ability/knowledge/academics
	name = "Academics"
	description = "Affects your character's familiarity with academics and literature. Affects how many languages your character knows. At 0 points, your character will only know one language."

/datum/st_stat/ability/knowledge/computer
	name = "Computer"
	/* V20 p. 108
	This Knowledge represents the ability to operate and program computers, including mobile devices.
	Most Computer use also imparts a degree of Internet awareness (if not savvy).
	*/
	description = "Affects your ability to use and interact with computerized devices."

// This kinda sucks dick to do for every stat.
/datum/st_stat/ability/knowledge/computer/New()
	. = ..()
	if(CONFIG_GET(flag/punishing_zero_dots))
		description += " At 0 points, you won't be able to use a computer."

/datum/st_stat/ability/knowledge/finance
	name = "Finance"
	description = "Affects your character's wealth and business acumen. Affects the starting balance of your character's bank account, as well as how much money they receive from selling items."

/datum/st_stat/ability/knowledge/investigation
	name = "Investigation"
	description = "Affects your character's ability to piece together observations to reach conclusions."

/datum/st_stat/ability/knowledge/law
	name = "Law"
	description = "Affects your character's familiarity with laws and policies in their appropriate contexts."

/datum/st_stat/ability/knowledge/medicine
	name = "Medicine"
	description = "Affects your character's knowledge of anatomy, medicine, and emergency first aid protocols. Used in Vicissitude."

/datum/st_stat/ability/knowledge/occult
	name = "Occult"
	description = "Affects your character's knowledge of esoteric and occult knowledge and concepts. Used in magic disciplines and affects your magical rituals. At occult 3 or higher, you can identify magical artifacts."

/datum/st_stat/ability/knowledge/politics
	name = "Politics"
	description = "Affects your character's talent with regards to political manuevers."


/datum/st_stat/ability/knowledge/rituals
	name = "Rituals"

/datum/st_stat/ability/knowledge/rituals/can_have_stat(mob/owner)
	if(!get_werewolf_splat(owner))
		return FALSE
	return TRUE


/datum/st_stat/ability/knowledge/science
	name = "Science"
	description = "Affects your character's talent in the sciences, and their ability to synthesize chemicals."

/datum/st_stat/ability/knowledge/technology
	name = "Technology"
	/* V20 p. 110
	The Technology Knowledge represents a broad acumen with electronics, computer hardware, and devices more elaborate than “machines,” which fall under the Crafts Skill.
	If it has a processor, a transistor, or an integrated circuit — if it’s electronic rather than electrical manipulating it uses the Technology Knowledge.
	This is the wide-ranging Ability used to build one’s own computer, install (or subvert) a security system, repair a mobile phone, or kitbash a shortwave radio.
	You must always choose a specialization in Technology, even though you possess some skill in multiple fields.
	*/
	description = "Affects your character's familiarity with machines, devices, and electrical systems."

// I guess wolfs just use computer or science???
/datum/st_stat/ability/knowledge/technology/can_have_stat(mob/owner)
	if(get_werewolf_splat(owner))
		return FALSE
	return TRUE

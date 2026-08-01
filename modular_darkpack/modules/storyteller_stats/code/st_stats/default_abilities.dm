// Talents
/datum/st_stat/ability/alertness
	subcategory = "Talents"
	name = "Alertness"
	description = "Affects your character's vigilance, alongside their ability to understand and react to threats."

/datum/st_stat/ability/athletics
	subcategory = "Talents"
	name = "Athletics"
	description = "Affects your character's physical wellbeing and endurance, as well as their ability to climb walls and jump."

/datum/st_stat/ability/awareness
	subcategory = "Talents"
	name = "Awareness"
	description = "Affects your character's ability to notice otherworldly and supernatural events for what they are."

/datum/st_stat/ability/brawl
	subcategory = "Talents"
	name = "Brawl"
	description = "Affects your character's fist-fighting ability and the 'floor' of your unarmed damage."

/datum/st_stat/ability/empathy
	subcategory = "Talents"
	name = "Empathy"
	description = "Affects your character's ability to understand someone else's emotions and state of mind."

/datum/st_stat/ability/expression
	subcategory = "Talents"
	name = "Expression"
	description = "Affects your character's ability to emote and express themselves."

/datum/st_stat/ability/intimidation
	subcategory = "Talents"
	name = "Intimidation"
	description = "Affects your character's ability to persuade via coercion and violence."

/datum/st_stat/ability/leadership
	subcategory = "Talents"
	name = "Leadership"
	description = "Affects your character's ability to lead, direct, and organize groups."

/datum/st_stat/ability/streetwise
	subcategory = "Talents"
	name = "Streetwise"
	description = "Affects your character's familiarity with the criminal underworld and connections to lower-income communities."

/datum/st_stat/ability/subterfuge
	subcategory = "Talents"
	name = "Subterfuge"
	description = "Affects your character's ability to sabotage and strike with stealth and deception."

// Skills
/datum/st_stat/ability/animal_ken
	subcategory = "Skills"
	name = "Animal Ken"
	description = "Affects your character's relationship to animals and creatures."

/datum/st_stat/ability/crafts
	subcategory = "Skills"
	name = "Crafts"
	description = "Affects your character's ability to create iteams or structures."

/datum/st_stat/ability/drive
	subcategory = "Skills"
	name = "Drive"
	description = "Determines how well your character can operate vehicles."

/datum/st_stat/ability/etiquette
	subcategory = "Skills"
	name = "Etiquette"
	description = "Affects your character's ability to be perceived as pleasant in attitude."

/datum/st_stat/ability/firearms
	subcategory = "Skills"
	name = "Firearms"
	description = "Affects your character's skill with guns. Lowers the recoil of certain weapons."

/datum/st_stat/ability/larceny
	subcategory = "Skills"
	name = "Larceny"
	description = "Affects your character's ability to steal and pick locks."

/datum/st_stat/ability/melee
	subcategory = "Skills"
	name = "Melee"
	description = "Affects your character's damage with all melee weapons."

/datum/st_stat/ability/performance
	subcategory = "Skills"
	name = "Performance"
	description = "Affects your character's ability to dance, sing, or execute other demanding and precise tasks."

/datum/st_stat/ability/stealth
	subcategory = "Skills"
	name = "Stealth"
	description = "Affects your character's ability to sneak and go unnoticed."

/datum/st_stat/ability/survival
	subcategory = "Skills"
	name = "Survival"
	description = "Affects your character's ability to stay alive outside or in extreme environments."

// Knowledges
/datum/st_stat/ability/academics
	subcategory = "Knowledges"
	name = "Academics"
	description = "Affects your character's familiarity with scholarly activities such as literature, socieology, and the political sciences."

/datum/st_stat/ability/computer
	subcategory = "Knowledges"
	name = "Computer"
	/* V20 p. 108
	This Knowledge represents the ability to operate and program computers, including mobile devices.
	Most Computer use also imparts a degree of Internet awareness (if not savvy).
	*/
	description = "Affects your ability to use and interact with computerized devices."

// This kinda sucks dick to do for every stat.
/datum/st_stat/ability/computer/New()
	. = ..()
	if(CONFIG_GET(flag/punishing_zero_dots))
		description += "Affects your ability to use and interact with computerized devices."

/datum/st_stat/ability/finance
	subcategory = "Knowledges"
	name = "Finance"
	description = "Affects your character's wealth and business acumen."

/datum/st_stat/ability/investigation
	subcategory = "Knowledges"
	name = "Investigation"
	description = "Affects your character's ability to piece together observations to reach conclusions."

/datum/st_stat/ability/law
	subcategory = "Knowledges"
	name = "Law"
	description = "Affects your character's familiarity with laws and policies in their appropriate contexts."

/datum/st_stat/ability/medicine
	subcategory = "Knowledges"
	name = "Medicine"
	description = "Affects your character's knowledge of anatomy, diagnosis, and first aid."

/datum/st_stat/ability/occult
	subcategory = "Knowledges"
	name = "Occult"
	description = "Affects your character's knowledge of the esoteric and occult."

/datum/st_stat/ability/politics
	subcategory = "Knowledges"
	name = "Politics"
	description = "Affects your character's knowlege of society, the government, and large scale cooperation."

/datum/st_stat/ability/science
	subcategory = "Knowledges"
	name = "Science"
	description = "Affects your character's knowledge of the material world, chemistry, and physics."

/datum/st_stat/ability/technology
	subcategory = "Knowledges"
	name = "Technology"
	/* V20 p. 110
	The Technology Knowledge represents a broad acumen with electronics, computer hardware, and devices more elaborate than “machines,” which fall under the Crafts Skill.
	If it has a processor, a transistor, or an integrated circuit — if it’s electronic rather than electrical manipulating it uses the Technology Knowledge.
	This is the wide-ranging Ability used to build one’s own computer, install (or subvert) a security system, repair a mobile phone, or kitbash a shortwave radio.
	You must always choose a specialization in Technology, even though you possess some skill in multiple fields.
	*/
	description = "Affects your character's familiarity with machines, devices, and electrical systems."

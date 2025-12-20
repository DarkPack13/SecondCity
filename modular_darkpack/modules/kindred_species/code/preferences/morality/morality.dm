/datum/preference/choiced/vtm_morality
	savefile_key = "morality_path"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_TABLETOP
	main_feature_name = "Path"
	relevant_inherent_trait = TRAIT_VTM_MORALITY
	must_have_relevant_trait = TRUE
	can_randomize = FALSE

/datum/preference/choiced/vtm_morality/create_default_value()
	return /datum/morality/humanity

/datum/preference/choiced/vtm_morality/init_possible_values()
	var/list/values = list()
	for(var/morality_type in subtypesof(/datum/morality))
		var/datum/morality/M = morality_type
		values[initial(M.name)] = morality_type
	return values

/datum/preference/choiced/vtm_morality/is_valid(value)
	return ispath(value, /datum/morality)

/datum/preference/choiced/vtm_morality/serialize(input)
	if(ispath(input))
		var/datum/morality/M = input
		return initial(M.name)
	return input

/datum/preference/choiced/vtm_morality/deserialize(input, datum/preferences/preferences)
	var/list/choices = get_choices()
	if(input in choices)
		return choices[input]
	return choices[serialize(create_default_value())]

/datum/preference/choiced/vtm_morality/apply_to_human(mob/living/carbon/human/target, value)
	var/datum/st_stat/morality_path/morality/stat_morality = target.storyteller_stats["[STAT_MORALITY]"]
	if(!stat_morality)
		return

	stat_morality.morality_path = new value(target)

	if(stat_morality.morality_path.alignment == MORALITY_ENLIGHTENMENT)
		var/datum/species/human/kindred/kindred_species = target.dna.species
		if(istype(kindred_species))
			kindred_species.enlightenment = TRUE

/datum/morality
	var/name = ""
	var/desc = ""
	/// Humanity or Enlightenment
	var/alignment
	/// The bearing of the path's ethos
	var/bearing

/datum/morality/humanity
	name = "Path of Humanity"
	desc = "The Path of Humanity, the most common Path across all Kindred by far, and the only Path which is deemed to be acceptable by the Camarilla, posits that the only way to resist the Beast is by staying true to the values and nature of mortal life. Much in the way the Masquerade seeks to conceal the awareness of vampires from mortal society, the Path of Humanity seeks to suppress the Beast by denying Vampirism and it's darkest urges, and thus, the Masquerade and Humanity go hand-in-hand. Humanity, unlike most Paths, has many advantages, including affecting how 'human' a vampire may look to others. A character who has embraced a Path of Enlightenment or is distant from their Humanity may never breathe or blink, may exhibit animalistic snarls or sunken eyes. Make no mistake - a Vampire on the Path of Humantiy is not a saint. Vampires are predators by nature, and just because they follow this Path doesn't mean they're not. Most mortals are on this Path - but ironically enough, a vampire extremely high in humanity may seem more human than most mortals. Deviating from this Path is intensely dangerous, requires extremely low Humanity, and requires a mentor, and your character will have forever discarded all remaining behaviors, beliefs, appearance, and morality of what once made them human."
	alignment = MORALITY_HUMANITY
	bearing = BEARING_MUNDANE

/datum/morality/power
	name = "Path of Power and the Inner Voice"
	desc = "The Path of Power and the Inner Voice is a Path of Enlightenment that controls the Beast through rigorous determination and the amassing of worldly power. Adherents are called Unifiers."
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_COMMAND

/datum/morality/heaven
	name = "Path of Heaven"
	desc = "Followers of Via Caeli attempt to control their Beast through religious devotion. They are frequently referred to as the Faithful."
	alignment = MORALITY_HUMANITY
	bearing = BEARING_HOLINESS

/datum/morality/metamorphosis
	name = "Path of Metamorphosis"
	desc = "The Path of Metamorphosis is a Path of Enlightenment that controls the Beast by studying its limits and the limits of vampirism in general. The Path is the result of the earlier Road of Metamorphosis and it is practiced mostly by the Tzimisce clan."
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_INHUMANITY

/datum/morality/assamite
	name = "Path of Blood"
	desc = "The Path of Blood is a Path of Enlightenment common among the Assamites. Its followers fight the Beast with rigorous devotion to the cause of Haqim. Adherents are called Dervishes or Assassins."
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_RESOLVE

/datum/morality/hive
	name = "Path of the Hive"
	desc = "Via Hyron, more commonly called Road of the Hive or Path of the Hive, is a minor Road that is followed almost exclusively by the Baali. Adherents are called Abelenes."
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_JUSTICE

/datum/morality/kings
	name = "Road of Kings"
	desc = "Via Regalis, commonly called the Road of Kings. Followers of Via Regalis control their Beast by ruling over others. Mortals are inferior, promises will be fulfilled, and power is everything. Those who follow the Road of Kings are known as Scions."
	alignment = MORALITY_HUMANITY
	bearing = BEARING_COMMAND

/datum/morality/heart
	name = "Path of the Scorched Heart"
	desc = "The Path of the Scorched Heart, originally called the Path of Rathmonicus, is an ancient Path of Enlightenment that originates with the True Brujah. Based on the Book of the Empty Heart by Rathmonicus, it was first disseminated among a few Kindred in the Catholic Church; its scriptures were later reunited and compiled by the True Black Hand. The Path of the Scorched Heart controls the Beast by systematically eradicating every emotion within the vampire's heart. The Path is especially favored among the True Brujah, who already cultivate few emotions. Adherents are called the Unforgiving."
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_INTELLECT

/datum/morality/typhon
	name = "Path of Typhon"
	desc = "The Path of Typhon is a Path of Enlightenment that draws heavily on Setite doctrine and the religion around their Antediluvian. Adherents are called Theophidians and Typhonists. Outsiders call them Corruptors."
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_DEVOTION

/datum/morality/bones
	name = "Path of Bones"
	desc = "The Path of Bones is a Path of Enlightenment that suppresses the Beast by studying the true nature of death and its relationships with other states of existence. Scholars of death and the transition into it, followers of this Path benefit Necromantic and Thanatological study via the knowledge they bring, rather than the political or pragmatic benefits of their concourse with the dead. This Path is sometimes derided as one that celebrates wanton murder, but Followers of this Path are genuinely curious - and their encounters with all manner of mortal life can be made victim of their grim curiosity, causing them to rarely deal with mortals, resulting in a very introverted, quiet temperament. Adherents are called Gravediggers."
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_SILENCE

/datum/morality/night
	name = "Road of Night"
	desc = "Via Noctis, commonly called the Road of Night. The Redeemers feel the weight of Caine's curse and their own damnation, even more so than those who follow Via Caeli. Also like the Noddists, the Redeemers seek redemption and forgiveness, and to earn it requires suffering and purification. However, instead of the fairly benign ways of the Noddists, the Redeemers actively go about the world of man, punishing and killing mortal sinners. Some followers of Via Noctis offer penance for lesser deeds, and still others will Embrace irredeemable mortals to help them in their punishment. They also target Cainites who would tempt mortals into corruption, outstanding examples being the Followers of Set and the Baali."
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_GUILT

/datum/morality/honor
	name = "Path of Honorable Accord"
	desc = "The Path of Honorable Accord is a Path of Enlightenment that harnesses the Beast through the rigorous practice of honorable and chivalrous behavior. Known for their loyalty to their group, their leaders, and it's allies, as well as their firm devotion to upholding their own word and promises, these vampires place duty above all else. Adherents are called Knights, Patriots, or Canonici. Make no mistake - vampires who follow this path are not compassionate or humane in any sense. Indeed, they still see humans as little more than chattel or food, and undeserving of the considerations of honor that are bestowed on other vampires."
	alignment = MORALITY_HUMANITY
	bearing = BEARING_DEVOTION

/datum/morality/beast
	name = "Path of the Feral Heart"
	desc = "The Path of the Feral Heart (sometimes called the 'Path of the Beast') is a Path of Enlightenment practiced especially by members of Clan Gangrel. It controls the Beast by accepting its urges as natural and accepting their role as a hunter among hunters. Adherents are called Bestials or Beasts."
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_MENACE

/datum/morality/samiel
	name = "Code of Samiel"
	desc = "The Code of Samiel is a doctrine that formalized the tenets of the Warrior Salubri and of the Path of Retribution. It was designed by Saulot's greatest childe warrior, Samiel himself. Adherents swear to bring retribution to all manner of evil, chief among which are Infernalists, Demons and the Followers of Set. Vengeance, vigilance and righteousness are all held as core virtues."
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_JUSTICE //I have no idea what this actually does

/datum/morality/caine
	name = "Path of Caine"
	desc = "The Path of Caine, whose followers are commonly called Noddists, are Cainites who devote themselves to studying the nature of the vampyric condition, particularly through the emulation of Caine and the teachings of the Book of Nod. Adherents swear to study, reflect, and unearth the true nature of what it means to be a vampire, as well as embrace and reach the ultimate form of the condition. Followers are often scholarly or introspective vampires who excel in their discipline and rigor. Noddists swear to cast aside their lost humanity, embrace their new condition, emulate Caine in all things, as well as take the vitae of the unworthy through Diablerie to become closer to the Dark Father. Sins include befriending or co-existing with mortals, succumbing to Frenzy or Rotschrek, failing to diablerize a 'Humane' vampire, failing to engage in study or research into vampirism, as well as denying the inherent needs of a vampire by failing to feed or by showing compassion."
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_FAITH

/datum/morality/cathari
	name = "Path of Cathari"
	desc = "The Path of Cathari, whose followers are commonly called Albigensians, are vampires whose ethos sprung forth from the Cathar heresy of the Catholic Church in the Dark Ages. The Cathar heresy posited that the world was created in equal parts by a good ('light') creator, responsible for virtue and spirit, and an evil ('dark') creator, responsible for the material world and all it's vices. Vampires who follow this path reason that since those cursed with vampirism are denied the everlasting spiritual peace of an afterlife, due to their immortality, the very essence of their being is to favor this 'dark' creator by tempting others with all the trappings of the material world. Followers of this path, in a way, thus seek spirituality in 'depravity'. Sins include showing restraint, showing trust, murder, sacrificing your own gratification for someone else's convenience, refraining from indulgence, or encouraging others to excersize restraint."
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_SEDUCTION // add this

/datum/morality/lilith
	name = "Path of Lilith"
	desc = "The Path of Lilith, often called Bahari or Lilins, are those vampires who study the teachings and lessons of Lilith. Considered heretical by most Cainites of the Sabbat, the Bahari practice the ancient ways handed down by Lilith herself, believing that pain, tribulation, and suffering, are the only roads to learning and true growth. Only through suffering, experiencing the limits of creation and it's sensations can understanding be had is what these vampires believe, with little compassion for those who lack the insight or the will to embark upon it's journey. Sins include feeding immediately when hungry, pursuing wealth or power, not correcting others regarding the story of Caine and Lilith, feeling remorse for someone in pain, fearing death, murder, failing to dispense pain and anguish, and shunning pain."
	alignment = MORALITY_ENLIGHTENMENT
	bearing = BEARING_TRIBULATION // add this

/datum/morality/redemption
	name = "Path of Redemption"
	desc = "There are thousands of terms for God. Jesus, Yahweh, Allah, Ahura-Mazda. Yet one thing is certain: Vampires, being immortal, being cursed by God, witnessing the Great Flood, and being in the First City know that God is real. Followers of this Path are thus extremely devoted believers in their faith and religious principles, using the Curse as evidence of their chance for redemption on the day of their judgment by a benevolent creator. Indeed, vampires are outcasts of Heaven, but could this all be a test? Commonly called 'Martyrs', those who follow the Path of Redemption  "

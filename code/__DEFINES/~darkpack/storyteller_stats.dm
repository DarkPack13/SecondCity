// Stat Flags
#define AFFECTS_HEALTH (1<<0)
#define AFFECTS_SPEED (1<<1)
#define AFFECTS_STATS (1<<2) // If the stat affects other stats, like courage or permanent willpower.


#define STAT_FREEBIE_POINTS /datum/st_stat/freebie

// Physical
#define STAT_STRENGTH /datum/st_stat/attribute/physical/strength
#define STAT_DEXTERITY /datum/st_stat/attribute/physical/dexterity
#define STAT_STAMINA /datum/st_stat/attribute/physical/stamina
// Social
#define STAT_CHARISMA /datum/st_stat/attribute/social/charisma
#define STAT_MANIPULATION /datum/st_stat/attribute/social/manipulation
#define STAT_APPEARANCE /datum/st_stat/attribute/social/appearance
// Mental
#define STAT_PERCEPTION /datum/st_stat/attribute/mental/perception
#define STAT_INTELLIGENCE /datum/st_stat/attribute/mental/intelligence
#define STAT_WITS /datum/st_stat/attribute/mental/wits

// Talents
#define STAT_ALERTNESS /datum/st_stat/ability/talent/alertness
#define STAT_ATHLETICS /datum/st_stat/ability/talent/athletics
#define STAT_AWARENESS /datum/st_stat/ability/talent/awareness
#define STAT_BRAWL /datum/st_stat/ability/talent/brawl
#define STAT_EMPATHY /datum/st_stat/ability/talent/empathy
#define STAT_EXPRESSION /datum/st_stat/ability/talent/expression
#define STAT_INTIMIDATION /datum/st_stat/ability/talent/intimidation
#define STAT_LEADERSHIP /datum/st_stat/ability/talent/leadership
#define STAT_PRIMAL_URGE /datum/st_stat/ability/talent/primary_urge // WEREWOLF
#define STAT_STREETWISE /datum/st_stat/ability/talent/streetwise
#define STAT_SUBTERFUGE /datum/st_stat/ability/talent/subterfuge

// Skills
#define STAT_ANIMAL_KEN /datum/st_stat/ability/skill/animal_ken
#define STAT_CRAFTS /datum/st_stat/ability/skill/crafts
#define STAT_DRIVE /datum/st_stat/ability/skill/drive
#define STAT_ETIQUETTE /datum/st_stat/ability/skill/etiquette
#define STAT_FIREARMS /datum/st_stat/ability/skill/firearms
#define STAT_LARCENY /datum/st_stat/ability/skill/larceny
#define STAT_MELEE /datum/st_stat/ability/skill/melee
#define STAT_PERFORMANCE /datum/st_stat/ability/skill/performance
#define STAT_STEALTH /datum/st_stat/ability/skill/stealth
#define STAT_SURVIVAL /datum/st_stat/ability/skill/survival

// Knowledges
#define STAT_ACADEMICS /datum/st_stat/ability/knowledge/academics
#define STAT_COMPUTER /datum/st_stat/ability/knowledge/computer
#define STAT_FINANCE /datum/st_stat/ability/knowledge/finance
#define STAT_INVESTIGATION /datum/st_stat/ability/knowledge/investigation
#define STAT_LAW /datum/st_stat/ability/knowledge/law
#define STAT_MEDICINE /datum/st_stat/ability/knowledge/medicine
#define STAT_OCCULT /datum/st_stat/ability/knowledge/occult
#define STAT_POLITICS /datum/st_stat/ability/knowledge/politics
#define STAT_RITUALS /datum/st_stat/ability/knowledge/rituals // WEREWOLF
#define STAT_SCIENCE /datum/st_stat/ability/knowledge/science
#define STAT_TECHNOLOGY /datum/st_stat/ability/knowledge/technology

// Advantages
#define STAT_PERMANENT_WILLPOWER /datum/st_stat/pooled/permanent_willpower
#define STAT_TEMPORARY_WILLPOWER /datum/st_stat/pooled/temporary_willpower
#define STAT_PERMANENT_RAGE /datum/st_stat/pooled/permanent_rage // WEREWOLF
#define STAT_TEMPORARY_RAGE /datum/st_stat/pooled/temporary_rage // WEREWOLF
#define STAT_PERMANENT_GNOSIS /datum/st_stat/pooled/permanent_gnosis // WEREWOLF
#define STAT_TEMPORARY_GNOSIS /datum/st_stat/pooled/temporary_gnosis // WEREWOLF

// Virtues
#define STAT_CONSCIENCE /datum/st_stat/virtue/conscience
#define STAT_SELF_CONTROL /datum/st_stat/virtue/self_control
#define STAT_CONVICTION /datum/st_stat/virtue/conviction
#define STAT_INSTINCT /datum/st_stat/virtue/instinct
#define STAT_COURAGE /datum/st_stat/virtue/courage

//Morality Path
#define STAT_MORALITY /datum/st_stat/morality_path/morality


// Parent stats, mainly used for point allocation in preferences.

#define STAT_CATEGORY_ATTRIBUTE "Attributes"
#define STAT_SUBCATEGORY_MENTAL "Mental"
#define STAT_SUBCATEGORY_SOCIAL "Social"
#define STAT_SUBCATEGORY_PHYSICAL "Physical"

#define STAT_CATEGORY_ABILITY "Abilities"
#define STAT_SUBCATEGORY_TALENTS "Talents"
#define STAT_SUBCATEGORY_SKILLS "Skills"
#define STAT_SUBCATEGORY_KNOWLEDGES "Knowledges"

#define STAT_CATEGORY_POOLED "Pooled"
#define STAT_SUBCATEGORY_VIRTUES "Virtues"

// Defines used for saving of stats.
#define STAT_SCORE "score"
#define STAT_POINTS "points"
#define STAT_FREEBIE_COST_SPENT "freebie_cost_spent"

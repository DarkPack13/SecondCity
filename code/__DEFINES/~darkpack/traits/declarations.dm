// This file contains all of the "static" define strings that tie to a trait.
// WARNING: The sections here actually matter in this file as it's tested by CI. Please do not toy with the sections."

// BEGIN TRAIT DEFINES

/*
Remember to update _globalvars/traits.dm if you're adding/removing/renaming traits.
*/

// CITY_TRAITS
#define STATION_TRAIT_RED_STAR "station_trait_red_star"
#define STATION_TRAIT_WILD_MASQUERADE "station_trait_wild_masquerade"
#define STATION_TRAIT_INFESTATION "station_trait_infestation"
#define STATION_TRAIT_PEST_CONTROL "station_trait_pest_control"
#define STATION_TRAIT_STRAY_MIGRATION "station_trait_stray_migration"
#define STATION_TRAIT_COSPLAY_CONVENTION "station_trait_cosplay_convention"

// Mob traits

// If the user is unbondable via blood bonds.
#define TRAIT_UNBONDABLE "unbondable"
// If the kindred's blood can't bond others.
#define TRAIT_DEFICIENT_VITAE "deficient_vitae"
//If the kindred is obfuscated.
#define TRAIT_OBFUSCATED "obfuscated"
#define TRAIT_BLOODY_LOVER "bloody_lover"
#define TRAIT_TOUGH_FLESH "tough_flesh"
#define TRAIT_BLOODY_SUCKER "bloody_sucker"
#define TRAIT_NON_INT "non_intellectual"
#define TRAIT_COFFIN_THERAPY "coffin_therapy"
#define TRAIT_RUBICON "rubicon"
#define TRAIT_HUNGRY "hungry"
#define TRAIT_STAKE_RESISTANT "stake_resistant"
#define TRAIT_STAKE_IMMUNE "stake_immune"
#define TRAIT_STAKED "staked"
#define TRAIT_LAZY "lazy"
#define TRAIT_HOMOSEXUAL "homosexual"
#define TRAIT_HUNTED "hunted"
#define TRAIT_VIOLATOR "violator"
#define TRAIT_DIABLERIE "diablerie"
#define TRAIT_GULLET "gullet"
#define TRAIT_CHARMER "charmer"
#define TRAIT_COLD_AURA "cold_aura"
#define TRAIT_WARM_AURA "warm_aura"
#define TRAIT_FRENETIC_AURA "frenetic_aura"
#define TRAIT_BLUSH_OF_HEALTH "blush_of_health"
/// The mob will automatically breach the Masquerade when seen by others, with no exceptions
#define TRAIT_UNMASQUERADE "unmasquerade"
/// The mob always dodges melee attacks
#define TRAIT_ENHANCED_MELEE_DODGE "enhanced_melee_dodge"
/// Can pass through walls so long as it doesn't move the mob into a new area
#define TRAIT_PASS_THROUGH_WALLS "pass_through_walls"
/// Technology supernaturally refuses to work or doesn't work properly for this person
#define TRAIT_REJECTED_BY_TECHNOLOGY "rejected_by_technology"
/// Vampire cannot drink from anyone who doesn't consent to it
#define TRAIT_CONSENSUAL_FEEDING_ONLY "consensual_feeding_only"
/// Instead of knocking someone out when fed on, this vampire's Kiss inflicts pain
#define TRAIT_PAINFUL_VAMPIRE_KISS "painful_vampire_kiss"
/// Vampires will always diablerise this vampire given the chance
#define TRAIT_IRRESISTIBLE_VITAE "irresistible_vitae"
/// Vampire cannot feed from poor people
#define TRAIT_FEEDING_RESTRICTION "feeding_restriction"
/// Will always fail to resist supernatural mind-influencing powers
#define TRAIT_CANNOT_RESIST_MIND_CONTROL "cannot_resist_mind_control"
/// Cannot leave the vicinity of whoever's vitae you've drank
#define TRAIT_VITAE_ADDICTION "vitae_addiction"
/// Is hurt by holiness/holy symbols and repelled by them
#define TRAIT_REPELLED_BY_HOLINESS "repelled_by_holiness"
/// Any changes in this Kindred's Humanity will be doubled
#define TRAIT_SENSITIVE_HUMANITY "sensitive_humanity"
/// Duration of frenzy is doubled
#define TRAIT_LONGER_FRENZY "longer_frenzy"
// DARKPACK TODO - refactor these traits into mutant bodyparts and a component maybe
/// If eyes are uncovered, they will be obviously supernatural to everyone nearby
#define TRAIT_MASQUERADE_VIOLATING_EYES "masquerade_violating_eyes"
/// If face is uncovered, they will be obviously supernatural to everyone nearby
#define TRAIT_MASQUERADE_VIOLATING_FACE "masquerade_violating_face"
/// A special form of fakedeath that vampires go into rather than dying above -200 health
#define TRAIT_TORPOR "torpor"
/// Instead of dying at -100 health, enters a deathcoma and properly dies at -200 health
#define TRAIT_CAN_ENTER_TORPOR "can_enter_torpor"
/// Uses Vampire: The Masquerade morality systems
#define TRAIT_VTM_MORALITY "vtm_morality"
/// Uses Vampire: The Masquerade Clans/Bloodlines
#define TRAIT_VTM_CLANS "vtm_clans"
/// This species drinks blood
#define TRAIT_BLOOD_DRINKER "blood_drinker"
/// Does not biologically age, and so has a disconnected biological and chronological age
#define TRAIT_UNAGING "unaging"
// Does the mob know thaumaturgy?
#define TRAIT_THAUMATURGY_KNOWLEDGE "thaumaturgy_knowledge"
// Does the mob have ghostsight?
#define TRAIT_GHOST_VISION "ghost_vision"
#define TRAIT_VICISSITUDE_KNOWLEDGE "vicissitude_knowledge"
#define TRAIT_MYSTICISM_KNOWLEDGE "mysticism_knowledge"
#define TRAIT_NECROMANCY_KNOWLEDGE "necromancy_knowledge"
#define TRAIT_ILLEGAL_IDENTITY "illegal_identity" // GOVERMENT

// Allows the user to pass through doors
#define TRAIT_PASSDOOR "trait_passdoor" //DARKPACK EDIT ADDITION -- Obtenebration & Mysticism Rework
#define TRAIT_IN_FRENZY "in_frenzy"


/// They have warped time at some point in this round
#define TRAIT_TIMEWARPER "timewarper"

// END TRAIT DEFINES

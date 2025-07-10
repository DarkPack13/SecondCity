// Defines for Species IDs. Used to refer to the name of a species, for things like bodypart names or species preferences.
#define SPECIES_KINDRED "kindred"

/// Health level where mobs who can Torpor will actually die
#define HEALTH_THRESHOLD_TORPOR_DEAD -200

#define iskindred(A) (FALSE)
// TODO: [Lucia] implement other splats
#define isghoul(A) (FALSE)
#define iscathayan(A) (FALSE)
#define isgarou(A) (FALSE)

#define isnpc(A) (istype(A, /mob/living/carbon/human/npc))

#define SOUL_PRESENT 1
#define SOUL_ABSENT 2
#define SOUL_PROJECTING 3

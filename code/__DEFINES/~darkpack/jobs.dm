/**
 * =======================
 * WARNING WARNING WARNING
 * WARNING WARNING WARNING
 * WARNING WARNING WARNING
 * =======================
 * These names are used as keys in many locations in the database
 * you cannot change them trivially without breaking job bans and
 * role time tracking, if you do this and get it wrong you will die
 * and it will hurt the entire time
 */

//No department
#define JOB_CITIZEN "Citizen"
#define JOB_ORDINARY_CITIZEN "Ordinary Citizen"
#define JOB_BARISTA "Barista"


//Camarilla
#define JOB_PRINCE "Prince"
#define JOB_SHERIFF "Sheriff"
#define JOB_HOUND "Hound"
#define JOB_HARPY "Harpy"
#define JOB_SENESCHAL "Seneschal"

//Primogens
#define JOB_PRIMOGEN_TOREADOR "Primogen Toreador"
#define JOB_PRIMOGEN_BANU_HAQIM "Primogen Banu Haqim"
#define JOB_PRIMOGEN_LASOMBRA "Primogen Lasombra"
#define JOB_PRIMOGEN_MALKAVIAN "Primogen Malkavian"
#define JOB_PRIMOGEN_NOSFERATU "Primogen Nosferatu"
#define JOB_PRIMOGEN_VENTRUE "Primogen Ventrue"

//Anarch
#define JOB_BARON "Baron"
#define JOB_TAPSTER "Bartender"
#define JOB_BRUISER "Bruiser"
#define JOB_EMISSARY "Emissary"
#define JOB_SWEEPER "Sweeper"

//Tzimisce
#define JOB_BOGATYR "Bogatyr"

//Police

//Clinic
#define JOB_CLINIC_DIRECTOR "Clinic Director"
#define JOB_DOCTOR "Doctor"

//Church
#define JOB_PRIEST "Priest"


#define JOB_DISPLAY_ORDER_CITIZEN 1
#define JOB_DISPLAY_ORDER_VETERINARIAN 2
#define JOB_DISPLAY_ORDER_DAUGHTER 4
#define JOB_DISPLAY_ORDER_BAALI 5
#define JOB_DISPLAY_ORDER_TRUJAH 6
#define JOB_DISPLAY_ORDER_KIASYD 7
#define JOB_DISPLAY_ORDER_NAGARAJA 9
#define JOB_DISPLAY_ORDER_PRINCE 10
#define JOB_DISPLAY_ORDER_SHERIFF 11
#define JOB_DISPLAY_ORDER_CLERK 12
#define JOB_DISPLAY_ORDER_HARPY 13
#define JOB_DISPLAY_ORDER_HOUND 14
#define JOB_DISPLAY_ORDER_TOWERWORK 15
#define JOB_DISPLAY_ORDER_BANU 16
#define JOB_DISPLAY_ORDER_LASOMBRA 17
#define JOB_DISPLAY_ORDER_MALKAVIAN 18
#define JOB_DISPLAY_ORDER_NOSFERATU 19
#define JOB_DISPLAY_ORDER_TOREADOR 20
#define JOB_DISPLAY_ORDER_VENTRUE 21
#define JOB_DISPLAY_ORDER_PRIEST 22
#define JOB_DISPLAY_ORDER_CLINICS_DIRECTOR 23
#define JOB_DISPLAY_ORDER_DOCTOR 24
#define JOB_DISPLAY_ORDER_GRAVEYARD 25
#define JOB_DISPLAY_ORDER_STREETJAN 26
#define JOB_DISPLAY_ORDER_STRIP 27
#define JOB_DISPLAY_ORDER_TAXI 28
#define JOB_DISPLAY_ORDER_AXE_GANGSTER 29
#define JOB_DISPLAY_ORDER_AXE_LEADER 35
#define JOB_DISPLAY_ORDER_BARON 30
#define JOB_DISPLAY_ORDER_EMISSARY 31
#define JOB_DISPLAY_ORDER_SWEEPER 32
#define JOB_DISPLAY_ORDER_BRUISER 33
#define JOB_DISPLAY_ORDER_LIAISON 34
#define JOB_DISPLAY_ORDER_TAPSTER 35
#define JOB_DISPLAY_ORDER_DEALER 36
#define JOB_DISPLAY_ORDER_SUPPLY 37
#define JOB_DISPLAY_ORDER_REGENT 38
#define JOB_DISPLAY_ORDER_ARCHIVIST 39
#define JOB_DISPLAY_ORDER_GARGOYLE 40
#define JOB_DISPLAY_ORDER_GIOVANNI 21
#define JOB_DISPLAY_ORDER_POLICE_CHIEF 42
#define JOB_DISPLAY_ORDER_POLICE 43
#define JOB_DISPLAY_ORDER_POLICE_SERGEANT 44
#define JOB_DISPLAY_ORDER_ASSISTANT_DISTRICT_ATTORNEY 45
#define JOB_DISPLAY_ORDER_FBI 46
#define JOB_DISPLAY_ORDER_VOIVODE 47
#define JOB_DISPLAY_ORDER_BOGATYR 48
#define JOB_DISPLAY_ORDER_ZADRUGA 49
#define JOB_DISPLAY_ORDER_AMBERGLADE 50
#define JOB_DISPLAY_ORDER_PAINTEDCITY 51
#define JOB_DISPLAY_ORDER_ENDRON 52
#define JOB_DISPLAY_ORDER_SABBATDUCTUS 53
#define JOB_DISPLAY_ORDER_SABBATPACK 54
#define JOB_DISPLAY_ORDER_SABBATPRIEST 55

#define DEPARTMENT_BITFLAG_CITIZEN (1<<0)
#define DEPARTMENT_CITIZEN "Citizen"
#define DEPARTMENT_BITFLAG_PRINCE (1<<1)
#define DEPARTMENT_PRINCE "Prince"
#define DEPARTMENT_BITFLAG_CAMARILLA (1<<2)
#define DEPARTMENT_CAMARILLA "Camarilla"
#define DEPARTMENT_BITFLAG_CHURCH (1<<3)
#define DEPARTMENT_CHURCH "Church"
#define DEPARTMENT_BITFLAG_CLINIC (1<<4)
#define DEPARTMENT_CLINIC "Clinic"
#define DEPARTMENT_BITFLAG_ANARCH (1<<5)
#define DEPARTMENT_ANARCH "Anarch"
#define DEPARTMENT_BITFLAG_STRIP_CLUB (1<<6)
#define DEPARTMENT_STRIP_CLUB "Strip Club"
#define DEPARTMENT_BITFLAG_AXE_GANG (1<<7)
#define DEPARTMENT_AXE_GANG "Axe Gang"


DEFINE_BITFIELD(departments_bitflags, list(
	"CITIZEN" = DEPARTMENT_BITFLAG_CITIZEN,
	"PRINCE" = DEPARTMENT_BITFLAG_PRINCE,
	"CAMARILLA" = DEPARTMENT_BITFLAG_CAMARILLA,
	"CHURCH" = DEPARTMENT_BITFLAG_CHURCH,
	"CLINIC" = DEPARTMENT_BITFLAG_CLINIC,
	"ANARCH" = DEPARTMENT_BITFLAG_ANARCH,
	"STRIP_CLUB" = DEPARTMENT_BITFLAG_STRIP_CLUB,
	"AXE_GANG" = DEPARTMENT_BITFLAG_AXE_GANG,
))

/// Combination flag for jobs which are considered regular crew members of the station.
#define CITY_JOB_FLAGS (JOB_CREW_MANIFEST|JOB_EQUIP_RANK|JOB_CREW_MEMBER|JOB_NEW_PLAYER_JOINABLE|JOB_REOPEN_ON_ROUNDSTART_LOSS|JOB_ASSIGN_QUIRKS)

// Variable macros used to declare who is the supervisor for a given job, announced to the player when they join as any given job.
#define SUPERVISOR_TRADITIONS "the Traditions"
#define SUPERVISOR_PRINCE "the Prince"
#define SUPERVISOR_SHERIFF "the Sheriff"
#define SUPERVISOR_PRIMOGEN_BANU_HAQIM "the Banu Haqim Primogen"
#define SUPERVISOR_BARON "the Baron"
#define SUPERVISOR_CLINIC_DIRECTOR "the Clinic Director"
#define SUPERVISOR_CLUB_DIRECTOR "the Strip Club Owner"

#define SUPERVISOR_BARON_PUBLIC "the Bar's Owner"

// Playtime tracking system, see jobs_exp.dm
#define EXP_TYPE_KINDRED "Kindred"
#define EXP_TYPE_GAROU "Garou"
#define EXP_TYPE_CAMARILLA "Camarilla Authorities"
#define EXP_TYPE_GANG "Gangs"
#define EXP_TYPE_TREMERE "Tremere"
#define EXP_TYPE_ANARCH "Anarchs"
#define EXP_TYPE_SABBAT "Sabbat"
#define EXP_TYPE_COUNCIL "Camarilla Primogen Council"
#define EXP_TYPE_POLICE "Police Force"
#define EXP_TYPE_NATIONAL_SECURITY "National Security"
#define EXP_TYPE_SERVICES "City Services"
#define EXP_TYPE_CLINIC "St. John's Clinic"
#define EXP_TYPE_GIOVANNI "Giovanni Family"
#define EXP_TYPE_TZIMISCE "Tzimisce Mansion"
#define EXP_TYPE_CHURCH "Church"
#define EXP_TYPE_CLUB "Strip Club"

#define EXP_TYPE_PAINTED_CITY "Sept of the Painted City"
#define EXP_TYPE_AMBERGLADE "Sept of the Amberglade"
#define EXP_TYPE_SPIRAL "Hive of the Poisoned Shore"

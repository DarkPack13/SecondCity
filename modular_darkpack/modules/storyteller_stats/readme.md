https://github.com/DarkPack13/SecondCity/pull/38
https://github.com/DarkPack13/SecondCity/pull/58
https://github.com/DarkPack13/SecondCity/pull/69

## Storyteller stats

Module ID: STORYTELLER_STATS

### Description:

Not to be confused with TG traits. A stat system based heavily on WoD

### TG Proc/File Changes:

- [code/modules/mob/living/living.dm](/code/modules/mob/living/living.dm):
  - `/mob/living/Initialize(mapload)`

### Modular Overrides:

- [modular_darkpack/master_files/code/modules/mob/living/living_defines.dm](/modular_darkpack/master_files/code/modules/mob/living/living_defines.dm): `var/datum/storyteller_stats/storyteller_stat_holder`
- [modular_darkpack/master_files/code/modules/mob/living/living.dm](/modular_darkpack/master_files/code/modules/mob/living/living.dm): `storyteller_stat_holder = new()`

### Defines:

- [code/\_\_DEFINES/~darkpack/storyteller_stats.dm](/code/__DEFINES/~darkpack/storyteller_stats.dm):
  - `STAT_###` Im not going to list all of them, but one for every trait following this format.

### Included files that are not contained in this module:

- [code/\_\_DEFINES/~darkpack/storyteller_stats.dm](code/__DEFINES/~darkpack/storyteller_stats.dm)

### Credits:

FalloutFalcon, XeonMations

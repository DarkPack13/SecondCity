https://github.com/DarkPack13/SecondCity/pull/407

## \<Splats>

Module ID: SPLATS

### Description:

A framework for supernatural types (splats) to replace the old species-based splat
code. Splats are the different kinds of supernatural creatures in the World of
Darkness like vampires, ghouls, werewolves, mages, and so on.

Living mobs can have multiple splat datums, which can all:

- Apply traits to their owners that determine different aspects of the supernatural
  creature, like being immortal or weak to silver.
- Give their owners actions to represent innate supernatural abilities, like using
  vampiric blood to heal or empower themselves.
- Optionally give their owners biotypes to represent fundamentally supernatural existences,
  like being undead or a spirit.
- Manage which powers the owner is able to use and provide a way to easily interact
  with them in code.
- Apply unique effects to their owners upon gaining them, which can easily be undone
  when the splat is removed.
- Specify which splats can co-exist with them and dynamically approve or reject new
  splats for unique cross-splat interactions like Abominations.

### TG Proc/File Changes:

- N/A

### Modular Overrides:

- [modular_darkpack/master_files/code/modules/mob/living/living_defines.dm](/modular_darkpack/master_files/code/modules/mob/living/living_defines.dm)
  - `var/list/datum/splat/splats`
- [modular_darkpack/master_files/code/modules/mob/living/living.dm](/modular_darkpack/master_files/code/modules/mob/living/living.dm)
  - `/mob/living/Destroy()`

### Defines:

- [code/\_\_DEFINES/~darkpack/splats.dm](/code/__DEFINES/~darkpack/splats.dm)
- [code/\_\_DEFINES/~darkpack/dcs/splat_signals.dm](/code/__DEFINES/~darkpack/dcs/splat_signals.dm)

### Included files that are not contained in this module:

- [modular_darkpack/modules/unit_tests/apply_all_splats.dm](/modular_darkpack/modules/unit_tests/apply_all_splats.dm)

### Credits:

@TheCarnalest

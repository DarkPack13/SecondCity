https://github.com/DarkPack13/SecondCity/pull/421

## \<Guestbooks>

Module ID: GUESTBOOK

### Description:

This module is for guestbooks, our system that allows people to not know everyone off the bat and set custom names that are persistent across rounds.

### TG Proc/File Changes:

- `code/game/say.dm`
- `code/modules/mob/living/carbon/human/human_helpers.dm`
- `code/modules/unit_tests/surgeries.dm`
- `code/modules/unit_tests/changeling.dm`
- `code/controllers/subsystem/persistence/_persistence.dm`

### Modular Overrides:

- `modular_darkpack/master_files/code/datums/mind/_mind.dm`
- `modular_darkpack/master_files/code/modules/mob/living/carbon/human/init_signals.dm`
- `modular_darkpack/master_files/code/modules/client/preferences_savefile.dm`

### Defines:

- `code/__DEFINES/~darkpack/guestbook.dm`

### Included files that are not contained in this module:

- `tgui/packages/tgui/interfaces/Guestbook.tsx`

### Other module changes:

- `modular_darkpack/modules/jobs/code/_jobs.dm`

### Credits:

thgvr
meemofcourse
XeonMations

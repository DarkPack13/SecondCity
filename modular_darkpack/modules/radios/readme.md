https://github.com/DarkPack13/SecondCity/pull/432

## Title: Darkpack Radios

MODULE ID: RADIOS

### Description:

Adds our own custom radios that use our guestbooks system for communication.

### TG Proc/File Changes:

- `code/_globalvars/admin.dm`
- `code/controllers/subsystem/blackbox.dm`
- `code/datums/brain_damage/imaginary_friend.dm`
- `code/game/machinery/doors/passworddoor.dm`
- `code/game/machinery/telecomms/machines/allinone.dm`
- `code/game/machinery/telecomms/broadcasting.dm`
- `code/game/machinery/telecomms/machine_interactions.dm`
- `code/game/machinery/hologram.dm`
- `code/game/objects/items/devices/radio/headset.dm`
- `code/game/objects/items/devices/radio/intercom.dm`
- `code/game/objects/items/devices/radio/radio.dm`
- `code/game/objects/items/devices/taperecorder.dm`
- `code/game/communications.dm`
- `code/game/say.dm`
- `code/modules/assembly/voice.dm`
- `code/modules/clothing/head/jobs.dm`
- `code/modules/mining/lavaland/mining_loot/megafauna/colossus.dm`
- `code/modules/mob/dead/observer/observer_say.dm`
- `code/modules/mob/living/carbon/human/species_types/dullahan.dm`
- `code/modules/mob/living/silicon/ai/freelook/eye.dm`
- `code/modules/mob/living/living_say.dm`
- `code/modules/mod/mod_link.dm`
- `code/modules/projectiles/ammunition/_firing.dm`
- `code/modules/unit_tests/say.dm`
- `code/modules/wiremod/components/atom/hear.dm`
- `tgui/packages/tgui-panel/chat/constants.ts`
- `tgui/packages/tgui-panel/styles/tgchat/chat-dark.scss`
- `tgui/packages/tgui-panel/styles/tgchat/chat-light.scss`
- `tgui/packages/tgui-say/styles/colors.scss`
- `tgui/packages/tgui-say/constants.ts`

### Modular Overrides:

- `modular_darkpack/master_files/code/game/objects/items/devices/radio/radio.dm`

### Defines:

- `code/__DEFINES/radio.dm`
- `code/__DEFINES/~darkpack/dcs/signals/signals_global.dm`
- `code/__DEFINES/~darkpack/crimes.dm`

### Included files that are not contained in this module:

- `tools/UpdatePaths/Scripts/DarkPack/432_radios.txt`

### Credits:

XeonMations

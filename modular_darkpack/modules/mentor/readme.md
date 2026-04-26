## Title: Mentor

MODULE ID: MENTOR

### Description:

Adds a mentor system, allowing for players to send a-help like messages to mentors, asking them about game mechanics and help.

### TG Proc Changes:

- code/modules/client/client_procs.dm > client/Topic()
- /code/modules/admin/secrets.dm > /datum/admins/proc/Secrets_topic(), /datum/admins/proc/Secrets()

### Defines:

- N/A

### Master file additions

- N/A

### Included files that are not contained in this module:

- `tgui/packages/tgui/interfaces/PreferencesMenu/preferences/features/game_preferences/darkpack_auto_dementor.tsx`

### Credits:

chazzyjazzy - porting to Darkpack

Azarak - Porting, tweaks
Poojawa - Implementation

## <DARKPACK MERITS AND FLAWS>

Module ID: MERITS_FLAWS

### Description:

This module implements Darkpack merits/flaws, allowing users to select negative quirks for extra freebie points to allocate on the stat sheet, or positive quirks to diminish their freebie points on the statsheet. Users cannot go below zero freebie points.

### TG Proc/File Changes:

- `tgui/packages/tgui/interfaces/PreferencesMenu/CharacterPreferences/QuirksPage.tsx`
- `code/modules/client/preferences/middleware/quirks.dm` -- adds two procs, `get_freebie_points()`, `get_quirk_balance()`

### Modular Overrides:

- N/A

### Defines:

- N/A

### Included files that are not contained in this module:

- N/A

### Credits:

chazzyjazzy

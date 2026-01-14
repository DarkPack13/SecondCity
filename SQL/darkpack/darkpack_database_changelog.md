Any time you make a change to the schema files, remember to increment the database schema version. Generally increment the minor number, major should be reserved for significant changes to the schema. Both values go up to 255. Keep this up to date with `../database_changelog.md` and be sure to update that one's latest database version accordingly as well.

Make sure to also update `DB_MAJOR_VERSION` and `DB_MINOR_VERSION`, which can be found in `code/__DEFINES/subsystem.dm`.

The latest database version is 5.34; The query to update the schema revision table is:

```sql
INSERT INTO `schema_revision` (`major`, `minor`) VALUES (5, 34);
```

or

```sql
INSERT INTO `SS13_schema_revision` (`major`, `minor`) VALUES (5, 34);
```

In any query remember to add a prefix to the table names if you use one.

---

Version 5.34, 14 January 2026, by XeonMations, Buffyuwu

```sql
ALTER TABLE `library` MODIFY COLUMN `category` VARCHAR(255);
```

Any time you make a change to the schema files, remember to increment the database schema version. Generally increment the minor number, major should be reserved for significant changes to the schema. Both values go up to 255. Keep this up to date with `../database_changelog.md` and be sure to update that one's latest database version accordingly as well.

Make sure to also update `DB_MAJOR_VERSION` and `DB_MINOR_VERSION`, which can be found in `code/__DEFINES/subsystem.dm`.

The latest database version is 5.35; The query to update the schema revision table is:

```sql
INSERT INTO `schema_revision` (`major`, `minor`) VALUES (5, 36);
```

or

```sql
INSERT INTO `SS13_schema_revision` (`major`, `minor`) VALUES (5, 36);
```

In any query remember to add a prefix to the table names if you use one.

---

Version 5.35, 14 January 2026, by XeonMations, Buffyuwu

```sql
ALTER TABLE `library` MODIFY COLUMN `category` VARCHAR(255);
```

---

Version 5.36, 30 September 2026, by JohnFulpWillard

```sql
DROP TABLE IF EXISTS `library_corax`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `library_corax` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(45) NOT NULL,
  `title` varchar(45) NOT NULL,
  `content` text NOT NULL,
  `category` VARCHAR(255) NOT NULL,
  `ckey` varchar(32) NOT NULL DEFAULT 'LEGACY',
  `datetime` datetime NOT NULL,
  `deleted` tinyint(1) unsigned DEFAULT NULL,
  `round_id_created` int(11) unsigned NULL,
  PRIMARY KEY (`id`),
  KEY `deleted_idx` (`deleted`),
  KEY `idx_lib_id_del` (`id`,`deleted`),
  KEY `idx_lib_del_title` (`deleted`,`title`),
  KEY `idx_lib_search` (`deleted`,`author`,`title`,`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
```

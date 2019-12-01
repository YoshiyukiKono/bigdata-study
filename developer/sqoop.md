# Sqoop

## Import

```
$ sqoop import --connect jdbc:mysql://<hostname>/<dbname> --table <tablename> --username <username> --password <password> \
> -- target-dir <dirpath>
```

### Default configuration
- Format: text
- Separater: comma


Rucio Replicator Functions
==========================

This is to make replicating datasets easier. Example:

```
echo user.cerny.some.data.set.name | rucio-replicate-to CERN-PROD_SCRATCHDISK
```

You can specify multiple destinations (RSEs) as well. The resulting
rule will store the dataset on _at least one_ of them.

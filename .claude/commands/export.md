---
description: "Export all records to JSON and CSV in a new protected directory"
---

# export

Export all records to JSON and CSV in a new protected directory. Contains child records. Never upload or overwrite an earlier export without instruction.

```bash
node scripts/swim.mjs export --out=<new-directory>
```

Read current records. Report facts from the output; ask for missing write values. Read commands accept --json. Ambiguous matches list candidates and exit 1. Nothing sends from this system.

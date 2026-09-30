---
description: "Read docs/replace-iclasspro"
---

# import

Read docs/replace-iclasspro.md. Run the dry run, inspect identities and counts, then repeat without --dry-run. Do not claim a full history import.

```bash
node scripts/swim.mjs import iclasspro <custom-student-list.csv> --dry-run
```

Read current records. Report facts from the output; ask for missing write values. Read commands accept --json. Ambiguous matches list candidates and exit 1. Nothing sends from this system.

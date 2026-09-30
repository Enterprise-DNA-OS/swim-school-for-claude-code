---
description: "Read the family account first"
---

# fee

Read the family account first. Record an approved charge in integer cents. This is a ledger, not payment collection.

```bash
node scripts/swim.mjs fee --code=<invoice> --family=<code> --description="<charge>" --due=YYYY-MM-DD --cents=<integer> --currency=AUD
```

Read current records. Report facts from the output; ask for missing write values. Read commands accept --json. Ambiguous matches list candidates and exit 1. Nothing sends from this system.

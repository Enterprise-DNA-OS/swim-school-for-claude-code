---
description: "Record an already confirmed receipt, never initiate a payment"
---

# receipt

Record an already confirmed receipt, never initiate a payment. Reconcile the balance before and after.

```bash
node scripts/swim.mjs receipt --fee=<invoice> --reference=<external-receipt> --cents=<integer>
```

Read current records. Report facts from the output; ask for missing write values. Read commands accept --json. Ambiguous matches list candidates and exit 1. Nothing sends from this system.

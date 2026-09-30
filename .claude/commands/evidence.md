---
description: "Read docs/compliance"
---

# evidence

Read docs/compliance.md. Record actual verified evidence only; do not open credentials. For student consent and emergency records see docs/cli.md.

```bash
node scripts/swim.mjs evidence <instructor> --status=cleared --verified=YYYY-MM-DD --until=YYYY-MM-DD --reference="<evidence reference>"
```

Read current records. Report facts from the output; ask for missing write values. Read commands accept --json. Ambiguous matches list candidates and exit 1. Nothing sends from this system.

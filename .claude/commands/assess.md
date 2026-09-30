---
description: "Use an instructor observation, never infer skill from attendance"
---

# assess

Use an instructor observation, never infer skill from attendance. --passed=no records a failed skill. Past assessments remain in history.

```bash
node scripts/swim.mjs assess --student=<code> --skill=<skill> --passed=yes --note="<observed result>"
```

Read current records. Report facts from the output; ask for missing write values. Read commands accept --json. Ambiguous matches list candidates and exit 1. Nothing sends from this system.

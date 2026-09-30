---
description: "Read ready-to-move and the full student record"
---

# promote

Read ready-to-move and the full student record. The instructor decides; drop current placements first, then promote and enrol in the new class.

```bash
node scripts/swim.mjs promote <student> --level=<new-level> --note="<instructor decision>"
```

Read current records. Report facts from the output; ask for missing write values. Read commands accept --json. Ambiguous matches list candidates and exit 1. Nothing sends from this system.

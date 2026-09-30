# Swim School for Claude Code

For swim schools and children's lesson businesses. All demonstration children, guardians and instructors are fictional. Read README.md, docs/cli.md and docs/compliance.md before working with records.

## Rules

Read the current record before every write. Use scripts/swim.mjs for recurring work. Never invent attendance, consent, assessments, receipts or verification evidence. Never send messages, collect payments or certify safety. Staff decide level progression and legal applicability. Keep currencies separate. Unmarked attendance means unknown. A timetable conflict needs human review. Do not seed real records or expose credentials. Child records and generated documents need controlled storage, access and retention.

## Routing

- /families: Read guardian contact records.
- /students: Find students and their current levels.
- /levels: Read the school level limits.
- /instructors: Review staff evidence dates.
- /classes: Check capacity and waiting lists before placing a child.
- /lesson-week: Prepare the next seven days of lessons.
- /enrolments: Review active, waiting and dropped placements.
- /waitlist-review: Work through the waiting list in date order. A place still needs a checked enrolment.
- /attendance-watch: Review absence and register coverage together. An unmarked lesson is unknown, never an absence.
- /missing-marks: Reconcile the incomplete rolls with the instructor.
- /progress-review: Review current level requirements and the latest skill results.
- /ready-to-move: Ask an instructor to review children who passed every configured skill.
- /makeups-due: Review unused and expired make-up credits.
- /balances: Reconcile each family charge and receipt in its own currency.
- /fees-due: Prepare tuition follow-ups from open balances.
- /quiet-families: Review enrolled students with no recent contact note.
- /absence-and-fees: Find repeated absence alongside overdue family fees.
- /compliance: Read docs/compliance.md. Review evidence flags with the responsible person. A clear result is not a legal or safety clearance.
- /attention: Prepare the school action list and assign each item an owner.
- /student: Read the student, enrolments, assessment history and notes before changing anything.
- /roster: Print the lesson roll; separate regular and make-up places.
- /makeup-options: Read candidate lessons with the right level, a spare place and a date within credit validity. Confirm location and timetable conflicts with staff before booking.
- /add: Read docs/cli.md for each required field. Resolve related records first. Never guess a child identity or invent staff evidence.
- /enrol: Read the student and class first. Use --status=waitlisted when staff request a waiting place. Verify location, time and level. Capacity is checked again inside the write.
- /drop: Read the existing placement and confirm the requested change. Ends the placement today and retains earlier rolls. Do not erase history.
- /promote: Read ready-to-move and the full student record. The instructor decides; drop current placements first, then promote and enrol in the new class.
- /schedule: Read the class term and instructor timetable first. Each date is a local lesson date; check location and conflicts manually.
- /mark: Read the roll, confirm the instructor evidence, then mark present, absent or excused. Missing is unknown. Future marks fail.
- /assess: Use an instructor observation, never infer skill from attendance. --passed=no records a failed skill. Past assessments remain in history.
- /evidence: Read docs/compliance.md. Record actual verified evidence only; do not open credentials. For student consent and emergency records see docs/cli.md.
- /fee: Read the family account first. Record an approved charge in integer cents. This is a ledger, not payment collection.
- /receipt: Record an already confirmed receipt, never initiate a payment. Reconcile the balance before and after.
- /log: Read the student and log the operator-provided contact, keeping child details to what is necessary.
- /issue-makeup: Read the recorded absence. Apply the school credit policy and issue once. No automatic credit entitlement is assumed.
- /book-makeup: Read makeup-options and the target roll. Verify location and time with the guardian. The write checks level, validity and capacity again.
- /draft-follow-up: Write a draft under drafts. Review the recipient and facts, remove the internal note, and show the draft to the operator. Never send.
- /import: Read docs/replace-iclasspro.md. Run the dry run, inspect identities and counts, then repeat without --dry-run. Do not claim a full history import.
- /export: Export all records to JSON and CSV in a new protected directory. Contains child records. Never upload or overwrite an earlier export without instruction.
- /weekly-review: Write a Monday note from these four fresh reads: lesson places, missing marks and absence, balances, staff evidence. Name an owner and next step. Save drafts/weekly-review.md. Never invent counts or send.
- /customise: Read CLAUDE.md, docs/cli.md and the existing migrations. Translate the requested field, stage or policy into a new numbered migration. Do not rewrite an applied migration. Show the planned change, apply to a backup or demo first, update relevant commands and tests. For legal rules re-open the cited source and verify applicability before changing it.
- /new-view: Read views.json and the database views. Add a named read-only query for the requested question and a views.json entry. Use the shared renderer and brand.json. Test with demo data and inspect the HTML. Never build a front end.

All recipes live in .claude/commands. Other coding agents read AGENTS.md and these same recipes. Schema changes are new migrations. Drafts go in drafts. Applied migrations and historical attendance must not be rewritten.

Built and run through Omni by Enterprise DNA.

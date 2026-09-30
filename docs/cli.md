# CLI guide

Run npm run migrate before first use. npm run demo seeds fictional data. Never seed a live database. Read commands accept --json. Command dates are YYYY-MM-DD; lesson dates and times use the school's local timetable, while evidence dates use UTC for today comparisons. Check timetable conflicts manually; there is no time-zone or instructor clash engine.

## Read commands

- `families`: Read guardian contact records.
- `students`: Find students and their current levels.
- `levels`: Read the school level limits.
- `instructors`: Review staff evidence dates.
- `classes`: Check capacity and waiting lists before placing a child.
- `lesson-week`: Prepare the next seven days of lessons.
- `enrolments`: Review active, waiting and dropped placements.
- `waitlist-review`: Work through the waiting list in date order. A place still needs a checked enrolment.
- `attendance-watch`: Review absence and register coverage together. An unmarked lesson is unknown, never an absence.
- `missing-marks`: Reconcile the incomplete rolls with the instructor.
- `progress-review`: Review current level requirements and the latest skill results.
- `ready-to-move`: Ask an instructor to review children who passed every configured skill.
- `makeups-due`: Review unused and expired make-up credits.
- `balances`: Reconcile each family charge and receipt in its own currency.
- `fees-due`: Prepare tuition follow-ups from open balances.
- `quiet-families`: Review enrolled students with no recent contact note.
- `absence-and-fees`: Find repeated absence alongside overdue family fees.
- `compliance`: Read docs/compliance.md. Review evidence flags with the responsible person. A clear result is not a legal or safety clearance.
- `attention`: Prepare the school action list and assign each item an owner.

## Writes

```bash
npm run swim -- add family --code=F-10 --name="Demo family" --email=family@example.test
npm run swim -- add level --code=L-10 --name="Beginner" --capacity=4
npm run swim -- add student --code=S-10 --name="Demo Child" --family=F-10 --level=L-10 --dob=2019-01-01
npm run swim -- add instructor --code=I-10 --name="Demo Instructor" --jurisdiction=NSW
npm run swim -- add class --code=C-10 --name="Term beginners" --level=L-10 --instructor=I-10 --location=Sydney --from=2026-09-01 --to=2026-12-20 --capacity=4
npm run swim -- add skill --code=SK-10 --name="Safe entry" --level=L-10
npm run swim -- enrol --student=S-10 --class=C-10 --status=active --from=2026-09-30
npm run swim -- schedule --code=LESSON-10 --class=C-10 --date=2026-09-30 --time=09:00 --minutes=30
npm run swim -- mark --student=S-10 --session=LESSON-10 --status=absent --note="Instructor roll"
npm run swim -- assess --student=S-10 --skill=SK-10 --passed=yes --note="Instructor observed safe entry"
npm run swim -- issue-makeup --student=S-10 --session=LESSON-10 --code=MK-10 --expires=2026-10-30
npm run swim -- makeup-options MK-10
npm run swim -- book-makeup MK-10 --session=<eligible-lesson>
npm run swim -- drop --student=S-10 --class=C-10 --note="Level complete"
npm run swim -- promote S-10 --level=L-2 --note="Instructor approved next level"
npm run swim -- evidence I-10 --status=cleared --verified=2026-09-30 --until=2030-09-30 --reference=DEMO-VERIFICATION --first-aid=2027-09-30
npm run swim -- evidence student S-10 --emergency="Demo Guardian, confirmed contact" --consent=DEMO-CONSENT
npm run swim -- fee --code=INV-10 --family=F-10 --description="Term lessons" --due=2026-10-01 --cents=12000 --currency=AUD
npm run swim -- receipt --fee=INV-10 --reference=CONFIRMED-RECEIPT --cents=6000
npm run swim -- log S-10 --note="Guardian confirmed lesson time"
npm run swim -- draft-follow-up S-10
```

These dates are examples. Use real verified dates, not the example values. Evidence accepts cleared, application, unknown or barred. --nz-required=yes on add instructor applies the NZ statutory reminder only when staff have established applicability. Application status in NSW is shown for human review; the program does not authorise employment.

Class capacity is the smaller of the class limit and the level policy limit. Active places reserve the whole class term; make-up bookings also consume lesson capacity. A dropped enrolment retains earlier rolls and cannot be reused; use a new class term. Existing future make-ups must be reviewed separately when a child leaves. No automatic refunds, cancellations or removal of credits occur. Correcting issued credits or posted ledger errors needs a reviewed migration, preserving an audit record.

## Import and export

Read replace-iclasspro.md before import. export --out=<new-directory> emits a consistent JSON snapshot and one CSV per entity. CSV is raw data; open it as text when source fields begin with spreadsheet formulas. Exports contain child records. Store them under the same access rules as the database. They are portable records, not a one-command restore utility.

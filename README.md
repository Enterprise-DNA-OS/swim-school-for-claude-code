# Swim School for Claude Code

Families, lesson places, attendance, skill progress, make-up credits and fees in a database your swim school owns. MIT licence. Built by Enterprise DNA.

| Do it yourself | We customise it | We run it for you |
|---|---|---|
| Free code, your database and installation. | Your fields, lesson policies, imported history, preferred stack and parent front end if needed. | Installed, connected and operated through Omni by Enterprise DNA. One setup fee, then a retainer. |
| [Quick start](#quick-start) | [Get your version built](https://enterprisedna.co/omni/book?offer=replace-software&utm_campaign=iclasspro) | [Book a call](https://enterprisedna.co/omni/book?offer=replace-software&utm_campaign=iclasspro) |

Use Claude Code, Codex, OpenCode or Cursor. Each reads the same AGENTS.md, CLAUDE.md and command recipes.

## Quick start

Node 20 or newer:

```bash
git clone https://github.com/Enterprise-DNA-OS/swim-school-for-claude-code.git
cd swim-school-for-claude-code
npm install
npm test
npm run demo
npm run view
npm run docs
```

The fictional Harbour Swim School has five children, three families, two instructors and three class groups. It includes a full class, a waiting student, repeated absence, a missing attendance mark, expired make-up credit, overdue fees and safety evidence needing renewal. Dates are relative on the first seed. Repeating the seed retains existing records.

Ask /lesson-week, /makeups-due or /weekly-review. [CLI examples](docs/cli.md) show every write.

For real records, use a fresh DATA_DIR and run npm run migrate without seeding. DATABASE_URL connects to your own PostgreSQL database; otherwise embedded PGlite stores records on disk and permits one process at a time. Configure access, encryption, backups and retention before storing child records. Hosting and agent subscriptions cost separately.

## What works today

Class and level capacity checks, waiting lists, dated lesson rolls, attendance, instructor-reviewed skill assessment and progression, make-up credit issuance and booking, family charges and receipt reconciliation. No money moves. Child safety checks are evidence reminders with cited NSW and NZ scope, not regulator verification or permission to work.

The free base supports staff administration. It does not reproduce every iClassPro feature. Portal registration, card processing, mobile check-in, staff clocking and messaging are outside this base. See [scope](docs/why-no-front-end.md). No claim is made that iClassPro cannot produce equivalent reports.

## Commands

/absence-and-fees, /add, /assess, /attendance-watch, /attention, /balances, /book-makeup, /classes, /compliance, /customise, /draft-follow-up, /drop, /enrol, /enrolments, /evidence, /export, /families, /fee, /fees-due, /import, /instructors, /issue-makeup, /lesson-week, /levels, /log, /makeup-options, /makeups-due, /mark, /missing-marks, /new-view, /progress-review, /promote, /quiet-families, /ready-to-move, /receipt, /roster, /schedule, /student, /students, /waitlist-review, /weekly-review

Every read accepts --json. Names match without case sensitivity; partial identifiers work. Ambiguity lists candidates and exits 1. Unknown commands fail.

## Paperwork and views

brand.json controls the school name, colours and optional logo. npm run docs creates lesson rolls, family statements, student progress reports and make-up letters. Staff review every document. npm run view renders the school week, attendance and evidence dashboards as read-only HTML. Draft follow-ups stay under drafts and never send.

## Ten questions you can ask today

Supported questions, not unverified claims about the incumbent:

1. Which children have repeated absences and overdue family fees? (`absence-and-fees`)
2. Which lessons still have an unmarked child on the roll? (`missing-marks`)
3. Who passed every skill in their current level? (`ready-to-move`)
4. Which waiting students are attached to a class with space? (`waitlist-review`)
5. Which unused make-up credits expire next? (`makeups-due`)
6. Which eligible lessons have room for a particular make-up credit? (`makeup-options MK-01`)
7. Which instructors need a safety-check evidence review? (`compliance`)
8. Which enrolled students have no recent guardian contact note? (`quiet-families`)
9. Which family charges still have a balance, in each currency? (`balances`)
10. Which children have no assessment in their current level? (`progress-review`)

## Your first hour: ten things to ask for

1. Put our school name and logo on the statements.
2. Import a small iClassPro student export as a test.
3. Match our swim levels and class limits.
4. Add the skills our instructors assess.
5. Add this term's class groups and dated lessons.
6. Record our make-up credit policy.
7. Review our staff evidence requirements by jurisdiction.
8. Add a preferred guardian contact method.
9. Create a view of one location's missing marks.
10. Map the remaining attendance and fee history for reconciliation.

/customise writes a migration and applies it after a demo check. /new-view adds a read-only report. No front end is required for the staff workflows.

## Switch from iClassPro

The built-in importer reads selected columns from the documented Custom Student List CSV. It loads children and primary guardians in one command. It does not import historical lessons, assessments, balances or verification evidence. The report has no documented stable student key in the supported columns, so matching uses guardian name, email, child name and birthday. Changed identity fields need manual reconciliation. See the [replace guide](docs/replace-iclasspro.md).

```bash
npm run swim -- import iclasspro examples/custom-student-list.csv --dry-run
npm run swim -- import iclasspro examples/custom-student-list.csv
npm run swim -- export --out=./first-export
```

## Validation

npm test uses a temporary database and checks reads and writes, full classes, level progression, missing attendance, make-up validity, exact balances, duplicate receipts, import repeatability and rollback, export and branded documents. CI runs on Windows and Linux and against PostgreSQL, including concurrent enrolment capacity. Local test results and CI outcomes are reported separately.

[30 minutes with Sam](https://enterprisedna.co/omni/book?offer=replace-software&utm_campaign=iclasspro) to look at the lessons, the bill and what your version needs.

# Bring an iClassPro student list across

Source checked 2026-09-30: [iClassPro Custom Student List](https://support.iclasspro.com/hc/en-us/articles/12715617570711-What-is-the-Custom-Student-List). iClassPro documents selectable report columns and a CSV output. This importer covers students and primary guardians only.

1. In iClassPro open Reports, Students, Custom Student List. Choose the active and inactive scope you need and save those filters for reconciliation.
2. Select Student Name, Primary Guardian Name, Primary Email, Primary Phone Number and Birthday. Generate CSV. Keep the source unchanged. Names may use the vendor's default last-name-first format; the importer preserves them.
3. Use a fresh migrated database without demo records. Run the dry run below. ISO birthdays need no date flag; for slash dates specify dmy or mdy explicitly.
4. Review counts and identities. Run without --dry-run and compare every imported child and guardian. Create and verify levels, classes and placements separately before the first lesson.

```bash
npm run swim -- import iclasspro ./custom-student-list.csv --date-order=dmy --dry-run
npm run swim -- import iclasspro ./custom-student-list.csv --date-order=dmy
```

| Vendor field | Destination |
|---|---|
| Student Name | Student name, preserved as exported |
| Birthday | Student birth date, strict ISO or explicitly selected slash-date order |
| Primary Guardian Name | Family display name |
| Primary Email | Family email and part of import identity |
| Primary Phone Number | Family phone |

Names, guardian email and birthday are required. A source row without one fails the whole import so staff can resolve it. Duplicate identities in one file fail. Exact repeats do not duplicate records or overwrite later edits. Identity matching uses primary guardian name plus email, student name and birthday because the supported report columns lack a documented durable student identifier. A changed birthday with the same name and email is rejected. Changed names or emails can look like new people, so reconcile those manually before reimporting. The synthetic codes are not iClassPro IDs.

The example fixture uses the documented headers and fictional values. It is not a captured customer export. Unexpected headers, locale choices and vendor changes require a reviewed mapping.

## What needs separate mapping

Enrolment history, schedules, attendance, all skill assessments, financial transactions, secondary guardians, medical information, policy acceptance, make-up credits, uploaded documents, custom fields and payment credentials do not carry over in this importer. Do not treat the report's Balance Due as a reconciled ledger or a concatenated activity list as dated enrolments. Do not infer consent or safety evidence from a name.

The first student load is one command after selecting the report columns. A complete switch needs reconciled history, agreed payments and parent arrangements, access controls and a parallel run. Enterprise DNA maps that wider migration as part of a custom version. Keep iClassPro until staff have verified the required records and workflows.

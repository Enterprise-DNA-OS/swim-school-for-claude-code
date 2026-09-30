# Why no front end

This is a staff records system for a swim school, operated through a coding agent and one CLI. Read-only HTML gives the manager the week, attendance gaps, level progress, open fees and staff evidence. It is not an interactive application.

An incumbent's screens also provide mobile roll marking, parent self-service, offline work, drag-and-drop scheduling, payment collection and live messaging. Those are not in this free base. Staff verify timetable conflicts manually. This build fits the school that wants owned records and staff-led workflows; parent-facing registration and payments still need separate arrangements.

Enterprise DNA can build a parent front end, connections and the school's own workflows as a custom project through Omni by Enterprise DNA. That work is scoped and tested separately.

brand.json changes the school name, logo and colours. npm run view and npm run docs generate local HTML files. /new-view adds a read-only query and renderer entry. No server or web framework is required.

create table families (
 id uuid primary key default gen_random_uuid(), code text not null unique, name text not null,
 email text, phone text, created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table levels (
 id uuid primary key default gen_random_uuid(), code text not null unique, name text not null,
 max_students integer not null check(max_students>0), created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table students (
 id uuid primary key default gen_random_uuid(), code text not null unique, family_id uuid not null references families,
 name text not null, dob date, level_id uuid references levels, emergency_contact text, consent_ref text,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table instructors (
 id uuid primary key default gen_random_uuid(), code text not null unique, name text not null,
 jurisdiction text not null check(jurisdiction in ('NSW','NZ','OTHER')), nz_required boolean not null default false,
 check_status text not null default 'unknown' check(check_status in ('unknown','cleared','application','barred')),
 verified_on date, check_until date, evidence_ref text, first_aid_until date,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now(),
 check(check_until is null or verified_on is null or check_until>=verified_on)
);
create table classes (
 id uuid primary key default gen_random_uuid(), code text not null unique, name text not null,
 level_id uuid not null references levels, instructor_id uuid not null references instructors, location text not null,
 starts_on date not null, ends_on date not null, capacity integer not null check(capacity>0),
 created_at timestamptz not null default now(), updated_at timestamptz not null default now(), check(ends_on>=starts_on)
);
create table enrolments (
 id uuid primary key default gen_random_uuid(), student_id uuid not null references students, class_id uuid not null references classes,
 status text not null check(status in ('active','waitlisted','dropped')), joined_on date not null default current_date, ended_on date,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now(), unique(student_id,class_id)
);
create table sessions (
 id uuid primary key default gen_random_uuid(), code text not null unique, class_id uuid not null references classes,
 on_date date not null, starts_at time not null, minutes integer not null check(minutes>0),
 created_at timestamptz not null default now(), updated_at timestamptz not null default now(), unique(class_id,on_date,starts_at)
);
create table attendance (
 id uuid primary key default gen_random_uuid(), student_id uuid not null references students, session_id uuid not null references sessions,
 status text not null check(status in ('present','absent','excused')), note text,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now(), unique(student_id,session_id)
);
create table skills (
 id uuid primary key default gen_random_uuid(), code text not null unique, level_id uuid not null references levels, name text not null,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table assessments (
 id uuid primary key default gen_random_uuid(), student_id uuid not null references students, skill_id uuid not null references skills,
 on_date date not null default current_date, passed boolean not null, note text not null,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now(), unique(student_id,skill_id,on_date)
);
create table makeups (
 id uuid primary key default gen_random_uuid(), code text not null unique, attendance_id uuid not null unique references attendance,
 expires_on date not null, booked_session_id uuid references sessions,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table fees (
 id uuid primary key default gen_random_uuid(), code text not null unique, family_id uuid not null references families,
 description text not null, due_on date not null, amount_cents integer not null check(amount_cents>0), currency text not null check(currency in ('AUD','NZD','USD')),
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table receipts (
 id uuid primary key default gen_random_uuid(), reference text not null unique, fee_id uuid not null references fees,
 amount_cents integer not null check(amount_cents>0), received_on date not null default current_date,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table notes (
 id uuid primary key default gen_random_uuid(), student_id uuid not null references students, note text not null,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create function touch_updated_at() returns trigger language plpgsql as $$ begin new.updated_at=clock_timestamp(); return new; end $$;
do $$ declare t text; begin foreach t in array array['families','levels','students','instructors','classes','enrolments','sessions','attendance','skills','assessments','makeups','fees','receipts','notes'] loop execute format('create trigger touch before update on %I for each row execute function touch_updated_at()',t); end loop; end $$;
create index on enrolments(class_id,status);
create index on sessions(on_date);
create index on assessments(student_id,skill_id,on_date desc);
create view class_capacity as
 select c.id,c.code,c.name,l.name level,i.name instructor,c.location,c.starts_on,c.ends_on,
 least(c.capacity,l.max_students) capacity,
 (select count(*) from enrolments e where e.class_id=c.id and e.status='active') enrolled,
 least(c.capacity,l.max_students)-(select count(*) from enrolments e where e.class_id=c.id and e.status='active') places,
 (select count(*) from enrolments e where e.class_id=c.id and e.status='waitlisted') waiting
 from classes c join levels l on l.id=c.level_id join instructors i on i.id=c.instructor_id;
create view lesson_roster as
 select s.id session_id,s.code session,s.on_date,s.starts_at,c.id class_id,c.code class,st.id student_id,st.code student_code,st.name student,'regular'::text booking
 from sessions s join classes c on c.id=s.class_id join enrolments e on e.class_id=c.id and e.status in ('active','dropped') and e.joined_on<=s.on_date and (e.ended_on is null or s.on_date<e.ended_on) join students st on st.id=e.student_id
 union
 select s.id,s.code,s.on_date,s.starts_at,c.id,c.code,st.id,st.code,st.name,'makeup'::text
 from makeups m join attendance a on a.id=m.attendance_id join students st on st.id=a.student_id join sessions s on s.id=m.booked_session_id join classes c on c.id=s.class_id;
create view attendance_watch as
 select st.id,st.code,st.name,
 count(r.session_id) scheduled,count(a.id) marked,
 count(*) filter(where r.session_id is not null and a.id is null) missing,
 count(*) filter(where a.status in ('absent','excused')) absent,
 max(r.on_date) filter(where a.status='present') last_present
 from students st left join lesson_roster r on r.student_id=st.id and r.on_date<=current_date
 left join attendance a on a.student_id=st.id and a.session_id=r.session_id group by st.id,st.code,st.name;
create view fee_balances as
 select f.id,f.code,f.family_id,fa.name family,f.description,f.due_on,f.currency,f.amount_cents,
 f.amount_cents-coalesce((select sum(r.amount_cents) from receipts r where r.fee_id=f.id),0) balance_cents
 from fees f join families fa on fa.id=f.family_id;
create view skill_progress as
 select st.id,st.code,st.name,l.name level,count(sk.id) required,
 count(sk.id) filter(where a.passed) passed,max(a.on_date) last_assessed
 from students st left join levels l on l.id=st.level_id left join skills sk on sk.level_id=l.id
 left join lateral(select x.passed,x.on_date from assessments x where x.student_id=st.id and x.skill_id=sk.id order by x.on_date desc limit 1) a on true
 group by st.id,st.code,st.name,l.name;
create view makeup_queue as
 select m.id,m.code,st.code student_code,st.name student,l.name level,m.expires_on,s.code booked_session,
 case when m.booked_session_id is not null then 'booked' when m.expires_on<current_date then 'expired' else 'available' end status
 from makeups m join attendance a on a.id=m.attendance_id join students st on st.id=a.student_id left join levels l on l.id=st.level_id left join sessions s on s.id=m.booked_session_id;
create view compliance_flags as
 select i.code subject,'NSW_WWCC'::text rule,'Review online verification, status and clearance dates'::text finding from instructors i where i.jurisdiction='NSW' and
 (i.check_status not in ('cleared','application') or i.verified_on is null or i.evidence_ref is null or (i.check_status='cleared' and (i.check_until is null or i.check_until<current_date)))
 union all select code,'NZ_SAFETY','Review full safety-check evidence and three-year renewal' from instructors where jurisdiction='NZ' and nz_required and (verified_on is null or evidence_ref is null or check_status<>'cleared' or verified_on+interval '3 years'<=current_date)
 union all select code,'POLICY_FIRST_AID','Review first-aid evidence under school policy' from instructors where first_aid_until is null or first_aid_until<current_date
 union all select code,'POLICY_CONTACT','Emergency contact or consent evidence missing' from students where nullif(emergency_contact,'') is null or nullif(consent_ref,'') is null
 union all select code,'POLICY_CAPACITY','Enrolment exceeds configured class or level limit' from class_capacity where places<0;

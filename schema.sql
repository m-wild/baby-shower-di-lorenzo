/*
drop function take_gift;
drop function release_gift;
drop view my_gifts;
drop table gifts;
*/

create table gifts (
    rowid    serial      not null primary key,
    id       uuid        not null unique default uuid_generate_v4(),
    title    text        not null,
    descr    text        null,
    taken_by uuid        null references auth.users (id),
    taken_at timestamptz null,
    multi    boolean     not null default false
);

alter table gifts enable row level security;

create policy "Everyone can view gifts"
    on gifts for select
    to anon, authenticated
    using (true);

create view my_gifts 
    with (security_invoker = true)
    as
    select
    *,
    coalesce(taken_by = auth.uid(), false) as taken_by_me,
    coalesce(taken_by != coalesce(auth.uid(), '00000000-0000-0000-0000-000000000000'::uuid), false) as taken_by_other
    from gifts;

create or replace function take_gift(gift_id uuid)
    returns public.my_gifts
    language sql
    security definer
    as $$
        update my_gifts
        set
            taken_by = auth.uid(),
            taken_at = current_timestamp
        where id = gift_id
        and taken_by is null
        and auth.uid() is not null
        returning *;
    $$;

create or replace function release_gift(gift_id uuid)
    returns public.my_gifts
    language sql
    security definer
    as $$
        update my_gifts
        set
            taken_by = null,
            taken_at = null
        where id = gift_id
        and taken_by = auth.uid()
        returning *;
    $$;

/* Sample Data

insert into gifts (title) values ('Baby Towels');
insert into gifts (title, descr) values ('Sleeping Bags', '0-3 months, for hot weather');
insert into gifts (title, descr) values ('Changing Mat', 'For out and about');
insert into gifts (title, descr, multi) values ('Nappy Rash Cream', 'Sudocream', true);
insert into gifts (title, descr) values ('Baby Soap', 'Aveeno');

update gifts set taken_by = '36380f2e-2b86-489f-ad72-bedb3e2653c1', taken_at = current_timestamp where title = 'Sleeping Bags';
update gifts set taken_by = '92deee1d-3e25-4c90-9bf6-7ce8bdaf5284', taken_at = current_timestamp where title = 'Changing Mat';

*/
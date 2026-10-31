-- Jaktlagsappen ver1.1 - avskjutningsmal i molnet
create table if not exists public.goals (
  id text primary key,
  team_id text not null,
  created_by uuid references auth.users(id) default auth.uid(),
  hunting_year text not null,
  species text not null,
  adult_target integer not null default 0,
  young_target integer not null default 0,
  period_start text not null,
  period_end text not null,
  updated_at timestamptz not null default now(),
  unique(team_id, hunting_year, species)
);
create index if not exists goals_team_year_idx on public.goals(team_id,hunting_year);
alter table public.goals enable row level security;
drop policy if exists goals_read on public.goals;
drop policy if exists goals_insert on public.goals;
drop policy if exists goals_update on public.goals;
drop policy if exists goals_delete on public.goals;
create policy goals_read on public.goals for select to authenticated using (true);
create policy goals_insert on public.goals for insert to authenticated with check (created_by=auth.uid());
create policy goals_update on public.goals for update to authenticated using (true) with check (true);
create policy goals_delete on public.goals for delete to authenticated using (true);

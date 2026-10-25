-- Ejecutar una sola vez en Supabase > SQL Editor.
-- Cada usuario puede leer y modificar únicamente su propia fila.
create table if not exists public.app_data (
  user_id uuid primary key references auth.users (id) on delete cascade,
  cards jsonb not null default '[]'::jsonb check (jsonb_typeof(cards) = 'array'),
  expenses jsonb not null default '[]'::jsonb check (jsonb_typeof(expenses) = 'array'),
  updated_at timestamptz not null default now()
);

alter table public.app_data enable row level security;

revoke all on table public.app_data from anon, authenticated;
grant select, insert, update on table public.app_data to authenticated;

drop policy if exists "Users read their own app data" on public.app_data;
create policy "Users read their own app data"
  on public.app_data for select to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users create their own app data" on public.app_data;
create policy "Users create their own app data"
  on public.app_data for insert to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users update their own app data" on public.app_data;
create policy "Users update their own app data"
  on public.app_data for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);


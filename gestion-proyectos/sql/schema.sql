-- ============================================================
-- Sistema de Gestión de Proyectos TI - ARQUIE
-- Esquema completo: tablas, roles, RLS y alta automática de usuarios.
-- Ejecutar una sola vez en Supabase: Dashboard → SQL Editor → New query → pegar todo → Run.
-- ============================================================

-- ---------- 1. Perfiles de usuario (roles) ----------
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  email text not null,
  full_name text default '',
  role text not null default 'pendiente'
    check (role in ('admin', 'lider', 'asistente', 'finanzas', 'pendiente')),
  created_at timestamptz not null default now()
);

comment on table public.profiles is 'Un registro por usuario del equipo, con su rol (Admin/Líder/Asistente/Finanzas). Los nuevos usuarios entran en "pendiente" hasta que un Admin les asigna rol.';

-- Función auxiliar: rol del usuario que hace la petición (evita recursión en RLS).
create or replace function public.get_my_role()
returns text
language sql
security definer
stable
set search_path = public
as $$
  select role from public.profiles where id = auth.uid()
$$;

-- Alta automática de perfil cuando alguien se registra (Supabase Auth → auth.users).
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, full_name, role)
  values (new.id, new.email, coalesce(new.raw_user_meta_data->>'full_name', ''), 'pendiente');
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- ---------- 2. Catálogos ----------
create table if not exists public.statuses (
  id bigint generated always as identity primary key,
  name text not null unique,
  description text default '',
  color text default '#378ADD',
  active boolean not null default true,
  sort_order int default 0
);

create table if not exists public.stages (
  id bigint generated always as identity primary key,
  name text not null unique,
  description text default '',
  color text default '#378ADD',
  active boolean not null default true,
  sort_order int default 0
);

insert into public.statuses (name, description, sort_order) values
  ('Pendiente', 'Estado Pendiente del proyecto', 1),
  ('Activo', 'Estado Activo del proyecto', 2),
  ('Pausado', 'Estado Pausado del proyecto', 3),
  ('Finalizado', 'Estado Finalizado del proyecto', 4)
on conflict (name) do nothing;

insert into public.stages (name, description, sort_order) values
  ('Relevamiento', 'Etapa de relevamiento', 1),
  ('Diseño', 'Etapa de diseño', 2),
  ('Desarrollo', 'Etapa de desarrollo', 3),
  ('Testing', 'Etapa de testing', 4),
  ('Despliegue', 'Etapa de despliegue', 5),
  ('Cierre', 'Etapa de cierre', 6)
on conflict (name) do nothing;

-- ---------- 3. Proyectos ----------
create table if not exists public.projects (
  id bigint generated always as identity primary key,
  name text not null,
  client text not null,
  service text not null,
  status text not null default 'Pendiente',
  start_date date not null,
  end_date date,
  expected_cycle int not null,
  stage text not null,
  drive_link text default '',
  created_by uuid references public.profiles(id),
  created_at timestamptz not null default now()
);

-- ---------- 4. Riesgos ----------
create table if not exists public.risks (
  id bigint generated always as identity primary key,
  project_id bigint not null references public.projects(id) on delete cascade,
  correlative int not null default 1,
  detail text not null,
  impact text not null check (impact in ('Bajo', 'Medio', 'Alto', 'Crítico')),
  probability text not null check (probability in ('Baja', 'Media', 'Alta')),
  score int not null default 0,
  status text not null default 'Abierto',
  is_closed boolean not null default false,
  mitigation text default '',
  registration_date date not null default current_date,
  created_by uuid references public.profiles(id),
  created_at timestamptz not null default now()
);

-- ---------- 5. Hitos / Bitácora ----------
create table if not exists public.milestones (
  id bigint generated always as identity primary key,
  project_id bigint not null references public.projects(id) on delete cascade,
  name text not null,
  stage text not null,
  responsible text not null,
  planned_date date not null,
  actual_date date,
  status text not null default 'Programado',
  progress int not null default 0 check (progress between 0 and 100),
  invoices text default '',
  lessons_learned text default '',
  created_by uuid references public.profiles(id),
  created_at timestamptz not null default now()
);

-- ---------- 6. Auditoría ----------
create table if not exists public.audit_log (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  user_email text not null,
  project_name text default '',
  type text not null,
  from_status text default '-',
  to_status text default '-',
  comment text default ''
);

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================
alter table public.profiles enable row level security;
alter table public.statuses enable row level security;
alter table public.stages enable row level security;
alter table public.projects enable row level security;
alter table public.risks enable row level security;
alter table public.milestones enable row level security;
alter table public.audit_log enable row level security;

-- ---------- profiles ----------
-- Cualquier usuario ve su propio perfil; cualquiera con rol asignado ve a todo el equipo.
drop policy if exists "profiles_select" on public.profiles;
create policy "profiles_select" on public.profiles
  for select using (auth.uid() = id or public.get_my_role() <> 'pendiente');

-- Solo Admin cambia roles/datos de otros usuarios.
drop policy if exists "profiles_update_admin" on public.profiles;
create policy "profiles_update_admin" on public.profiles
  for update using (public.get_my_role() = 'admin');

-- ---------- statuses / stages (catálogos) ----------
drop policy if exists "catalog_select" on public.statuses;
create policy "catalog_select" on public.statuses
  for select using (public.get_my_role() <> 'pendiente');

drop policy if exists "catalog_write" on public.statuses;
create policy "catalog_write" on public.statuses
  for all using (public.get_my_role() = 'admin') with check (public.get_my_role() = 'admin');

drop policy if exists "stages_select" on public.stages;
create policy "stages_select" on public.stages
  for select using (public.get_my_role() <> 'pendiente');

drop policy if exists "stages_write" on public.stages;
create policy "stages_write" on public.stages
  for all using (public.get_my_role() = 'admin') with check (public.get_my_role() = 'admin');

-- ---------- projects ----------
-- Admin y Líder crean/editan/eliminan. Todos los roles con acceso (no pendientes) pueden ver.
drop policy if exists "projects_select" on public.projects;
create policy "projects_select" on public.projects
  for select using (public.get_my_role() <> 'pendiente');

drop policy if exists "projects_insert" on public.projects;
create policy "projects_insert" on public.projects
  for insert with check (public.get_my_role() in ('admin', 'lider'));

drop policy if exists "projects_update" on public.projects;
create policy "projects_update" on public.projects
  for update using (public.get_my_role() in ('admin', 'lider'));

drop policy if exists "projects_delete" on public.projects;
create policy "projects_delete" on public.projects
  for delete using (public.get_my_role() = 'admin');

-- ---------- risks ----------
-- Admin, Líder y Asistente crean/editan. Solo Admin y Líder eliminan.
drop policy if exists "risks_select" on public.risks;
create policy "risks_select" on public.risks
  for select using (public.get_my_role() <> 'pendiente');

drop policy if exists "risks_insert" on public.risks;
create policy "risks_insert" on public.risks
  for insert with check (public.get_my_role() in ('admin', 'lider', 'asistente'));

drop policy if exists "risks_update" on public.risks;
create policy "risks_update" on public.risks
  for update using (public.get_my_role() in ('admin', 'lider', 'asistente'));

drop policy if exists "risks_delete" on public.risks;
create policy "risks_delete" on public.risks
  for delete using (public.get_my_role() in ('admin', 'lider'));

-- ---------- milestones ----------
-- Admin, Líder y Asistente crean hitos y eliminan (Líder+Admin eliminan).
-- Finanzas también puede actualizar (la app restringe en la UI a los campos de
-- facturación; a nivel de base de datos el permiso de UPDATE es de fila completa,
-- documentado como límite conocido — ver README).
drop policy if exists "milestones_select" on public.milestones;
create policy "milestones_select" on public.milestones
  for select using (public.get_my_role() <> 'pendiente');

drop policy if exists "milestones_insert" on public.milestones;
create policy "milestones_insert" on public.milestones
  for insert with check (public.get_my_role() in ('admin', 'lider', 'asistente'));

drop policy if exists "milestones_update" on public.milestones;
create policy "milestones_update" on public.milestones
  for update using (public.get_my_role() in ('admin', 'lider', 'asistente', 'finanzas'));

drop policy if exists "milestones_delete" on public.milestones;
create policy "milestones_delete" on public.milestones
  for delete using (public.get_my_role() in ('admin', 'lider'));

-- ---------- audit_log ----------
drop policy if exists "audit_select" on public.audit_log;
create policy "audit_select" on public.audit_log
  for select using (public.get_my_role() <> 'pendiente');

drop policy if exists "audit_insert" on public.audit_log;
create policy "audit_insert" on public.audit_log
  for insert with check (public.get_my_role() <> 'pendiente');

-- ============================================================
-- PASO MANUAL FINAL (hazlo tú, una sola vez):
-- El primer usuario que se registre queda en rol "pendiente" (nadie puede
-- promoverlo porque solo un Admin puede cambiar roles, y todavía no hay
-- ninguno). Regístrate primero desde la pantalla de login de la app y luego
-- ejecuta esto reemplazando el correo:
--
--   update public.profiles set role = 'admin' where email = 'tu-correo@dominio.com';
--
-- Desde ahí, ya puedes asignar roles al resto del equipo desde la pestaña
-- "Usuarios" de la aplicación (solo visible para Admin).
-- ============================================================

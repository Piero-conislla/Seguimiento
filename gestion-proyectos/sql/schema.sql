-- ============================================================
-- Sistema de Gestión de Proyectos TI - ARQUIE
-- Esquema completo: tablas, roles, RLS y alta automática de usuarios.
-- Ejecutar una sola vez en Supabase: Dashboard → SQL Editor → New query → pegar todo → Run.
--
-- Si ya habías corrido una versión anterior de este esquema (con
-- milestones/hitos e impacto-probabilidad en riesgos), corre primero:
--   drop table if exists public.milestones cascade;
--   alter table public.risks drop column if exists impact, drop column if exists probability, drop column if exists score, drop column if exists is_closed;
-- antes de ejecutar el resto de este archivo.
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

create or replace function public.get_my_role()
returns text
language sql
security definer
stable
set search_path = public
as $$
  select role from public.profiles where id = auth.uid()
$$;

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
  ruc text default '',
  contact text default '',
  service text not null,
  status text not null default 'Pendiente',
  start_date date not null,
  end_date date,
  expected_cycle int not null,
  stage text not null,
  drive_link text default '',
  advance_payment boolean not null default false,
  created_by uuid references public.profiles(id),
  created_at timestamptz not null default now()
);

-- Migración suave si la tabla ya existía sin estas columnas:
alter table public.projects add column if not exists ruc text default '';
alter table public.projects add column if not exists contact text default '';
alter table public.projects add column if not exists advance_payment boolean not null default false;

-- ---------- 4. Riesgos ----------
-- Modelo por tipo de riesgo (sin score numérico de impacto x probabilidad).
create table if not exists public.risks (
  id bigint generated always as identity primary key,
  project_id bigint not null references public.projects(id) on delete cascade,
  correlative int not null default 1,
  detail text not null,
  risk_type text not null check (risk_type in (
    'Retraso de cronograma', 'Afecta la calidad', 'Afecta el presupuesto', 'Rompe operatividad'
  )),
  mitigation text default '',
  mitigation_responsible text default '',
  mitigation_due_date date,
  status text not null default 'Abierto'
    check (status in ('Abierto', 'En seguimiento', 'Mitigado', 'Cerrado')),
  registration_date date not null default current_date,
  created_by uuid references public.profiles(id),
  created_at timestamptz not null default now()
);

-- Migración suave: si la tabla ya existía con el modelo viejo (impact/probability/score/is_closed),
-- descomenta y corre esto ANTES de la sección de arriba:
-- alter table public.risks drop column if exists impact;
-- alter table public.risks drop column if exists probability;
-- alter table public.risks drop column if exists score;
-- alter table public.risks drop column if exists is_closed;
-- alter table public.risks add column if not exists risk_type text;
-- alter table public.risks add column if not exists mitigation_responsible text default '';
-- alter table public.risks add column if not exists mitigation_due_date date;

-- ---------- 5. Facturación (reemplaza a Hitos/Bitácora) ----------
create table if not exists public.invoices (
  id bigint generated always as identity primary key,
  project_id bigint not null references public.projects(id) on delete cascade,
  ruc text default '',
  series text not null,
  number text not null,
  issue_date date not null,
  due_date date not null,
  base numeric(12,2) not null default 0,
  igv numeric(12,2) not null default 0,
  total numeric(12,2) not null default 0,
  detraction numeric(12,2) not null default 0,
  voucher_link text default '',
  status text not null default 'Pendiente por pagar' check (status in ('Pendiente por pagar', 'Pagado')),
  payment_date date,
  created_by uuid references public.profiles(id),
  created_at timestamptz not null default now()
);

-- Recibos por Honorarios (RxH), uno o más por factura.
create table if not exists public.fee_receipts (
  id bigint generated always as identity primary key,
  invoice_id bigint not null references public.invoices(id) on delete cascade,
  provider text not null,
  registration_number text not null,
  due_date date,
  payment_date date,
  bank text default '',
  total_to_pay numeric(12,2) not null default 0,
  total_paid numeric(12,2) not null default 0,
  created_at timestamptz not null default now()
);

-- Tabla vieja de hitos, si existía, ya no se usa. Elimínala manualmente
-- cuando confirmes que no necesitas conservar el histórico:
--   drop table if exists public.milestones cascade;

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
alter table public.invoices enable row level security;
alter table public.fee_receipts enable row level security;
alter table public.audit_log enable row level security;

-- ---------- profiles ----------
drop policy if exists "profiles_select" on public.profiles;
create policy "profiles_select" on public.profiles
  for select using (auth.uid() = id or public.get_my_role() <> 'pendiente');

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
-- Admin y Líder crean/editan/eliminan (Admin elimina). Todos los roles con
-- acceso (no pendientes) pueden ver, INCLUYENDO Finanzas (necesita ver el
-- proyecto para facturar), salvo que se decida lo contrario más adelante.
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

-- ---------- invoices / fee_receipts (Facturación) ----------
-- Exclusivo del rol Finanzas. Ni siquiera Admin puede ver estos datos
-- (decisión explícita: confidencialidad de información de pagos/RxH).
drop policy if exists "invoices_all" on public.invoices;
create policy "invoices_all" on public.invoices
  for all using (public.get_my_role() = 'finanzas') with check (public.get_my_role() = 'finanzas');

drop policy if exists "fee_receipts_all" on public.fee_receipts;
create policy "fee_receipts_all" on public.fee_receipts
  for all using (public.get_my_role() = 'finanzas') with check (public.get_my_role() = 'finanzas');

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

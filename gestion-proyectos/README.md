# Sistema de Gestión de Proyectos TI — ARQUIE

Aplicación de una sola página (`index.html`) con login real y 4 roles de usuario, conectada a Supabase (base de datos + autenticación). Lista para publicar en Vercel.

## Roles

| Rol | Puede |
|---|---|
| **Admin** | Crea/edita/elimina proyectos y riesgos; edita catálogos (estados/etapas); asigna roles a usuarios en "Usuarios". **No ve la pestaña Facturación** (exclusiva de Finanzas). |
| **Líder** | Crea/edita proyectos y riesgos. Ve auditoría. No elimina proyectos, no gestiona catálogos ni usuarios, no ve Facturación. |
| **Asistente** | Crea/edita riesgos. No crea, edita ni elimina proyectos. No gestiona catálogos ni usuarios, no ve Facturación. |
| **Finanzas** | **Único rol con acceso a la pestaña Facturación** (facturas + Recibos por Honorarios). Ve el resto del sistema (Proyectos, Riesgos, Auditoría, Dashboard) en solo lectura. |

Nota: el módulo de "Bitácora / Hitos" de la primera versión fue reemplazado por el de **Facturación** (más el de Recibos por Honorarios, RxH). Riesgos ya no usa Impacto × Probabilidad × Score — usa "Tipo de Riesgo" categórico (Retraso de cronograma / Afecta la calidad / Afecta el presupuesto / Rompe operatividad) + Responsable + Fecha de Cumplimiento.

Los usuarios nuevos entran con rol **Pendiente** (no ven nada del sistema) hasta que un Admin les asigna un rol desde la pestaña "Usuarios".

## 1. Base de datos (Supabase) — ya hiciste el proyecto, falta el esquema

1. Entra a tu proyecto en [supabase.com](https://supabase.com/dashboard) → **SQL Editor** → **New query**.
2. Copia y pega **todo** el contenido de [`sql/schema.sql`](sql/schema.sql) → **Run**.
3. Verifica en **Table Editor** que aparecieron las tablas: `profiles`, `projects`, `risks`, `invoices`, `fee_receipts`, `audit_log`, `statuses`, `stages`.

Si ya habías corrido una versión anterior del esquema (con `milestones` e Impacto/Probabilidad/Score en `risks`), lee el comentario al inicio de `sql/schema.sql` — trae los `alter table`/`drop table` necesarios para migrar sin perder el resto de los datos.

## 2. Crear el primer Admin

1. Abre `index.html` (localmente o ya publicado), ve a la pestaña **"Crear cuenta"** y regístrate con tu correo real.
2. Vuelve a Supabase → **SQL Editor** → ejecuta (con tu correo):
   ```sql
   update public.profiles set role = 'admin' where email = 'tu-correo@dominio.com';
   ```
3. Vuelve a iniciar sesión en la app (o recarga) — ya deberías ver todo el sistema, incluida la pestaña **"Usuarios"**.
4. Desde ahí, cuando el resto del equipo se registre (quedan en "Pendiente"), les asignas su rol (Admin, Líder, Asistente o Finanzas).

## 3. Credenciales en el código

La `Project URL` y la `anon key` de Supabase ya están escritas directamente en `index.html` (líneas cerca de `SUPABASE_URL` / `SUPABASE_ANON_KEY`). **Esto es correcto y seguro**: la anon key está diseñada para ser pública — la protección real la da RLS (Row Level Security), definida en `sql/schema.sql`, que solo deja ver/editar datos según el rol de cada usuario autenticado.

⚠️ Nunca pongas aquí la **secret key** (`sb_secret_...`) de Supabase — esa sí es privada, salta todas las reglas de RLS, y jamás debe estar en un archivo que se publique.

## 4. Publicar en Vercel

No necesita build (es HTML/JS plano):

**Opción A — Conectando el repo de GitHub (recomendado):**
1. Ve a [vercel.com](https://vercel.com) → **Add New → Project** → importa el repo `Seguimiento`.
2. En "Root Directory" selecciona la carpeta **`gestion-proyectos`**.
3. Framework Preset: **Other** (no requiere build command).
4. Deploy.

Cada vez que hagas push a la rama conectada, Vercel vuelve a publicar automáticamente.

**Opción B — Vercel CLI, sin conectar GitHub:**
```bash
cd gestion-proyectos
npx vercel --prod
```

## 5. Después de publicar

- En Supabase → **Authentication → URL Configuration**, agrega la URL de Vercel (ej. `https://tu-proyecto.vercel.app`) a **Site URL** y **Redirect URLs**, para que el login funcione correctamente desde ahí.
- Comparte la URL de Vercel con el equipo; cada persona crea su cuenta y tú (Admin) le asignas el rol.

## Notas sobre Facturación

- La pestaña **Facturación** solo es visible y accesible para el rol **Finanzas** — ni siquiera Admin puede verla ni leerla, a nivel de interfaz y también a nivel de base de datos (RLS en `invoices`/`fee_receipts` exige `role = 'finanzas'`). Si más adelante se necesita que Admin también tenga visibilidad (por ejemplo para auditoría financiera), es un cambio de una línea en `sql/schema.sql` (agregar `'admin'` a la política) y en `canAccessFacturacion()` de `index.html`.
- Cada factura puede tener uno o más **Recibos por Honorarios (RxH)** asociados; al editar una factura, la app reemplaza todos sus recibos por los que queden en el formulario en ese momento (borra e inserta de nuevo), así que no hace falta un flujo separado de edición de recibos.

# Sistema de Gestión de Proyectos TI — ARQUIE

Aplicación de una sola página (`index.html`) con login real y 4 roles de usuario, conectada a Supabase (base de datos + autenticación). Lista para publicar en Vercel.

## Roles

| Rol | Puede |
|---|---|
| **Admin** | Todo: crear/editar/eliminar proyectos, riesgos e hitos; editar catálogos (estados/etapas); asignar roles a usuarios en la pestaña "Usuarios". |
| **Líder** | Crear/editar proyectos, riesgos e hitos. Ve auditoría. No elimina proyectos, no gestiona catálogos ni usuarios. |
| **Asistente** | Crea/edita riesgos e hitos. No crea, edita ni elimina proyectos. No gestiona catálogos ni usuarios. |
| **Finanzas** | Ve todo (solo lectura en proyectos/riesgos). En Bitácora, solo puede editar "Facturas Asociadas" y "Lecciones Aprendidas" de un hito ya creado. |

Los usuarios nuevos entran con rol **Pendiente** (no ven nada del sistema) hasta que un Admin les asigna un rol desde la pestaña "Usuarios".

## 1. Base de datos (Supabase) — ya hiciste el proyecto, falta el esquema

1. Entra a tu proyecto en [supabase.com](https://supabase.com/dashboard) → **SQL Editor** → **New query**.
2. Copia y pega **todo** el contenido de [`sql/schema.sql`](sql/schema.sql) → **Run**.
3. Verifica en **Table Editor** que aparecieron las tablas: `profiles`, `projects`, `risks`, `milestones`, `audit_log`, `statuses`, `stages`.

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

## Límite conocido

El permiso de "Finanzas" para editar solo Facturas/Lecciones Aprendidas se aplica en la interfaz (la app deshabilita los demás campos del formulario). A nivel de base de datos, la política RLS le da permiso de `UPDATE` sobre toda la fila de `milestones` — un usuario Finanzas que llame a la API de Supabase directamente (fuera de esta interfaz) técnicamente podría editar otros campos del hito. Es una limitación aceptada dado el nivel de confianza dentro del equipo; si se necesita restricción estricta a nivel de columna, se resuelve con un trigger de base de datos que valide qué columnas cambiaron según el rol.

# Tablero Kanban del equipo

## Qué es esto
Un tablero Kanban compartido para que el equipo gestione tareas de sprints: columnas de Backlog, Por hacer, En progreso, Revisión y Completado, con arrastrar y soltar, métricas de puntos y gráficos de velocidad y burndown.

## Decisiones fijas
- **Sin login individual.** Cualquiera con el link entra y edita. El link no debe hacerse público ni quedar indexado en buscadores; solo se comparte dentro del equipo por canales privados (WhatsApp, correo, etc.).
- **Base de datos: Supabase**, plan gratuito. La tabla se llama `tasks`.
- **Acceso a la base de datos:** abierto (RLS con política `using (true) with check (true)`), porque no hay login. Si en algún momento se agrega login, hay que revisar y ajustar esta regla.
- **Sin armazón de frontend** (Next.js, React, etc.): un solo archivo `index.html` con JavaScript simple. No hace falta más para este tamaño de herramienta.
- El código de la pantalla se actualiza solo tras cada acción propia (crear, mover, borrar tarea), sin depender únicamente del aviso de tiempo real de Supabase (ese aviso sigue activo para cambios que hagan otros compañeros, pero no es la única vía).

## Qué queda fuera por ahora (a propósito)
- Login individual por persona.
- Reglas de quién puede ver o editar según el rol.
- Notificaciones o historial de cambios.
- Datos históricos reales de sprints anteriores en el gráfico de velocidad (arrancan en 0 hasta que haya sprints completados de verdad).

## Llaves y configuración
La URL y la llave `anon` de Supabase están directamente en `index.html`. Es correcto que estén ahí: esa llave está pensada para ser pública, la protección real la da la regla de acceso (RLS) de la tabla, no el secreto de la llave. La llave `service_role` de Supabase nunca debe entrar a este archivo ni a este repositorio.

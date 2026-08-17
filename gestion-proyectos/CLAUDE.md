# Sistema de Gestión de Proyectos TI — ARQUIE

Este subdirectorio es un proyecto independiente del tablero Kanban en la raíz de este repositorio y del `arquie-content/`. Comparten repositorio por conveniencia, no por relación funcional.

Ver `README.md` en esta carpeta para setup y despliegue.

## Decisiones fijas

- **Con login individual y roles** (a diferencia del tablero Kanban de la raíz, que decidió no tenerlo). Roles: Admin, Líder, Asistente, Finanzas.
- **Base de datos y autenticación: Supabase** (proyecto propio, separado del que use el tablero Kanban). Tablas: `profiles`, `projects`, `risks`, `invoices`, `fee_receipts`, `audit_log`, `statuses`, `stages`.
- **Facturación es exclusiva de Finanzas**: ni Admin, Líder ni Asistente ven esa pestaña ni sus datos (decisión explícita de confidencialidad, validada por el cliente). Aplicado tanto en la UI como en RLS.
- **Riesgos usa "Tipo de Riesgo" categórico** (Retraso de cronograma / Afecta la calidad / Afecta el presupuesto / Rompe operatividad), no el modelo anterior de Impacto × Probabilidad × Score.
- **No hay módulo de Hitos/Bitácora** (se eliminó; Facturación lo reemplaza como seguimiento post-venta).
- **RLS por rol**, no `using (true)`: cada tabla filtra según el rol del usuario autenticado (ver `sql/schema.sql`). Los usuarios nuevos entran en rol `pendiente` y no ven nada hasta que un Admin les asigna rol.
- **Sin armazón de frontend**: un solo archivo `index.html` con JavaScript simple, igual que el Kanban.
- **Despliegue: Vercel**, sirviendo el HTML estático directamente (sin build).
- La `anon key` de Supabase va directa en `index.html` (pensada para ser pública). La `secret key` nunca debe tocar este repo.

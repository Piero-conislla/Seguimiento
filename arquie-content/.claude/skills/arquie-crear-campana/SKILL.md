---
name: arquie-crear-campana
description: Orquesta una campaña completa de ARQUIE para Instagram y LinkedIn (flyer + carrusel + video sobre un mismo tema), coordinando las skills arquie-crear-flyer, arquie-crear-carrusel y arquie-crear-video. Usar cuando el usuario pide "una campaña" o contenido para varios formatos a la vez sobre un mismo tema.
---

# ARQUIE — Crear Campaña

Coordina la producción de una campaña multi-formato (flyer + carrusel + video) sobre un mismo tema, para Instagram y LinkedIn, manteniendo un solo hilo narrativo.

## 1. Brief de campaña

Reúne en una sola ronda de preguntas (si no vienen ya en el pedido):
- **Tema/pilar** de contenido (usa los 3 pilares de la sección 5 del Brand Prompt Book si aplica, o el tema libre del usuario).
- **Objetivo de funnel** de la campaña completa: normalmente una campaña recorre TOFU → MOFU → BOFU en varias piezas, no una sola etapa. Pregunta si quieren cubrir el recorrido completo o enfocarse en una etapa.
- **Duración/cadencia**: ¿cuántos días o semanas, cuántas piezas por semana?
- **Dato real disponible** para las láminas de riesgo/autoridad (o se usa placeholder, ver sección 15 del Brand Prompt Book).

## 2. Distribuir el tema en piezas

Reparte el mismo tema entre formatos según su rol natural en el funnel:

| Pieza | Rol típico en la campaña | Funnel sugerido |
|---|---|---|
| Flyer/post individual | Abre la conversación o refuerza un punto suelto | TOFU |
| Carrusel (8 láminas) | Desarrolla el problema completo, educa y genera autoridad | TOFU→MOFU→BOFU (una sola pieza recorre la secuencia 6.1) |
| Video/Reel | Formato de mayor alcance, mismo gancho que el carrusel en otro medio, o resumen tipo "Arquito explica" | TOFU o cierre con CTA |

No repitas el mismo gancho literal en las tres piezas — varía el ángulo mantendiendo el mismo tema y la misma cifra/dato de fondo, para que quien vea las tres no sienta contenido duplicado.

## 3. Producir cada pieza

Invoca en orden:
1. `arquie-crear-carrusel` primero (es la pieza que ancla la narrativa completa).
2. `arquie-crear-flyer` reutilizando el gancho o un insight del carrusel desde otro ángulo.
3. `arquie-crear-video` con el guion basado en el mismo mecanismo/dato, adaptado a formato corto.

Reutiliza la primera imagen generada como imagen semilla (`--ref`, sección 8 del Brand Prompt Book) para las piezas siguientes, así toda la campaña comparte una misma paleta y luz exactas, no solo la misma paleta de colores nominal.

Respeta la mezcla de feed 50% ilustración / 30% fotografía / 20% Arquito (sección 5b) al elegir el estilo visual de cada pieza — no uses Arquito en las tres piezas de la misma campaña salvo que el usuario lo pida explícitamente.

## 4. Adaptar copy por plataforma

Cada pieza ya trae copy IG y LinkedIn (generado por su skill correspondiente). Revisa que la diferencia entre ambos sea real y no cosmética:

| | Instagram | LinkedIn |
|---|---|---|
| Longitud de caption | Corta, 2-4 líneas | Puede ser más larga, hasta 4-6 líneas, con salto de línea antes de "ver más" |
| Hashtags | 3-5, al final | Máx. 2-3, integrados o al final, menos genéricos |
| Tono | Conversacional | Ligeramente más institucional, mismo nivel de claridad (sección 6.0) |
| CTA | Puede invitar a comentar/guardar | Puede invitar a conversar/agendar (audiencia con más intención de compra) |

El mensaje central y el dato de fondo deben ser idénticos en ambas plataformas — solo cambia el envoltorio, nunca el contenido ni las cifras.

## 5. Entregable final

Organiza todo en `output/campanas/<slug-de-campana>/`:
- `brief.md`: tema, objetivo, funnel recorrido, cadencia, dato base usado.
- `flyer/`, `carrusel/`, `video/`: subcarpetas con el output de cada skill.
- `calendario.md`: tabla simple con fecha sugerida, pieza, plataforma(s) y estado (borrador/listo/publicado) — para que el equipo la use como checklist manual de publicación.

Recuerda que la publicación en Instagram y LinkedIn es manual en este setup (no hay integración con las APIs de Meta/LinkedIn todavía): el entregable deja todo listo para que alguien del equipo suba las piezas o las programe con una herramienta como Buffer/Metricool.

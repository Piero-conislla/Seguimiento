---
name: arquie-crear-flyer
description: Crea un flyer/post individual de ARQUIE (imagen única para feed, story o banner) usando el Brand Prompt Book y generándolo con Nano Banana. Usar cuando el usuario pide "un flyer", "un post", "una imagen" o "un banner" para Instagram o LinkedIn.
---

# ARQUIE — Crear Flyer

Genera una sola pieza gráfica (no carrusel) lista para publicar, con copy corto e imagen generada por Nano Banana.

## 1. Reunir contexto (solo lo que falte)

Antes de escribir el prompt de imagen, ten claro:
- **Tema/idea central** (una sola idea, sección 13 del Brand Prompt Book).
- **Etapa del funnel**: TOFU, MOFU, FOMO o BOFU (usa `arquie-neurovisual-funnel` para decidir si no está claro).
- **Formato de destino**:
  - Post cuadrado IG/LinkedIn → 1:1 (plantilla 4.1 o 4.7)
  - Story/Reel → 9:16 (plantilla 4.4)
  - Banner LinkedIn → 16:9 (plantilla 4.5)
- **Estilo visual**: ilustración conceptual, fotografía real, o Arquito (respeta la mezcla 50/30/20 de la sección 5b si se conoce el histórico del mes).

Si el usuario no da tema ni funnel, pregunta ambos en una sola pregunta corta. No preguntes lo que ya se pueda inferir del pedido.

## 2. Armar el prompt de imagen

Lee `../../brand/brand-prompt-book.md` (secciones 1, 4 y la del pilar/funnel correspondiente en `arquie-neurovisual-funnel`) y compón el prompt siguiendo el orden: Sujeto → Estilo → Composición → Color y luz → Formato → BLOQUE MAESTRO.

Si la pieza lleva a Arquito, usa el prompt de referencia de la sección 3 del Brand Prompt Book y pasa `--ref` con un archivo de `assets/mascota/` si existe alguno.

Recuerda: nunca pidas texto largo ni el logo dentro de la imagen — pide espacio negativo.

## 3. Generar la imagen

Ejecuta el script (requiere `GEMINI_API_KEY` en `.env`, ver README del proyecto):

```bash
python scripts/generate_image.py \
  --prompt "PROMPT_COMPLETO_AQUI" \
  --out output/flyers/<slug-del-tema>.png
```

Con referencia de Arquito:

```bash
python scripts/generate_image.py \
  --prompt "PROMPT_COMPLETO_AQUI" \
  --ref assets/mascota/arquito_base.png \
  --out output/flyers/<slug-del-tema>.png
```

Genera 2-3 variantes cambiando ligeramente el prompt (sección 7: "genera varias opciones y elige").

## 4. Copy (texto de la publicación)

Escribe el titular (máx. 8 palabras) y subtítulo aplicando el tono de voz (sección 6.0) y, si corresponde, la estructura del funnel elegido (secciones TOFU/MOFU/FOMO/BOFU de `arquie-neurovisual-funnel`).

Entrega dos versiones de copy corto para pie de publicación:
- **Instagram**: más conversacional, 2-4 líneas, cierra con 3-5 hashtags relevantes (sin emojis salvo si el post es de Arquito).
- **LinkedIn**: mismo mensaje, tono algo más institucional, sin hashtags saturados (máx. 3), puede ser 1-2 líneas más largo.

Un solo CTA, tomado de la escalera de la sección 6.6.

## 5. Entregable

Deja en `output/flyers/<slug-del-tema>/`:
- La(s) imagen(es) PNG generada(s).
- `copy.md` con: titular, subtítulo, copy IG, copy LinkedIn, CTA, hashtags.

Recuérdale al usuario que el titular/logo se sobreponen después en Canva o PowerPoint sobre el espacio negativo generado.

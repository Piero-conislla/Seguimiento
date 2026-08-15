---
name: arquie-crear-video
description: Crea el guion, storyboard visual (imágenes por escena generadas con Nano Banana) y estructura de un video corto de ARQUIE (Reel/TikTok/LinkedIn video). Usar cuando el usuario pide "un video", "un reel" o "un guion" para redes.
---

# ARQUIE — Crear Video

Importante: Nano Banana genera **imágenes fijas**, no video. Esta skill produce el guion y el storyboard (una imagen por escena) listos para montar en una herramienta de edición (CapCut, Premiere, Canva Video) o, si se pide explícitamente, un video simple tipo slideshow ensamblado con ffmpeg a partir de las imágenes generadas.

Si el usuario necesita generación de video real (clips con movimiento generados por IA, no slideshow), avísale que eso requiere conectar un modelo de video aparte (ej. Veo en Vertex AI, Kling, Runway) — no está incluido en este setup y necesita su propia API key.

## 1. Reunir contexto

- Tema y objetivo (funnel: TOFU/MOFU/FOMO/BOFU).
- Duración objetivo: Reel/Story corto (15-30s, 4-6 escenas) o video más largo tipo LinkedIn (45-90s, 6-10 escenas).
- ¿Lleva a Arquito narrando, voz en off, o solo texto en pantalla?

## 2. Guion

Estructura recomendada (adapta la lógica de la sección 6.1 del Brand Prompt Book a formato video):

1. **Gancho** (0-3s): pregunta o dato que detiene el scroll.
2. **Problema** (3-8s): situación reconocible.
3. **Riesgo/Educación** (8-20s): una idea por escena, nunca más de una lámina de riesgo.
4. **Solución/Autoridad** (20-30s): mecanismo o caso anonimizado.
5. **Cierre + CTA** (últimos 3-5s): CTA de la escalera (sección 6.6), tono según etapa de funnel.

Cada escena: máximo 1-2 frases de texto en pantalla o narración (regla de 45 palabras/lámina del Brand Prompt Book aplica igual). Tono directo, claro, entendible (sección 6.0). Cero signos de exclamación, cero urgencia artificial.

## 3. Storyboard (una imagen fija por escena)

Para cada escena, arma el prompt de imagen con el tipo que mejor encaje (sección 4 del Brand Prompt Book: 4.1 foto, 4.4 vertical 9:16 para Reels, mascota sección 3 si Arquito narra). Formato **9:16** para Reels/Stories, 16:9 si es para feed de LinkedIn.

Usa la misma imagen semilla o referencia de Arquito en todas las escenas para consistencia visual:

```bash
python scripts/generate_image.py --prompt "PROMPT_ESCENA_N" --ref assets/mascota/arquito_base.png --out output/videos/<slug>/escena_N.png
```

## 4. (Opcional) Ensamblar un slideshow simple

Si el usuario pide un video ya montado y no solo el storyboard, y `ffmpeg` está disponible, arma un slideshow básico (sin voz, con música/texto añadidos después):

```bash
ffmpeg -framerate 1/3 -i output/videos/<slug>/escena_%d.png \
  -vf "scale=1080:1920,format=yuv420p" -r 30 \
  output/videos/<slug>/borrador.mp4
```

Deja claro que esto es un borrador de referencia (transiciones estáticas), no el video final — para producción real (voz, subtítulos, transiciones, animación) se necesita edición manual en CapCut/Premiere/Canva.

## 5. Entregable

Deja en `output/videos/<slug-del-tema>/`:
- `guion.md`: escena por escena, con texto/narración y duración estimada.
- `escena_1.png` … `escena_N.png`
- `borrador.mp4` (solo si se generó).
- Copy de publicación para **Instagram** (Reel: gancho como texto de portada + caption corto + hashtags) y **LinkedIn** (video nativo: caption más desarrollado, primeras 2 líneas deben funcionar sin "ver más").

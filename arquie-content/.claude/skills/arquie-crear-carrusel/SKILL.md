---
name: arquie-crear-carrusel
description: Crea un carrusel de 8 láminas de ARQUIE (copy + imágenes) siguiendo la plantilla oficial gancho-problema-riesgo-educación-educación-autoridad-Arquito-invitación. Usar cuando el usuario pide "un carrusel" para Instagram o LinkedIn.
---

# ARQUIE — Crear Carrusel

Produce un carrusel completo de 8 láminas (texto + imagen por lámina) usando la plantilla de la sección 6.3 del Brand Prompt Book.

## 1. Reunir contexto

Necesitas:
- **Tema** del carrusel (ej. "inventarios que no cuadran", "automatización de reportes").
- Un **dato o mecanismo real** para la lámina de riesgo y la de autoridad. Si el usuario no lo tiene, usa lenguaje conceptual o un placeholder explícito como `[X% de diferencia en inventario]` — nunca inventes cifras (sección 15 del Brand Prompt Book).

Si falta el tema, pregúntalo. No preguntes por el resto si se puede inferir o usar placeholder.

## 2. Generar el copy de las 8 láminas

Usa el prompt "Generador de carrusel completo" de la sección 6.7 del Brand Prompt Book (`../../brand/brand-prompt-book.md`) con el TEMA del usuario. Verifica cada lámina contra las reglas:
- Gancho ≤ 8 palabras, abre un bucle mental que no se resuelve en la lámina 1.
- Máx. 45 palabras por lámina.
- Una sola lámina de riesgo (agitada con datos, nunca con adjetivos — tabla 6.2).
- Cero signos de exclamación, cero urgencia artificial.
- CTA final tomado de la escalera 6.6 (nivel 1 o 2 para contenido de conciencia/educativo; nivel 3 solo si el carrusel es de autoridad/BOFU).
- Frase de Arquito en la lámina 7, coherente con su personalidad (sección 3).

Si el resultado no pasa el corrector de tono anti-hype (sección 6.7), corrígelo antes de continuar.

## 3. Generar las imágenes (una por lámina, mismo estilo visual)

Mapeo lámina → tipo de imagen (sección 6.3 y 4 del Brand Prompt Book):

| # | Lámina | Prompt base |
|---|---|---|
| 1 | Gancho | 4.2 Portada de carrusel |
| 2 | Problema | 4.1 Foto real de operación |
| 3 | Riesgo | 4.3 Lámina interior |
| 4 | Educación (por qué) | 4.6 Ilustración conceptual |
| 5 | Educación (cómo) | 4.3 Lámina interior (para viñetas) |
| 6 | Autoridad | 4.7 Tarjeta de dato |
| 7 | Arquito | Núcleo + vestuario según tema (sección 3) |
| 8 | Invitación | Fondo limpio con espacio para logotipo |

Genera las 8 con el mismo `--ref` de imagen semilla (sección 8) si ya existe una en `assets/referencias/`, para mantener consistencia visual entre láminas. Formato 4:5 salvo que el usuario pida 1:1.

```bash
python scripts/generate_image.py --prompt "PROMPT_LAMINA_N" --out output/carruseles/<slug>/lamina_N.png
```

Si no hay imagen semilla todavía, genera la lámina 1 primero, pide al usuario que la valide, y úsala como `--ref` para las 7 restantes — así el carrusel se ve como una sola pieza y no como 8 imágenes sueltas.

## 4. Entregable

Deja en `output/carruseles/<slug-del-tema>/`:
- `lamina_1.png` … `lamina_8.png`
- `copy.md` con el texto de cada lámina, más:
  - Copy de portada (caption) para **Instagram**: gancho + 1 línea de contexto + CTA a "desliza" + hashtags.
  - Copy de portada (caption) para **LinkedIn**: gancho + 2-3 líneas de contexto más desarrolladas (LinkedIn tolera más texto), mismo CTA, sin hashtags saturados.

Recuerda: el texto de cada lámina se sobrepone después en Canva/PowerPoint sobre el espacio negativo de la imagen — el script no escribe texto dentro de la imagen.

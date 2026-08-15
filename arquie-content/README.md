# ARQUIE Content Studio

Sistema de generación de contenido de marca para ARQUIE — Arquitectura Empresarial Latam. Genera flyers, carruseles y videos (guion + storyboard) con estilo de marca consistente, organizados en campañas para Instagram y LinkedIn.

## Cómo funciona

1. El **Brand Prompt Book** (`brand/brand-prompt-book.md`) y la skill **`arquie-neurovisual-funnel`** contienen todo el ADN de marca: paleta, tipografía, mascota Arquito, tono de voz, ICP y estrategia de funnel (TOFU-MOFU-FOMO-BOFU). Son la fuente de verdad para cualquier pieza.
2. Las imágenes se generan con **Nano Banana** (Gemini 2.5 Flash Image) vía `scripts/generate_image.py`.
3. Cuatro **skills de Claude Code** (`.claude/skills/`) saben cómo combinar ambas cosas:
   - `arquie-crear-flyer` — una pieza individual (post/story/banner).
   - `arquie-crear-carrusel` — carrusel de 8 láminas (plantilla oficial gancho→invitación).
   - `arquie-crear-video` — guion + storyboard de video corto (Nano Banana no genera video; produce imágenes fijas por escena).
   - `arquie-crear-campana` — orquesta las tres anteriores sobre un mismo tema, para IG y LinkedIn a la vez.

Uso típico: pide en Claude Code "arma una campaña sobre [tema]" y la skill `arquie-crear-campana` coordina todo, dejando el resultado organizado en `output/campanas/<tema>/`.

## Setup

```bash
cd arquie-content
pip install -r scripts/requirements.txt
cp .env.example .env
# edita .env y pega tu GEMINI_API_KEY (ver instrucciones dentro del archivo)
```

**Importante sobre la API key:** el nivel gratuito de Google AI Studio da cuota 0 para el modelo de imágenes. Hay que activar facturación (billing, pay-as-you-go) en el proyecto asociado a la key en https://aistudio.google.com/app/api-keys → columna "Nivel de facturación" → "Configurar la facturación". El costo es por imagen generada (aprox. $0.039 c/u a la fecha de este documento), sin costo fijo.

Prueba rápida:

```bash
python scripts/generate_image.py --prompt "Un círculo azul simple sobre fondo blanco" --out output/prueba.png
```

## Estructura

```
arquie-content/
├── brand/
│   └── brand-prompt-book.md      # fuente de verdad visual y narrativa
├── .claude/skills/                # skills de Claude Code
│   ├── arquie-neurovisual-funnel/
│   ├── arquie-crear-flyer/
│   ├── arquie-crear-carrusel/
│   ├── arquie-crear-video/
│   └── arquie-crear-campana/
├── scripts/
│   └── generate_image.py          # llama a Nano Banana
├── assets/
│   ├── mascota/                   # renders de referencia de Arquito (súbelos aquí)
│   └── referencias/                # "imágenes semilla" para consistencia visual (sección 8 del Brand Prompt Book)
└── output/                        # piezas generadas (ignorado por git, ver .gitignore)
    ├── flyers/<tema>/
    ├── carruseles/<tema>/
    ├── videos/<tema>/
    └── campanas/<tema>/
```

## Estado actual / lo que falta

- ✅ Brand Prompt Book y skill estratégica migrados y organizados.
- ✅ Skills de flyer, carrusel, video y campaña listas.
- ✅ Script de generación de imágenes contra Nano Banana.
- ⚠️ **Falta activar billing** en el proyecto de Google AI Studio para poder generar imágenes reales (ver arriba).
- ⚠️ La publicación en Instagram y LinkedIn es **manual** en este setup: cada skill deja las piezas listas en `output/`, pero no las publica. Publicar de forma 100% automática requiere apps aprobadas de Meta (Instagram Graph API) y LinkedIn (Marketing API), con proceso de revisión de cada plataforma — es un paso posterior, fuera de este alcance inicial.
- 📌 `assets/mascota/` está vacío: sube ahí el render base de Arquito (el que ya tengan) para que las skills lo usen como referencia y mantengan consistencia.

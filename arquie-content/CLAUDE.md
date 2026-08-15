# ARQUIE Content Studio

Este subdirectorio es un proyecto independiente del tablero Kanban que vive en la raíz de este repositorio (`Seguimiento`). Están en el mismo repo por conveniencia, no porque estén relacionados.

Ver `README.md` en esta carpeta para el propósito y setup. Ver `brand/brand-prompt-book.md` para el ADN de marca completo (paleta, tipografía, mascota, tono de voz, ICP, estrategia de funnel).

## Decisiones fijas

- Generación de imágenes: **Nano Banana** (Gemini 2.5 Flash Image) vía `scripts/generate_image.py`. La `GEMINI_API_KEY` vive solo en `.env` (gitignored), nunca en el código ni en el repo.
- Video: no hay modelo de video conectado. `arquie-crear-video` produce guion + storyboard (imágenes fijas) + opcionalmente un slideshow simple con ffmpeg, no video generativo con movimiento.
- Publicación en Instagram/LinkedIn: manual por ahora. No hay integración con Meta Graph API ni LinkedIn Marketing API.

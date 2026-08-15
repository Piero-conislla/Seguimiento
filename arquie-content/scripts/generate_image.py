#!/usr/bin/env python3
"""Genera imágenes con Nano Banana (Gemini 2.5 Flash Image) usando la API de Google AI Studio.

Uso:
  python generate_image.py --prompt "texto del prompt" --out output/flyer.png
  python generate_image.py --prompt "texto del prompt" --ref assets/mascota/arquito_base.png --out output/arquito_almacen.png

Requiere la variable de entorno GEMINI_API_KEY (ver .env.example).
"""
import argparse
import base64
import os
import sys

import requests

MODEL = "gemini-2.5-flash-image"
API_URL = f"https://generativelanguage.googleapis.com/v1beta/models/{MODEL}:generateContent"


def load_api_key() -> str:
    key = os.environ.get("GEMINI_API_KEY")
    if key:
        return key
    env_path = os.path.join(os.path.dirname(__file__), "..", ".env")
    if os.path.exists(env_path):
        with open(env_path) as f:
            for line in f:
                if line.startswith("GEMINI_API_KEY="):
                    return line.strip().split("=", 1)[1]
    sys.exit("Falta GEMINI_API_KEY. Configúrala en .env o como variable de entorno.")


def build_parts(prompt: str, ref_paths: list[str]) -> list[dict]:
    parts = []
    for ref_path in ref_paths:
        with open(ref_path, "rb") as f:
            data = base64.b64encode(f.read()).decode("utf-8")
        mime = "image/png" if ref_path.lower().endswith(".png") else "image/jpeg"
        parts.append({"inline_data": {"mime_type": mime, "data": data}})
    parts.append({"text": prompt})
    return parts


def generate(prompt: str, out_path: str, ref_paths: list[str] | None = None) -> None:
    api_key = load_api_key()
    ref_paths = ref_paths or []

    payload = {
        "contents": [{"parts": build_parts(prompt, ref_paths)}],
        "generationConfig": {"responseModalities": ["IMAGE", "TEXT"]},
    }

    resp = requests.post(
        API_URL,
        headers={"x-goog-api-key": api_key, "Content-Type": "application/json"},
        json=payload,
        timeout=120,
    )
    resp.raise_for_status()
    data = resp.json()

    os.makedirs(os.path.dirname(out_path) or ".", exist_ok=True)
    saved = False
    for candidate in data.get("candidates", []):
        for part in candidate.get("content", {}).get("parts", []):
            inline = part.get("inlineData") or part.get("inline_data")
            if inline and inline.get("data"):
                with open(out_path, "wb") as f:
                    f.write(base64.b64decode(inline["data"]))
                saved = True
                print(f"Guardado: {out_path}")
            elif "text" in part:
                print(f"[modelo dice]: {part['text']}")
    if not saved:
        sys.exit(f"No se recibió imagen en la respuesta:\n{data}")


def main() -> None:
    parser = argparse.ArgumentParser(description="Genera una imagen ARQUIE con Nano Banana.")
    parser.add_argument("--prompt", required=True, help="Prompt completo (incluye el BLOQUE MAESTRO).")
    parser.add_argument("--out", required=True, help="Ruta de salida del PNG.")
    parser.add_argument(
        "--ref",
        action="append",
        default=[],
        help="Ruta a imagen de referencia (repetible). Úsalo para consistencia de Arquito o imagen semilla.",
    )
    args = parser.parse_args()
    generate(args.prompt, args.out, args.ref)


if __name__ == "__main__":
    main()

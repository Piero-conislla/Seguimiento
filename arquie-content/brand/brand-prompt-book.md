# ARQUIE — Brand Prompt Book (v2.1)

Guía de prompts para generar contenido visual de marca con IA.
Versión 2.1 · Julio 2026 · Enfoque: redes sociales.
Documento cerrado — incluye ICP y actitud narrativa oficiales.
Herramientas objetivo: **Gemini / Nano Banana** · ChatGPT / DALL·E.

> Este archivo es la fuente de verdad para todos los prompts de imagen ARQUIE. Las skills `arquie-crear-flyer`, `arquie-crear-carrusel` y `arquie-crear-video` se apoyan en él.

## 0. Cómo usar este documento

Un prompt es la instrucción de texto que le das a la IA para que genere una imagen. Este libro convierte la identidad de ARQUIE en prompts listos para copiar y pegar, de modo que todo lo que se publique se vea como parte de la misma marca.

Anatomía de un buen prompt — todo prompt de este libro sigue este orden:

| Bloque | Qué responde | Ejemplo |
|---|---|---|
| Sujeto | ¿Qué se ve? | un almacén ordenado con estanterías altas |
| Estilo | ¿Con qué técnica? | render 3D limpio, estilo corporativo |
| Composición | ¿Cómo está encuadrado? | plano medio, espacio negativo a la izquierda |
| Color y luz | ¿Con qué paleta? | azul profundo #0C489C con acentos cian #009CD8 |
| Formato | ¿Qué proporción? | formato cuadrado 1:1 |

**Regla de oro sobre el texto:** las IA de imagen escriben mal. Nunca les pidas que incluyan textos largos ni el logo. En su lugar, pide espacio negativo (una zona vacía de la imagen) y coloca ahí el titular y el logo después, en Canva o PowerPoint. Es más rápido y siempre sale perfecto.

## 1. ADN visual de ARQUIE — el "bloque maestro"

Este párrafo es el corazón del libro. Pégalo al final de cualquier prompt y la imagen saldrá con identidad ARQUIE.

**BLOQUE MAESTRO:**
> Estética corporativa premium, tecnológica y sobria. Paleta estricta: azul corporativo profundo #0C489C como color dominante, cian #009CD8 como acento puntual, gris neutro #848484 y blanco puro para respiro. Iluminación suave y difusa, de estudio, con un realce cian discreto. Detalles finos tipo circuito o red de nodos como elemento gráfico secundario, nunca invasivo. Composición equilibrada, ordenada, con amplio espacio negativo. Acabados mate y superficies limpias. Aspecto profesional y confiable. Sin estética cyberpunk, sin luces de neón, sin resplandores intensos, sin saturación excesiva, sin ruido visual. Sin texto en la imagen.

Los cuatro atributos de la marca y su traducción visual:

| Atributo | Cómo se ve | Cómo NO se ve |
|---|---|---|
| Corporativa | Orden, alineación, geometría estable | Composiciones caóticas o experimentales |
| Premium | Espacio en blanco generoso, acabados mate, un solo punto focal | Recargado, muchos elementos compitiendo |
| Tecnológica | Circuitos finos, nodos conectados, interfaces limpias | Robots, hologramas, código cayendo en pantalla |
| Sobria | Azul dominante, cian como acento mínimo | Neón, brillos intensos, alto contraste agresivo |

⚠️ **El cian es acento, no protagonista.** La diferencia entre "tecnológico premium" y "cyberpunk barato" está casi toda ahí: si el cian ocupa más de un 15% de la imagen, ya cruzaste la línea. En los prompts, refuérzalo con "cian usado con moderación, solo como detalle de acento".

### Colores oficiales

| Color | Hex | Uso |
|---|---|---|
| Azul ARQUIE | `#0C489C` | Dominante: fondos, formas principales |
| Cian acento | `#009CD8` | Luces, brillos, detalles de circuito, énfasis |
| Gris neutro | `#848484` | Textos secundarios, elementos de apoyo |
| Blanco | `#FFFFFF` | Espacio de respiro, contraste |

Colores de apoyo (fondos suaves): un azul muy claro casi blanco para fondos limpios y un azul medio para degradados. Todo degradado va de `#0C489C` a `#009CD8` — nunca hacia otro tono.

### Tipografía — sistema oficial

| Uso | Fuente | Peso sugerido |
|---|---|---|
| Títulos | Arimo | Bold |
| Subtítulos | Open Sans | SemiBold |
| Texto corrido | Arial | Regular |

Las tres son sans-serif universales y de altísima legibilidad. Arial es fuente de sistema; Arimo y Open Sans son gratuitas en Google Fonts y están disponibles en Canva, Word y PowerPoint.

⚠️ Arimo fue diseñada por Google como sustituto de Arial con métricas idénticas: un titular en Arimo Bold y un texto en Arial Regular se leen casi como la misma tipografía en distinto peso, no como dos fuentes contrastantes. Esto genera un sistema coherente y sobrio, pero la jerarquía visual depende exclusivamente del tamaño y el peso. Compénsalo con contrastes de tamaño amplios (título al menos 2× el texto corrido) y con Bold marcado en los títulos.

Tamaños mínimos para redes (lienzo de 1080×1080 px o 1080×1350 px):

| Elemento | Tamaño | Fuente | Peso |
|---|---|---|---|
| Titular principal | 90–120 px | Arimo | Bold |
| Subtítulo | 55–70 px | Open Sans | SemiBold |
| Texto corrido | 45–55 px | Arial | Regular |
| Pie o fuente del dato | 32 px | Arial | Regular |

Nunca bajes de 32 px: por debajo de eso, en celular el texto deja de leerse.

**Cinco reglas de legibilidad móvil:**
1. Máximo 8 palabras por titular. Si no cabe, es dos publicaciones.
2. Nada de pesos Light o Thin sobre fondo azul.
3. Texto blanco sobre azul `#0C489C`, o azul sobre blanco. Evita gris `#848484` para texto principal.
4. Alineación a la izquierda para bloques de texto.
5. Prueba obligatoria: mira la pieza en tu propio celular al tamaño real del feed antes de publicar.

## 1b. Cómo evitar que las imágenes se vean "cyberpunk"

Riesgo estético principal: las IA tienden por defecto a exagerar lo tecnológico. Agrega este fragmento cuando las imágenes salgan demasiado brillantes o futuristas:

**FRENO ANTI-NEÓN:**
> Estética empresarial realista y contenida, no futurista. Iluminación natural y suave. Los elementos tecnológicos deben ser sutiles y de baja opacidad. Sin resplandores, sin luces de neón, sin ambientes oscuros con luces de colores, sin estética cyberpunk, sin ciencia ficción.

Señales de que te fuiste al lado equivocado: fondos negros con luces moradas o rosadas, resplandores alrededor de cada objeto, ambientes nocturnos con lluvia, pantallas flotantes por todas partes, personas con visores. Si ves alguna, regenera con el freno anti-neón.

## 2. El logotipo — cuándo y cómo usarlo

| Versión | Cuándo usarla |
|---|---|
| Principal (azul + cian) | Por defecto, sobre fondos blancos o muy claros |
| Negativo (blanco) | Sobre fondos azul oscuro, fotos oscuras o degradados |
| Negro | Documentos en blanco y negro, impresión de bajo costo |
| Gris | Cuando el logo debe estar presente pero discreto (marcas de agua, pies de página) |

**Importante:** nunca pidas a la IA que genere el logo. Sale deformado. Genera la imagen con espacio libre en una esquina y superpón el archivo PNG real.

Descripción del isotipo: búho estilizado en trazo continuo monolínea, ojos grandes y redondos, cresta de tres antenas rematadas en círculos que evocan un circuito impreso, cuerpo en forma de escudo con un hexágono en el pecho.

## 3. Arquito — la mascota

Se llama Arquito (diminutivo de ARQUIE). Vive en: redes sociales, contenido educativo, capacitaciones, material de ferias y comunicación interna. NO vive en: propuestas comerciales, informes de auditoría, contratos y documentos formales (ahí manda el logotipo institucional).

Dos capas:
- **Capa 1 — El núcleo.** Nunca cambia. Es lo que hace que la gente la reconozca al instante.
- **Capa 2 — El vestuario y el contexto.** Cambia libremente según el tema de cada publicación.

Todo prompt de mascota es: **[NÚCLEO] + [VESTUARIO] + [ESCENA] + [FORMATO]**.

### Personalidad de Arquito

Curioso, ordenado y directo — el que se da cuenta de lo que todos pasaron por alto.

- **Curioso:** hace preguntas, no da órdenes. "¿Ya revisaste el stock de la zona C?" en vez de "Revisa el stock de la zona C".
- **Ordenado:** cuando explica, enumera. Prefiere "hay tres razones" sobre "hay varias razones".
- **Directo:** frases cortas, sin adornos. Va al punto.
- **El que se da cuenta:** señala el detalle que los demás pasaron por alto. Nunca regaña ni se burla.

Frases típicas:
- "Contar es fácil. Lo difícil es saber por qué no cuadra."
- "El dato estaba ahí. Solo había que mirarlo desde otro ángulo."
- "Antes de comprar más, revisa qué tienes."

### Capa 1 — El núcleo (invariable)

**NÚCLEO DE LA MASCOTA:**
> Un búho mascota en 3D estilo caricatura moderna, cuerpo redondeado y compacto, plumaje blanco perlado en el pecho y azul profundo #0C489C en la cabeza, espalda y alas. Ojos enormes, redondos y expresivos con iris azul e intenso brillo blanco. Pico pequeño y oscuro en forma de triángulo redondeado. Sobre la cabeza, una cresta de tres antenas delgadas azules rematadas en esferas luminosas cian, como un circuito. Líneas de circuito cian brillante recorren sus alas. Proporciones tiernas: cabeza grande, cuerpo pequeño. Render 3D pulido con superficies mate suaves, iluminación de estudio cálida y realce cian. Expresión amable y despierta.

Los cuatro rasgos que nunca se negocian:
1. La cresta de tres antenas con esferas cian (elemento de identidad ARQUIE, aparece en el logotipo). Sin cresta no hay marca.
2. Los ojos grandes con iris azul y brillo.
3. El plumaje azul `#0C489C` con pecho blanco.
4. Las líneas de circuito cian en las alas.

💡 Si un accesorio tapa la cresta (casco, chullo, sombrero), pide explícitamente que las antenas asomen por encima o por los costados.

### La cresta como grafismo autónomo

Como la cresta ya es un elemento reconocible de la marca, puede usarse sola, sin el búho, como recurso decorativo (mismo principio del swoosh de Nike).

> Elemento gráfico minimalista: tres antenas delgadas de distinta altura, rematadas en pequeñas esferas luminosas cian #009CD8, unidas por finos trazos de circuito impreso. Trazo limpio y uniforme. Aislado sobre fondo [blanco / azul #0C489C]. Sin otros elementos.

Úsalo como marca de agua en esquinas, como viñeta antes de cada punto en un carrusel, o como patrón repetido de baja opacidad en fondos.

### Capa 2 — Guardarropa

| Traje | Fragmento para el prompt | Cuándo usarlo |
|---|---|---|
| Ejecutivo | …vistiendo un saco azul marino entallado, camisa blanca y corbata cian, con postura confiada. | Contenido corporativo, propuesta de valor, alianzas |
| Consultor casual | …vistiendo una camisa celeste con las mangas arremangadas y un fotocheck colgado al cuello. | Tips prácticos, "cómo hacerlo", cercanía |
| Operativo de almacén | …con un chaleco reflectivo naranja y un casco de seguridad amarillo (las antenas asoman por encima del casco), sosteniendo una tablet. | Inventarios, auditorías, logística |
| Analista de datos | …con lentes de montura delgada y un suéter gris, rodeado de pantallas flotantes con gráficos azules. | Analítica, Power BI, IA |
| Peruano / cultural | …con un chullo andino tejido en tonos rojos y blancos con motivos geométricos (antenas asoman por los costados) y un poncho ligero sobre los hombros. | Fiestas patrias, contenido local, orgullo peruano |
| Deportivo | …con una camiseta deportiva blanca de banda diagonal roja y pantalón corto azul, un balón genérico bajo el ala. | Campañas de temporada, contenido ligero |
| Docente | …con un saco de tweed y un puntero láser, junto a una pizarra flotante. | Capacitaciones, webinars, contenido educativo |
| Festivo | …con un gorro de fiesta cónico en cian y blanco, y serpentinas alrededor. | Aniversarios, hitos, celebraciones |

**Regla de armonía:** el traje puede salirse de la paleta (naranja del chaleco, rojo del chullo), pero el cuerpo del búho siempre conserva sus colores. La ropa es el acento; el búho es la marca.

⚠️ **Dos cuidados legales:**
- **FIFA World Cup 2026:** nunca copa/emblema oficial (marcas con licencia estricta). Usa la fila "Deportivo" del guardarropa. Pide siempre: "sin logotipos, sin trofeos, sin emblemas de ningún torneo".
- **Marca Perú:** el logotipo de la espiral requiere autorización de PROMPERÚ. Si no está tramitada, quédate con la estética (chullo, rojo y blanco, motivos andinos) sin colocar el logotipo.

### Cómo usarla en la práctica

Método recomendado (imagen de referencia): en Gemini/Nano Banana, sube el render original de la mascota junto con tu instrucción:

> "Usando esta mascota exactamente como referencia, mantén su diseño, colores, cresta de antenas y proporciones sin ningún cambio. Cámbiale únicamente la vestimenta por [VESTUARIO] y ubícala en [ESCENA]. Formato 1:1."

Esto da mucha más consistencia que describirla desde cero. **Guarda tus mejores renders de Arquito en `assets/mascota/` y úsalos siempre como referencia.**

Contenido serializado (formatos recurrentes):
- **"Arquito encontró…"** — un hallazgo real y anonimizado de una auditoría o inventario. Formato de intriga, muy compartible.
- **"Arquito explica"** — un término técnico traducido a lenguaje simple.
- **"El almacén de Arquito"** — errores comunes de bodega ilustrados con humor, con la solución al final.

### Escenas sugeridas (combinables con cualquier traje)
- **Analista:** …frente a un tablero de control flotante con gráficos azules, señalando un dato con el ala.
- **Almacén:** …de pie frente a estanterías de cajas perfectamente ordenadas.
- **Bienvenida:** …saludando con un ala levantada, fondo azul degradado limpio, mucho espacio a la derecha.
- **Explicando:** …junto a una pizarra flotante con un diagrama de flujo simple en líneas cian.
- **Celebración:** …con las alas arriba y confeti cian y blanco cayendo.

## 4. Prompts por tipo de pieza

Cada uno está listo para copiar. Reemplaza lo que está en [corchetes]. Todos terminan pegando el **[BLOQUE MAESTRO]** de la sección 1.

### 4.1 Post cuadrado (feed IG / LinkedIn) — 1:1
> Fotografía corporativa profesional de [ESCENA], iluminación natural suave, colores desaturados con predominancia de azules fríos. Composición con el sujeto desplazado a la derecha y amplio espacio negativo limpio a la izquierda para colocar texto. Formato cuadrado 1:1. [BLOQUE MAESTRO]

Ejemplos de ESCENA: "una supervisora con casco de seguridad revisando una tablet frente a estanterías de almacén", "manos sobre un teclado con una pantalla de tablero de datos desenfocada al fondo", "un equipo de tres personas revisando indicadores en una pantalla grande".

### 4.2 Portada de carrusel — 1:1 o 4:5
> Ilustración conceptual minimalista de [CONCEPTO], estilo isométrico limpio con formas geométricas simples y líneas finas. Fondo azul profundo #0C489C con un degradado suave hacia cian. El elemento central ocupa el tercio inferior, dejando el tercio superior completamente libre para un titular. Formato vertical 4:5. [BLOQUE MAESTRO]

Ejemplos de CONCEPTO: "un almacén organizándose en cuadrícula", "datos dispersos convirtiéndose en un gráfico ordenado", "engranajes conectados por líneas de circuito".

### 4.3 Lámina interior de carrusel — 4:5
> Fondo abstracto sobrio para presentación corporativa: degradado azul profundo #0C489C a azul medio, con una malla muy tenue de nodos y líneas conectadas en cian de baja opacidad en la esquina inferior derecha. El 70% del lienzo debe quedar liso y despejado. Sin elementos figurativos. Formato vertical 4:5.

Este es el fondo de trabajo. Genera tres o cuatro variantes y reutilízalas todo el mes.

### 4.4 Historia vertical (Stories / Reels) — 9:16
> [ESCENA o mascota] compuesto en formato vertical extremo 9:16, con el elemento principal centrado en el tercio medio del encuadre. Zona superior e inferior despejadas para texto y botones. Fondo azul degradado con brillo cian sutil detrás del sujeto. [BLOQUE MAESTRO]

### 4.5 Portada de LinkedIn / banner — 16:9
> Escena panorámica corporativa de [ESCENA AMPLIA], perspectiva amplia, iluminación fría y profesional. El lado izquierdo debe quedar despejado y de tono uniforme para superponer el logotipo y un titular. Formato apaisado 16:9. [BLOQUE MAESTRO]

### 4.6 Imagen de cabecera para artículo del blog — 16:9
> Ilustración conceptual editorial sobre [TEMA], estilo semiplano con profundidad sutil, paleta reducida a azul #0C489C, cian #009CD8, gris y blanco. Metáfora visual clara y única, sin acumular elementos. Fondo limpio. Formato 16:9. [BLOQUE MAESTRO]

### 4.7 Fondo para tarjeta de cita o dato — 1:1
> Textura corporativa abstracta: superficie azul profundo con un patrón muy sutil de líneas de circuito impreso en cian de baja opacidad, concentrado en los bordes. El centro debe quedar completamente limpio y uniforme. Iluminación suave desde arriba. Formato cuadrado 1:1.

## 5. Prompts por pilar de contenido

### Pilar 1 — Ahorros y eficiencia
Metáforas: orden emergiendo del desorden, espacio recuperado, flechas descendentes en costos, un almacén despejado.

> Ilustración isométrica limpia de un almacén que pasa de estanterías desordenadas en el lado izquierdo a estanterías perfectamente alineadas en el lado derecho, con una transición visual clara entre ambos estados. Paleta azul y cian sobre fondo claro. Formato 4:5. [BLOQUE MAESTRO]

### Pilar 2 — Datos e IA para decidir mejor
Metáforas: puntos que se conectan, gráficos que se elevan, una lupa sobre datos, un tablero de control.

> Ilustración conceptual de una constelación de puntos de datos dispersos que se conectan mediante líneas cian formando un gráfico ascendente claro. Fondo azul profundo. Estilo limpio y geométrico, sin cifras ni etiquetas legibles. Formato 1:1. [BLOQUE MAESTRO]

### Pilar 3 — Digitalización y automatización
Metáforas: papel convirtiéndose en pantalla, engranajes conectados, flujos automáticos, procesos encadenados.

> Ilustración conceptual de documentos de papel transformándose progresivamente en interfaces digitales flotantes, de izquierda a derecha. Estilo semiplano con líneas finas cian. Fondo azul claro muy suave. Formato 16:9. [BLOQUE MAESTRO]

## 5b. Mezcla oficial del feed

La proporción de contenido visual en el feed no se decide publicación por publicación:

| Tipo de contenido | Proporción | Uso principal |
|---|---|---|
| Ilustración conceptual | 50% | Explicaciones, procesos, ideas abstractas, pilares editoriales |
| Fotografía real | 30% | Operaciones en terreno, equipo humano, casos de negocio |
| Mascota Arquito | 20% | Serialización, cierre de carruseles, contenido educativo ligero |

De cada 10 publicaciones al mes: 5 ilustración, 3 fotografía, 2 Arquito. No es rígido semana a semana, pero al cerrar el mes la mezcla debe volver aquí.

Por qué funciona: la ilustración hace que ARQUIE se vea consultora y estratégica. La fotografía aterriza y da realismo. Arquito construye cercanía y recordación. Los tres se necesitan.

## 6. Capa narrativa: del problema a la conversación

### 6.0 Tono de voz oficial

Directa, clara y entendible.

| Adjetivo | Qué significa en la práctica | Cómo se rompe |
|---|---|---|
| Directa | Va al punto en la primera frase. Sin rodeos, sin preámbulos corporativos | "En un contexto empresarial cada vez más desafiante, es importante considerar…" |
| Clara | Cada término técnico se explica o se sustituye. Frases cortas, un solo verbo principal por oración | "Optimización holística de procesos end-to-end" |
| Entendible | Un gerente sin formación técnica debe seguir el mensaje. Cero jerga innecesaria | "Implementación de RPA sobre stack legacy vía APIs REST" |

Frase de prueba: si tu mamá o tu tío de provincia no entienden lo que escribiste, no está listo para publicar.

### 6.0b A quién le hablamos y desde dónde

**ICP:** empresas peruanas de más de 6 empleados que facturan más de S/ 50,000 al mes, que quieren ordenar sus procesos, conectar su información, automatizar operaciones y desarrollar agentes de IA. Objetivo declarado: operaciones controladas, con costos claros, tiempos medibles y riesgos identificados.

| Dimensión | Detalle |
|---|---|
| Rol | Fundador, gerente general u operacional; en empresas más grandes, jefe de operaciones o TI |
| Momento de negocio | En fase de escalar: la operación creció y los procesos improvisados empezaron a dolerles |
| Dolor real | No es "no tener tecnología". Es "no ver lo que está pasando" — costos que no cuadran, tiempos que se estiran, decisiones a ciegas |
| Lo que teme | Invertir en tecnología que no se use, software caro que nadie entiende, un proyecto largo sin resultados visibles |
| Lo que valora | Claridad, rapidez de implementación, gente que le explique sin condescendencia |

### 6.0c Actitud narrativa frente a los datos

Hablamos de KPIs de valor sin miedo, con energía y con placer en los datos.

- **Sin miedo:** los datos no son una amenaza que va a delatar a alguien. Son una herramienta que empodera.
- **Con energía:** un descubrimiento se cuenta como un hallazgo, no como un informe forense. "Encontramos que…" pega más que "Se identificó que…".
- **Con placer:** los datos son interesantes por sí mismos. Un patrón bien contado engancha.

⚠️ Entusiasmo por los datos ≠ hype comercial. La energía se transmite con especificidad y descubrimiento, no con signos de exclamación ni superlativos. "Este dato cambia cómo compras" transmite más energía que "¡Descubrimientos increíbles!".

### 6.1 La secuencia

En B2B nadie compra en el primer contacto.

| Etapa | Qué ocurre en la mente del lector | Cómo se ve en ARQUIE |
|---|---|---|
| 1. Problema | "Esto me pasa a mí" — reconocimiento | "Tu ERP dice 1,200 unidades. En el almacén hay 1,143." |
| 2. Riesgo | "Y me está costando más de lo que creía" — dimensiona | Qué se pierde: quiebres de stock, compras duplicadas, observaciones en auditoría |
| 3. Educación | "Ah, ahora entiendo por qué pasa" — valor recibido | Explicar el mecanismo: por qué se descuadra un inventario |
| 4. Autoridad | "Estos saben de lo que hablan" — confianza | Caso real anonimizado, cifra concreta, respaldo CCL / APPROLOG |
| 5. Invitación | "Quiero saber más" — bajo compromiso | "¿Cuánto hace que no cuadras tu inventario? Conversemos 15 minutos" |

La etapa 3 (educación) genera reciprocidad: entregar conocimiento útil y gratuito crea una deuda psicológica pequeña que hace más probable que el lector responda la invitación. Si saltas de "Riesgo" directo a "Contáctanos", el mensaje se lee como venta.

### 6.2 ⚠️ La agitación en B2B: dónde se rompe la fórmula

PAS nació en el marketing directo al consumidor, donde exagerar el dolor funciona. En B2B con marca premium, la agitación excesiva destruye credibilidad.

**Regla para ARQUIE: agita con datos, no con adjetivos.**

| ❌ Así no | ✅ Así sí |
|---|---|
| "Tu almacén está sangrando dinero" | "Una diferencia del 4% en inventario equivale a un mes de utilidad en operaciones de bajo margen" |
| "Estás perdiendo clientes sin darte cuenta" | "El quiebre de stock se detecta, en promedio, cuando el cliente ya llamó a reclamar" |
| "¡Es urgente actuar ya!" | "El cierre contable no espera. La pregunta es si llegas con los números cuadrados o justificándolos" |

Además: **una sola lámina de riesgo por carrusel.** Dos ya es alarmismo.

### 6.3 Plantilla de carrusel — 8 láminas

| # | Etapa | Función del texto | Visual (sección) |
|---|---|---|---|
| 1 | Gancho | Pregunta o dato que abre un bucle mental. Máx. 8 palabras | Portada de carrusel (4.2) |
| 2 | Problema | Describe la situación con detalle reconocible | Foto real de operación (4.1) |
| 3 | Riesgo | Cuantifica el costo. Una sola lámina | Lámina interior (4.3) |
| 4 | Educación | Explica el mecanismo. El "por qué" | Ilustración conceptual (4.6) |
| 5 | Educación | El "cómo": 3 pasos concretos y aplicables | Lámina interior con viñetas |
| 6 | Autoridad | Caso, cifra o respaldo. Sin nombrar clientes sin permiso | Tarjeta de dato (4.7) |
| 7 | Arquito | Resumen memorable en boca del personaje | Arquito con vestuario del tema (sección 3) |
| 8 | Invitación | Pregunta abierta + CTA suave | Fondo limpio con logotipo |

### 6.4 Ejemplo completo — servicio de inventarios

1. **Gancho:** "Tu ERP y tu almacén no dicen lo mismo. ¿Sabes cuánto?"
2. **Problema:** "El sistema dice 1,200 unidades. El conteo real arroja 1,143. Nadie sabe cuándo se produjo la diferencia — solo que ya está ahí."
3. **Riesgo:** "Esa brecha no aparece sola en el cierre contable. Aparece antes: en compras que no hacían falta, en pedidos que no se pudieron despachar, y en observaciones que retrasan una certificación OEA."
4. **Educación (por qué):** "¿Por qué se descuadra? Casi nunca por robo. Tres causas explican la mayoría: registros hechos después del movimiento físico, unidades de medida inconsistentes entre compras y despacho, y devoluciones que vuelven al anaquel sin volver al sistema."
5. **Educación (cómo):** "Tres medidas que puedes aplicar esta semana: 1) Define reglas de negocio escritas para cada SKU. 2) Empieza conteos cíclicos por zona de alta rotación, no inventarios totales. 3) Cuenta a ciegas: sin mostrar el stock teórico al personal."
6. **Autoridad:** "En una operación con múltiples almacenes implementamos conteo ciego digital priorizando zonas críticas. Resultado: 20% de mejora en el proceso de compras e inventarios."
7. **Arquito** (chaleco reflectivo y casco): "Contar es fácil. Lo difícil es saber por qué no cuadra."
8. **Invitación:** "¿Cuándo fue tu último inventario cuadrado al 100%? Cuéntanos en los comentarios — o escríbenos y lo revisamos juntos en 15 minutos."

### 6.5 Principios de neuromarketing, aplicados con sobriedad

| Principio | Qué dice | Cómo aplicarlo en ARQUIE |
|---|---|---|
| Especificidad | Las cifras exactas se perciben como más verdaderas que las redondas | "1,143 unidades" convence más que "más de mil" |
| Aversión a la pérdida | Perder duele cerca del doble de lo que agrada ganar | "Evita observaciones en tu auditoría" pega más que "mejora tu control" |
| Fluidez cognitiva | Lo fácil de leer se percibe como más cierto | La legibilidad es persuasión |
| Bucle abierto | Una pregunta sin responder genera tensión que empuja a seguir | El gancho de la lámina 1 nunca se responde en la lámina 1 |
| Autoridad prestada | La confianza se transfiere entre instituciones | CCL y APPROLOG en las piezas de fondo de embudo |
| Anclaje | El primer número condiciona la percepción de todos los siguientes | Menciona el costo del problema antes que el valor de la solución |

### 6.6 Escalera de llamados a la acción

Ordenados de menor a mayor compromiso. Nunca uses el escalón 4 en contenido de conciencia.

1. **Conversacional:** "¿Te ha pasado? Cuéntanos en los comentarios." → contenido de problema
2. **De valor:** "Tenemos una guía con las 7 causas más comunes. ¿La quieres?" → contenido educativo
3. **De diagnóstico:** "Conversemos 15 minutos y te decimos si vale la pena revisarlo." → contenido de autoridad
4. **Comercial directo:** "Solicita tu propuesta." → solo para quien ya conversó contigo

### 6.7 Prompts de copywriting

Estos van como texto (no imagen), a Claude/ChatGPT/Gemini.

**Generador de carrusel completo:**
> Actúa como copywriter B2B especializado en consultoría de procesos, datos e IA para empresas peruanas en fase de escalar. Escribe un carrusel de 8 láminas sobre [TEMA] siguiendo esta secuencia: gancho, problema, riesgo, educación (por qué), educación (cómo, en 3 pasos), autoridad, frase de la mascota, invitación. Audiencia: fundadores, gerentes generales o gerentes operativos de empresas peruanas con más de 6 empleados y facturación mensual mayor a S/ 50,000, que quieren ordenar procesos, conectar información, automatizar y desarrollar agentes de IA. Están en fase de escalar y sienten que la operación creció más rápido que sus sistemas. Su dolor real no es "no tener tecnología" — es no ver lo que pasa dentro de su propio negocio. Tono: directo, claro y entendible. Cero exageración, cero signos de exclamación, cero lenguaje de venta agresiva. Habla de KPIs y datos con energía y placer, no con miedo ni advertencias. Agita el problema con datos concretos, nunca con adjetivos alarmistas. Restricciones: máximo 8 palabras en el gancho; máximo 45 palabras por lámina; español de Perú; sin emojis salvo en la lámina de la mascota. El llamado a la acción debe invitar a conversar, nunca a comprar.

**Corrector de tono (anti-hype):**
> Reescribe el siguiente texto eliminando toda exageración, urgencia artificial y lenguaje de venta agresiva. Sustituye los adjetivos alarmistas por datos concretos o consecuencias operativas verificables. Mantén el mismo mensaje pero con registro sobrio y profesional, dirigido a un gerente de operaciones con años de experiencia que desconfía del marketing. Texto: [PEGA AQUÍ]

**Generador de ganchos:**
> Genera 10 ganchos de máximo 8 palabras para un carrusel de LinkedIn sobre [TEMA], dirigido a fundadores y gerentes de empresas peruanas de más de 6 empleados que facturan más de S/ 50,000 mensuales y buscan ordenar sus procesos, conectar su información y automatizar operaciones. Cada gancho debe abrir un bucle mental — plantear algo que exija seguir leyendo para resolverse. Prohibido: signos de exclamación, mayúsculas sostenidas, promesas de resultados, la palabra "secreto" y las frases "¿Sabías que…?" y "Esto te va a sorprender".

## 7. Reglas de oro y prohibiciones

✅ **Siempre**
- Pega el BLOQUE MAESTRO al final de cada prompt.
- Pide espacio negativo para el texto; el texto se agrega después.
- Sube la imagen de referencia de la mascota cuando la uses.
- Especifica el formato (1:1, 4:5, 9:16, 16:9) en cada prompt.
- Genera varias opciones y elige; la primera rara vez es la mejor.

❌ **Nunca**
- Logos ni marcas de terceros en las imágenes (FIFA, clubes, Microsoft, empresas clientes). Riesgo legal real.
- Rostros que parezcan personas reales identificables, ni caras de tu equipo generadas por IA.
- Textos largos generados por IA dentro de la imagen.
- Verde matrix, código cayendo, robots humanoides metálicos genéricos.
- Estética cyberpunk: fondos negros con neón morado o rosado, resplandores intensos, ambientes nocturnos futuristas.
- Texto por debajo de 32 px en piezas para redes.
- Pesos tipográficos Light o Thin sobre fondos de color.
- "Compra aquí", "Oferta limitada", "No te lo pierdas" y cualquier urgencia artificial.
- Signos de exclamación en el copy.
- Más de una lámina de riesgo por carrusel.
- Nombrar clientes en casos de éxito sin autorización escrita. Anonimiza siempre: "una operación con múltiples almacenes".
- Colores fuera de la paleta (nada de magenta o amarillo, aunque aparezcan en brochures heredados).
- Personas de banco de imágenes sonriendo a cámara con los brazos cruzados. Prefiere gente trabajando de verdad.
- Saturación excesiva o brillos exagerados.

## 8. Truco de consistencia: la imagen semilla

Cuando encuentres una imagen que te encante, guárdala en `assets/referencias/`. La próxima vez, súbela junto al prompt y escribe:

> "Genera una nueva imagen con exactamente el mismo estilo visual, paleta e iluminación que esta referencia, pero con el siguiente contenido: [describe]."

Esta es la forma más confiable de mantener coherencia mes a mes, mucho más que confiar en la descripción escrita.

## 9. Próximos pasos recomendados (del documento original)

- Armar plantillas de Canva con este sistema: portada de carrusel, lámina interior y post cuadrado.
- Crear un banco de referencias: 10–15 imágenes generadas con este libro que sirvan de semilla para futuras piezas.
- Complementar con un Company Brief (qué hace ARQUIE: líneas de negocio, sectores, respaldos, historia).
- Pilotear un primer carrusel con la estructura de la sección 6.4, medir engagement y comentarios, y ajustar.

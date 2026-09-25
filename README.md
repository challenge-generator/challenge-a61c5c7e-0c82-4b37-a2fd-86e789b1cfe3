# Optimización de la gestión de contenedores en un entorno de producción

La empresa fintech 'Fintech Innovations' ha experimentado un crecimiento significativo en sus aplicaciones basadas en contenedores. Actualmente, enfrentan desafíos en la gestión del ciclo de vida de estos contenedores, incluyendo despliegues, escalado y monitoreo. El equipo de DevSecOps necesita optimizar la orquestación de contenedores para asegurar una alta disponibilidad y rendimiento de las aplicaciones. Los actores involucrados son el 'equipo de desarrollo', el'sistema de orquestación' y el'monitor de rendimiento'. La operación clave es el 'escalado automático de contenedores' con umbrales definidos de '1 000 solicitudes por segundo' y modo de falla 'timeout de 5 segundos'. El objetivo es reducir el tiempo de inactividad y mejorar la eficiencia operativa.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | orquestación de contenedores |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 20 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Evaluación del sistema de orquestación existente

**Objetivo:** Identificar las limitaciones y puntos de mejora en el sistema de orquestación actual.

**Tiempo estimado:** 5 horas

**Instrucciones:**

- Analiza el sistema de orquestación existente para identificar las limitaciones y puntos de mejora. Considera aspectos como la escalabilidad, la latencia y la tolerancia a fallos. Proporciona un informe detallado con tus hallazgos.

**Entregable:** Informe de evaluación del sistema de orquestación.

<details>
<summary>Pistas de conocimiento</summary>

- Considera la consistencia de los datos entre los contenedores y el sistema de orquestación.
- Evalúa el impacto de las actualizaciones de contenedores en la disponibilidad del servicio.

</details>

### Fase 2: Diseño de la estrategia de orquestación optimizada

**Objetivo:** Proponer una estrategia de orquestación que aborde las limitaciones identificadas y mejore la eficiencia operativa.

**Tiempo estimado:** 8 horas

**Instrucciones:**

- Basándote en el informe de evaluación, diseña una estrategia de orquestación optimizada. Considera aspectos como el escalado automático, la tolerancia a fallos y la monitorización del rendimiento. Proporciona un documento de diseño detallado.

**Entregable:** Documento de diseño de la estrategia de orquestación optimizada.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el uso de patrones de diseño como el 'sidecar' para mejorar la tolerancia a fallos.
- Evalúa la implementación de políticas de escalado automático basadas en métricas de rendimiento.

</details>

### Fase 3: Implementación y validación de la estrategia de orquestación

**Objetivo:** Implementar la estrategia de orquestación propuesta y validar su eficacia en un entorno de pruebas.

**Tiempo estimado:** 7 horas

**Instrucciones:**

- Implementa la estrategia de orquestación propuesta en un entorno de pruebas. Realiza pruebas de carga y estrés para validar la eficacia de la estrategia. Proporciona un informe de validación detallado.

**Entregable:** Informe de validación de la estrategia de orquestación.

<details>
<summary>Pistas de conocimiento</summary>

- Utiliza herramientas de pruebas de carga como 'Apache JMeter' para simular escenarios de alta demanda.
- Monitorea el rendimiento del sistema durante las pruebas para identificar posibles puntos de mejora.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es la orquestación de contenedores y por qué es importante en un entorno de producción?
- **paraQueSirve**: ¿Para qué sirve la orquestación de contenedores en el contexto de Fintech Innovations?
- **comoSeUsa**: ¿Cómo se utiliza la orquestación de contenedores para mejorar la eficiencia operativa?
- **erroresComunes**: ¿Cuáles son los errores comunes en la orquestación de contenedores y cómo se pueden evitar?
- **queDecisionesImplica**: ¿Qué decisiones implica la implementación de una estrategia de orquestación optimizada?

## Criterios de Evaluacion

- Identificación de las limitaciones y puntos de mejora en el sistema de orquestación existente.
- Propuesta de una estrategia de orquestación optimizada que aborde las limitaciones identificadas.
- Implementación y validación efectiva de la estrategia de orquestación en un entorno de pruebas.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
docker build -t reto:local . && terraform -chdir=terraform init -backend=false && terraform -chdir=terraform validate
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*

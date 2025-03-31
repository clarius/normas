![Icon](https://github.com/clarius/openlaw/raw/main/assets/img/icon.png) OpenLaw - Argentina, Jurisdicción Nacional
============

![Leyes Vigentes](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fbit.ly%2Fsaij-leyes&query=%24.searchResults.categoriesResultList%5B0%5D.facetChildren%5B0%5D.facetHits&label=Leyes%20Vigentes)
![Dynamic JSON Badge](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fbit.ly%2Fsaij-decretos&query=%24.searchResults.categoriesResultList%5B0%5D.facetChildren%5B0%5D.facetHits&label=Decretos%20Vigentes&color=purple)

Normas argentinas (leyes y decretos) de jurisdicción nacional, actualizadas usando [OpenLaw](https://github.com/clarius/openlaw).

Actualización automática de lunes a viernes a las 22hs, incorporadas (merged) al repositorio de martes a sábado a las 10am. 
Para evitar el merge automático, un pull-request puede asignarse a uno o más revisores.

Los documentos están organizados por el tipo de norma en las carpetas `ley` y `decreto`. Cada norma esta en un archivo 
individual en formato markdown, por ejemplo la [Ley Antimafias](ley/LNS0007841.md). 

## Documentos

El formato de los documentos está diseñado para ser fácilmente legible tanto por personas como programas, por lo cual se encuentra 
estructurado de la siguiente manera, en formato [markdown](https://en.wikipedia.org/wiki/Markdown):

```md
---
YAML
---
# Titulo

## Capítulos

<a id="1"></a>
Artículo 1º- 
```

### Contenido

El contenido de la norma, utiliza el formato `mardown` básico, sólo conteniendo indicadores de cabeceras (#, ##, etc.) para 
título y capítulos/secciones de la norma, y anchors/links sobre cada artículo para poder crear vínculos directos específicos, 
como por ejemplo [ley/LNS0007841.md#6](ley/LNS0007841.md#6) 
para el artículo 6.

GitHub provee automáticamente una tabla de contenidos y links directos a todas las secciones del documento, por ejemplo 
[CAPÍTULO IV Decomiso anticipado](ley/LNS0007841.md#cap%C3%ADtulo-iv-decomiso-anticipado), la que 
se hace visible al hacer click en el ícono correspondiente:

![image](https://github.com/user-attachments/assets/842fb140-e898-4dd6-ac6f-c6e2b861b72b)

### Metadata

La seccion en formato YAML (denominada front-matter y popularizadas por [Jekyll](https://jekyllrb.com/docs/front-matter/) y
[GitHub](https://docs.github.com/en/contributing/writing-for-github-docs/using-yaml-frontmatter)) permite visualizar rápidamente metadata básica de una norma en GitHub en formato de tabla al inicio del documento  como puede verse en la captura de la seccion anterior.

Esta metadata no es normativa, se encuentra en español y provee información útil como el link directo a la fuente de datos de la norma en el sistema [SAIJ](https://www.saij.gob.ar), como el caso de la [Ley Antimafias](https://www.saij.gob.ar/LNS0007841). Esta sección utiliza el separador markdown estándard 
`---` al inicio y fin de la sección.

La metadata completa de un articulo se encuentra en la carpeta `data/[Id].json`. El `Id` puede extraerse programaticamente 
del YAML front-matter. Por ejemplo, ver metadata completa de la [Ley Antimafias](ley/data/123456789-0abc-defg-g14-87000scanyel.json).

### Desarrolladores

Este repositorio puede utilizarse eficientemente para recolectar estadisticas relacionadas con las leyes argentinas.
Es altamente recomendado familiarizarse con [jq](https://jqlang.org/manual/) para sacarle el mejor provecho a la 
disponibilidad de los JSON completos del sistema SAIJ.

Los ejemplos siguientes utilizan pwsh (powershell cross-platform) y jq (en cualquier sistema operativo).

#### Valores unicos de 'estado' de las leyes y decretos

```pwsh
dir -r *.json | gc | jq -r '.document.content | .estado // .status' | select -unique
```
Resultados:
```
Vigente, de alcance general
Individual, Solo Modificatoria o Sin Eficacia
A
Derogada
Vetada
```

#### Lista de normas con la palabra `Covid` en el titulo

```pwsh
cd ./ley
dir -r *.json | gc | jq -r '.document.content | select(.["titulo-norma"]? // "" | ascii_downcase | contains("covid")) | .["nombre-coloquial"] + ": " + .["titulo-norma"]' | where {$_}
``` 
Resultados:
```
DECRETO NACIONAL 260/2020: Decreto de Necesidad y Urgencia sobre Emergencia Sanitaria en virtud de la Pandemia declarada por la Organización Mundial De La Salud  en relación con el coronavirus COVID-19 por el plazo de 1 año
DECRETO NACIONAL 1/2022: Donación de Vacunas contra la Covid-19 a favor del Gobierno de la República Árabe De Egipto
DECRETO NACIONAL 411/2021: Decreto de Necesidad y Urgencia que establece medidas generales de prevención de Covid-19 destinadas a mitigar la transmisión del virus hasta el día 9 de julio de 2021, inclusive
DECRETO NACIONAL 811/2020: Aprobación del Modelo de Contrato de Préstamo CAF a celebrarse con la Corporación Andina de Fomento destinado a financiar el "Programa de Apoyo al Plan Nacional Argentina Contra el Hambre en la Emergencia Socio-Sanitaria COVID-19"
DECRETO NACIONAL 431/2021: Decreto de Necesidad y Urgencia que establece el Marco legal para el desarrollo del Plan Nacional de Vacunación Destinado a Generar Inmunidad Adquirida contra la COVID-19 con Inclusión de la Protección de los Niños, las Niñas y Adolescentes
DECRETO NACIONAL 352/2020: Creación del Programa para la Emergencia Financiera Provincial para asistir financieramente a las provincias por las necesidades ocasionadas por la epidemia de Covid-19
DECRETO NACIONAL 853/2021: Aprobación del Contrato de Financiación a celebrarse con el Banco Europeo de Inversiones destinado a financiar el Proyecto de Apoyo al Plan Estratégico para la Vacunación Contra la Covid-19 en la República Argentina
DECRETO NACIONAL 494/2021: Decreto de Necesidad y Urgencia que establece Nuevas Medidas Generales de Prevención de la Covid-19 y Nuevos Parámetros para Definir Situaciones de Alarma Epidemiológica y Sanitaria que regirá hasta el día 1 de octubre de 2021 inclusive
DECRETO NACIONAL 835/2021: Donación de Vacunas contra la Covid-19 a favor de la República De Filipinas
...
```


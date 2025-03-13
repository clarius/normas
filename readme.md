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

![Icon](https://github.com/clarius/openlaw/raw/main/assets/img/icon.png) OpenLaw - Argentina, Jurisdicción Nacional
============

![Leyes Vigentes](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fbit.ly%2Fsaij-leyes&query=%24.searchResults.categoriesResultList%5B0%5D.facetChildren%5B0%5D.facetHits&label=Leyes%20Vigentes)
![Dynamic JSON Badge](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fbit.ly%2Fsaij-decretos&query=%24.searchResults.categoriesResultList%5B0%5D.facetChildren%5B0%5D.facetHits&label=Decretos%20Vigentes&color=purple)

Normas argentinas (leyes y decretos) de jurisdicción nacional, actualizadas usando [OpenLaw](https://github.com/clarius/openlaw).

Actualización automática de lunes a viernes a las 22hs, incorporadas (merged) al repositorio de martes a sábado a las 10am. 
Para evitar el merge automático, un pull-request puede asignarse a uno o más revisores.

Los documentos están organizados por el tipo de norma en las carpetas `ley` y `decreto`. Cada norma esta en un archivo 
individual en formato markdown, por ejemplo la [Ley Antimafias](ley/123456789-0abc-defg-g14-87000scanyel.md). 

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

<!-- 
YAML
-->
```

### Contenido

El contenido de la norma, utiliza el formato `mardown` básico, sólo conteniendo indicadores de cabeceras (#, ##, etc.) para 
título y capítulos/secciones de la norma, y anchors/links sobre cada artículo para poder crear vínculos directos específicos, 
como por ejemplo [ley/123456789-0abc-defg-g14-87000scanyel.md#6](https://github.com/clarius/normas/blob/main/ley/123456789-0abc-defg-g14-87000scanyel.md#6) 
para el artículo 6.

GitHub provee automáticamente una tabla de contenidos y links directos a todas las secciones del documento, por ejemplo 
[CAPÍTULO IV Decomiso anticipado](ley/123456789-0abc-defg-g14-87000scanyel.md#cap%C3%ADtulo-iv-decomiso-anticipado), la que 
se hace visible al hacer click en el ícono correspondiente:

![image](https://github.com/user-attachments/assets/d6709674-3bb6-402b-99dc-913254b339a3)

### Metadata

Las secciones en formato YAML (denominadas front-matter y popularizadas por [Jekyll](https://jekyllrb.com/docs/front-matter/) y
[GitHub](https://docs.github.com/en/contributing/writing-for-github-docs/using-yaml-frontmatter)) cumplen dos propósitos utilizando 
un mismo formato: 

- Al inicio: permite visualizar rápidamente metadata básica de una norma en GitHub en formato de table al inicio del documento,
  como puede verse en la captura de la seccion [contenido](#contenido).

  Esta sección no es normativa, se encuentra en español y provee información útil como links directos a la fuente de 
  datos de la norma en el sistema [SAIJ](https://www.saij.gob.ar), como el caso de la [Ley Antimafias](https://www.saij.gob.ar/LNS0007841).
  Esta sección utiliza el separador markdown estándard `---` al inicio y fin de la sección.

- Al final: metadata normativa de [OpenLaw](https://github.com/clarius/OpenLaw) para consumo programático, usando
  delimitador de HTML `<!--` y `-->` al inicio y fin de la sección respectivamente. La elección de este delimitador
  (también estándard en front-matter, pero no tan común en documentos markdown) obedece a poder ocultarla automáticamente
  cuando se visualiza un documento en GitHub, mejorando su legibilidad.


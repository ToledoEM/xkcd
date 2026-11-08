# Draw a stick figure

Draws one stick figure per row of \`data\`. The figure is built from
eight fuzzy elements – a circular head plus seven bones (spine, two
humeri, two radii and two legs) – which are emitted as just two
\[geom_xkcdpath()\] layers.

## Usage

``` r
xkcdman(mapping, data, seed = NULL, ...)
```

## Arguments

- mapping:

  Aesthetic mapping

- data:

  Dataset

- seed:

  Optional integer for a reproducible figure. See \[geom_xkcdpath()\].

- ...:

  Optional arguments passed on to \[geom_xkcdpath()\].

## Details

The following aesthetics are required, supplied through \`mapping\` or
as columns of \`data\`: \`x\` and \`y\` (centre of the head), \`scale\`
(overall size), \`ratioxy\` (the x/y scale ratio, which keeps the figure
from being distorted when the axes have different units), and the angles
\`angleofspine\`, \`anglerighthumerus\`, \`anglelefthumerus\`,
\`anglerightradius\`, \`angleleftradius\`, \`anglerightleg\`,
\`angleleftleg\` and \`angleofneck\`.

## See also

\[geom_xkcdpath()\]

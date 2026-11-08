# Draw lines or circles

Deprecated in favour of \[geom_xkcdpath()\], which integrates with
ggplot2's aesthetic machinery instead of rebuilding mappings by hand.
Migrate segments to \`geom_xkcdpath(aes(x = x, y = y, xend = xend, yend
= yend), ...)\` and circles to the \`diameter\` aesthetic.

## Usage

``` r
xkcdline(mapping, data, typexkcdline = "segment", mask = TRUE, ...)
```

## Arguments

- mapping:

  Aesthetic mapping

- data:

  Dataset

- typexkcdline:

  "segment" or "circunference"

- mask:

  Logical

- ...:

  Additional arguments

## See also

\[geom_xkcdpath()\]

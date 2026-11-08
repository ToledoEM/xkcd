# Plot the axis

This function plots the axis in an XKCD style.

## Usage

``` r
xkcdaxis(xrange, yrange, ...)
```

## Arguments

- xrange:

  The range of the X axe.

- yrange:

  The range of the Y axe.

- ...:

  Other arguments passed to geom_xkcdpath.

## Value

A list of layers containing the axes, coordinate system, and theme.

## Examples

``` r
if (FALSE) { # \dontrun{
xrange <- range(mtcars$mpg)
yrange <- range(mtcars$wt)
p <- ggplot() +
     geom_point(aes(mpg, wt), data=mtcars) +
     xkcdaxis(xrange,yrange)
p
} # }
```

# cran-comments

## Submission summary

This is a maintenance release of xkcd (0.1.0 -> 0.1.1).

The main purpose of this submission is to fix the NOTE currently shown on the CRAN
check page for the five r-devel flavors:

```
checking R code for possible problems ... NOTE
  '.Label' should be changed to 'levels'
```

The vignette built a factor with the deprecated `structure(..., .Label = )` idiom.
It now uses `factor(..., labels = )`, which produces an identical factor
(verified with `identical()`).

Also in this release:

* `xkcdrect()` was rewritten as a standard ggplot2 geom (`GeomXkcdRect`). It
  previously evaluated its own `aes()` mapping with `rlang::eval_tidy()`, which
  meant it silently ignored faceting, the `.data` pronoun, and plot-level
  aesthetics. It now returns a single layer and uses the standard `fill`,
  `colour` and `linewidth` aesthetics.
* `geom_xkcdpath()`, `xkcdrect()` and `xkcdman()` gained a `seed` argument, so
  plots can be reproduced exactly. The global random state is left unchanged.
* `xkcdman()` now uses `geom_xkcdpath()` internally, reducing a stick figure from
  eight layer-producing calls to two layers.
* `xkcdline()` is deprecated in favour of `geom_xkcdpath()` and now warns.
* A `testthat` suite was added; the package previously had no tests.
* `rlang` was dropped from Imports, as the rewrite removed its only use.

## Test environments

* local macOS (aarch64-apple-darwin, Darwin 25.6.0), R 4.6.1

## R CMD check results

`R CMD check --no-manual` gives:

```
0 errors | 0 warnings | 0 notes
```

Status: OK

## Reverse dependencies

There are no reverse dependencies on CRAN (checked with
`tools::package_dependencies("xkcd", reverse = TRUE)`), so the `xkcdrect()`
interface change below breaks no other CRAN package.

## Notes on backward compatibility

`xkcdrect()` changed in a user-visible way: it now returns a single layer rather
than a list of five, and the `fillcolour`, `bordercolour` and `borderlinewidth`
arguments were replaced by the standard `fill`, `colour` and `linewidth`
aesthetics. The three old argument names continue to work for this release and
issue a warning directing users to the replacements.

`xkcdline()` is deprecated but still exported and functional; it warns via
`.Deprecated()`.

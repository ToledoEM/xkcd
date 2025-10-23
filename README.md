# xkcd

An R package to create hand-drawn (xkcd-style) plots and elements for ggplot2.

This repository contains the source for the `xkcd` package (development version).

Originally from https://r-forge.r-project.org/projects/xkcd/ and now pulled out of CRAN

## Install


Install the current development version from GitHub (dev):

```r
# using remotes
remotes::install_github("ToledoEM/xkcd")

# or using devtools
devtools::install_github("ToledoEM/xkcd")
```
## Quick example

```r
library(xkcd)
library(ggplot2)

df <- data.frame(x = 1:10, y = cumsum(runif(10, -0.5, 0.8)))

ggplot(df, aes(x = x, y = y)) +
  geom_xkcdpath(linewidth = 1, colour = "black") +
  theme_xkcd()
```

Notes:
- The package uses `Hmisc::bezier()` internally for smoothing paths.
- The package prefers `linewidth` (ggplot2 >= 3.4.0) for line thickness; older code using `size` is supported where possible.
- For proper xkcd fonts you may want to install and register fonts with `extrafont::font_import()` and `extrafont::loadfonts()`.

Font load order note:

 - To ensure system fonts are discovered correctly, load `extrafont` and call `extrafont::loadfonts()` after loading the package and before plotting. Example:

```r
library(xkcd)
library(extrafont)
extrafont::loadfonts(device = "win", quiet = TRUE) # or device = "pdf"/"postscript" as needed
# then create your plot that uses xkcd fonts
```

Loading `extrafont` and calling `loadfonts()` before the plotting session ensures fonts are registered with R's graphics device and will be available to `theme_xkcd()` and other functions that use the xkcd fonts.

Automatic (opt-in) font loading

If you prefer the package to attempt to register system fonts automatically on attach, set the option `xkcd.auto_load_fonts` to `TRUE` **before** calling `library(xkcd)`. This is opt-in to avoid surprising side-effects during package attach.

```r
# Enable automatic font loading (opt-in)
options(xkcd.auto_load_fonts = TRUE)
library(xkcd)
# The package will attempt to call extrafont::loadfonts() for common devices
```

## Development

To set up a development workflow (document, check, install), the following `devtools` / `remotes` helpers are useful:

```r
# regenerate documentation from roxygen comments
devtools::document()

# run package checks (skip building PDF manual if you don't have LaTeX installed)
devtools::check(args = "--no-manual")

# build vignettes locally
devtools::build_vignettes()

# install the package from the local source
devtools::install_local()
```

To render vignette sources directly:

```r
rmarkdown::render("vignettes/xkcd-intro.Rmd")
```

## Dependencies

The package relies on (at least):

- ggplot2
- Hmisc
- grid
- extrafont (for optional fonts)

These will be declared in the package `DESCRIPTION`; when developing locally you can install them with:

```r
install.packages(c("ggplot2", "Hmisc", "grid"))
remotes::install_cran("extrafont")
```

## Contributing

Contributions, bug reports, and pull requests are welcome. Please open an issue describing the change and include a minimal reproducible example if relevant.

## License

This repository does not include a LICENSE file. If you intend to publish or share the package, add a suitable `LICENSE` file (e.g. MIT) to the repository.

pkgname <- "xkcd"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('xkcd')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("theme_xkcd")
### * theme_xkcd

flush(stderr()); flush(stdout())

### Name: theme_xkcd
### Title: Creates an XKCD theme
### Aliases: theme_xkcd

### ** Examples

## Not run: 
##D # Assuming 'xkcd' font is installed and registered:
##D p <- ggplot(mtcars, aes(mpg, wt)) +
##D      geom_point() +
##D      theme_xkcd()
##D p
## End(Not run)



cleanEx()
nameEx("xkcd-package")
### * xkcd-package

flush(stderr()); flush(stdout())

### Name: xkcd-package
### Title: Plotting ggplot2 Graphics in an XKCD Style
### Aliases: xkcd-package xkcd
### Keywords: package

### ** Examples

## Not run: vignette("xkcd-intro")



cleanEx()
nameEx("xkcdaxis")
### * xkcdaxis

flush(stderr()); flush(stdout())

### Name: xkcdaxis
### Title: Plot the axis
### Aliases: xkcdaxis

### ** Examples

## Not run: 
##D xrange <- range(mtcars$mpg)
##D yrange <- range(mtcars$wt)
##D p <- ggplot() +
##D      geom_point(aes(mpg, wt), data=mtcars) +
##D      xkcdaxis(xrange,yrange)
##D p
## End(Not run)



cleanEx()
nameEx("xkcdrect")
### * xkcdrect

flush(stderr()); flush(stdout())

### Name: xkcdrect
### Title: Draw fuzzy rectangles
### Aliases: xkcdrect
### Keywords: manip

### ** Examples

## Not run: 
##D volunteers <- data.frame(year = c(2007:2011),
##D                          number = c(56470, 56998, 59686, 61783, 64251))
##D 
##D xrange <- range(volunteers$year)
##D yrange <- range(volunteers$number)
##D 
##D p <- ggplot() + 
##D      xkcdrect(aes(xmin = year - 0.2, 
##D                   xmax = year + 0.2,
##D                   ymin = number - 500,
##D                   ymax = number + 500),
##D               data = volunteers, 
##D               fillcolour = "pink",
##D               borderlinewidth = 1.2) +
##D      geom_point(aes(x = year, y = number), data = volunteers) +
##D      xkcdaxis(xrange, yrange) +
##D      theme_xkcd()
##D p
## End(Not run)



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')

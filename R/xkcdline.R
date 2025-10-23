


pointscircunference <- function(x =0, y=0, diameter = 1, ratioxy=1, npoints = 16, alpha=  runif(1, 0, pi/2)){
  center <- c(x,y)
  r <- rep( diameter / 2, npoints )
  tt <- seq(alpha,2*pi + alpha,length.out = npoints)
  r <- jitter(r)
  sector <-  tt > alpha & tt <= ( pi/ 2 + alpha)
  r[ sector ] <- r[sector] * 1.05
  sector <-  tt > ( 2 * pi/2 + alpha)  & tt < (3* pi/ 2 +alpha)
  r[ sector ] <- r[sector] * 0.95
  xx <- center[1] + r * cos(tt) * ratioxy
  yy <- center[2] + r * sin(tt)
  return(data.frame(bezier(x = xx, y =yy,evaluation=60)))
}


pointssegment <- function(x, y, xend, yend, npoints = 10, xjitteramount= 0, yjitteramount=0, bezier = TRUE) {
  ##require(Hmisc) # bezier
  if(npoints < 2 )
    stop("npoints must be greater than 1")
  ## If there are no jitters, do not interpolate
  if( xjitteramount == 0 & yjitteramount == 0) npoints <- 2
  xbegin <- x
  ybegin <- y
  x <- seq(xbegin,xend,length.out = npoints)
  if( (xend - xbegin) != 0 ) {
    y <- (yend - ybegin) * ( x - xbegin ) / (xend - xbegin) + ybegin
  } else {
    y <-  seq(ybegin, yend, length.out = npoints)
  }
  if(xjitteramount !=0) x <- jitter(x, amount=xjitteramount)
  if(yjitteramount !=0) y <- jitter(y, amount=yjitteramount)
  x[1] <- xbegin
  y[1] <- ybegin
  x[length(x)] <- xend
  y[length(y)] <- yend
  if(bezier & length(x)>2 & (xjitteramount != 0 | yjitteramount != 0)) {
    data <- data.frame(bezier(x=x, y=y, evaluation=30))
  }
  else data <- data.frame(x=x,y=y)
  data
}




#' @rdname geom_xkcdpath
#' @importFrom ggplot2 ggproto GeomPath aes layer
#' @importFrom grid gList polylineGrob gpar
GeomXkcdPath <- ggplot2::ggproto("GeomXkcdPath", ggplot2::GeomPath,
                                 
                                 required_aes = c("x", "y"),
                                 
                                 default_aes = ggplot2::aes(
                                   colour = "black", linewidth = 0.5, linetype = 1, alpha = NA,
                                   xend = NA, yend = NA, diameter = NA,
                                   xjitteramount = 0, yjitteramount = 0,
                                   npoints = 30, ratioxy = 1, bezier = TRUE,
                                   mask = TRUE, group = 1
                                 ),
                                 
                                 draw_group = function(data, panel_params, coord) {
                                   is_segment <- !is.na(data$xend[1]) & !is.na(data$yend[1])
                                   is_circle <- !is.na(data$diameter[1])
                                   
                                   params <- list(
                                     npoints = data$npoints[1],
                                     xjitteramount = data$xjitteramount[1],
                                     yjitteramount = data$yjitteramount[1],
                                     ratioxy = data$ratioxy[1],
                                     bezier = data$bezier[1]
                                   )
                                   
                                   if (is_segment) {
                                     path_data <- pointssegment(
                                       x = data$x[1], y = data$y[1], xend = data$xend[1], yend = data$yend[1],
                                       npoints = params$npoints, xjitteramount = params$xjitteramount,
                                       yjitteramount = params$yjitteramount, bezier = params$bezier
                                     )
                                   } else if (is_circle) {
                                     path_data <- pointscircunference(
                                       x = data$x[1], y = data$y[1], diameter = data$diameter[1],
                                       ratioxy = params$ratioxy, npoints = params$npoints
                                     )
                                   } else {
                                     path_data <- data.frame(
                                       x = data$x + stats::runif(length(data$x), -data$xjitteramount[1], data$xjitteramount[1]),
                                       y = data$y + stats::runif(length(data$y), -data$yjitteramount[1], data$yjitteramount[1]),
                                       group = data$group
                                     )
                                   }
                                   
                                   grob_list <- grid::gList()
                                   data_grob <- coord$transform(path_data, panel_params)
                                   
                                   draw_aes <- data[1, names(data) %in% names(ggplot2::GeomPath$default_aes)]
                                   
                                   if (data$mask[1] == TRUE) {
                                     mask_size <- max(draw_aes$size * 2, 3)
                                     mask_grob <- grid::polylineGrob(
                                       x = data_grob$x, y = data_grob$y, id = data_grob$group,
                                       default.units = "native",
                                       gp = grid::gpar(
                                         col = "white",
                                         lwd = mask_size * .pt,
                                         lty = draw_aes$linetype,
                                         lineend = "round"
                                       )
                                     )
                                     grob_list <- grid::gList(grob_list, mask_grob)
                                   }
                                   
                                   line_grob <- grid::polylineGrob(
                                     x = data_grob$x, y = data_grob$y, id = data_grob$group,
                                     default.units = "native",
                                     gp = grid::gpar(
                                       col = draw_aes$colour,
                                       lwd = draw_aes$size * .pt,
                                       lty = draw_aes$linetype,
                                       lineend = "round"
                                     )
                                   )
                                   
                                   grob_list <- grid::gList(grob_list, line_grob)
                                   
                                   return(grob_list)
                                 }
)

#' @title Draw lines or circles in an XKCD style
#'
#' @description This function draws handwritten lines, segments, circles, or paths in the XKCD style.
#'
#' @usage
#' geom_xkcdpath(mapping = NULL, data = NULL, stat = "identity", position = "identity", ...,
#'   xjitteramount = NULL, yjitteramount = NULL, npoints = NULL, ratioxy = NULL, 
#'   bezier = FALSE, mask = FALSE, na.rm = FALSE, show.legend = NA, inherit.aes = TRUE)
#'
#' @inheritParams ggplot2::geom_path
#' @param mapping Aesthetic mapping generated by \code{\link[ggplot2]{aes}}.
#' @param data Dataset used in this layer.
#' @param xjitteramount Amount of random horizontal displacement (jitter) to apply to the path points (in data units).
#' @param yjitteramount Amount of random vertical displacement (jitter) to apply to the path points (in data units).
#' @param npoints Number of points for interpolation, which determines the fidelity of the jittered line.
#' @param ratioxy The ratio of the x range to the y range (e.g., \code{diff(xrange) / diff(yrange)}), used to correctly scale circular elements.
#' @param bezier Logical. If \code{TRUE}, applies Bezier curve smoothing via \code{Hmisc::bezier} to the jittered path.
#' @param mask Logical. If \code{TRUE}, draws a thick white mask path underneath the primary path to simulate a "hand-drawn" outline.
#' @param ... Other arguments passed to the Geom.
#'
#' @details
#' Required aesthetics depend on the geometry:
#' \itemize{
#' \item \strong{Segment}: \code{x, y, xend, yend}
#' \item \strong{Circle}: \code{x, y, diameter}
#' \item \strong{Path}: \code{x, y}
#' }
#'
#' @export
geom_xkcdpath <- function(mapping = NULL, data = NULL, stat = "identity",
                          position = "identity", ..., na.rm = FALSE,
                          show.legend = NA, inherit.aes = TRUE) {
  ggplot2::layer(
    data = data,
    mapping = mapping,
    stat = stat,
    geom = GeomXkcdPath,
    position = position,
    show.legend = show.legend,
    inherit.aes = inherit.aes,
    params = list(
      na.rm = na.rm,
      ...
    )
  )
}

#' @title Draw lines or circles in an XKCD style (Deprecated)
#'
#' @description This function is deprecated. Use \code{\link{geom_xkcdpath}} instead.
#'
#' @inheritParams geom_xkcdpath
#' @param typexkcdline DEPRECATED. The new Geom detects type from aesthetics.
#' @export
xkcdline <- function(mapping = NULL, data = NULL, typexkcdline = "segment", ...) {
  warning("xkcdline() is deprecated. Please use geom_xkcdpath() instead.")
  geom_xkcdpath(mapping = mapping, data = data, ...)
}
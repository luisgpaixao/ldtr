#' Create Fishnet
#'
#' Creates a fishnet of regular squares over a study area
#'
#' @param sta an sf Simple feature collection representing the study area for analysis.
#' @param square_size an integer value representing square side dimension, in meters.
#'
#' @return an sf Simple feature collection representing a regular square fishnet.
#' @export
create_fishnet <- function(sta, square_size){

  grid = st_as_sf(st_make_grid(sta, square_size, crs = st_crs(sta)))

  return(grid)
}


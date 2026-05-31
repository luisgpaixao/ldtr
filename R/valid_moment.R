#' Validate moment
#'
#' Check if moment's data is valid.
#'
#' @param mm a sf Simple polygon feature collection representing the moment.
#' @param index an integer value indicating moment index
#'
#' @return a sf Simple polygon feature collection representing the moment.
#' @export
valid_moment <- function(mm, index){
  
  if(is.na(st_crs(mm))){
    stop(paste0("CRS of moment", index, " not defined, please check your data.\n"), call. = T)
  }

  if(! all(st_layers(mm_path)$geomtype %in% c("Polygon", "3D Polygon"))){
    stop(paste0("Moment", index, " geometry type is not Polygon, please check your data.\n"), call. = T)
  }
  
  return(mm)
  
}
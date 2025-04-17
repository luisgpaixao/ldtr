#' Validate moment
#'
#' Read moment data and check if it's valid.
#'
#' @param mm_path an ESRI Shapefile path representing the moment.
#'
#' @return an sf Simple feature collection representing the moment.
#' @export
valid_moment <- function(mm_path, index){
  
  mm = st_read(mm_path)
  
  if((is.na(st_crs(mm)$units)) || (is.null(st_crs(mm)$units))){
    stop(paste0("CRS of moment", index, "not defined, please check your data.\n"), call. = T)
  }

  if(! all(st_layers(mm_path)$geomtype %in% c("Polygon", "3D Polygon"))){
    stop(paste0("Moment", index, "geometry type is not Polygon, please check your data.\n"), call. = T)
  }
  
  return(mm)
  
}
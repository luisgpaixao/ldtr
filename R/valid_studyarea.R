#' Validate study area
#'
#' Read study area data and check if it's valid.
#'
#' @param sta_path an ESRI Shapefile path representing the study area.
#'
#' @return an sf Simple feature collection representing the study area.
#' @export
valid_studyarea <- function(sta_path){
  
  sta = st_read(sta_path)
  if(nrow(sta)==0){
    stop("Empty study area, please check your data.\n", call. = T)
  }
  
  sta = sta[,"geometry"]
  if((is.na(st_crs(sta)$units)) || (is.null(st_crs(sta)$units)) || (st_crs(sta)$units != "m")){
    stop("CRS units of study area's Shapefile are not in meters, please check your data.\n", call. = T)
  }
  
  if(! all(st_geometry_type(sta) %in% c("POLYGON", "MULTIPOLYGON"))){
    stop("Study area's geometry type is not Polygon, please check your data.\n", call. = T)
  }
  
  return(sta)
  
}
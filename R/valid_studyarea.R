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
    stop("Empty study area, please check your data.\n")
  }
  
  sta = sta[,"geometry"]
  if((is.null(st_crs(sta)$units)) || (st_crs(sta)$units != "m")){
    stop("CRS units of study area's Shapefile are not in meters, please check your data.\n", call. = T)
  }
  
  return(sta)
  
}
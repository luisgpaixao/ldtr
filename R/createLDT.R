#' Create LDT object
#'
#' Constructor for LDT objects.
#'
#' @param studyarea a sf polygon layer object, from sf package, representing the study area.
#' @param moments a list of sf polygon layer objects, from sf package, representing the moments for analysis, by chronological order.
#' @param patches an integer value representing minimum area threshold of features, in square meters. Default to 5000.
#' @param squares an integer value representing square side dimension, in meters. Only used if type of analysis if set to squares. Default to 10000.
#' @param analysis_squares a logical value representing the type of analysis. If TRUE, the analysis is done by a regular grid of squares. If FALSE, the analysis is done by districts. Default to TRUE.
#' @param spatialshift a logical value representing if spatial shift is to be consider. Default to FALSE.
#' @param perforation a logical value representing if perforation is to be consider. Default to FALSE.
#' @param forecast a logical value representing if forecast is to be consider. Default to FALSE.
#' @param output a character value representing the path for the Geopackage or ESRI Shapefile output. Default to NULL.
#'
#' @return an LDT object.
#' @export
#'
#' @examples
#' \donttest{
#' 
#' If using Geopackage, with multiple layers, read sf object with layer argument:
#' 
#' path_gpkg = "/path_to_wd/target.gpkg"
#' 
#' std_area = st_read(path_gpkg, layer = "study_area")
#' 
#' list_moments = list(st_read(path_gpkg, layer = "moment1"), st_read(path_gpkg, layer = "moment2"))
#' 
#' or if using ESRI Shapefiles:
#' 
#' std_area = st_read("/path_to_wd/studyarea.shp")
#' 
#' list_moments = list(st_read(/path_to_wd/moment1.shp"), st_read("/path_to_wd/moment2.shp"))
#' 
#' # create a 2 moments 30000 meters square size Land dynamics object, considering patches over 1000 square meters, spatial shift, perforation and forecast
#' objLDT <- createLDT(std_area, list_moments, patches=1000, squares=30000, analysis_squares=T, spatialshift=T, perforation=T, 
#' forecast=T, output="/path_to_output/outLDT.gpkg")
#' }
createLDT <- function(studyarea, moments, patches=5000, squares=10000, 
                      analysis_squares=T, spatialshift=F, perforation=F, 
                      forecast=F, output=NULL) {


  default_clusterarea = 50000
  if((squares/1000) * (squares/1000) > default_clusterarea){
    gap_area = 1
  }else{
    gap_area = ceiling(default_clusterarea / ((squares/1000) * (squares/1000)))
  }

  if(length(moments) < 2){
    stop("Number of moments is less than 2. Please check Ldt object variables.\n", call. = T)
  }
  
  temp_fold = if(is.null(output)) {
    tempdir()
  } else {
    file.path(dirname(output), "temp")
  }
  
  new("Ldt",
      analysis_squares = analysis_squares,
      nmoments = length(moments),
      studyarea = studyarea,
      moments = moments,
      patches = patches,
      squares = squares,
      spatialshift = spatialshift,
      perforation = perforation,
      forecast = forecast,
      output = output,
      temp_fold = temp_fold,
      cluster_area = default_clusterarea,
      gap_area = ifelse(analysis_squares, gap_area, 1)
  )
}

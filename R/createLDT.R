#' Create LDT object
#'
#' Constructor for LDT objects.
#'
#' @param analysis_squares a logical value representing if the type of analysis is done by a regular grid of squares. If false, the type of analysis is done by districts.
#' @param nmoments an integer value representing the amount of moments to consider.
#' @param studyareapath a character value representing the path for the ESRI Shapefile that defines the study area.
#' @param momentspaths a vector of character values representing the paths for the ESRI Shapefiles that defines the moments for analysis, by chronological order.
#' @param patches an integer value representing minimum area threshold of features, in square meters.
#' @param squares an integer value representing square side dimension, in meters. Only used if type of analysis if set to squares.
#' @param spatialshift a logical value representing if spatial shift is to be consider.
#' @param perforation a logical value representing if perforation is to be consider.
#' @param forecast a logical value representing if forecast is to be consider.
#' @param output a character value representing the path for the ESRI Shapefile output.
#'
#' @return an LDT object.
#' @export
#'
#' @examples
#' \donttest{
#' # set working directory
#' setwd("/path_to_wd/")
#'
#' # create a 2 moments 30000 meters square size Land dynamics object, considering patches over 1000 square meters, spatial shift, perforation and forecast
#' objLDT <- createLDT(T, 2, "studyarea.shp", c("moment1.shp", "moment2.shp"), 1000, 30000, T, T, T, "outLDT.shp")
#' }
createLDT <- function(analysis_squares, nmoments, studyareapath, momentspaths,
                     patches, squares, spatialshift, perforation, forecast, output) {


  default_clusterarea = 50000
  if((squares/1000) * (squares/1000) > default_clusterarea){
    gap_area = 1
  }else{
    gap_area = ceiling(default_clusterarea / ((squares/1000) * (squares/1000)))
  }

  if(nmoments < 2 || length(momentspaths) < 2){
    stop("Number of moments is less than 2. Please check Ldt object variables.\n", call. = T)
  }

  if(nmoments != length(momentspaths)){
    stop("Number of moments is different than number of shapefile paths. Please check Ldt object variables.\n", call. = T)
  }

  if(analysis_squares){
    new("Ldt", analysis_squares = T, nmoments = nmoments, studyareapath = studyareapath,
        momentspaths = momentspaths, patches = patches, squares = squares, spatialshift = spatialshift, 
        perforation = perforation, forecast = forecast, output = output, temp_fold = file.path(dirname(output), "temp" ),
        cluster_area = default_clusterarea, gap_area = gap_area)
  }else{
    new("Ldt", analysis_squares = F, nmoments = nmoments, studyareapath = studyareapath,
        momentspaths = momentspaths, patches = patches, squares = squares, spatialshift = spatialshift, 
        perforation = perforation, forecast = forecast, output = output, temp_fold = file.path(dirname(output), "temp" ),
        cluster_area = default_clusterarea, gap_area = 1)
  }


}

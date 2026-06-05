#' Create LDT object
#'
#' Constructor for LDT objects.
#'
#' @param studyarea a sf Simple polygon feature collection, from sf package, representing the study area.
#' @param moments a list of sf Simple polygon feature collections, from sf package, representing the moments for analysis, by chronological order.
#' @param patches an integer value representing minimum area threshold of features, in square meters. Default to 5000.
#' @param squares an integer value representing square side dimension, in meters. Only used if type of analysis if set to squares. Default to 10000.
#' @param analysis_squares a logical value representing the type of analysis. If `TRUE`, the analysis is done by a regular grid of squares. If `FALSE`, the analysis is done by districts. Default to `TRUE`.
#' @param spatialshift a logical value representing if spatial shift is to be consider. Default to `FALSE`.
#' @param perforation a logical value representing if perforation is to be consider. Default to `FALSE`.
#' @param forecast a logical value representing if forecast is to be consider. Default to `FALSE`.
#'
#' @return an LDT object.
#' @export
#'
#' @examples
#' \donttest{
#' library(sf)
#' 
#' path_gpkg <- system.file(
#'   "extdata",
#'   "example_ldt.gpkg",
#'   package = "ldtr"
#' )
#'
#' std_area <- st_read(
#'   path_gpkg,
#'   layer = "study_area",
#'   quiet = TRUE
#' )
#'
#' list_moments <- list(
#'   st_read(path_gpkg, layer = "moment1", quiet = TRUE),
#'   st_read(path_gpkg, layer = "moment2", quiet = TRUE)
#' )
#' 
#' 
#' # Create a 2 moments 5000 meters square size Land dynamics object, 
#' considering patches over 1000 square meters, 
#' spatial shift, perforation and forecast
#' 
#' objLDT <- createLDT(std_area, 
#'                     list_moments, 
#'                     patches=1000,
#'                     squares=5000,
#'                     spatialshift=TRUE, 
#'                     perforation=TRUE, 
#'                     forecast=TRUE)
#' }
createLDT <- function(studyarea, moments, patches=5000, squares=10000, 
                      analysis_squares=TRUE, spatialshift=FALSE, perforation=FALSE, 
                      forecast=FALSE) {


  default_clusterarea = 50000
  if((squares/1000) * (squares/1000) > default_clusterarea){
    gap_area = 1
  }else{
    gap_area = ceiling(default_clusterarea / ((squares/1000) * (squares/1000)))
  }

  if(length(moments) < 2){
    stop("Number of moments is less than 2. Please check Ldt object variables.\n", call. = T)
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
      temp_fold = {
        x = tempfile(pattern = "ldtr_")
        dir.create(x)
        x
      },
      cluster_area = default_clusterarea,
      gap_area = ifelse(analysis_squares, gap_area, 1)
  )
}

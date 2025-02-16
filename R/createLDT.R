#' Create LDT object
#'
#' Constructor for LDT objects.
#'
#' @slot analysis_squares a logical value representing if the type of analysis is done by a regular grid of squares. If false, the type of analysis is done by districts.
#' @slot nmoments an integer value representing the amount of moments to consider.
#' @slot studyareapath a character value representing the path for the ESRI Shapefile that defines the study area.
#' @slot momentspaths a vector of character values representing the paths for the ESRI Shapefiles that defines the moments for analysis, by chronological order.
#' @slot patches an integer value representing minimum area threshold of features, in square meters.
#' @slot squares an integer value representing square side dimension, in meters. Only used if type of analysis e set to squares.
#' @slot perforation a logical value representing if perforation is to be consider.
#' @slot forecast a logical value representing if forecast is to be consider.
#' @slot output a character value representing the path for the ESRI Shapefile output.
#'
#' @return an LDT object.
#'
createLDT = function(analysis_squares, nmoments, studyareapath, momentspaths,
                     patches, squares, perforation, forecast, output) {


  default_clusterarea = 50000
  if((squares/1000) * (squares/1000) > default_clusterarea){
    gap_area = 1
  }else{
    gap_area = default_clusterarea / ((squares/1000) * (squares/1000))
  }

  if(nmoments < 2 || length(momentspaths) < 2){
    stop("Number of moments is less than 2. Please check Ldt object variables.", call. = T)
  }

  if(nmoments != length(momentspaths)){
    stop("Number of moments is different than number of shapefile paths. Please check Ldt object variables.", call. = T)
  }

  if(analysis_squares){
    new("Ldt", analysis_squares = T, nmoments = nmoments, studyareapath = studyareapath,
        momentspaths = momentspaths, patches = patches, squares = squares, perforation = perforation,
        forecast = forecast, output = output, temp_fold = file.path(dirname(output), "temp" ),
        cluster_area = default_clusterarea, gap_area = gap_area)
  }else{
    new("Ldt", analysis_squares = F, nmoments = nmoments, studyareapath = studyareapath,
        momentspaths = momentspaths, patches = patches, squares = squares, perforation = perforation,
        forecast = forecast, output = output, temp_fold = file.path(dirname(output), "temp" ),
        cluster_area = default_clusterarea, gap_area = 1)
  }


}

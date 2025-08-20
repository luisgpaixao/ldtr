#' A Custom S4 Class for an Ldt
#'
#' This class represents all the attributes necessary to preform a Land Dynamics process.
#'
#' @slot analysis_squares a logical value representing if the type of analysis is done by a regular grid of squares. If false, the type of analysis is done by districts.
#' @slot nmoments an integer value representing the amount of moments to consider.
#' @slot studyareapath a character value representing the path for the ESRI Shapefile that defines the study area.
#' @slot momentspaths a vector of character values representing the paths for the ESRI Shapefiles that defines the moments for analysis, by chronological order.
#' @slot patches an integer value representing minimum area threshold of features, in square meters.
#' @slot squares an integer value representing square side dimension, in meters. Only used if type of analysis e set to squares.
#' @slot spatialshift a logical value representing if spatial shift is to be consider.
#' @slot perforation a logical value representing if perforation is to be consider.
#' @slot forecast a logical value representing if forecast is to be consider.
#' @slot output a character value representing the path for the ESRI Shapefile output.
#' @slot temp_fold a character value representing the path for temporary folder. Automatically filled based on output path.
#' @slot cluster_area a numeric value representing a cluster minimum area to loop the process, to try managing memory on large data sets. Can be changed in the constructor.
#' @slot gap_area a numeric value representing the number of features in every loop of the process, to try managing memory on large data sets. For analysis type "districts", the value is 1.
#' @export
# class and methods
setClass(
  "Ldt",
  slots = list(
    analysis_squares = "logical",
    nmoments = "numeric",
    studyareapath = "character",
    momentspaths = "character",
    patches = "numeric",
    squares = "numeric",
    spatialshift = "logical",
    perforation = "logical",
    forecast = "logical",
    output = "character",
    temp_fold = "character",
    cluster_area = "numeric",
    gap_area = "numeric"
  )
)

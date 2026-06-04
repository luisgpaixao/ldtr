#' A Custom S4 Class for an Ldt
#'
#' This class represents all the attributes necessary to preform a Land Dynamics process.
#'
#' @slot analysis_squares a logical value representing if the type of analysis is done by a regular grid of squares. If FALSE, the type of analysis is done by districts.
#' @slot nmoments an integer value representing the amount of moments to consider.
#' @slot studyarea a sf Simple polygon feature collection, from sf package, representing the study area.
#' @slot moments a list of sf Simple polygon feature collections, from sf package, representing the moments for analysis, by chronological order.
#' @slot patches an integer value representing minimum area threshold of features, in square meters.
#' @slot squares an integer value representing square side dimension, in meters. Only used if type of analysis e set to squares.
#' @slot spatialshift a logical value representing if spatial shift is to be consider.
#' @slot perforation a logical value representing if perforation is to be consider.
#' @slot forecast a logical value representing if forecast is to be consider.
#' @slot temp_fold a character value representing the path for temporary folder.
#' @slot cluster_area a numeric value representing a cluster minimum area to loop the process, to try managing memory on large data sets. Can be changed in the constructor.
#' @slot gap_area a numeric value representing the number of features in every loop of the process, to try managing memory on large data sets. For analysis type "districts", the value is 1.
#' @export
# class and methods

setClass(
  "Ldt",
  slots = list(
    analysis_squares = "logical",
    nmoments = "numeric",
    studyarea = "sf",
    moments = "list",
    patches = "numeric",
    squares = "numeric",
    spatialshift = "logical",
    perforation = "logical",
    forecast = "logical",
    temp_fold = "character",
    cluster_area = "numeric",
    gap_area = "numeric"
  )
,

validity = function(object) {
  
  # studyarea must be polygon sf
  if (!inherits(object@studyarea, "sf")) {
    return("studyarea must be an sf object")
  }
  
  geom_type_study <- unique(sf::st_geometry_type(object@studyarea))
  
  if (!all(geom_type_study %in% c("POLYGON", "MULTIPOLYGON"))) {
    return("studyarea must contain polygon geometries")
  }
  
  # moments must be list of sf polygon objects
  if (!is.list(object@moments)) {
    return("moments must be a list")
  }
  
  for (i in seq_along(object@moments)) {
    
    x <- object@moments[[i]]
    
    if (!inherits(x, "sf")) {
      return(
        paste0("moments[[", i, "]] is not an sf object")
      )
    }
    
    geom_type <- unique(sf::st_geometry_type(x))
    
    if (!all(geom_type %in% c("POLYGON", "MULTIPOLYGON"))) {
      return(
        paste0(
          "moments[[", i, "]] must contain polygon geometries"
        )
      )
    }
  }
  
  TRUE
}
)
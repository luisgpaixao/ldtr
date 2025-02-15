#' Update symmetrical difference or perforation values
#'
#' Updates symmetrical difference or perforation values in the study area features.
#'
#' @param in_layer an sf Simple feature collection, representing the study area features.
#' @param join_layer an sf Simple feature collection, representing symmetrical difference or perforation features.
#' @param join_field a character representing the field to be updated in the study area sf Simple feature collection.
#'
#' @return an sf Simple feature collection, representing the study area features.
#'
join_location <- function(in_layer, join_layer, join_field){

  in_layer[in_layer$FID %in% unique(join_layer$FID), join_field] = 1
  in_layer[!(in_layer$FID %in% unique(join_layer$FID)), join_field] = 0

  return(in_layer)
}

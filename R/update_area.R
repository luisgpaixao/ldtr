#' Update area field
#'
#' Updates area values in sf Simple feature collection.
#'
#' @param in_layer an sf Simple feature collection with area field.
#' @param field a character indicating the area field to be updated.
#'
#' @return an sf Simple feature collection, with updated area field.
#'
update_area <- function(in_layer, field){

  in_layer[[field]] = round(as.integer(st_area(in_layer)), 0)

  return(in_layer)
}

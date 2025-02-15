#' Select perforation features
#'
#' Selects features where perforation was detected.
#'
#' @param in_layer an sf Simple feature collection, representing symmetrical difference between a pair of moments of analysis.
#' @param intersect_layer an sf Simple feature collection, representing the first moment of the pair.
#'
#' @return an sf Simple feature collection representing the features where perforation was detected.
#'
select_perf <- function(in_layer, intersect_layer){

  buff = st_buffer(in_layer, 0.2)
  buff = multi_to_single(buff)
  within = st_within(buff, intersect_layer)
  sel = buff[lengths(within) > 0,]
  return(sel)
}

#' Symmetrical difference
#'
#' Performs symmetrical difference between two sf Simple feature collections.
#'
#' @param in_layer1 an sf Simple feature collection.
#' @param in_layer2 an sf Simple feature collection.
#'
#' @return an sf Simple feature collection.
#' @export
symmetrical_difference <- function(in_layer1, in_layer2){

  dif1 = suppressWarnings(st_difference(in_layer1, st_union(st_combine(in_layer2))))
  dif2 = suppressWarnings(st_difference(in_layer2, st_union(st_combine(in_layer1))))

  return(rbind(dif1, dif2))
}

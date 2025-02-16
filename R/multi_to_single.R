#' Transform multipart features into singlepart features
#'
#' Explodes all multipart features in an sf Simple feature collection.
#'
#' @param in_layer an sf Simple feature collection.
#'
#' @return an sf Simple feature collection.
#' @export
multi_to_single <- function(in_layer){

  single = in_layer %>% filter("POLYGON" == st_geometry_type(geometry))

  multi = in_layer %>% filter("MULTIPOLYGON" == st_geometry_type(geometry))
  multi = st_cast(multi, "POLYGON")

  return(rbind(single, multi))
}

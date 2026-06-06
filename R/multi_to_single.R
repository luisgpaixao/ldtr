#' Transform multipart features into singlepart features
#'
#' Explodes all multipart features in an sf Simple feature collection.
#'
#' @param in_layer an sf Simple feature collection.
#'
#' @return an sf Simple feature collection.
#' @export
multi_to_single <- function(in_layer){
  
  geom_types <- as.character(
    sf::st_geometry_type(in_layer)
  )
  
  single <- in_layer[
    geom_types == "POLYGON",
  ]
  
  multi <- in_layer[
    geom_types == "MULTIPOLYGON",
  ]
  
  multi <- suppressWarnings(
    sf::st_cast(multi, "POLYGON")
  )
  
  suppressWarnings(rbind(single, multi))
}

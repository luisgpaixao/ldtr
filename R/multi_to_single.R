#' Transform multipart features into singlepart features
#'
#' Explodes all multipart features in an sf Simple feature collection.
#'
#' @param in_layer an sf Simple feature collection.
#'
#' @return an sf Simple feature collection.
#' @export
multi_to_single <- function(in_layer){

  single = in_layer %>%
    dplyr::filter(
      sf::st_geometry_type(.) == "POLYGON"
    )
  
  multi = in_layer %>%
    dplyr::filter(
      sf::st_geometry_type(.) == "MULTIPOLYGON"
    )
  
  multi = suppressWarnings(st_cast(multi, "POLYGON"))

  return(suppressWarnings(rbind(single, multi)))
}

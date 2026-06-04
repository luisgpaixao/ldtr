#' Validate moment
#'
#' Check if moment's data is valid.
#'
#' @param mm a sf Simple polygon feature collection representing the moment.
#' @param index an integer value indicating moment index
#'
#' @return a sf Simple polygon feature collection representing the moment.
#' @export
valid_moment <- function(mm, index){

  geom_type <- unique(as.character(sf::st_geometry_type(mm)))
  
  valid_types <- c(
    "POLYGON",
    "MULTIPOLYGON"
  )
  
  crs <- sf::st_crs(mm)
  
  invalid_crs <-
    is.na(crs) ||
    is.na(crs$wkt) ||
    grepl("Undefined", crs$Name)
  
  if(invalid_crs){
    stop(paste0("CRS of moment", index, " not defined, please check your data.\n"), call. = T)
  }

  if (!all(geom_type %in% valid_types)) {
    stop(
      paste0(
        "Moment ", index,
        " geometry type must be POLYGON or MULTIPOLYGON."
      ),
      call. = TRUE
    )
  }
  
  return(mm)
  
}
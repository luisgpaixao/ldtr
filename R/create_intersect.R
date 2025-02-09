#' Create Intersections
#'
#' Creates a list of moments for the Landscape Dynamics analysis, clipped by a study area layer.
#' Area field is updated for all features.
#'
#' @param nmoments a list of sf Simple feature collections representing the moments for analysis.
#' @param sta an sf Simple feature collection representing the study area for analysis.
#' @param field a character indicating the area field to be updated.
#'
#' @return a list of sf Simple feature collections representing the moments for analysis, clipped by study area.
#'
create_intersect <- function(nmoments, sta, field){

  moments = list()
  for(i in 1:length(nmoments)){
    mmtname = paste0("intersect_t", i)
    moments[[mmtname]] = st_intersection(nmoments[[i]], sta)
    moments[[mmtname]] = update_area(moments[[mmtname]], field)
    moments[[mmtname]] = moments[[mmtname]][!is.na(moments[[mmtname]]$FID),]
    cat("Intersect", i, "Done\n")
  }

  return(moments)

}

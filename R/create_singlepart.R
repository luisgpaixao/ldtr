#' Create Singlepart
#'
#' Creates a list of moments for the Landscape Dynamics analysis, updating polygons to singlepart features.
#' Area field is updated for all features.
#'
#' @param nmoments a list of sf Simple feature collections representing the moments for analysis.
#' @param field a character indicating the area field to be updated.
#'
#' @return a list of sf Simple feature collections representing the moments for analysis, updated to singlepart.
#' @export
create_singlepart <- function(nmoments, field){

  moments = list()
  for(i in 1:length(nmoments)){
    mmtname = paste0("multisingle_t", i)
    moments[[mmtname]] = multi_to_single(nmoments[[i]])
    moments[[mmtname]] = update_area(moments[[mmtname]], field)
    moments[[mmtname]] = moments[[mmtname]][!is.na(moments[[mmtname]]$FID),]
    cat("Multi to SinglePart", i, "Done\n")
  }

  return(moments)

}

#' Create Select patch
#'
#' Creates a list of moments for the Landscape Dynamics analysis, discarding features with area under a threshold.
#' Area field is updated for all features.
#'
#' @param nmoments a list of sf Simple feature collections representing the moments for analysis
#' @param field a character indicating the area field to be updated
#' @param patch_value an integer value representing minimum area threshold of features, in square meters
#'
#' @return a list of sf Simple feature collections representing the moments for analysis, filtered by area threshold
#'
create_selectpatch <- function(nmoments, field, patch_value){

  moments = list()
  for(i in 1:length(nmoments)){
    mmtname = paste0("select_t", i)
    moments[[mmtname]] = nmoments[[i]][nmoments[[i]][[field]] >= patch_value, ]
    moments[[mmtname]] = update_area(moments[[mmtname]], field)
    moments[[mmtname]] = moments[[mmtname]][!is.na(moments[[mmtname]]$FID),]
    cat("Patch", i, "Done")
  }

  return(moments)

}

#' Subset moments by FID
#'
#' Creates a features subset for all the moments of analysis, using FID field.
#'
#' @param nmoments a list of sf Simple feature collections representing the moments for analysis.
#' @param fid_field a character indicating the FID field.
#' @param fid_select a vector of integers, representing the FID values to subset.
#'
#' @return a list of sf Simple feature collections representing the moments for analysis, subset by FID.
#'
subset_by_fid <- function(nmoments, fid_field, fid_select){

  for(i in 1:length(nmoments)){
    nmoments[[i]] = nmoments[[i]][nmoments[[i]][[fid_field]] %in% fid_select, ]
  }
  return(nmoments)
}

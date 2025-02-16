#' Join Area and Frequency
#'
#' Updates study area's Simple feature collection by adding area and frequency fields, and populating according to the moments of analysis.
#' Area field is updated for all features.
#'
#' @param nmoments a list of sf Simple feature collections representing the moments for analysis.
#' @param sta an sf Simple features collection representing the study area for analysis.
#'
#' @return an sf Simple features collection representing the study area for analysis, updated with area and frequency values of the different moments of analysis.
#' @export
join_areafreq <- function(nmoments, sta){

  for(i in 1:length(nmoments)){
    statsSum = stats_by_FID(nmoments[[i]])
    sta = join_FID_AREA(sta, statsSum, paste0(constants$AREA_FIELD_BASE, i), paste0(constants$FREQ_FIELD_BASE, i))
    cat("Join fields", i, "Done\n")
  }

  return(sta)

}

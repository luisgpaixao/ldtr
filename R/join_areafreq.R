#' Create Join fields
#'
#' Creates a list of moments for the Landscape Dynamics analysis, discarding features with area under a threshold.
#' Area field is updated for all features.
#'
#' @param nmoments a list of sf Simple feature collections representing the moments for analysis
#' @param sta an sf Simple feature collection representing the study area for analysis
#'
#' @return a list of sf Simple feature collections representing the moments for analysis, filtered by area threshold
#'
create_joinfields = function(nmoments, sta){

  for(i in 1:length(nmoments)){
    statsSum = stats_by_AreaFID(nmoments[[i]])
    sta = join_FID_AREA(sta, statsSum, paste0(AREA_FIELD_BASE, i), paste0(FREQ_FIELD_BASE, i))
    cat("Join fields", i, "Done")
  }

  return(sta)

}

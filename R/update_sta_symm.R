#' Update symmetrical difference fields
#'
#' Updates symmetrical differences fields on study area's Simple feature collection.
#'
#' @param sta an sf Simple feature collection representing the study area for analysis.
#' @param symdif_perf a list of sf Simple feature collections representing the symmetrical differences between all moments for analysis.
#'
#' @return an sf Simple feature collection representing the study area for analysis, updated with symmetrical difference fields.
#'
update_sta_symm <- function(sta, symdif_perf){

  for(i in 1:length(symdif_perf)){
    sta = join_location(sta, symdif_perf[[i]], names(symdif_perf[i]))
  }

  return(sta)
}

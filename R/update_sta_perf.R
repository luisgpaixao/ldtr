#' Update perforation fields
#'
#' Updates perforation fields on study area's Simple feature collection.
#'
#' @param sta an sf Simple feature collection representing the study area for analysis.
#' @param perf_features a list of sf Simple feature collections representing the perforation between all moments for analysis.
#'
#' @return an sf Simple feature collection representing the study area for analysis, updated with perforation fields.
#' @export
update_sta_perf <- function(sta, perf_features){

  for(i in 1:length(perf_features)){

    if(nrow(perf_features[[1]]) == 0){
      sta[[names(perf_features[1])]] = 0
    }else{
      sta = join_location(sta, perf_features[[i]], names(perf_features[i]))
    }

  }

  return(sta)

}

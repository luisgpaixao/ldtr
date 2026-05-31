#' Create Moments
#'
#' Creates a list of moments for the Landscape Dynamics analysis.
#' If crs of moments is not the same as the study area, a transformation is applied.
#'
#' @param momentslist a list of sf Simple polygon feature collections, from sf package, representing the moments for analysis, by chronological order.
#' @param sta a sf Simple polygon feature collection, from sf package, representing the study area for analysis.
#'
#' @return a list of sf Simple polygon feature collections representing the moments for analysis.
#' @export
create_moments <- function(momentslist, sta){

  moments = list()
  for(i in 1:length(momentslist)){
    mmtname = paste0("m", i)
    moments[[mmtname]] = valid_moment(momentslist[i], i)
    moments[[mmtname]] = moments[[mmtname]][,"geometry"]
    if(st_crs(moments[[mmtname]]) != st_crs(sta)){
      message("CRS of Moment ", mmtname, " changed to ", st_crs(sta)$input, "\n")
      moments[[mmtname]] = st_transform(moments[[mmtname]], st_crs(sta))
    }

  }

  return(moments)

}

#' Create Moments
#'
#' Creates a list of moments for the Landscape Dynamics analysis.
#' If crs of moments is not the same as the study area, a transformation is applied.
#'
#' @param momentspaths a list of ESRI Shapefiles paths representing the Moments for analysis.
#' @param sta an sf Simple feature collection representing the study area for analysis.
#'
#' @return a list of sf Simple feature collections representing the moments for analysis.
#' @export
create_moments <- function(momentspaths, sta){

  moments = list()
  for(i in 1:length(momentspaths)){
    mmtname = paste0("m", i)
    moments[[mmtname]] = valid_moment(momentspaths[i], i)
    moments[[mmtname]] = moments[[mmtname]][,"geometry"]
    if(st_crs(moments[[mmtname]]) != st_crs(sta)){
      message("CRS of Moment ", mmtname, " changed to ", st_crs(sta)$input, "\n")
      moments[[mmtname]] = st_transform(moments[[mmtname]], st_crs(sta))
    }

  }

  return(moments)

}

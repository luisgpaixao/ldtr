#' Area and Frequency Stats by feature's FID
#'
#' Given a moment of analysis clipped by the study area's features, creates a data frame with FID and respective values for total area and frequency of patches.
#'
#' @param in_layer an sf Simple feature collection representing a moment of analysis clipped by study area's features.
#'
#' @return a data.frame with the same amount of rows and same order as the study area's sf Simple collection, containing information on FID, sum of areas and frequency of patches.
#'
stats_by_FID <- function(in_layer){

  set_fid = unique(in_layer[[FID_FIELD]])

  fid = c()
  sum = c()
  count = c()

  for(i in set_fid){
    sel = in_layer[in_layer[[FID_FIELD]]==i, ]
    fid = c(fid, i)
    count = c(count, nrow(sel))
    sum = c(sum, sum(sel[[AREAINICIAL_FIELD]]))
  }

  return(data.frame(fid = fid, sum = sum, count = count))

}

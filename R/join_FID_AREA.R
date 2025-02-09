#' Area and Frequency Stats by feature's FID
#'
#' Given a moment of analysis clipped by the study area's features, creates a data frame with FID and respective values for total area and frequency of patches.
#'
#' @param in_layer an sf Simple features collection representing the study area for analysis.
#' @param in_df a data.frame with the same amount of rows and same order as the study area's sf Simple collection, containing information on FID, sum of areas and frequency of patches.
#' @param area_field a character indicating the name of the field representing the sum of areas of patches in a moment of analysis.
#' @param count_field a character indicating the name of the field representing the count of patches in a moment of analysis.
#'
#' @return an sf Simple features collection representing the study area for analysis, updated with area and frequency for a moment of analysis.
#'
join_FID_AREA <- function(in_layer, in_df, area_field, count_field){

  fc = nrow(in_df)

  if(fc == 0){
    in_layer[, count_field] = 0
    in_layer[, area_field] = 0
  }else{
    for(i in 1:fc){
      ct = in_df$count[i]
      ar = in_df$sum[i]
      in_layer[in_layer$FID == in_df$fid[i], count_field] = ct
      in_layer[in_layer$FID == in_df$fid[i], area_field] = ar
    }

    fc = nrow(in_layer)

    for(i in 1:fc){
      if(is.na(in_layer[i, ][[count_field]])){
        in_layer[i, count_field] = 0
        in_layer[i, area_field] = 0
      }
    }
  }

  return(in_layer)

}

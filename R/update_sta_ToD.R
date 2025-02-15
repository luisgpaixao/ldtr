#' Update Type of Dynamics fields
#'
#' Updates all ToD fields on study area's Simple feature collection.
#'
#' @param sta an sf Simple feature collection representing the study area for analysis.
#' @param n_moment an integer value representing the number of moments for analysis.
#' @param perforation a logical value indicating if perforation should be consider.
#' @param forecast a logical value indicating if forecast should be consider.
#'
#' @return an sf Simple feature collection representing the study area for analysis, updated with ToD fields.
#'
update_sta_ToD <- function(sta, n_moment, perforation, forecast){

  pairs = create_pairs(n_moment)

  # presence
  for(i in 1:n_moment){
    aux_freq = paste0(FREQ_FIELD_BASE, i)
    aux_pres = paste0(PRESENCE_FIELD_BASE, i)

    sta[sta[[aux_freq]] > 0, aux_pres] = 1
    sta[sta[[aux_freq]] == 0, aux_pres] = 0
  }

  # var area
  for(i in 1:length(pairs)){
    aux_area = paste0(VAR_AREA_FIELD_BASE, pairs[[i]][1], pairs[[i]][2])
    aux_area1 = paste0(AREA_FIELD_BASE, pairs[[i]][1])
    aux_area2 = paste0(AREA_FIELD_BASE, pairs[[i]][2])

    sta[[aux_area]] = sta[[aux_area2]] - sta[[aux_area1]]
    sta[(sta[[aux_area]] >= -100) & (sta[[aux_area]] <= 100), aux_area] = 0

  }

  # var NP
  for(i in 1:length(pairs)){
    aux_np = paste0(VAR_NP_FIELD_BASE, pairs[[i]][1], pairs[[i]][2])
    aux_np1 = paste0(FREQ_FIELD_BASE, pairs[[i]][1])
    aux_np2 = paste0(FREQ_FIELD_BASE, pairs[[i]][2])

    sta[[aux_np]] = sta[[aux_np2]] - sta[[aux_np1]]

  }

  # ToD
  for(i in 1:length(pairs)){

    aux_area = paste0(VAR_AREA_FIELD_BASE, pairs[[i]][1], pairs[[i]][2])
    aux_np = paste0(VAR_NP_FIELD_BASE, pairs[[i]][1], pairs[[i]][2])
    aux_sym = paste0(SYM_FIELD_BASE, pairs[[i]][1], pairs[[i]][2])
    aux_tod = paste0(TOD_FIELD_BASE, pairs[[i]][1], pairs[[i]][2])
    aux_perf = paste0(PERF_FIELD_BASE, pairs[[i]][1], pairs[[i]][2])
    aux_pres1 = paste0(PRESENCE_FIELD_BASE, pairs[[i]][1])
    aux_pres2 = paste0(PRESENCE_FIELD_BASE, pairs[[i]][2])

    sta[(sta[[aux_area]] == 0) & (sta[[aux_np]] == 0), aux_tod] = "A - No change"
    sta[(sta[[aux_area]] == 0) & (sta[[aux_np]] == 0) & (sta[[aux_sym]] == 1), aux_tod] = "A1 - Spatial shift"
    sta[(sta[[aux_area]] == 0) & (sta[[aux_np]] > 0), aux_tod] = "B - Fragmentation per se"
    sta[(sta[[aux_area]] == 0) & (sta[[aux_np]] < 0), aux_tod] = "C - Aggregation per se"
    sta[(sta[[aux_area]] > 0) & (sta[[aux_np]] == 0), aux_tod] = "D - Gain"
    sta[(sta[[aux_area]] < 0) & (sta[[aux_np]] == 0), aux_tod] = "E - Loss"

    if(perforation){
      sta[(sta[[aux_area]] < 0) & (sta[[aux_np]] == 0) & (sta[[aux_perf]] == 1), aux_tod] = "E1 - Perforation"
    }

    sta[(sta[[aux_area]] > 0) & (sta[[aux_np]] > 0), aux_tod] = "F - NP increment by gain"
    sta[(sta[[aux_area]] > 0) & (sta[[aux_np]] < 0), aux_tod] = "G - Aggregation by gain"
    sta[(sta[[aux_area]] < 0) & (sta[[aux_np]] < 0), aux_tod] = "H - NP decrement by loss"
    sta[(sta[[aux_area]] < 0) & (sta[[aux_np]] > 0), aux_tod] = "I - Fragmentation by loss"
    sta[(sta[[aux_pres1]] == 0) & (sta[[aux_pres2]] == 0), aux_tod] = "Study object is absent"

  }


  if(forecast){

    last_pairs = pairs[[length(pairs)]]

    aux_freq = paste0(FREQ_FIELD_BASE, last_pairs[2])
    aux_tod = paste0(TOD_FIELD_BASE, last_pairs[1], last_pairs[2])


    sta[sta[[aux_tod]] == "A - No change", FORECAST_FIELD] = "A - No change"
    sta[sta[[aux_tod]] == "A1 - Spatial shift", FORECAST_FIELD] = "A - No change"
    sta[sta[[aux_tod]] == "G - Aggregation by gain", FORECAST_FIELD] = "TOTAL COVER"
    sta[sta[[aux_tod]] == "F - NP increment by gain", FORECAST_FIELD] = "G then TOTAL COVER"
    sta[(sta[[aux_tod]] == "D - Gain") & (sta[[aux_freq]] == 1), FORECAST_FIELD] = "TOTAL COVER"
    sta[(sta[[aux_tod]] == "D - Gain") & (sta[[aux_freq]] > 1), FORECAST_FIELD] = "G then TOTAL COVER"
    sta[sta[[aux_tod]] == "H - NP decrement by loss", FORECAST_FIELD] = "NO COVER"
    sta[sta[[aux_tod]] == "I - Fragmentation by loss", FORECAST_FIELD] = "H then NO COVER"
    sta[(sta[[aux_tod]] == "E - Loss") & (sta[[aux_freq]] == 1), FORECAST_FIELD] = "NO COVER"
    sta[(sta[[aux_tod]] == "E - Loss") & (sta[[aux_freq]] > 1), FORECAST_FIELD] = "H then NO COVER"
    sta[sta[[aux_tod]] == "Study object is absent", FORECAST_FIELD] = "No forecast"
  }


  return(sta)

}

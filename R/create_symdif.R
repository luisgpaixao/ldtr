#' Create symmetrical difference between moments
#'
#' Preform symmetrical differences and perforation between all moments of analysis.
#'
#' @param nmoments a list of sf Simple feature collections representing the moments for analysis.
#' @param area_field a character indicating the area field to be updated.
#' @param perforation a logical argument indicating if perforation should be considered.
#'
#' @return a list of lists containing sf Simple feature collections representing the symmetrical differences and perforations between all moments for analysis.
#' @export
create_symdif <- function(nmoments, area_field, perforation){

  pairs = create_pairs(length(nmoments))

  moments = list(symdif = list(), perf = list())
  for(i in 1:length(pairs)){
    sufix = paste0(pairs[[i]][1], pairs[[i]][2])
    mmtname = paste0(constants$SYM_FIELD_BASE, sufix)
    moments$symdif[[mmtname]] = symmetrical_difference(nmoments[[pairs[[i]][1]]], nmoments[[pairs[[i]][2]]])
    cat("Symmetrical Difference", sufix, "Done\n")
    moments$symdif[[mmtname]] = multi_to_single(moments$symdif[[mmtname]])
    moments$symdif[[mmtname]] = update_area(moments$symdif[[mmtname]], area_field)
    cat("Multi to SinglePart", sufix, "Done\n")
    try({moments$symdif[[mmtname]][[mmtname]] = 1}, silent = T)

    if(perforation){
      cat("Perforation", sufix, "check\n")
      perfname = paste0(constants$PERF_FIELD_BASE, sufix)
      moments$perf[[perfname]] = select_perf(moments$symdif[[mmtname]], nmoments[[pairs[[i]][1]]])
    }

  }

  return(moments)

}

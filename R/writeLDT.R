#' Write LDT output
#'
#' Performs the Landscape Dynamics process and exports an ESRI Shapefile and png maps as outputs.
#'
#' @slot objLDT an object of class LDT.
#'
#' @return an sf Simple feature collection, representing the Land Dynamics output.
#'
#' @import sf
#' @import dplyr
#' @import ggplot2
#' @import ggspatial
#'
#' @export
#'
#' @examples
#'
#' # set working directory
#' setwd("/path_to_wd/")
#'
#' # create a 2 moments 30000 meters square size Land dynamics object, considering patches over 1000 square meters, spatial shift, perforation and forecast
#' objLDT <- createLDT(T, 2, "studyarea.shp", c("moment1.shp", "moment2.shp"), 1000, 30000, T, T, T, "outLDT.shp")
#'
#' # run LDT
#' writeLDT(objLDT)
#'
writeLDT <- function(objLDT){

  if(file.exists(objLDT@output)){
    stop("Output file already exists, please check your data.\n", call. = T)
  }

  if(!dir.exists(objLDT@temp_fold)){
    dir.create(objLDT@temp_fold)
  }

  # study area
  sta = valid_studyarea(objLDT@studyareapath)

  # moments
  mmt = create_moments(objLDT@momentspaths, sta)

  # squares or districts
  if(objLDT@analysis_squares){
    fishnet = create_fishnet(sta, objLDT@squares)
    cat("Fishnet Created\n")
    sta = st_intersection(fishnet, st_union(sta, by_feature = F))
    cat("Fishnet Clipped by Study Area\n")
  }

  sta[constants$FID_FIELD] = seq(1, nrow(sta), 1)

  seq_area = seq(1, nrow(sta), objLDT@gap_area)
  if(seq_area[length(seq_area)]!=nrow(sta)){
    seq_area = c(seq_area, (nrow(sta)))
  }

  # intersect
  intersct = create_intersect(mmt, sta, constants$AREAINICIAL_FIELD)

  # multipart to singlepart
  mmt_single = create_singlepart(intersct, constants$AREAINICIAL_FIELD)
  suppressWarnings(rm(intersct))
  gc()

  # patch
  mmt_patch = create_selectpatch(mmt_single, constants$AREAINICIAL_FIELD, objLDT@patches)
  suppressWarnings(rm(mmt_single))
  gc()

  # join fields
  sta = join_areafreq(mmt_patch, sta)

  if(objLDT@analysis_squares){
    range_sta = 1:(length(seq_area)-1)
  }else{
    range_sta = 1:length(seq_area)
  }

  vec_shp = c()
  for(seqs in range_sta){
    suppressWarnings(rm(aux_sta, aux_mmt_patch, mmt_symdif_perf))
    gc()
    if(objLDT@analysis_squares){
      aux_sta = sta[seq_area[seqs]:(seq_area[seqs+1]),]
      aux_mmt_patch = subset_by_fid(mmt_patch, constants$FID_FIELD, (seq_area[seqs]:(seq_area[seqs+1]-1)))
    }else{
      aux_sta = sta[seq_area[seqs],]
      aux_mmt_patch = subset_by_fid(mmt_patch, constants$FID_FIELD, (seq_area[seqs]))
    }

    # Symmetrical Difference and perforation
    if(objLDT@spatialshift || objLDT@perforation){
      mmt_symdif_perf = create_symdif(aux_mmt_patch, constants$AREAINICIAL_FIELD, objLDT@perforation)
    }
    
    if(objLDT@spatialshift){
      aux_sta = update_sta_symm(aux_sta, mmt_symdif_perf$symdif)
    }
    
    if(objLDT@perforation){
      aux_sta = update_sta_perf(aux_sta, mmt_symdif_perf$perf)
    }

    cat("Finishing the process, please wait...\n")

    # final analysis fields
    aux_sta = update_sta_ToD(aux_sta, objLDT@nmoments, objLDT@spatialshift, objLDT@perforation, objLDT@forecast)

    out_v_file = file.path(objLDT@temp_fold, paste0("v", seqs, ".shp"))
    st_write(aux_sta, out_v_file)
    vec_shp = c(vec_shp, out_v_file)

  }

  shp_list = list()
  for(i in vec_shp){
    shp_list[[length(shp_list)+1]] = st_read(i)
  }

  out_shp = do.call("rbind", shp_list)

  st_write(out_shp, objLDT@output)
  unlink(objLDT@temp_fold, recursive = T)

  create_layouts(objLDT@nmoments, objLDT@output)

  return(out_shp)
}

#' Write LDT output
#'
#' Preforms the Land Dynamics process and exports an ESRI Shapefile and png maps as outputs.
#'
#' @slot objLDT an object of class LDT.
#'
#' @return an sf Simple feature collection, representing the Land Dynamics output.
#'
writeLDT = function(objLDT){

  if(!dir.exists(objLDT@temp_fold)){
    dir.create(objLDT@temp_fold)
  }

  # study area
  sta = st_read(objLDT@studyareapath)

  sta = sta[,"geometry"]
  if((is.null(st_crs(sta)$units)) || (st_crs(sta)$units != "m")){
    stop("CRS units of study area's Shapefile are not in meters, please check your data.", call. = T)
  }

  # moments
  mmt = create_moments(objLDT@momentspaths, sta)

  # squares or districts
  if(objLDT@analysis_squares){
    fishnet = create_fishnet(sta, objLDT@squares)
    cat("Fishnet Created")
    sta = st_intersection(fishnet,sta)
    cat("Fishnet Clipped by Study Area")
  }
  sta[FID_FIELD] = seq(1, nrow(sta), 1)

  seq_area = seq(1, nrow(sta), objLDT@gap_area)
  if(seq_area[length(seq_area)]!=nrow(sta)){
    seq_area = c(seq_area, (nrow(sta)+1))
  }

  # intersect
  intersct = create_intersect(mmt, sta, AREAINICIAL_FIELD)

  # multipart to singlepart
  mmt_single = create_singlepart(intersct, AREAINICIAL_FIELD)
  rm(intersct)
  gc()

  # patch
  mmt_patch = create_selectpatch(mmt_single, AREAINICIAL_FIELD, objLDT@patches)
  rm(mmt_single)
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
    rm(aux_sta, aux_mmt_patch, mmt_symdif_perf)
    gc()
    if(objLDT@analysis_squares){
      aux_sta = sta[seq_area[seqs]:(seq_area[seqs+1]-1),]
      aux_mmt_patch = subset_by_fid(mmt_patch, FID_FIELD, (seq_area[seqs]:(seq_area[seqs+1]-1)))
    }else{
      aux_sta = sta[seq_area[seqs],]
      aux_mmt_patch = subset_by_fid(mmt_patch, FID_FIELD, (seq_area[seqs]))
    }

    # Symmetrical Difference and perforation
    mmt_symdif_perf = create_symdif(aux_mmt_patch, AREAINICIAL_FIELD, objLDT@perforation)
    aux_sta = update_sta_symm(aux_sta, mmt_symdif_perf$symdif)

    if(objLDT@perforation){
      aux_sta = update_sta_perf(aux_sta, mmt_symdif_perf$perf)
    }

    cat("Finishing the process, please wait...")

    # final analysis fields
    aux_sta = update_sta_ToD(aux_sta, objLDT@nmoments, objLDT@perforation, objLDT@forecast)

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

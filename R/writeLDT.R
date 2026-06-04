#' Write LDT output
#'
#' Performs the Landscape Dynamics process and returns a sf Simple polygon feature collection and a list of ggplot maps.
#'
#' @param objLDT an object of class `LDT`.
#' @param saveoutput a logical value representing if output layer should be exported. Default to `FALSE`.
#' @param savemaps a logical value representing if output maps should be exported. Default to `FALSE`.
#' @param layername a character value representing the layer basename. Used only if `saveoutput = TRUE` or `savemaps = TRUE`.
#' @param outfolder a character value representing the path for output folder. Used only if `saveoutput = TRUE` or `savemaps = TRUE`.
#'
#' @return a list with 2 elements: a sf Simple polygon feature collection representing the Land Dynamics output, and a list of ggplot objects, representing all Land Dynamics output layout maps.
#'
#' @import sf
#' @import dplyr
#' @import ggplot2
#' @import ggspatial
#'
#' @export
#'
#' @examples
#' \donttest{
#' library(sf)
#' 
#' path_gpkg <- system.file(
#'   "extdata",
#'   "example_ldt.gpkg",
#'   package = "ldtr"
#' )
#'
#' std_area <- st_read(
#'   path_gpkg,
#'   layer = "study_area",
#'   quiet = TRUE
#' )
#'
#' list_moments <- list(
#'   st_read(path_gpkg, layer = "moment1", quiet = TRUE),
#'   st_read(path_gpkg, layer = "moment2", quiet = TRUE)
#' )
#' 
#' 
#' # Create a 2 moments 10000 meters square size Land dynamics object, 
#' considering patches over 1000 square meters, 
#' spatial shift, perforation and forecast
#' 
#' objLDT <- createLDT(std_area, 
#'                     list_moments, 
#'                     patches=1000,
#'                     spatialshift=T, 
#'                     perforation=T, 
#'                     forecast=T)
#' 
#' # run LDT
#' writeLDT(objLDT)
#' }
writeLDT <- function(objLDT, saveoutput = F, savemaps = F, layername = NULL, outfolder = NULL){

  if(!is.null(objLDT@output) && file.exists(objLDT@output)){
    stop("Output file already exists, please check your data.\n", call. = T)
  }

  if(!dir.exists(objLDT@temp_fold)){
    dir.create(objLDT@temp_fold)
  }

  # study area
  sta = valid_studyarea(objLDT@studyarea)

  # moments
  mmt = create_moments(objLDT@moments, sta)

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

    out_v_file = file.path(objLDT@temp_fold, paste0("v", seqs, ".gpkg"))

    if ("FID" %in% names(aux_sta)) {
      aux_sta$FID = NULL
    }
    
    aux_sta = sf::st_zm(aux_sta, drop = TRUE)
    
    st_write(aux_sta, out_v_file)
    vec_shp = c(vec_shp, out_v_file)

  }

  shp_list = list()
  for(i in vec_shp){
    shp_list[[length(shp_list)+1]] = st_read(i)
  }

  out_shp = do.call("rbind", shp_list)

  # st_write(out_shp, objLDT@output)
  unlink(objLDT@temp_fold, recursive = T)

  layouts = create_layouts(objLDT@nmoments, out_shp)
  
  if(saveoutput){
    
    if(is.null(outfolder)){
      cat("No output folder was set! Optionally save sf objects with st_write() function!\n")
      
    }else if(is.null(layername)){
      cat("No layername was set! Using default name!\n")
      
      out_lyr = file.path(outfolder, "results.gpkg")
      st_write(out_shp, out_lyr)
      
    }else{
      out_lyr = file.path(outfolder, paste0(layername, ".gpkg"))
      st_write(out_shp, out_lyr)
    }
  }
  
  if(savemaps){
    
    if(is.null(outfolder)){
      cat("No output folder was set! Optionally save ggplot objects with ggsave() function!\n")
      
    }else if(is.null(layername)){
      cat("No layername was set! Using default names!\n")
      
      for(i in 1:length(layouts)){
        out_png = file.path(outfolder, paste0(names(layouts[i]), ".png"))
        ggsave(out_png, plot = layouts[i], width = 15, height = 10, units = "cm")
      }
    
    }else{
        for(i in 1:length(layouts)){
          out_png = file.path(outfolder, paste0(layername, '_', names(layouts[i]), ".png"))
          ggsave(out_png, plot = layouts[i], width = 15, height = 10, units = "cm")
        }
      }
  }

  return(list(ldt_output = out_shp, layouts = layouts))
}

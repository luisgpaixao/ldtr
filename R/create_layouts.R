#' Create layouts
#'
#' Creates all possible output PNG maps.
#'
#' @param nmoments an integer value representing the number of moments of analysis.
#' @param in_layer_path a character value representing the path for the ESRI Shapefile final output.
#' @export
create_layouts <- function(nmoments, in_layer_path){

  in_shp = st_read(in_layer_path)

  colors_tod = c("transparent", "grey", "#005ce6", "#73b2ff", "#4de600",
                 "#ff5500", "#a83800", "#38a800", "#55ff00",
                 "#e69900", "#ff0000","transparent")

  tod = c("A - No change", "A1 - Spatial shift", "B - Fragmentation per se",
          "C - Aggregation per se", "D - Gain", "E - Loss", "E1 - Perforation",
          "F - NP increment by gain", "G - Aggregation by gain", "H - NP decrement by loss",
          "I - Fragmentation by loss", "Study object is absent")

  outline = c("black", "black", rep("#828282", 10))

  dfOS = data.frame(color = colors_tod, tod = tod, outline = outline)

  pairs = create_pairs(nmoments)

  for(i in 1:length(pairs)){

    tod_field = paste0(constants$TOD_FIELD_BASE, pairs[[i]][1], pairs[[i]][2])
    out_png = gsub(".shp", paste0("_", tod_field, ".png"), in_layer_path)

    aux_shp = in_shp
    names(aux_shp)[names(aux_shp)== tod_field] = "tod"

    aux_shp = left_join(aux_shp, dfOS, by = "tod", copy = F)

    ocup = unique(aux_shp[["tod"]])
    ocup  = data.frame(tod=ocup[order(ocup)])
    ocup = left_join(ocup, aux_shp, "tod", copy = F, multiple = "first")

    vec_color = c()
    vec_outline = c()

    p = ggplot()
    for(a in 1:length(ocup$tod)){
      cat(ocup$tod[a])
      vec_color = c(vec_color, dfOS[dfOS$tod == ocup$tod[a],]$color)
      vec_outline = c(vec_outline, dfOS[dfOS$tod == ocup$tod[a],]$outline)
      value = ocup$tod[a]
      p = p + geom_sf(data = aux_shp[aux_shp[["tod"]] == ocup$tod[a],], aes_(color = value, fill = value), show.legend = T)
    }
    p = p + scale_fill_manual(name = "Types of Dynamics", values = vec_color) +
      scale_color_manual(name = "Types of Dynamics", values = vec_outline) +
      theme_bw() +
      theme(plot.background = element_blank(),
            panel.border = element_blank(),
            axis.ticks = element_blank(),
            axis.text = element_blank(),
            panel.grid = element_blank(),
            legend.position = "left",
            legend.title=element_text(size=10),
            legend.text=element_text(size=9)) +
      annotation_scale(location = "bl", style = "ticks", width_hint = 0.1,
                       line_col = "black", text_col = "black") +
      annotation_north_arrow(location = "tl", which_north = "true",
                             style = north_arrow_minimal(
                               line_col = "black",
                               fill = "black",
                               text_col = "black"),
                             pad_x = unit(0.05, "cm"),
                             pad_y = unit(0.05, "cm"),
                             height = unit(1, "cm"),
                             width = unit(1, "cm"),
                             color = "black")

    ggsave(out_png, plot = p, width = 15, height = 10, units = "cm")

    if(pairs[[i]][1] == 1 & pairs[[i]][2] == nmoments){
      plot(p)
    }

  }


}

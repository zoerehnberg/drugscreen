#' @title plotHeat_gdsc
#'
#' @description Plot a heatmap for one GDSC plate.
#'
#' @param data Data frame to plot.
#' @param scan The SCAN_ID of the plate to plot. Either scan or drug and CL must be used.
#' @param drug May specify the plate by providing both the DRUG_ID and COSMIC_ID of a drug-CL combination.
#' @param CL May specify the plate by providing both the DRUG_ID and COSMIC_ID of a drug-CL combination.
#' @param legendLoc The location of the legend, either "side" or "bottom".
#'
#' @return A GDSC heatmap.
#'
#' @export
plotHeat_gdsc <- function(data = raw_gdsc, scan = NA, drug = NA, CL = NA,
                           legendLoc = "side"){
  # get data for the plate of interest
  if(is.na(scan)){
    scan = subset(data, DRUG_ID == drug & COSMIC_ID == CL)$SCAN_ID[1]
  }
  use.dat <- dplyr::filter(data, SCAN_ID == scan)[,c("DRUGSET_ID","POSITION",
                                                     "INTENSITY")]
  # get row/column info
  if(max(use.dat$POSITION) > 100){
    nwells <- 384
    COL <- rep(1:24,16)
    ROW <- rep(1:16, each = 24)
  }
  else{
    nwells <- 96
    COL <- rep(1:12,8)
    ROW <- rep(1:8, each = 12)
  }

  # create vector of intensities -- fill in missing entries with NA
  INTENSITY <- rep(NA, nwells)
  INTENSITY[use.dat$POSITION] <- use.dat$INTENSITY

  plot.dat <- data.frame(INTENSITY, ROW, COL)

  if(legendLoc == "side"){
    return(ggplot(data = plot.dat, aes(x = COL, y = ROW)) +
             geom_tile(aes(fill = INTENSITY), color = "white") +
             scale_fill_gradientn(colors = colorspace::diverge_hcl(4)) +
             scale_x_continuous(breaks = unique(plot.dat$COL),
                                labels = interleave(seq(1, max(plot.dat$COL), 2), "")) +
             scale_y_reverse(breaks = unique(plot.dat$ROW),
                             labels = interleave(seq(1, max(plot.dat$ROW), 2), "")) +
             labs(x = "", y = "", title = paste0("Plate ", scan)) +
             guides(fill = guide_colorbar(title = expression(atop("Intensity",
                                                                  "(log"[2]*")")),
                                          ticks = FALSE)) +
             theme(panel.background = element_rect(fill = "black",color = "black"),
                   panel.grid = element_blank(),
                   title = element_text(size = 18),
                   axis.text = element_text(size = 14),
                   legend.title = element_text(size = 16),
                   legend.text = element_text(size = 16)))
  }
  else if(legendLoc == "bottom"){
    return(ggplot(data = plot.dat, aes(x = COL, y = ROW)) +
             geom_tile(aes(fill = INTENSITY), color = "white") +
             scale_fill_gradientn(colors = colorspace::diverge_hcl(4)) +
             scale_x_continuous(breaks = unique(plot.dat$COL),
                                labels = interleave(seq(1, max(plot.dat$COL), 2), "")) +
             scale_y_reverse(breaks = unique(plot.dat$ROW),
                             labels = interleave(seq(1, max(plot.dat$ROW), 2), "")) +
             labs(x = "", y = "", title = paste0("Plate ", scan)) +
             theme(panel.background = element_rect(fill = "black",
                                                   color = "black"),
                   panel.grid = element_blank(),
                   title = element_text(size = 18),
                   axis.text = element_text(size = 14),
                   legend.title = element_text(size = 16),
                   legend.text = element_text(size = 16),
                   legend.position = "bottom",
                   legend.key.width = unit(1.5, "cm")) +
             guides(fill = guide_colourbar(label.position = "bottom", ticks = FALSE,
                                           title = expression("Intensity (log"[2]*")"))))
  }
}

#' @title plotHeat_ccle
#'
#' @description Plot a heatmap for one CCLE plate.
#'
#' @param data Data frame to plot.
#' @param scan The ASSAY_PLATE_NAME of the plate to plot.
#' @param legendLoc The location of the legend, either "side" or "bottom".
#'
#' @return A CCLE heatmap.
#'
#' @export
plotHeat_ccle <- function(data = raw_ccle, scan, legendLoc = "side"){
  # get data for the plate of interest
  use.dat <- dplyr::filter(data, ASSAY_PLATE_NAME == scan)[,c("COLUMN_ID","ROW_ID","VALUE")]

  # get the data to plot
  plot.dat <- data.frame(COLUMN_ID = rep(1:48, 32), ROW_ID = rep(1:32, each = 48))
  plot.dat <- merge(x = plot.dat, y = use.dat,
                    by = c("COLUMN_ID", "ROW_ID"),
                    all.x = TRUE)

  if(legendLoc == "side"){
    return(ggplot(data = plot.dat, aes(x = COLUMN_ID, y = ROW_ID)) +
             geom_tile(aes(fill = VALUE), color = "white") +
             scale_fill_gradientn(colors = colorspace::diverge_hcl(4)) +
             scale_x_continuous(breaks = 1:48,
                                labels = interleave(seq(1, 48, 3), "","")) +
             scale_y_reverse(breaks = 1:32,
                             labels = interleave(seq(1, 32, 2), "")) +
             labs(x = "", y = "", title = paste0("Plate ", scan)) +
             guides(fill = guide_colorbar(title = expression(atop("Intensity","(log"[2]*")")),
                                          ticks = FALSE)) +
             theme(panel.background = element_rect(fill = "black", color = "black"),
                   panel.grid = element_blank(),
                   title = element_text(size = 18),
                   axis.text = element_text(size = 12),
                   legend.title = element_text(size = 16),
                   legend.text = element_text(size = 16)))
  }
  else if(legendLoc == "bottom"){
    return(ggplot(data = plot.dat, aes(x = COLUMN_ID, y = ROW_ID)) +
             geom_tile(aes(fill = VALUE), color = "white") +
             scale_fill_gradientn(colors = colorspace::diverge_hcl(4)) +
             scale_x_continuous(breaks = 1:48,
                                labels = interleave(seq(1, 48, 3), "","")) +
             scale_y_reverse(breaks = 1:32,
                             labels = interleave(seq(1, 32, 2), "")) +
             labs(x = "", y = "", title = paste0("Plate ", scan)) +
             theme(panel.background = element_rect(fill = "black", color = "black"),
                   panel.grid = element_blank(),
                   title = element_text(size = 18),
                   axis.text = element_text(size = 12),
                   legend.title = element_text(size = 16),
                   legend.text = element_text(size = 16),
                   legend.position = "bottom") +
             guides(fill = guide_colourbar(label.position = "bottom", ticks = FALSE,
                                           title = expression("Intensity (log"[2]*")"))))
  }
}

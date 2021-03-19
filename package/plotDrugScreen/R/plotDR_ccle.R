#' @title plotDR_ccle
#'
#' @description Plot a dose-response curve for one (or two) CCLE drug-cell line combinations.
#'
#' @param data Data frame to plot. The x-axis will display log2(CONCENTRATION); the y-axis will display RV_MUC.
#' @param combo1 The COMBO_ID of the drug-CL combination to plot.
#' @param combo2 Optional. A second COMBO_ID so that a replicate of the drug-CL combination can added to the plot.
#' @param manScale An optional upper y-axis limit.
#' @param title Plot title.
#' @param connect Logical. Should the plotted points be connected by a line?
#'
#' @return A CCLE dose-response plot.
#'
#' @export
plotDR_ccle <- function(data = norm_ccle, combo1, combo2, manScale = NA,
                            title = "CCLE", connect = FALSE){
  # FIRST DRUG
  tmp <- subset(data, COMBO_ID == combo1)
  plot.dat_1 <- tmp[,c("CONCENTRATION","RV_MUC")]
  plot.dat_1$CONCENTRATION <- log2(plot.dat_1$CONCENTRATION)

  # SECOND DRUG
  tmp <- subset(data, COMBO_ID == combo2)
  plot.dat_2 <- tmp[,c("CONCENTRATION","RV_MUC")]
  plot.dat_2$CONCENTRATION <- log2(plot.dat_2$CONCENTRATION)

  # make the plots
  upperlim <- 1.5
  if(!is.na(manScale)){
    upperlim <- manScale
  }
  toPlot <- ggplot() +
    geom_point(data = plot.dat_1, aes(x = CONCENTRATION, y = RV_MUC),
               shape = 4, size = 2.5, stroke = 2) +
    geom_point(data = plot.dat_2, aes(x = CONCENTRATION, y = RV_MUC),
               shape = 1, size = 2.5, stroke = 2, color = "red") +
    geom_abline(aes(slope = 0, intercept = 1), color = "darkgreen",
                linetype = "dotdash", size = 0.8) +
    scale_y_continuous(limits = c(-0.1, upperlim)) +
    labs(title = title, x = expression("dose (log"["2 "]*mu*"M)"),
         y = "relative viability") +
    theme(title = element_text(size = 17),
          axis.text = element_text(size = 14),
          axis.title = element_text(size = 16))
  if(connect){
    toPlot <- toPlot +
      geom_line(data = plot.dat_1, aes(x = CONCENTRATION, y = RV_MUC),
                size = 0.15, alpha = 0.6) +
      geom_line(data = plot.dat_2, aes(x = CONCENTRATION, y = RV_MUC), color = "red",
                size = 0.15, alpha = 0.6)
  }
  return(toPlot)
}

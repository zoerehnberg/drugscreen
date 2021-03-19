#' @title plotDR_gdsc
#'
#' @description Plot a dose-response curve for one (or two) GDSC drug-cell line combinations.
#'
#' @param data Data frame to plot. The x-axis will display log2(CONC); the y-axis will display RV_MUC.
#' @param CL The COSMIC_ID of the drug_CL combination to plot.
#' @param drug1 The DRUG_ID of the drug_CL combination to plot.
#' @param drug2 Optional. A second DRUG_ID so that a replicate of the drug_CL combination can added to the plot.
#' @param manScale An optional upper y-axis limit.
#' @param title Plot title.
#' @param connect Logical. Should the plotted points be connected by a line?
#'
#' @return A GDSC dose-response plot.
#'
#' @export
plotDR_gdsc <- function(data = norm_gdsc, CL, drug1, drug2 = NA, manScale = NA,
                            title = "GDSC", connect = FALSE){
  dat <- subset(data, COSMIC_ID == CL)

  # FIRST DRUG
  tmp <- subset(dat, DRUG_ID == drug1)
  plot.dat_1 <- tmp[,c("CONC","RV_MUC")]
  plot.dat_1$CONC <- log2(plot.dat_1$CONC)

  # SECOND DRUG
  tmp <- subset(dat, DRUG_ID == drug2)
  plot.dat_2 <- tmp[,c("CONC","RV_MUC")]
  plot.dat_2$CONC <- log2(plot.dat_2$CONC)

  # make the plots
  upperlim <- 1.5
  if(!is.na(manScale)){
    upperlim <- manScale
  }
  toPlot <- ggplot() +
    geom_point(data = plot.dat_1, aes(x = CONC, y = RV_MUC),
               shape = 4, size = 2.5, stroke = 2) +
    geom_point(data = plot.dat_2, aes(x = CONC, y = RV_MUC),
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
      geom_line(data = plot.dat_1, aes(x = CONC, y = RV_MUC),
                size = 0.15, alpha = 0.6) +
      geom_line(data = plot.dat_2, aes(x = CONC, y = RV_MUC), color = "red",
                size = 0.15, alpha = 0.6)
  }
  return(toPlot)
}

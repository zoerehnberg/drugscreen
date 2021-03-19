#' @title plotDR_compare
#'
#' @description Plot a dose-response curve containing both a GDSC drug-cell line combination and a CCLE drug-cell line combination.
#'
#' @param dataGDSC GDSC data frame to plot. The x-axis will display log2(CONC); the y-axis will display RV_MUC.
#' @param clGDSC The COSMIC_ID of the GDSC drug_CL combination to plot.
#' @param drugGDSC The DRUG_ID of the GDSC drug_CL combination to plot.
#' @param dataCCLE CCLE data frame to plot. The x-axis will display log2(CONC); the y-axis will display RV_MUC.
#' @param comboCCLE The COMBO_ID of the CCLE drug_CL combination to plot.
#' @param manScale An optional upper y-axis limit.
#' @param connect Logical. Should the plotted points be connected by a line?
#'
#' @return A dose-response plot containing both a GDSC drug-CL combination and a CCLE drug-CL combination.
#'
#' @export
plotDR_compare <- function(dataGDSC = norm_gdsc, clGDSC, drugGDSC,
                           dataCCLE = norm_ccle, comboCCLE, manScale = NA,
                           connect = FALSE){
  # GDSC
  datGDSC <- subset(dataGDSC, COSMIC_ID == clGDSC & DRUG_ID == drugGDSC,
                    select = c("CONC","RV_MUC"))
  datGDSC$CONC <- log2(datGDSC$CONC)

  # CCLE
  datCCLE <- subset(dataCCLE, COMBO_ID == comboCCLE,
                    select = c("CONCENTRATION","RV_MUC"))
  datCCLE$CONCENTRATION <- log2(datCCLE$CONCENTRATION)

  # make the plot
  upperY <- 1.5
  if(!is.na(manScale)){
    upperY <- manScale
  }
  lowerX <- min(datGDSC$CONC, datCCLE$CONCENTRATION)
  upperX <- max(datGDSC$CONC, datCCLE$CONCENTRATION)
  toPlot <- ggplot() +
    geom_point(data = datGDSC, aes(x = CONC, y = RV_MUC), shape = 4,
               size = 2.5, stroke = 2) +
    geom_point(data = datCCLE, aes(x = CONCENTRATION, y = RV_MUC),
               shape = 1, size = 2.5, stroke = 2, color = "red") +
    geom_abline(aes(slope = 0, intercept = 1), color = "darkgreen",
                linetype = "dotdash", size = 0.8) +
    scale_y_continuous(limits = c(-0.1, upperY)) +
    scale_x_continuous(limits = c(lowerX, upperX)) +
    labs(title = "GDSC vs. CCLE", x = expression("dose (log"["2 "]*mu*"M)"),
         y = "relative viability") +
    theme(title = element_text(size = 17),
          axis.text = element_text(size = 14),
          axis.title = element_text(size = 16))

  if(connect){
    toPlot <- toPlot +
      geom_line(data = plotGDSC, aes(x = CONC, y = RV_MUC),
                size = 0.15, alpha = 0.6) +
      geom_line(data = plotCCLE, aes(x = CONCENTRATION, y = RV_MUC), color = "red",
                size = 0.15, alpha = 0.6)
  }
  return(toPlot)
}

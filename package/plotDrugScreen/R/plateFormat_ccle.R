#' @title plotFormat_ccle
#'
#' @description Display the plate format for a CCLE plate layout.
#'
#' @param data Plate format data frame.
#' @param plate The ASSAY_PLATE_NAME of the plate layout to plot.
#'
#' @return A CCLE plate format plot.
#'
#' @export
plotFormat_ccle <- function(data = raw_ccle, plate){
  # subset to columns of interest
  dat <- subset(data, ASSAY_PLATE_NAME == plate,
                select = c("COLUMN_ID","ROW_ID","WELL_TYPE","CONCENTRATION"))
  dat$USE <- ifelse(dat$WELL_TYPE == "SA", dat$CONCENTRATION, dat$WELL_TYPE)

  # get well types
  plot.dat <- data.frame(ROW = rep(1:32,each = 48), COL = rep(1:48,32),
                         TAG = "Missing")
  for(i in 1:nrow(dat)){
    plot.dat[plot.dat$ROW == dat[i,2] & plot.dat$COL == dat[i,1],3] <- dat[i,5]
  }
  plot.dat$TAG <- as.character(plot.dat$TAG)

  # translate tag names to well types
  to.drug <- function(x){
    if(x == "Missing") x <- "Missing"
    else if(x == "8") x <- "Dose 1"
    else if(x == "2.53164601") x <- "Dose 2"
    else if(x == "0.801153719") x <- "Dose 3"
    else if(x == "0.253529608") x <- "Dose 4"
    else if(x == "0.0802308992") x <- "Dose 5"
    else if(x == "0.0253895205") x <- "Dose 6"
    else if(x == "0.00803465955") x <- "Dose 7"
    else if(x == "0.00254261401") x <- "Dose 8"
    else if(x == "AC") x <- "Blank"
    else if(x == "NC") x <- "Untreated"
    return(x)
  }
  plot.dat$TAG <- factor(sapply(plot.dat$TAG, to.drug, USE.NAMES = FALSE))

  myColors <- c("grey0","grey10","grey20","grey30","grey40", "grey50",
                "grey60", "grey70","#56B4E9","#009E73","#F0E442")
  names(myColors) <- c("Dose 1","Dose 2","Dose 3","Dose 4","Dose 5","Dose 6",
                       "Dose 7","Dose 8","Untreated","Blank","Missing")

  return(ggplot(data = plot.dat, aes(x = COL, y = ROW)) +
           geom_point(aes(color = TAG), size = 5) +
           scale_color_manual(values = myColors) +
           labs(x = "", y = "") +
           scale_x_continuous(breaks = 1:48,
                              labels = interleave(seq(1, 48, 2), "")) +
           scale_y_reverse(breaks = 1:32,
                           labels = interleave(seq(1, 32, 2), "")) +
           theme(legend.title = element_blank(),
                 legend.text = element_text(size = 20),
                 axis.text = element_text(size = 14)) +
           guides(color = guide_legend(override.aes = list(size = 5))))
}

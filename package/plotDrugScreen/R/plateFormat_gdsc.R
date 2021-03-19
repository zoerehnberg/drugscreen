#' @title plotFormat_gdsc
#'
#' @description Display the plate format for a GDSC plate layout.
#'
#' @param data Plate format data frame.
#' @param drugest The DRUGSET_ID of the plate layout to plot.
#'
#' @return A GDSC plate format plot.
#'
#' @export
plotFormat_gdsc <- function(data = gdsc_plate_maps, drugset){

  use.me <- subset(data, DRUGSET_ID == drugset)[,c(3:6,9)]
  use.me$USE <- ifelse(!is.na(use.me$DRUG_ID), use.me$ORIG_TAG, use.me$TAG)

  if(table(use.me$DRUG_ID)[1] == 9){
    myColors <- c("grey0","grey10","grey20","grey30","grey40","grey50",
                  "grey60","grey70","grey80","#E69F00","#56B4E9",
                  "#009E73","#F0E442","#D55E00","#CC79A7")
    names(myColors) <- c("Dose 1","Dose 2","Dose 3","Dose 4","Dose 5","Dose 6",
                         "Dose 7","Dose 8","Dose 9","Other","Untreated",
                         "Blank","Missing","Unused","Failed")
  }
  else{
    myColors <- c("grey0","grey20","grey40","grey60","grey80","#E69F00",
                  "#56B4E9","#009E73","#F0E442","#D55E00","#CC79A7")
    names(myColors) <- c("Dose 1","Dose 2","Dose 3","Dose 4","Dose 5","Other",
                         "Untreated","Blank","Missing","Unused","Failed")
  }
  to.drug <- function(x, fort){
    if(x %in% c("k", "k1", "k2", "ss")) x = "Other"
    else if(x == "raw1") x = "Dose 1"
    else if(x == "raw2") x = "Dose 2"
    else if(x == "raw3") x = "Dose 3"
    else if(x == "raw4") x = "Dose 4"
    else if(x == "raw5") x = "Dose 5"
    else if(x == "raw6") x = "Dose 6"
    else if(x == "raw7") x = "Dose 7"
    else if(x == "raw8") x = "Dose 8"
    else if(x == "raw9") x = "Dose 9"
    else if(x == "B") x = "Blank"
    else if(x == "NC-0") x = "Untreated"
    else if(x == "UN-USED") x = "Unused"
    else if(x == "FAIL") x = "Failed"
    else x = "Missing"
    return(x)
  }
  use.me$TAG <- factor(sapply(use.me$USE, to.drug, drugset, USE.NAMES = FALSE))

  return(ggplot(data = use.me, aes(x = ACROSS, y = as.numeric(factor(DOWN)))) +
           geom_point(aes(color = TAG), size = 7) +
           scale_color_manual(values = myColors) +
           labs(x = "", y = "") +
           scale_x_continuous(breaks = c(1:24),
                              labels = interleave(seq(1, 24, 2), "")) +
           scale_y_reverse(breaks = c(1:16),
                           labels = interleave(seq(1, 16, 2), "")) +
           theme(legend.title = element_blank(),
                 legend.text = element_text(size = 20),
                 axis.text = element_text(size = 14)) +
           guides(color = guide_legend(override.aes = list(size = 5))))
}

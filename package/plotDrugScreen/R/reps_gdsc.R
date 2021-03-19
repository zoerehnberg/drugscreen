#' @title reps_gdsc
#'
#' @description Select rows for replicates tested at the same maxc.
#'
#' @param data Must have COSMIC_ID and DRUG_ID columns and no maxc column.
#' @param d Allowed difference between replicates' max concentration.
#' @param data2 Must contain max concentration.
#' @param drugsA Vector of DRUG_IDs for replicate A.
#' @param drugsB Vector of DRUG_IDs for replicate B.
#'
#' @return A data frame containing only observations for the given replicates that were tested at the same concentrations in both replicate A and B.
#'
#' @export
reps_gdsc <- function(data, d = 0.5, data2 = gdsc_nlme_stats,
                      drugsA = c("1014","1036","1058","156"),
                      drugsB = c("1526","1371","1527","1066")){
  `%fin%` <- function(x, table) {
    fastmatch::fmatch(x, table, nomatch = 0L) > 0L
  }
  dat <- subset(data, DRUG_ID %fin% c(drugsA, drugsB))

  # add a column for the maximum tested concentration and keep only the combo
  # information
  use.dat <- merge(x = dat,
                   y = data2[,c("CL","DRUG_ID_lib","maxc")],
                   by.x = c("COSMIC_ID","DRUG_ID"),
                   by.y = c("CL","DRUG_ID_lib"))
  use.dat <- use.dat[,c("COSMIC_ID","DRUG_ID","maxc")]
  use.dat <- use.dat[!duplicated(use.dat),]

  # create a single row for each replicated combo
  dupCombo <- vector(mode = "list")
  for(i in 1:length(drugsA)){
    dupCombo[[i]] <- merge(x = subset(use.dat, DRUG_ID == drugsA[i]),
                           y = subset(use.dat, DRUG_ID == drugsB[i]),
                           by = "COSMIC_ID")
  }
  dupCombo <- dplyr::bind_rows(dupCombo)

  # only keep observations with the same max concentration
  dupCombo <- subset(dupCombo, abs(maxc.x - maxc.y) < d)
  dupDat <- rbind(merge(x = dat,
                        y = dupCombo[,c("COSMIC_ID","DRUG_ID.x")],
                        by.x = c("COSMIC_ID","DRUG_ID"),
                        by.y = c("COSMIC_ID","DRUG_ID.x")),
                  merge(x = dat,
                        y = dupCombo[,c("COSMIC_ID","DRUG_ID.y")],
                        by.x = c("COSMIC_ID","DRUG_ID"),
                        by.y = c("COSMIC_ID","DRUG_ID.y")))
  return(dupDat)
}

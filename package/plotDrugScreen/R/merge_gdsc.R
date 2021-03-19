#' @title merge_gdsc
#'
#' @description Creates a data frame with a single row for each replicated drug-CL combination
#'
#' @param data Must have COSMIC_ID and DRUG_ID columns. Likely the output of reps_gdsc.
#' @param drugsA Vector of DRUG_IDs for replicate A.
#' @param drugsB Vector of DRUG_IDs for replicate B.
#'
#' @return A data frame containing one row for each drug-CL combination for replicates A and B.
#'
#' @export
merge_gdsc <- function(data, drugsA = c("1014","1036","1058","156"),
                           drugsB = c("1526","1371","1527","1066")){
  `%fin%` <- function(x, table) {
    fastmatch::fmatch(x, table, nomatch = 0L) > 0L
  }
  dat <- subset(data, DRUG_ID %fin% c(drugsA, drugsB))

  repsList <- vector(mode = "list")
  for(i in 1:length(drugsA)){
    tmp1 <- subset(dat, DRUG_ID == drugsA[i])
    tmp2 <- subset(dat, DRUG_ID == drugsB[i])
    repsList[[i]] <- merge(x = tmp1, y = tmp2, by = "COSMIC_ID")
  }
  return(dplyr::bind_rows(repsList))
}

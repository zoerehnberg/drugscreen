% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotDR_compare.R
\name{plotDR_compare}
\alias{plotDR_compare}
\title{plotDR_compare}
\usage{
plotDR_compare(
  dataGDSC = norm_gdsc,
  clGDSC,
  drugGDSC,
  dataCCLE = norm_ccle,
  comboCCLE,
  manScale = NA,
  connect = FALSE
)
}
\arguments{
\item{dataGDSC}{GDSC data frame to plot. The x-axis will display log2(CONC); the y-axis will display RV_MUC.}

\item{clGDSC}{The COSMIC_ID of the GDSC drug_CL combination to plot.}

\item{drugGDSC}{The DRUG_ID of the GDSC drug_CL combination to plot.}

\item{dataCCLE}{CCLE data frame to plot. The x-axis will display log2(CONC); the y-axis will display RV_MUC.}

\item{comboCCLE}{The COMBO_ID of the CCLE drug_CL combination to plot.}

\item{manScale}{An optional upper y-axis limit.}

\item{connect}{Logical. Should the plotted points be connected by a line?}
}
\value{
A dose-response plot containing both a GDSC drug-CL combination and a CCLE drug-CL combination.
}
\description{
Plot a dose-response curve containing both a GDSC drug-cell line combination and a CCLE drug-cell line combination.
}

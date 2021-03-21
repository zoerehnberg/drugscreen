# Technical Error and Plate Design in Drug Screening Studies

## Ways to Use This Repository

- **Download the docker image.** This contains the completed analysis, including all original data, processed data, Rmd scripts, and plots, and will allow an exploration of the analysis through a web browser.  Download the image from https://www.dropbox.com/s/lzqvm94d7weazii/drugscreen.tar.gz?dl=0.  Load the image with

      docker load -i drugscreen.tar.gz  
  and then run it with
  
      docker run -it --rm -p 127.0.0.1:80:80 drugscreen  
  The image can be removed with 
  
      docker image rm drugscreen

- **Download the release.** This contains a snapshot of the completed analysis as run in the docker image, including all original data, processed data, Rmd scripts, and plots. Several `make` commands can be run to redo analysis and plotting. For example, running 

      make package
      make installpackage
      make plots  
  will re-create all plots and allow the exploration of plotting scripts. See the makefile for all possible commands.


## Drug Screening Shiny App

Visit https://github.com/zoerehnberg/shinydrugscreen for a Shiny app that facilitates the exploration of the raw GDSC and CCLE drug screening data.

## Data Sources

The following data are needed, and should be saved in the `data/original` directory.  The data can be automatically downloaded using `data/download.Rmd`.

1. `gdsc_v17`, `gdsc_plate_maps`, and `gdsc_nlme_stats`: Available from the CancerRxGene  GitHub page (https://github.com/CancerRxGene/gdscdata/tree/master/data)

2. `GDSC_cells` and `GDSC_drugs`: Available from the GDSC bulk data download page (https://www.cancerrxgene.org/downloads/bulk_download)

3. `ccle_orig`: Available from the Supplementary Data in the second Addendum to *The Cancer Cell Line Encyclopedia enables predictive modelling of anticancer drug sensitivity* (Barretine, et al. 2019)

4. `processedCCLEdata`: Available from the pharmacological profiling legacy data on the CCLE website (https://portals.broadinstitute.org/ccle/data)

5. `GDSC_to_CCLE`: Available from the Supplementary Data in *Pharmacogenomic agreement between two cancer cell line data sets* (The Cancer Cell Line Encyclopedia Consortium & The Genomics of Drug Sensitivity in Cancer Consortium 2015)

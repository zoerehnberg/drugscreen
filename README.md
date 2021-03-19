# Technical Error and Plate Design in Drug Screening Studies

## Ways to Use This Repository

- **Download the release.** This contaians a snapshot of the completed analysis, including all original data, processed data, Rmd scripts, and plots. Several `make` commands can be run to redo analysis and plotting. For example, running `make package`, `make installpackage`, and `make plots` will re-create all plots and allow the exploration of plotting scripts. See the makefile for all possible commands.

- **Download the docker image.** This contaians the completed analysis, including all original data, processed data, Rmd scripts, and plots. Running this image will allow an exploration of the analysis through a web browser. Use the command `docker run -it --name <CONTAINER_NAME> -p 127.0.0.1:80:80 drugscreen_analysis` to run. Files can be copied out of the container (e.g. `docker cp <CONTAINER_NAME>:/home/rep/output/ .`). The container should be removed once the exploration is complete (`docker rm <CONTAINER_NAME>`).

## Drug Screening Shiny App

Visit https://github.com/zoerehnberg/drug_screening_shiny for a Shiny app that facilitates the exploration of the raw GDSC and CCLE drug screening data.

## Data Sources

The following data are needed, and should be saved in the `data/original` directory.  The data can be automatically downloaded using `data/download.Rmd`.

1. `gdsc_v17`, `gdsc_plate_maps`, and `gdsc_nlme_stats`: Available from the CancerRxGene  GitHub page (https://github.com/CancerRxGene/gdscdata/tree/master/data)

2. `GDSC_cells` and `GDSC_drugs`: Available from the GDSC bulk data download page (https://www.cancerrxgene.org/downloads/bulk_download)

3. `ccle_orig`: Available from the Supplementary Data in the second Addendum to *The Cancer Cell Line Encyclopedia enables predictive modelling of anticancer drug sensitivity* (Barretine, et al. 2019)

4. `processedCCLEdata`: Available from the pharmacological profiling legacy data on the CCLE website (https://portals.broadinstitute.org/ccle/data)

5. `GDSC_to_CCLE`: Available from the Supplementary Data in *Pharmacogenomic agreement between two cancer cell line data sets* (The Cancer Cell Line Encyclopedia Consortium & The Genomics of Drug Sensitivity in Cancer Consortium 2015)

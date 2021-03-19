.PHONY: builddocker build rerun download process package installpackage plots clean dockeronly archive

builddocker: build dockeronly

build: download process package installpackage plots

rerun: clean process package installpackage plots

download:
	cd data && R -e 'rmarkdown::render("download.Rmd")'

process:
	echo "Processing GDSC data..."
	cd analysis && R -e 'rmarkdown::render("dataPrep_GDSC.Rmd")'
	echo "Processing CCLE data..."
	cd analysis && R -e 'rmarkdown::render("dataPrep_CCLE.Rmd")'
	echo "Matching GDSC and CCLE data..."
	cd analysis && R -e 'rmarkdown::render("match_GDSC_CCLE.Rmd")'
	echo "Calculating magnitude of spatial effects..."
	cd analysis && R -e 'rmarkdown::render("spatialEffectsMag.Rmd")'
	echo "Calculating magnitude of checkerboard pattern..."
	cd analysis && R -e 'rmarkdown::render("quantifyCheckerboard.Rmd")'
	echo "Final processing of original data..."
	cd analysis && R -e 'rmarkdown::render("copy_original.Rmd")'

package:
	cp data/processed/* package/plotDrugScreen/data/ 
	cp data/original/gdsc_nlme_stats.rda package/plotDrugScreen/data/
	cp data/original/gdsc_plate_maps.rda package/plotDrugScreen/data/            
	R CMD build package/plotDrugScreen
	rm package/plotDrugScreen/data/*  # To save space.  

installpackage: 
	R -e 'devtools::install_local("'`echo plotDrugScreen*.tar.gz`'", upgrade="never")'

plots:
	echo "Making plots and figures..."
	cd analysis && R -e 'rmarkdown::render("plots_format.Rmd")'
	cd analysis && R -e 'rmarkdown::render("plots_correlation.Rmd")'
	cd analysis && R -e 'rmarkdown::render("plots_technicalError.Rmd")'
	cd analysis && R -e 'rmarkdown::render("plots_AUCheatmaps.Rmd")'
	cd analysis && R -e 'rmarkdown::render("plots_drugL685458.Rmd")'
	cd analysis && R -e 'rmarkdown::render("plots_challenges.Rmd")'
	cd analysis && R -e 'rmarkdown::render("plots_biology.Rmd")'

clean:
	echo "Deleting all processed data and output..."
	rm -f data/processed/*
	rm -f output/*
	rm -f analysis/*.html
	rm -f archive.tar.bz2
	rm -f plotDrugScreen*.tar.gz
	R -e 'remove.packages("plotDrugScreen")'

dockeronly:     
	# To save space:
	# Replace data in the installed R package with symbolic links to data/original and data/processed
	rm -f R/x86*/4.0/plotDrugScreen/data/*.rda
	ln -s /home/rep/data/original/*.rda R/x86*/4.0/plotDrugScreen/data/
	ln -s /home/rep/data/processed/*.rda R/x86*/4.0/plotDrugScreen/data/
	# Remove package file
	rm -f plotDrugScreen*.tar.gz

archive:
	rm -f archive.tar.bz2
	tar --exclude='.git' -cjf /tmp/archive.tar.bz2 . && mv /tmp/archive.tar.bz2 .

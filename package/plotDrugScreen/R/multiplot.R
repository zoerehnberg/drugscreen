#' @title multiplot
#'
#' @description Print out several plots in a grid.
#'
#' @param plotlist List of plots.
#' @param cols Number of columns in the grid of plots to produce
#' @param title Main title.
#'
#' @return A grid of plots.
#'
#' @export
multiplot <- function(plotlist = NULL, cols = 1,  title = NULL) {
  plots <- plotlist
  numPlots = length(plots)

  layout <- matrix(seq(1, (cols * ceiling(numPlots/cols)) + cols),
                   ncol = cols, nrow = ceiling(numPlots/cols) + 1, byrow = T)

  if(numPlots == 1){
    print(plots[[1]])
    }
  else{
    grid::grid.newpage()
    grid::pushViewport(grid::viewport(layout = grid::grid.layout(nrow(layout), ncol(layout),
                                               heights = unit(c(0.5, rep(4,numPlots)),"null"))))
    grid::grid.text(title, vp = grid::viewport(layout.pos.row = 1,
                                   layout.pos.col = 1:ncol(layout)),
              gp = grid::gpar(fontsize = 16))
    for (i in 1:numPlots) {
      matchidx <- as.data.frame(which(layout == i+cols, arr.ind = TRUE))
      print(plots[[i]], vp = grid::viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

#' @title interleave
#'
#' @description Interleave two (or three) vectors.
#'
#' @param x First vector.
#' @param y Second vector. To be interleaved with x.
#' @param z If provided, third vector. To be interleaved with x and y.
#'
#' @return A vector of length length(x) + length(y) with the elements of x and y interleaved.
#'
#' @export
interleave <- function(x,y,z = NULL){
  if(!is.null(z)){
    lx <- length(x)
    ly <- length(y)
    lz <- length(z)
    n <- max(lx,ly,lz)
    return(as.vector(rbind(rep(x, length.out=n), rep(y, length.out=n),
                           rep(z, length.out=n))))
  }
  else{
    lx <- length(x)
    ly <- length(y)
    n <- max(lx,ly)
    return(as.vector(rbind(rep(x, length.out=n), rep(y, length.out=n))))
  }
}

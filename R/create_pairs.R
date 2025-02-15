#' Create pairs of moments
#'
#' Creates a list of all possible paring between the moments of analysis.
#'
#' @param n_moment an integer value representing the number of moments for analysis.
#'
#' @return a list of vectors containing the possible pairs of moments.
#'
create_pairs <- function(n_moment){

  pairs = list()

  for(i in 1:(n_moment-1)){
    pairs[[length(pairs)+1]] = c(i, i+1)
    if(i+1 != n_moment){
      pairs[[length(pairs)+1]] = c(i, n_moment)
    }
  }

  return(pairs)

}

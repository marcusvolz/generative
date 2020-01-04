#' Generates data for the 'Interpolate Squares' visualisation
#'
#' For each square, interpolates the four edges of the square to random line segments whose endpoints lie inside the square
#' @param seed Seed number
#' @param n Number of squares
#' @param ease_function Either randomly selected or specified for all squares.
#' Options: "linear", "quadratic-in", "quadratic-out", "quadratic-in-out", "cubic-in", "cubic-out", "cubic-in-out",
#' "quartic-in", "quartic-out", "quartic-in-out", "quintic-in", "quintic-out", "quintic-in-out", "sine-in",
#' "sine-out", "sine-in-out", "circular-in", "circular-out", "circular-in-out", "exponential-in",
#' "exponential-out", "exponential-in-out", "elastic-in", "elastic-out", "elastic-in-out", "back-in",
#' "back-out", "back-in-out", "bounce-in", "bounce-out", "bounce-in-out"
#' @keywords interpolate
#' @export
#' @examples
#' interpolate_squares()

interpolate_squares <- function(seed = 1, n = 25, ease_function = "") {
  # Set seed
  set.seed(seed)
  
  # Ease functions
  ease_functions <- c("linear", "quadratic-in", "quadratic-out", "quadratic-in-out", "cubic-in", "cubic-out", "cubic-in-out",
                      "quartic-in", "quartic-out", "quartic-in-out", "quintic-in", "quintic-out", "quintic-in-out", "sine-in",
                      "sine-out", "sine-in-out", "circular-in", "circular-out", "circular-in-out", "exponential-in",
                      "exponential-out", "exponential-in-out", "elastic-in", "elastic-out", "elastic-in-out", "back-in",
                      "back-out", "back-in-out", "bounce-in", "bounce-out", "bounce-in-out")
  
  # Function for generating data for one square
  make_facet <- function(ease = "bounce-out") {
    df1 <- data.frame(x = c(0, 1, 1, 0), y = c(0, 0, 1, 1), xend = c(1, 1, 0, 0), yend = c(0, 1, 1, 0))
    df2 <- data.frame(x = runif(4), y = runif(4), xend = runif(4), yend = runif(4))
    df <- list(df1, df2)
    tf <- tweenr::tween_states(df, tweenlength = 1, statelength = 0, ease = ease, nframes = 1000)
    tf
  }
  
  # Generate data
  if (ease_function %in% ease_functions) {
    temp <- rep(ease_function, times = n)
  } else {
    temp <- sample(ease_functions, n)
  }
  
  df <- temp %>%
    purrr::map_df(make_facet, .id = "id") %>%
    dplyr::mutate(id = as.integer(id)) %>%
    dplyr::left_join(data.frame(id = 1:length(ease_functions), fn = ease_functions), by = "id")
  
  # Return data
  df
}

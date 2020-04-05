#' Procedural Ring
#'
#' Generates data from a contrived algorithm in which a point continuously moves around
#' the circumference of a circle and offsets randomly from the circle boundary based on
#' user-set parameters such as eps.
#' @param seed The seed number
#' @param n The number of steps to make around the circumference of the circle
#' @param n_circles The number of times to repeat the algorithm (results are overlaid and interpolated)
#' @param r_0 The radius of the circle
#' @param eps The base amount to offset from the circumference of the circle
#' @param eps_big If there is a 'defect', the point jumps to this large radius + eps + noise
#' @param p_defect The probability of a defect (an unusualy high offset)
#' @param delta The angle (in degrees) between successive radial movements around the circumference (+/-1 deg is added)
#' @param wildflower If TRUE, r is always updated in the positive radial direction
#' @keywords procedural ring algorithm
#' @export
#' @examples
#' procedural_ring()

procedural_ring <- function(seed = 3, n = 400, n_circles = 4, r_0 = 5000,
                            eps = 500, eps_big = 5000, p_defect = 0.1, delta = 2.02, wildflower = FALSE) {
  set.seed(seed)
  theta <- 0
  r <- r_0
  r_last <- r

  make_circle <- function() {
    df <- data.frame(x = numeric(0), y = numeric(0))
    for(i in 1:n) {
      df[i, c("x", "y")] <- c(r * cos(theta), r * sin(theta))
      theta <- theta + (delta + runif(1, -1, 1)) * pi / 180
      defect <- runif(1)
      r <- ifelse(defect < p_defect,
                  eps_big + runif(1, 0, eps),
                  r_last + runif(1, ifelse(wildflower, 0, -eps), eps))
      r_last <- ifelse(defect < p_defect / 10, r_last, r)
    }
    df %>% dplyr::mutate(xend = lead(x), yend = lead(y)) %>% dplyr::filter(!is.na(xend))
  }
  
  1:n_circles %>% purrr::map(~make_circle()) %>%
    tweenr::tween_states(tweenlength = 2, statelength = 1, ease = "linear", nframes = 10000)
}
# generative

A repository of generative visualisations created with R.

### Installation

```R
devtools::install_github("marcusvolz/generative")
library(generative)
```

### Procedural ring

```R
# Load packages
library(aRtwork)
library(ggplot2)
library(tweenr)

# Generate data
df <- procedural_ring(seed = 3, n = 400, n_circles = 4, r_0 = 5000,
                      eps = 500, eps_big = 5000, p_defect = 0.1, delta = 2.02)

# Create plot
p <- ggplot() +
  geom_segment(aes(x, y, xend = xend, yend = yend), df, size = 0.025, alpha = 0.05) +
  coord_equal() +
  theme_void()

# Save plot (might take a few moments)
ggsave("procedural_ring.png", p, width = 20, height = 20, units = "cm")
```
![](https://github.com/marcusvolz/aRtwork/blob/master/plots/procedural_ring.png)

## Interpolate squares

```R
# Load packages
library(aRtwork)
library(ggplot2)

# Generate data
df <- interpolate_squares(seed = 1, n = 25, ease_function = "")

# Create plot
p <- ggplot() +
  geom_segment(aes(x, y, xend = xend, yend = yend), df, alpha = 0.03,
               size = 0.15, lineend = "round") +
  facet_wrap(~id, scales = "free") +
  theme_blankcanvas(margin_cm = 2.5)

# Save plot
ggsave("interpolate_squares.png", p, width = 20 , height = 20, units = "cm")
```

![](https://github.com/marcusvolz/aRtwork/blob/master/plots/interpolate_squares.png)

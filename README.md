# aRtwork

A Repository of Artistic Visualisations Created with R.

## Interpolate squares

Inperpolates the edges of a square to random line segments.

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

![](https://github.com/marcusvolz/aRtwork/blob/master/plots/interpolate_squares.png "")
# generative

A repository of generative visualisations created with R.

### Installation

```R
devtools::install_github("marcusvolz/generative")
library(generative)
```

### Procedural ring

Refer to the following [Gist](https://gist.github.com/marcusvolz/69b38feb9908aa3a80ff6df77c7e00bd).

![](https://github.com/marcusvolz/aRtwork/blob/master/plots/procedural_ring.png)

## Interpolate squares

Refer to the following [Gist](https://gist.github.com/marcusvolz/28881fe048778b89a3a2f465c731ed94).

```R
# Load packages
library(generative)
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

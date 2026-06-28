# ============================================================================
# Chart 1: The SGA Divergence
# Blind vs. Non-Blind Substantial Gainful Activity Limits, 1978-2026
#
# Notes from the Abstract — "Legally Nothing"
# Copyright (c) 2026 Andrew R. Crocker
# Data source: Social Security Administration, COLA Determinations
# https://www.ssa.gov/oact/cola/sga.html
# ============================================================================

library(ggplot2)

theme_1950s <- function() {
  theme_minimal(base_family = "Arial", base_size = 14) +
    theme(
      plot.background = element_rect(fill = "#FAF5E9", color = NA),
      panel.background = element_rect(fill = "#FAF5E9", color = NA),
      panel.grid.major = element_line(color = "#E6DECA", linewidth = 0.6),
      panel.grid.minor = element_blank(),
      axis.title = element_text(face = "bold", color = "#3A3A3A"),
      axis.text = element_text(color = "#4A4A4A"),
      plot.title = element_text(face = "bold", size = 20, color = "#3A3A3A"),
      plot.subtitle = element_text(size = 13, color = "#5A5A5A"),
      plot.margin = margin(15, 15, 15, 15),
      legend.position = "none"
    )
}

sga <- data.frame(
  year = 1978:2026,
  blind = c(334, 375, 417, 459, 500, 550, 580, 610, 650, 680, 700, 740,
            780, 810, 850, 880, 930, 940, 960, 1000, 1050, 1110, 1170,
            1240, 1300, 1330, 1350, 1380, 1450, 1500, 1570, 1640, 1640,
            1640, 1690, 1740, 1800, 1820, 1820, 1950, 1970, 2040, 2110,
            2190, 2260, 2460, 2590, 2700, 2830),
  nonblind = c(260, 280, 300, 300, 300, 300, 300, 300, 300, 300, 300, 300,
               500, 500, 500, 500, 500, 500, 500, 500, 500, 700, 700,
               740, 780, 800, 810, 830, 860, 900, 940, 980, 1000, 1000,
               1010, 1040, 1070, 1090, 1130, 1170, 1180, 1220, 1260,
               1310, 1350, 1470, 1550, 1620, 1690)
)

sga$difference <- sga$blind - sga$nonblind

p <- ggplot(sga, aes(x = year)) +
  geom_ribbon(aes(ymin = nonblind, ymax = blind), fill = "#C0392B", alpha = 0.12) +
  geom_line(aes(y = blind), color = "#C0392B", linewidth = 1.3) +
  geom_line(aes(y = nonblind), color = "#3A3A3A", linewidth = 1.3) +
  annotate("text", x = 2010, y = 2300, label = "Statutorily Blind",
           color = "#C0392B", fontface = "bold", size = 4.5, hjust = 0) +
  annotate("text", x = 2010, y = 1050, label = "All Other Disabilities",
           color = "#3A3A3A", fontface = "bold", size = 4.5, hjust = 0) +
  annotate("text", x = 1996, y = 750,
           label = "$1,140/mo\ndifference\nin 2026",
           color = "#C0392B", fontface = "bold", size = 4, hjust = 0.5,
           lineheight = 0.9) +
  annotate("segment", x = 2026.5, xend = 2026.5,
           y = 1690, yend = 2830,
           color = "#C0392B", linewidth = 0.8,
           arrow = arrow(ends = "both", length = unit(0.15, "cm"))) +
  scale_x_continuous(breaks = seq(1980, 2025, 5),
                     limits = c(1978, 2028)) +
  scale_y_continuous(labels = scales::dollar_format(),
                     breaks = seq(0, 3000, 500)) +
  labs(
    title = "The Earnings Line That Was Never Drawn",
    subtitle = "Monthly SGA limits: blind vs. all other disabilities, 1978\u20132026 (SSA)",
    x = NULL,
    y = "Monthly SGA Limit"
  ) +
  theme_1950s()

print(p)

ggsave("~/Downloads/chart1_sga_divergence.png", p,
       width = 1456 / 150, height = 819 / 150, dpi = 150)

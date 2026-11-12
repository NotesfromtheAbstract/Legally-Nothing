# ============================================================================
# Chart 3: The Threshold Ladder
# Where 12.5 Million Americans Fall Between Two Standards
#
# Notes from the Abstracts — "Legally Nothing"
# Copyright (c) 2026 Andrew R. Crocker
# Data sources:
#   Texas HHSC CODTW (55 dB threshold)
#   SSA Listing 2.10 (90 dB threshold)
#   Goman AM, Lin FR. Am J Public Health. 2016;106(10):1820-1822.
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
      plot.margin = margin(15, 25, 15, 15),
      legend.position = "none"
    )
}

# Severity bands from Goman & Lin (NHANES 2001-2010)
bands <- data.frame(
  label = c("Normal hearing", "Mild\n25.4M", "Moderate\n10.7M",
            "Severe\n1.8M", "Profound\n0.4M"),
  ymin = c(0, 25, 40, 60, 80),
  ymax = c(25, 40, 60, 80, 110),
  fill = c("#E6DECA", "#E6DECA", "#2471A3", "#2471A3", "#C0392B"),
  alpha = c(0.3, 0.5, 0.25, 0.35, 0.25)
)

# Key reference points on the dB scale
markers <- data.frame(
  db = c(20, 55, 60, 90),
  label = c("Whispered speech (~20 dB)",
            "Texas CODTW\nthreshold (55 dB)",
            "Normal conversation\n(~60 dB)",
            "SSA Listing 2.10\nthreshold (90 dB)"),
  color = c("#4A4A4A", "#2471A3", "#4A4A4A", "#C0392B"),
  hjust = c(0, 0, 0, 0)
)

p <- ggplot() +
  # Severity bands
  geom_rect(data = bands,
            aes(xmin = 0.3, xmax = 0.7, ymin = ymin, ymax = ymax),
            fill = bands$fill, alpha = bands$alpha) +
  # Band labels
  geom_text(data = bands,
            aes(x = 0.5, y = (ymin + ymax) / 2, label = label),
            color = "#3A3A3A", size = 3.8, fontface = "bold",
            lineheight = 0.85) +
  # Threshold lines
  geom_segment(aes(x = 0.28, xend = 0.85, y = 55, yend = 55),
               color = "#2471A3", linewidth = 1.2, linetype = "solid") +
  geom_segment(aes(x = 0.28, xend = 0.85, y = 90, yend = 90),
               color = "#C0392B", linewidth = 1.2, linetype = "solid") +
  # Threshold labels - positioned above and below to avoid overlap
  annotate("text", x = 0.12, y = 55,
           label = "Texas CODTW\n(55 dB)",
           color = "#2471A3", fontface = "bold", size = 3.8, hjust = 0.5,
           lineheight = 0.85) +
  annotate("text", x = 0.12, y = 90,
           label = "SSA Listing 2.10\n(90 dB)",
           color = "#C0392B", fontface = "bold", size = 3.8, hjust = 0.5,
           lineheight = 0.85) +
  # The space between: annotation
  annotate("segment", x = 0.22, xend = 0.22, y = 55, yend = 90,
           color = "#3A3A3A", linewidth = 0.8,
           arrow = arrow(ends = "both", length = unit(0.15, "cm"))) +
  annotate("text", x = 0.18, y = 72.5,
           label = "~12.5M\nAmericans",
           color = "#3A3A3A", fontface = "bold", size = 4.2,
           hjust = 0.5, lineheight = 0.85) +
  # Normal conversation reference
  geom_segment(aes(x = 0.28, xend = 0.72, y = 60, yend = 60),
               color = "#4A4A4A", linewidth = 0.5, linetype = "dotted") +
  annotate("text", x = 0.87, y = 60,
           label = "Normal conversation (~60 dB)",
           color = "#4A4A4A", size = 3.2, hjust = 0.5, fontface = "italic") +
  scale_y_continuous(breaks = seq(0, 110, 10),
                     labels = function(x) paste0(x, " dB"),
                     limits = c(0, 115)) +
  scale_x_continuous(limits = c(0.05, 1.0)) +
  coord_flip() +
  labs(
    title = "Where 12.5 Million Americans Fall",
    subtitle = "Between the Texas standard and the SSA listing, measured in decibels of hearing loss",
    x = NULL,
    y = "Pure Tone Average (dB HL) in Better Ear"
  ) +
  theme_1950s() +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid.major.y = element_blank()
  )

print(p)

ggsave("~/Downloads/chart3_threshold_ladder.png", p,
       width = 1456 / 150, height = 819 / 150, dpi = 150)

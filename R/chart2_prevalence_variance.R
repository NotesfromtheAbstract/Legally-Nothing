# ============================================================================
# Chart 2: The Prevalence Variance
# Same Question, Three Cutoffs, Three Populations
#
# Notes from the Abstracts — "Legally Nothing"
# Copyright (c) 2026 Andrew R. Crocker
# Data sources:
#   Lin FR, Niparko JK, Ferrucci L. Arch Intern Med. 2011;171(20):1851-1852.
#   Goman AM, Lin FR. Am J Public Health. 2016;106(10):1820-1822.
#   WHO. Deafness and hearing loss fact sheet. March 2026.
#   NFB. Blindness Statistics (legally blind prevalence).
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

prev <- data.frame(
  source = c(
    "CDC/NHANES\n(\u226525 dB)\nLin et al. 2011",
    "CDC/NHANES\n(\u226525 dB)\nGoman & Lin 2016",
    "WHO\n(>35 dB)\nCurrent definition",
    "WHO\n(>40 dB)\nPre-2022 definition"
  ),
  millions = c(30.0, 38.2, 15.5, 12.5),
  note = c("bilateral", "bilateral", "estimated US share", "estimated US share")
)

prev$source <- factor(prev$source, levels = prev$source)

# US-specific WHO estimates are approximate, derived from global proportions
# applied to US population. The exact numbers matter less than the variance.

p <- ggplot(prev, aes(x = source, y = millions)) +
  geom_col(fill = c("#2471A3", "#2471A3", "#C0392B", "#C0392B"),
           width = 0.65) +
  geom_text(aes(label = paste0(millions, "M")),
            vjust = -0.5, fontface = "bold", color = "#3A3A3A", size = 5) +
  geom_hline(yintercept = 1.1, linetype = "dashed",
             color = "#3A3A3A", linewidth = 0.6) +
  annotate("text", x = 4.4, y = 2.8,
           label = "Legally blind: ~1.1M\n(definition unchanged since 1967)",
           color = "#3A3A3A", size = 3.5, hjust = 1, fontface = "italic",
           lineheight = 0.9) +
  scale_y_continuous(labels = function(x) paste0(x, "M"),
                     limits = c(0, 45),
                     breaks = seq(0, 40, 10)) +
  labs(
    title = "How Many Americans Have Disabling Hearing Loss?",
    subtitle = "Same question, different cutoffs, different answers",
    x = NULL,
    y = "Estimated Population (millions)"
  ) +
  theme_1950s() +
  theme(axis.text.x = element_text(size = 10, lineheight = 0.9))

print(p)

ggsave("~/Downloads/chart2_prevalence_variance.png", p,
       width = 1456 / 150, height = 819 / 150, dpi = 150)

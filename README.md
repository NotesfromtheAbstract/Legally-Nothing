# Legally Nothing — Data and Charts

Charts and data for ["Legally Nothing"](https://notes-from-the-abstract.ghost.io/) published in *Notes from the Abstracts*.

## Charts

| Chart | File | Description |
|-------|------|-------------|
| 1 | `chart1_sga_divergence.png` | Blind vs. non-blind SGA limits, 1978–2026. Monthly earnings thresholds diverging over 48 years. |
| 2 | `chart2_prevalence_variance.png` | Hearing loss prevalence estimates using three different dB cutoffs (25, 35, 40 dB). Same question, three populations. |
| 3 | `chart3_threshold_ladder.png` | Decibel scale showing where 12.5 million Americans fall between the Texas CODTW (55 dB) and SSA Listing 2.10 (90 dB). |

## Data Sources

| Source | Data Used | URL |
|--------|-----------|-----|
| SSA COLA Determinations | SGA amounts 1975–2026, blind and non-blind | https://www.ssa.gov/oact/cola/sga.html |
| SSA Blue Book, Listing 2.10 | Hearing loss disability criteria (90 dB air, 60 dB bone, or 40% word recognition) | https://www.ssa.gov/disability/professionals/bluebook/2.00-SpecialSensesandSpeech-Adult.htm |
| SSA Red Book, 2026 | Current SGA amounts ($1,690 non-blind, $2,830 blind) | https://www.ssa.gov/redbook/newfor2026.htm |
| Goman AM, Lin FR (2016) | Prevalence of hearing loss by severity, NHANES 2001–2010 | doi:10.2105/AJPH.2016.303299 |
| Lin FR, Niparko JK, Ferrucci L (2011) | Hearing loss prevalence, NHANES 2001–2008 | doi:10.1001/archinternmed.2011.506 |
| WHO Fact Sheet (2026) | Disabling hearing loss definition (>35 dB) | https://www.who.int/news-room/fact-sheets/detail/deafness-and-hearing-loss |
| Texas HHSC | CODTW criteria (55 dB unaided, 30 dB aided, 50% speech discrimination) | https://www.hhs.texas.gov/services/disability/deaf-hard-hearing/tuition-waiver |
| IRS Rev. Proc. 2025-32 | Additional standard deduction for blindness, 2026 | https://www.irs.gov/taxtopics/tc551 |

## Reproduction

All charts are produced in R using `ggplot2` with a custom `theme_1950s()` defined in each script. Scripts are self-contained. Output dimensions: 1456×819 px at 150 DPI.

```r
source("R/chart1_sga_divergence.R")
source("R/chart2_prevalence_variance.R")
source("R/chart3_threshold_ladder.R")
```

## License

Copyright (c) 2026 Andrew R. Crocker. All rights reserved.

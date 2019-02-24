# ueqr
R package for the analysis of the User Experience Questionnaire (UEQ)

Analyses items and scales of the the User Experience Questionnaire as described by Hinderks, Schrepp and Thomaschewski on https://www.ueq-online.org.

## Overview
* `clean_ueq()` removes inconsistent data entries with the method described by the questionnaire's authors: If the difference between the best and worst evaluation of an item differs by more than 3 points on the scale this is seen as an indicator for a problematic data pattern. Rows where this is the case for 3 or more scales will be removed.
* `ueq_items()` and `ueq_scales()` both return a data frame with the analysed items and scales (including descriptive statistics, confidence intervals and benchmarks).
* `ueq_case_scale_means()` calculates means for each scale per case. Can be used to further analyse differences in mean values.
* `analyze_ueq()` takes an additional column by which the data will be grouped in order to perform a comparison of means.

## Installation
```
devtools::install_github("gitc23/ueqr")
```

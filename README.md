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

## How to use
Functions work out of the box with just a dataframe supplied. Column names MUST conform to the order of items in the original questionnaire.

```
# analyse scales of a raw UEQ export
ueq_scales(sample_items, is.clean = FALSE, ueq_range = c(1:26))

           scale     means      vars        sd   n confidence   ci_left  ci_right     alpha   lambda2     benchmark
1 attractiveness 1.5077031 1.2609578 1.1229238 238  0.1426625 1.3650406 1.6503656 0.9144399 0.9097830 Above Average
2    perspicuity 1.7121849 1.2148087 1.1021836 238  0.1400276 1.5721573 1.8522124 0.8345766 0.7958659          Good
3     efficiency 1.6344538 1.1184493 1.0575676 238  0.1343593 1.5000945 1.7688131 0.8248765 0.7948633          Good
4  dependability 1.2731092 0.7689785 0.8769142 238  0.1114081 1.1617012 1.3845173 0.5990847 0.6082850 Above Average
5    stimulation 1.1838235 1.1161191 1.0564654 238  0.1342193 1.0496043 1.3180428 0.8272948 0.8071646 Above Average
6        novelty 0.8266807 1.1140847 1.0555021 238  0.1340969 0.6925838 0.9607776 0.7155509 0.6715016 Above Average


# compare means of two groups by supplying the column index of the grouping variable
analyze_ueq(sample_items, is.clean = FALSE, ueq_range = c(1:26), group_var = 27)

# A tibble: 18 x 8
   .y.            group1 group2     p p.adj p.format p.signif method  
   <fct>          <chr>  <chr>  <dbl> <dbl> <chr>    <chr>    <chr>   
 1 attractiveness 2      3      0.701  1    0.70     ns       Wilcoxon
 2 attractiveness 2      1      0.952  1    0.95     ns       Wilcoxon
 3 attractiveness 3      1      0.708  1    0.71     ns       Wilcoxon
 4 perspicuity    2      3      0.490  1    0.49     ns       Wilcoxon
 5 perspicuity    2      1      0.978  1    0.98     ns       Wilcoxon
 6 perspicuity    3      1      0.414  1    0.41     ns       Wilcoxon
 7 efficiency     2      3      0.300  0.9  0.30     ns       Wilcoxon
 8 efficiency     2      1      0.634  1    0.63     ns       Wilcoxon
 9 efficiency     3      1      0.561  1    0.56     ns       Wilcoxon
10 dependability  2      3      0.538  1    0.54     ns       Wilcoxon
11 dependability  2      1      0.699  1    0.70     ns       Wilcoxon
12 dependability  3      1      0.887  1    0.89     ns       Wilcoxon
13 stimulation    2      3      0.143  0.38 0.14     ns       Wilcoxon
14 stimulation    2      1      0.909  0.91 0.91     ns       Wilcoxon
15 stimulation    3      1      0.126  0.38 0.13     ns       Wilcoxon
16 novelty        2      3      0.241  0.72 0.24     ns       Wilcoxon
17 novelty        2      1      0.916  0.92 0.92     ns       Wilcoxon
18 novelty        3      1      0.246  0.72 0.25     ns       Wilcoxon
```

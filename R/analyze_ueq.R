#' Summarize results for UEQ data
#'
#' update
#'
#' @param df dataframe with 26 columns in the order specified in the UEQ documentation
#'
#' @param df dataframe with 26 columns in the order specified in the UEQ documentation
#' @param is.clean Boolean whether the passed dataframe is already cleaned
#' @param ueq_range the range of columns where the 26 UEQ Items are to be found
#' @param group_vars index of additional variables that should not be dropped
#'
#' @export
analyze_ueq <- function(df, is.clean = FALSE, ueq_range = c(1:26), group_var = 27) {

  scales <- list(attractiveness = c(1,12,14,16,24,25),
                 perspicuity = c(2,4,13,21),
                 efficiency = c(9,20,22,23),
                 dependability = c(8,11,17,19),
                 stimulation = c(5,6,7,18),
                 novelty = c(3,10,15,26))

  if (!is.clean) {
    scale_means <- ueq_case_scale_means(df, is.clean = FALSE, ueq_range = ueq_range, add_vars = group_var)
  } else {
    scale_means <- ueq_case_scale_means(df, is.clean = TRUE, ueq_range = ueq_range, add_vars = group_var)
  }

  ggpubr::compare_means(c(attractiveness, perspicuity, efficiency, dependability, stimulation, novelty)
                        ~ Gruppe1, data = scale_means)
  ### Gruppe anpassen

}

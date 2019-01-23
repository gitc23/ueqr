#' Summarize results for UEQ data
#'
#' update
#'
#' @param df dataframe with 26 columns in the order specified in the UEQ documentation
#'
#' @param is.clean Boolean whether the passed dataframe is already cleaned
#' @param ueq_range the range of columns where the 26 UEQ Items are to be found
#' @param group_var index of additional variables that should not be dropped
#'
#' @import dplyr
#'
#' @export
compare_ueq_scales <- function(df, is.clean = FALSE, ueq_range = c(1:26), group_var = 27) {

  scales <- list(attractiveness = c(1,12,14,16,24,25),
                 perspicuity = c(2,4,13,21),
                 efficiency = c(9,20,22,23),
                 dependability = c(8,11,17,19),
                 stimulation = c(5,6,7,18),
                 novelty = c(3,10,15,26))

  if (!is.clean) {
    scale_means <- ueq_case_scale_means(df, is.clean = FALSE, ueq_range = ueq_range, add_vars = group_var)
    colnames(scale_means)[7] <- c("group")
  } else {
    scale_means <- ueq_case_scale_means(df, is.clean = TRUE, ueq_range = ueq_range, add_vars = group_var)
    colnames(scale_means)[7] <- c("group")
  }

  ggpubr::compare_means(c(attractiveness, perspicuity, efficiency, dependability, stimulation, novelty)
                        ~ group, data = scale_means)

}




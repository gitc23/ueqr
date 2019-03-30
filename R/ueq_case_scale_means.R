#' Get scale means per case to do further analysis
#'
#' Calculates means for each scale per case. Can be used to further analyse differences
#' in mean values.
#'
#' @param df dataframe with 26 columns in the order specified in the UEQ documentation
#' @param is.clean Boolean whether the passed dataframe is already cleaned
#' @param ueq_range the range of columns where the 26 UEQ Items are to be found
#' @param add_vars index of additional variables that should not be dropped
#'
#' @return dataframe with 26 columns minus the number of rows where the above pattern was true
#'
#' @export
#'
ueq_case_scale_means <- function(df, is.clean = FALSE, ueq_range = c(1:26), add_vars = NULL) {

  scales <- list(attractiveness = c(1,12,14,16,24,25),
                 perspicuity = c(2,4,13,21),
                 efficiency = c(9,20,22,23),
                 dependability = c(8,11,17,19),
                 stimulation = c(5,6,7,18),
                 novelty = c(3,10,15,26))

  if (!is.clean) {
    cleaned_df <- clean_ueq(df, ueq_range = ueq_range, add_vars = add_vars)
  } else {
    cleaned_df <- df
  }

  scale_means <- cleaned_df %>%
    mutate(attractiveness = round(rowMeans(cleaned_df[unlist(scales[1])]), digits = 2),
           perspicuity = round(rowMeans(cleaned_df[unlist(scales[2])]), digits = 2),
           efficiency = round(rowMeans(cleaned_df[unlist(scales[3])]), digits = 2),
           dependability = round(rowMeans(cleaned_df[unlist(scales[4])]), digits = 2),
           stimulation = round(rowMeans(cleaned_df[unlist(scales[5])]), digits = 2),
           novelty = round(rowMeans(cleaned_df[unlist(scales[6])]), digits = 2)) %>%
    select(attractiveness, perspicuity, efficiency, dependability, stimulation, novelty)

  if (!is.null(add_vars)) {
    case_scale_means <- cbind(scale_means, cleaned_df[add_vars-(first(ueq_range)-1)])
  } else {
    case_scale_means <- scale_means
  }

  return(case_scale_means)
}

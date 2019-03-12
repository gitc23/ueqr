#' Clean an import with UEQ items
#'
#' Cleans an import of the 26 items of the UEQ after the method specified
#' at \url{https://www.ueq-online.org}. If the difference between the best
#' and worst evaluation of an item differs by more than 3 this is seen as
#' an indicator for a problematic data pattern. Rows where this is the case
#' for 3 or more scales will be removed.
#'
#' @param df dataframe with 26 columns in the order specified in the UEQ documentation
#' @param ueq_range the range of columns where the 26 UEQ Items are to be found
#' @param add_vars index of additional variables that should not be dropped
#'
#' @return dataframe with 26 columns minus the number of rows where the above pattern was true
#'
#' @export
#'
clean_ueq <- function(df, ueq_range = c(1:26), add_vars = NULL) {

  minus_four <- c(1, 2, 6:8, 11, 13:16, 20, 22, 26)
  four_minus <- c(3:5, 9, 10, 12, 17:19, 21, 23:25)

  attractiveness <- c(1, 12, 14, 16, 24, 25)
  perspicuity <- c(2, 4, 13, 21)
  efficiency <- c(9, 20, 22, 23)
  dependability <- c(8, 11, 17, 19)
  stimulation <- c(5, 6, 7, 18)
  novelty <- c(3, 10, 15, 26)

  df_transformed <- data.frame(df[ueq_range][minus_four]-4, 4-df[ueq_range][four_minus]) %>%
    select(c(stringr::str_sort(colnames(.), numeric = TRUE)))

  critical_cands <- df_transformed %>%
    mutate(attractiveness = apply(df_transformed[attractiveness], 1, function(x) max(x)-min(x)),
           perspicuity = apply(df_transformed[perspicuity], 1, function(x) max(x)-min(x)),
           efficiency = apply(df_transformed[efficiency], 1, function(x) max(x)-min(x)),
           dependability = apply(df_transformed[dependability], 1, function(x) max(x)-min(x)),
           stimulation = apply(df_transformed[stimulation], 1, function(x) max(x)-min(x)),
           novelty = apply(df_transformed[novelty], 1, function(x) max(x)-min(x))) %>%
    select(attractiveness:novelty) %>%
    apply(1, function(x) sum(x > 3))

  if (!is.null(add_vars)) {
    critical <- cbind(df_transformed, df[add_vars], critical_cands)
  } else {
    critical <- cbind(df_transformed, critical_cands)
  }

  clean <- critical[!critical$critical_cands >= 3,] %>%
    select(-critical_cands)

  return(clean)
}

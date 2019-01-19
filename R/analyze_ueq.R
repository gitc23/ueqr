#' Summarize results for UEQ data
#'
#' Creates a list with the two dataframes UEQ items and UEQ scales.
#'
#' @param df dataframe with 26 columns in the order specified in the UEQ documentation
#'
#' @return list with two dataframes
#'
#' @examples
#' analyze_ueq()
#'
#' @export
analyze_ueq <- function(df) {
  # add_vars <- colnames(sauber)[27:length(colnames(sauber))]
  item_results <- ueq_items(df)
  # item_results <- cbind(Item = data.frame(item_names_long), item_results)
  scales_results <- ueq_scales(df)
  list("items" = item_results, "scales" = scales_results)
}

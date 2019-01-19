#' Summarize results for the 26 UEQ items
#'
#' Creates a dataframe with mean, variance, standard deviation,
#' N, confidence, left and right confidence interval, scale, and item
#'
#' @param df dataframe with 26 columns in the order specified in the UEQ documentation
#'
#' @return dataframe with 9 columns and one row for each of the 26 items
#'
#' @examples
#' ueq_items()
#'
#' @export
ueq_items <- function(df) {

  scales <- list(attractiveness = c(1,12,14,16,24,25),
                 perspicuity = c(2,4,13,21),
                 efficiency = c(9,20,22,23),
                 dependability = c(8,11,17,19),
                 stimulation = c(5,6,7,18),
                 novelty = c(3,10,15,26))

  cleaned_df <- clean_ueq(df)

  setNames(
    data.frame(colMeans(cleaned_df),
               apply(cleaned_df, 2, var),
               apply(cleaned_df, 2, sd),
               apply(cleaned_df, 2, length)),
    c("mean", "var", "sd", "n")) %>%
    mutate(confidence = qnorm(0.975)*sd/sqrt(n)) %>%
    mutate(ci_left = mean - confidence,
           ci_right = mean + confidence) %>%
    mutate(id = seq.int(length(confidence))) %>%
    mutate(scale = case_when(
      id %in% scales[[1]] ~ "attractiveness",
      id %in% scales[[2]] ~ "perspicuity",
      id %in% scales[[3]] ~ "efficiency",
      id %in% scales[[4]] ~ "dependability",
      id %in% scales[[5]] ~ "stimulation",
      id %in% scales[[6]] ~ "novelty"
    )) %>%
    mutate(item = colnames(cleaned_df)) %>%
    select(-id)
}

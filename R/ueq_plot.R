#' @import ggplot2
#' @import reshape2
#' @import dplyr
#' @import ggthemes
mean_plot <- function(df, is.clean = FALSE, is.grouped = FALSE, ueq_range = c(1:26), group_var = 27, title = "Scale Means") {

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

  if (is.grouped) {
    colnames(scale_means)[7] <- c("group")
    plot_scale_means(scale_means, is.grouped = TRUE, title = title)
  } else {
    plot_scale_means(scale_means, is.grouped = FALSE, title = title)
  }

}


plot_scale_means <- function(scale_means_df, is.grouped = is.grouped, title = title) {

  if (is.grouped) {
    scale_means_df %>%
      reshape2::melt(id.vars = c("group")) %>%
      group_by(group, variable) %>%
      summarise(mean = mean(value), sd = sd(value), n = n()) %>%
      mutate(se = sd/sqrt(n),
             lower.ci = mean-qt(1-(0.05/2), n-1)*se,
             upper.ci = mean+qt(1-(0.05/2), n-1)*se) %>%
      ggplot(aes(x=variable, y=mean, fill=as.factor(group))) +
      geom_bar(position=position_dodge(width = 0.9), stat="identity") +
      geom_errorbar(aes(ymin=lower.ci, ymax=upper.ci), position=position_dodge(width=0.9), width=0.3) +
      theme_fivethirtyeight() +
      ggtitle(title) +
      labs(fill="group")
  } else {
    scale_means_df %>%
      reshape2::melt() %>%
      group_by(variable) %>%
      summarise(mean = mean(value), sd = sd(value), n = n()) %>%
      mutate(se = sd/sqrt(n),
             lower.ci = mean-qt(1-(0.05/2), n-1)*se,
             upper.ci = mean+qt(1-(0.05/2), n-1)*se) %>%
      ggplot(aes(x=variable, y=mean, fill=variable)) +
      geom_bar(position=position_dodge(width = 0.9), stat="identity") +
      geom_errorbar(aes(ymin=lower.ci, ymax=upper.ci), position=position_dodge(width=0.9), width=0.3) +
      theme_fivethirtyeight() +
      ggtitle(title) +
      guides(fill=FALSE)
  }

}

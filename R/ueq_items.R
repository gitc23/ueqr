# import scales

ueq_items <- function(df) {
  
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

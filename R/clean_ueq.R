clean_ueq <- function(df) {

  minus_four <- c(1,2,6:8,11,13:16,20,22,26)
  four_minus <- c(3:5,9,10,12,17:19,21,23:25)

  attractiveness <- c(1,12,14,16,24,25)
  perspicuity <- c(2,4,13,21)
  efficiency <- c(9,20,22,23)
  dependability <- c(8,11,17,19)
  stimulation <- c(5,6,7,18)
  novelty <- c(3,10,15,26)
  
  scales <- list(attractiveness, perspicuity, efficiency, dependability, stimulation, novelty)

  df_transformed <- data.frame(df[minus_four]-4, 4-df[four_minus]) %>% 
    select(c(stringr::str_sort(colnames(df_transformed), numeric = TRUE)))

  critical_cands <- df_transformed %>% 
    mutate(attractiveness = apply(df_transformed[attractiveness], 1, function(x) max(x)-min(x)),
           perspicuity = apply(df_transformed[perspicuity], 1, function(x) max(x)-min(x)),
           efficiency = apply(df_transformed[efficiency], 1, function(x) max(x)-min(x)),
           dependability = apply(df_transformed[dependability], 1, function(x) max(x)-min(x)),
           stimulation = apply(df_transformed[stimulation], 1, function(x) max(x)-min(x)),
           novelty = apply(df_transformed[novelty], 1, function(x) max(x)-min(x))) %>% 
    select(attractiveness:novelty) %>% 
    apply(1, function(x) sum(x > 3))
  critical <- cbind(df_transformed, critical_cands)
  
  # removed <- sum(critical$critical_cands >= 3)
  # cat(removed, "critical cases removed.\n")
  # Sys.sleep(0.5)
  
  clean <- critical[!critical$critical_cands >= 3,] %>% 
    select(-critical_cands)
  
  return(clean)
}
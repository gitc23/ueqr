# import scales

ueq_scales <- function(df) {
  
  cleaned_df <- clean_ueq(df)
  
  scales_list <- list() 
  for (i in 1:length(scales)) { 
    scale <- case_when( 
      i == 1 ~ "attractiveness",
      i == 2 ~ "perspicuity",
      i == 3 ~ "efficiency",
      i == 4 ~ "dependability",
      i == 5 ~ "stimulation",
      i == 6 ~ "novelty")
    means <- mean(rowMeans(cleaned_df[unlist(scales[i])])) 
    vars <- var(rowMeans(cleaned_df[unlist(scales[i])]))
    sd <- sd(rowMeans(cleaned_df[unlist(scales[i])]))
    n <- nrow(cleaned_df[unlist(scales[i])])
    confidence <- qnorm(0.975)*sd/sqrt(n)
    ci_left <-  means - confidence
    ci_right <-  means + confidence
    alpha <- psych::alpha(cleaned_df[unlist(scales[i])])[["total"]][["std.alpha"]] #nochmal prüfen, da leichte Abweichung zu Exceldatei
    lambda2 <- psych::alpha(cleaned_df[unlist(scales[i])])[["total"]][["G6(smc)"]]

    instance <- data_frame(scale, means, vars, sd, n, confidence, ci_left, ci_right, alpha, lambda2)
    scales_list[[i]] <- instance
  }
  
  scales_results <- bind_rows(scales_list)
  
  return(cbind(scales_results, benchmark = ueq_benchmarks(scales_results)))
}


ueq_benchmarks <- function(scales_results) {

  bm_attrac <- function(scale_mean) {
    bm <- case_when(
      scale_mean > 1.75 ~ "Excellent",
      scale_mean > 1.52 ~ "Good",
      scale_mean > 1.17 ~ "Above Average",
      scale_mean > 0.7 ~ "Below Average",
      scale_mean <= 0.7 ~ "Bad"
    )
    return(bm)
  }
  bm_pers <- function(scale_mean) {
    bm <- case_when(
      scale_mean > 1.9 ~ "Excellent",
      scale_mean > 1.56 ~ "Good",
      scale_mean > 1.08 ~ "Above Average",
      scale_mean > 0.64 ~ "Below Average",
      scale_mean <= 0.64 ~ "Bad"
    )
    return(bm)
  }
  bm_eff <- function(scale_mean) {
    bm <- case_when(
      scale_mean > 1.78 ~ "Excellent",
      scale_mean > 1.47 ~ "Good",
      scale_mean > 0.98 ~ "Above Average",
      scale_mean > 0.54 ~ "Below Average",
      scale_mean <= 0.54 ~ "Bad"
    )
    return(bm)
  }
  bm_dep <- function(scale_mean) {
    bm <- case_when(
      scale_mean > 1.65 ~ "Excellent",
      scale_mean > 1.48 ~ "Good",
      scale_mean > 1.14 ~ "Above Average",
      scale_mean > 0.78 ~ "Below Average",
      scale_mean <= 0.78 ~ "Bad"
    )
    return(bm)
  }
  bm_stim <- function(scale_mean) {
    bm <- case_when(
      scale_mean > 1.55 ~ "Excellent",
      scale_mean > 1.31 ~ "Good",
      scale_mean > 0.99 ~ "Above Average",
      scale_mean > 0.5 ~ "Below Average",
      scale_mean <= 0.5 ~ "Bad"
    )
    return(bm)
  }
  bm_nov <- function(scale_mean) {
    bm <- case_when(
      scale_mean > 1.4 ~ "Excellent",
      scale_mean > 1.05 ~ "Good",
      scale_mean > 0.71 ~ "Above Average",
      scale_mean > 0.3 ~ "Below Average",
      scale_mean <= 0.3 ~ "Bad"
    )
    return(bm)
  }

  benchmark <- rbind(
    bm_attrac(scales_results$means[1]),
    bm_pers(scales_results$means[2]),
    bm_eff(scales_results$means[3]),
    bm_dep(scales_results$means[4]),
    bm_stim(scales_results$means[5]),
    bm_nov(scales_results$means[6]))
  
  return(benchmark)
}

analyze_ueq <- function(df) {

  # add_vars <- colnames(sauber)[27:length(colnames(sauber))]
  
  item_results <- ueq_items(df)
  
  # wenn Namen gewünscht
  # item_results <- cbind(Item = data.frame(item_names_long), item_results)
  
  scales_results <- ueq_scales(df)
  
  # scale_means <- sauber %>% 
  #   mutate(Attraktivität = round(rowMeans(sauber[unlist(scales[1])]), digits = 2),
  #          Durchschaubarkeit = round(rowMeans(sauber[unlist(scales[2])]), digits = 2),
  #          Effizienz = round(rowMeans(sauber[unlist(scales[3])]), digits = 2),
  #          Steuerbarkeit = round(rowMeans(sauber[unlist(scales[4])]), digits = 2),
  #          Stimulation = round(rowMeans(sauber[unlist(scales[5])]), digits = 2),
  #          Originalität = round(rowMeans(sauber[unlist(scales[6])]), digits = 2)) %>% 
  #   select(Attraktivität, Durchschaubarkeit, Effizienz, Steuerbarkeit, Stimulation, Originalität, add_vars)
  
  list("items" = item_results, "scales" = scales_results)
 
  #return(results_list)
}

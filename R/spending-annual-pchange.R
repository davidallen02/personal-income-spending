dat <- pamngr::get_data("pce cur$") %>%
  tidyr::pivot_longer(cols = -dates, names_to = "variable") %>%
  pamngr::pchange(k = 12) %>%
  dplyr::slice_max(dates, n = 18) 

p <- dat %>%  
  pamngr::barplot(x = "dates", y = "value", fill = "variable") %>%
  pamngr::pam_plot(
    plot_title = "Personal Spending",
    plot_subtitle = "Annual Percent Change",
    show_legend = FALSE
  ) 

p %>% pamngr::all_output("spending-annual-pchange")
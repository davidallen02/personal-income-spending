dat <- pamngr::get_data("pitl") %>%
  tidyr::pivot_longer(cols = -dates, names_to = "variable") %>%
  pamngr::pchange(k = 1) %>%
  dplyr::slice_max(dates, n = 18) 

p <- dat %>%  
  pamngr::barplot(x = "dates", y = "value", fill = "variable") %>%
  pamngr::pam_plot(
    plot_title = "Personal Income",
    plot_subtitle = "Monthly Percent Change",
    show_legend = FALSE
  ) 

p %>% pamngr::all_output("income-monthly-change")
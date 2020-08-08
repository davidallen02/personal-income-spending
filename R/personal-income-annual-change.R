dat <- pamngr::get_data("pitl") %>%
  reshape2::melt(id.vars = "dates") %>%
  pamngr::pchange(k = 12) %>%
  dplyr::slice_max(dates, n = 18)

p <- dat %>%  
  pamngr::barplot(x = "dates", y = "value", fill = "variable") %>%
  pamngr::pam_plot(
    plot_title = "Personal Income",
    plot_subtitle = "Annual Percent Change",
    show_legend = FALSE
  ) 

p %>% pamngr::all_output("personal-income-annual-change")
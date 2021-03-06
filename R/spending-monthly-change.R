pamngr::get_data("pce cur$") %>%
  tidyr::pivot_longer(cols = -dates, names_to = "variable") %>%
  pamngr::pchange(k = 1) %>%
  # set_colnames(c("dates","value")) %>%
  # dplyr::arrange(dates) %>%
  # dplyr::mutate(
  #   m_change = (value - dplyr::lag(value)) %>% 
  #     divide_by(dplyr::lag(value)) %>% 
  #     multiply_by(100)
  # ) %>%
  dplyr::slice_max(dates, n = 18) %>%
  # dplyr::select(dates, m_change) %>%
  # reshape2::melt(id.vars = "dates") %>%
  pamngr::barplot(x = "dates", y = "value", fill = "variable") %>%
  pamngr::pam_plot(
    plot_title = "Personal Spending",
    plot_subtitle = "Monthly Percent Change",
    show_legend = FALSE
  ) %>%
  pamngr::all_output("spending-monthly-change")
pamngr::get_data("pidss") %>%
  reshape2::melt(id.vars = "dates") %>%
  dplyr::filter(dates >= as.POSIXct("2017-01-01")) %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Personal Savings Rate",
    plot_subtitle = "Percent of Personal Income",
    show_legend = FALSE
  ) %>%
  pamngr::all_output("personal-savings")



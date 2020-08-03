spending_level <- pamngr::get_data("pce cur$") %>%
  dplyr::filter(dates >= as.POSIXct("2020-01-01")) %>%
  reshape2::melt(id.vars = "dates") %>%
  pamngr::lineplot() %>%
  pamngr::pam.plot(
    plot.title = "Personal Consumption Expenditures",
    plot.subtitle = "Billions of USD",
    show.legend = FALSE
  ) 

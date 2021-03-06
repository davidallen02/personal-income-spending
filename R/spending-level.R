library(magrittr)

dat <- pamngr::get_data("pce cur$") %>%
  dplyr::filter(dates >= as.POSIXct("2020-01-01")) %>%
  reshape2::melt(id.vars = "dates")

p <- dat %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Personal Consumption Expenditures",
    plot_subtitle = "Billions of USD",
    show_legend = FALSE
  ) 

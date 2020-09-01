library(magrittr)

pamngr::get_data("pce defy") %>%
  dplyr::left_join(pamngr::get_data("pce cyoy"), by = "dates") %>%
  set_colnames(c("dates", "PCE Prices", "Core PCE Prices")) %>%
  dplyr::slice_max(dates, n = 74) %>%
  reshape2::melt(id.vars = "dates") %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Personal Consumption Expenditure Price Indexes",
    plot_subtitle = "Annual Change, Percent"
  ) %>%
  pamngr::all_output("price-indexes-annual")

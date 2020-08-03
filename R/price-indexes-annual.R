devtools::install_github("davidallen02/pamngr")
library(magrittr)

pamngr::get_data("pce defy") %>%
  dplyr::left_join(pamngr::get_data("pce cyoy"), by = "dates") %>%
  set_colnames(c("dates", "PCE Prices", "Core PCE Prices")) %>%
  dplyr::slice_max(dates, n = 74) %>%
  reshape2::melt(id.vars = "dates") %>%
  pamngr::lineplot() %>%
  pamngr::pam.plot(
    plot.title = "Personal Consumption Expenditure Price Indexes",
    plot.subtitle = "Annual Change, Percent"
  ) %>%
  pamngr::ppt_output("price-indexes-annual.png")

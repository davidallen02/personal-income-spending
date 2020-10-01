library(magrittr)

# Monthly ---------------------------------------------------------------------------

dat <- pamngr::join_sheets(c("pce-def","pce-core")) %>%
  magrittr::set_colnames(c("dates", "PCE", "Core PCE")) %>%
  tidyr::pivot_longer(cols = -dates, names_to = "variable") %>%
  pamngr::pchange(k = 1) %>%
  tidyr::pivot_wider(names_from = "variable") %>%
  dplyr::slice_max(dates, n = 36) %>%
  tidyr::pivot_longer(cols = -dates, names_to = "variable") %>%
  dplyr::mutate(variable = variable %>% factor(levels = c("PCE", "Core PCE")))

p <- dat %>%
  pamngr::barplot() %>%
  pamngr::pam_plot(
    plot_title = "Personal Consumption Expenditure Price Index",
    plot_subtitle = "Monthly Percent Change",
    show_legend = FALSE
  )

p <- p + ggplot2::facet_wrap(.~variable, ncol = 2)

p %>% pamngr::all_output("pce-deflator-monthly-pchange")


# Annual ----------------------------------------------------------------------------

dat <- pamngr::join_sheets(c("pce-def","pce-core")) %>%
  magrittr::set_colnames(c("dates", "PCE", "Core PCE")) %>%
  tidyr::pivot_longer(cols = -dates, names_to = "variable") %>%
  pamngr::pchange(k = 12) %>%
  tidyr::pivot_wider(names_from = "variable") %>%
  dplyr::slice_max(dates, n = 36) %>%
  tidyr::pivot_longer(cols = -dates, names_to = "variable") %>%
  dplyr::mutate(variable = variable %>% factor(levels = c("PCE", "Core PCE")))

p <- dat %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Personal Consumption Expenditure Price Index",
    plot_subtitle = "Annual Percent Change")

p %>% pamngr::all_output("pce-deflator-annual-pchange")

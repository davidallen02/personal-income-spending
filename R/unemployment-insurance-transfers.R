library(magrittr)

dat <- pamngr::get_data("piocunem") %>%
  dplyr::slice_max(dates, n = 60) %>%
  tidyr::pivot_longer(cols = -dates, names_to = "variable")

p <- dat %>%
  pamngr::barplot() %>%
  pamngr::pam_plot(
    plot_title = "Unemployment Insurance Transfer Receipts",
    plot_subtitle = "USD Billions",
    show_legend = FALSE
  )

p %>% pamngr::all_output("unemployment-insurance-transfers")
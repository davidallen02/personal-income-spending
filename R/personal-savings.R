library(magrittr)

dat <-pamngr::join_sheets(c("pidss", "pidsdi")) %>%
  dplyr::mutate(savings_rate = pidss/pidsdi * 100) %>%
  dplyr::select(dates, savings_rate) %>%
  reshape2::melt(id.vars = "dates") %>%
  dplyr::filter(dates >= as.POSIXct("2017-01-01"))

p <- dat %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Personal Savings Rate",
    plot_subtitle = "Percent of Disposable Personal Income",
    show_legend = FALSE
  )

p %>% pamngr::all_output("personal-savings")



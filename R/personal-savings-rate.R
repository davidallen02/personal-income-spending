library(magrittr)

dat <- pamngr::join_sheets(c("pidsdi","pidss")) %>%
  dplyr::mutate(savings_rate = pidss %>% 
                  magrittr::divide_by(pidsdi) %>% 
                  magrittr::multiply_by(100)) %>%
  dplyr::select(dates, savings_rate) %>%
  dplyr::filter(dates >= lubridate::as_datetime("2015-01-01")) %>%
  magrittr::set_colnames(c("dates", "Savings Rate")) %>%
  reshape2::melt(id.vars = "dates")

p <- dat %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Personal Savings Rate",
    plot_subtitle = "Personal Savings as a Percentage of Disposable Personal Income",
    show_legend = FALSE
  )

p %>% pamngr::all_output("personal-savings-rate")
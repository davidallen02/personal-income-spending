library(magrittr)

dat <- pamngr::join_sheets(c("piwgtotl",
                      "piocprop",
                      "piocrent",
                      "piocint",
                      "piocdiv",
                      "pioctran",
                      "piocxgsi")) %>%
  dplyr::mutate(
    piwgtotl   = piwgtotl - dplyr::lag(piwgtotl),
    piocprop   = piocprop - dplyr::lag(piocprop),
    piocrent   = piocrent - dplyr::lag(piocrent),
    piocint    = piocint - dplyr::lag(piocint),
    piocdiv    = piocdiv - dplyr::lag(piocdiv),
    government = pioctran - piocxgsi,
    government = government - dplyr::lag(government)
  ) %>%
  dplyr::select(-pioctran, -piocxgsi) %>%
  magrittr::set_colnames(c("dates",
                           "Employee\nCompensation", 
                           "Proprietors Income",
                           "Rental Income",
                           "Interest Income",
                           "Dividend Income",
                           "Net Government\nTransfers")) %>%
  dplyr::slice_max(dates, n = 1) %>%
  reshape2::melt(id.vars = "dates") %>%
  dplyr::mutate(foo = "foo")

plot_date <- dat %>% dplyr::select(dates) %>% unique() %>% dplyr::pull() %>% format("%B %Y,")

p <- dat %>% 
  pamngr::barplot(x = "variable", y = "value", fill = "foo") %>%
  pamngr::pam_plot(
    plot_title = "Change in Personal Income",
    plot_subtitle = paste(plot_date, "Billions of USD"),
    show_legend = FALSE
  ) 

  p %>% pamngr::all_output("personal-income-change-by-category")

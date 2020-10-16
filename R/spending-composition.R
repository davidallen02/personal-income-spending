library(magrittr)



dat <- pamngr::join_sheets(c("pce-drbl", "pce-ndrb","uspxhaut", "uspxhelc", "uspxtrso",
                             "uspxrcrs", "uspxfoae", "uspxfsvi", "uspxosvc")) %>%
  dplyr::slice_max(dates, n = 120) %>%
  tidyr::pivot_longer(cols = -dates, names_to = "variable")

p <- ggplot2::ggplot(dat, ggplot2::aes(dates, value, fill = variable)) +
  ggplot2::geom_area() +
  ggplot2::scale_fill_manual(values = pamngr::pam.pal())

p
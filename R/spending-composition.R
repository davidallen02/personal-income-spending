library(magrittr)

dat <- pamngr::join_sheets(c("pce-drbl", "uspxmvpa", "uspxfadh", "uspxrgav", "uspxodrg",
                             "pce-ndrb", "uspxfbof", "uspxclaf", "uspxgaog", "uspxondg",
                             "pce-srv", "uspxhaut", "uspxhelc", "uspxtrso", "uspxrcrs",
                             "uspxfoae", "uspxfsvi", "uspxosvc")) 

key <- pamngr::get_data("key") %>%
  dplyr::filter(security %in% names(dat)) %>%
  dplyr::mutate(
    label = LONG_COMP_NAME %>%
      stringr::str_remove("US Personal Consumption Expenditures ") %>%
      stringr::str_remove(" Nominal Dollars SAAR") %>%
      stringr::str_remove("US PCE ") %>%
      stringr::str_remove(" SAAR")
  ) %>%
  dplyr::select(security, label)

dat <- dat %>% 
  dplyr::slice_max(dates, n = 60) %>%
  tidyr::pivot_longer(cols = -dates, names_to = "security") %>%
  dplyr::left_join(key, by = "security")

dat1 <- dat %>% dplyr::filter(security %in% c("pce-drbl", "pce-ndrb", "pce-srv"))

p1 <- ggplot2::ggplot(dat1, ggplot2::aes(dates, value, fill = label)) +
  ggplot2::geom_area() +
  ggplot2::scale_fill_manual(values = pamngr::pam.pal()) 

p <- p1 %>%
  pamngr::pam_plot(
    plot_title = "Personal Spending Composition",
    plot_subtitle = "SAAR, USD Billions"
  )

p %>% pamngr::all_output("spending-composition")



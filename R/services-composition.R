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
      stringr::str_remove(" SAAR") %>%
      stringr::str_replace("Durable Household", "Durable\nHoushold") %>%
      stringr::str_replace("Services and", "Services\nand") %>%
      stringr::str_replace("Transportation Services", "Transport\nServices") %>%
      stringr::str_replace("Health Care", "Health\nCare") %>%
      stringr::str_replace("Housing and", "Housing\nand") %>%
      stringr::str_replace("Other Services", "Other\nServices") %>%
      stringr::str_replace("Recreation Services", "Recreation\nServices")
  ) %>%
  dplyr::select(security, label)

dat <- dat %>% 
  dplyr::slice_max(dates, n = 60) %>%
  tidyr::pivot_longer(cols = -dates, names_to = "security") %>%
  dplyr::left_join(key, by = "security") %>% 
  dplyr::filter(security %in% c("uspxhaut", "uspxhelc", "uspxtrso","uspxrcrs",
                                "uspxfoae","uspxfsvi", "uspxosvc"))

p <- ggplot2::ggplot(dat, ggplot2::aes(dates, value, fill = label)) +
  ggplot2::geom_area() +
  ggplot2::scale_fill_manual(values = c("#0f0285", "#462999", "#6a4aad", "#8c6dc2",
                                        "#ac91d6", "#cbb6ea", "#ebdcff")) +
  ggplot2::guides(fill = ggplot2::guide_legend(nrow = 3))

p <- p %>%
  pamngr::pam_plot(
    plot_title = "Services Composition",
    plot_subtitle = "SAAR, USD Billions"
  )

p %>% pamngr::all_output("services-composition")
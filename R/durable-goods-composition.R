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
      stringr::str_replace("Goods and", "Goods\nand")
  ) %>%
  dplyr::select(security, label)

dat <- dat %>% 
  dplyr::slice_max(dates, n = 60) %>%
  tidyr::pivot_longer(cols = -dates, names_to = "security") %>%
  dplyr::left_join(key, by = "security") %>% 
  dplyr::filter(security %in% c("uspxmvpa", "uspxfadh","uspxrgav", "uspxodrg"))

p <- ggplot2::ggplot(dat, ggplot2::aes(dates, value, fill = label)) +
  ggplot2::geom_area() +
  ggplot2::scale_fill_manual(values = c("#850237", "#b1556a", "#d994a2", "#ffd5dd")) +
  ggplot2::guides(fill = ggplot2::guide_legend(nrow = 3))

p <- p %>%
  pamngr::pam_plot(
    plot_title = "Durable Goods Composition",
    plot_subtitle = "SAAR, USD Billions"
  )

p %>% pamngr::all_output("durable-goods-composition")
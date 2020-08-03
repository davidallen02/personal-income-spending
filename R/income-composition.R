p <- pamngr::join_sheets(c("piwgtotl",
                           "piocprop",
                           "piocrent",
                           "piocint",
                           "piocdiv",
                           "pioctran",
                           "piocxgsi")) %>%
  dplyr::slice_max(dates, n = 12) %>%
  dplyr::rowwise() %>%
  dplyr::mutate(government = pioctran - piocxgsi) %>%
  dplyr::select(-pioctran, -piocxgsi) %>%
  magrittr::set_colnames(c("dates",
                           "Employee Compensation", 
                           "Proprietors Income",
                           "Rental Income",
                           "Interest Income",
                           "Dividend Income",
                           "Net Government Transfers")) %>%
  reshape2::melt(id.vars = "dates") %>%
  ggplot2::ggplot(ggplot2::aes(dates, value, fill = variable)) +
  ggplot2::geom_area() +
  ggplot2::scale_fill_manual(values = pamngr::pam.pal())

p %>%
  pamngr::pam_plot(
    plot_title = "Personal Income Composition",
    plot_subtitle = "Billions of USD"
  ) %>%
  pamngr::all_output("income-composition")
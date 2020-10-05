library(magrittr)

goods <- pamngr::join_sheets(c("uspxmvpa",
                               "uspxfadh",
                               "uspxrgav",
                               "uspxodrg",
                               "uspxfbof",
                               "uspxclaf",
                               "uspxgaog",
                               "uspxondg",
                               "uspxnxus")) %>%
  magrittr::set_colnames(c(
    "dates",
    "Motor Vehicles and Parts",
    "Furnishings and Durable Household Equipment",
    "Recreational Goods and Vehicles",
    "Other Durable Goods",
    "Food and Beverage for Off-Premises Consumption",
    "Clothing and Footwear",
    "Gasoline and Other Energy Goods",
    "Other Nondurable Goods",
    "Net Personal Consumption Abroad"
  )) %>%
  dplyr::mutate(type = "Goods") %>%
  reshape2::melt(id.vars = c("dates", "type"))

services <- pamngr::join_sheets(c("uspxhaut",
                                  "uspxhelc",
                                  "uspxtrso",
                                  "uspxrcrs",
                                  "uspxfoae",
                                  "uspxfsvi",
                                  "uspxosvc")) %>%
  magrittr::set_colnames(c(
    "dates",
    "Housing and Utilities",
    "Health Care",
    "Transportation Services",
    "Recreation Services",
    "Food Service and Accomodations",
    "Financial Services and Insurance",
    "Other Services"
  )) %>%
  dplyr::mutate(type = "Services") %>%
  reshape2::melt(id.vars = c("dates","type")) 

dat <- goods %>%
  dplyr::bind_rows(services) %>%
  pamngr::pchange(k = 1) %>%
  dplyr::slice_max(dates, n =1) %>%
  dplyr::arrange(value) %>%
  dplyr::mutate(
    variable = variable %>% factor(levels = variable)
  )

p <- dat %>%
  pamngr::barplot(x = "variable", y = "value", fill = "type") %>%
  pamngr::pam_plot(
    plot_title = "Personal Spending",
    plot_subtitle = "Monthly Percent Change"
  )

p <- p + ggplot2::coord_flip()

p %>% pamngr::all_output("spending-pchange-category")

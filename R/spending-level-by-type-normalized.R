library(magrittr)

dat <- pamngr::join_sheets(c("uspxgood", "pce srv")) %>%
  pamngr::normalize("2019-12-31") %>%
  magrittr::set_colnames(c("dates","Goods","Services")) %>%
  reshape2::melt(id.vars = "dates")

p <- dat %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Personal Consumption Expenditures",
    plot_subtitle = "Normalized to December 2019"
  ) 

p %>% pamngr::all_output("spending-level-by-type-normalized")

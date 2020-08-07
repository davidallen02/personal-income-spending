library(magrittr)

dat <- pamngr::get_data("pce cur$") %>%
  pamngr::normalize("2019-12-31") %>%
  reshape2::melt(id.vars = "dates")

p <- dat %>%
  pamngr::lineplot() %>%
  pamngr::pam_plot(
    plot_title = "Personal Consumption Expenditures",
    plot_subtitle = "Normalized to December 2019",
    show_legend = FALSE
  ) 

p %>% pamngr::all_output("spending-level-normalized")
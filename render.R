library(rmarkdown)

pandoc <- Sys.getenv("RSTUDIO_PANDOC")
Sys.setenv(RSTUDIO_PANDOC="/usr/lib/rstudio-server/bin/pandoc")

render("reportTop20CitiesByTotalOrders.Rmd", 
       quiet = TRUE, 
       output_dir = "~/git/r-project-d/work")
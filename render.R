library(rmarkdown)
library(httr)

# TODO: This dhould be driven by configuration
Sys.setenv(RSTUDIO_PANDOC="/usr/lib/rstudio-server/bin/pandoc")

render("reportTop20CitiesByTotalOrders.Rmd", 
       quiet = TRUE, 
       output_dir = "/distribution",
       output_file = paste("reportTop20CitiesByTotalOrders-", 
                           format(Sys.time(), "%Y%m%d-%H%M%S"), 
                           ".docx", 
                           sep = ""))

status <- content(GET("http://127.0.0.1/distribution/api.php"), "text")
write(status, "")
suppressMessages(library(odbc))
suppressMessages(library(implyr))
suppressMessages(library(dplyr))

# TODO: Move these into configurations
# According to details in /etc/odbcinst.ini
impalaDataSourceName <- "Cloudera ODBC Driver for Impala 64-bit"

# Depending on CDH deployments
impalaHost <- "192.168.56.102"
impalaPort <- 21050
impalaDatabase <- "default"
impalaUser <- "cloudera"
impalaPassword <- "cloudera"

getImpalaConnection <- function(datasourceName = impalaDataSourceName, 
                                hostName = impalaHost, port = impalaPort, 
                                databaseName = impalaDatabase, 
                                username = impalaUser, password = impalaPassword) {
  src_impala(
    drv = odbc::odbc(),
    driver = datasourceName,
    host = hostName, port = port,
    database = databaseName,
    uid = username,
    pwd = password
  )
}



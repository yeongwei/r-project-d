library(odbc)
library(implyr)
library(dplyr)

# According to details in /etc/odbcinst.ini
impalaDataSourceName <- "Cloudera ODBC Driver for Impala 64-bit"

# Depending on CDH deployments
impalaHost <- "192.168.56.102"
impalaPort <- 21050
impalaDatabase <- "default"
impalaUser <- "cloudera"
impalaPassword <- "cloudera"

odbcDriver <- odbc::odbc()

impalaConnection <- src_impala(
  drv = odbcDriver,
  driver = impalaDataSourceName,
  host = impalaHost,
  port = impalaPort,
  database = impalaDatabase,
  uid = impalaUser,
  pwd = impalaPassword
)

sql <- "
  select c.customer_city as city, count(o.order_id) as total_order
  from orders o
  join customers c on o.order_customer_id = c.customer_id
  group by city
  order by total_order desc
  limit 20
"
dbGetQuery(impalaConnection, sql)

source("impala.R")

impalaConnection <- getImpalaConnection()

getTop20CitiesByTotalorders <- function(connection = impalaConnection) {
  sql <- "
  select c.customer_city as city, count(o.order_id) as total_order
  from orders o
  join customers c on o.order_customer_id = c.customer_id
  group by city
  order by total_order desc
  limit 20
  "
  dbGetQuery(connection, sql)
}
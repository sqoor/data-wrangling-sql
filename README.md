# Data Wrangling With SQL
Mini Project wrangling database with MSSQL server

We have two databases SQLPlayground.bak and WideWorldImporters.bak
SQLPlayground.bak is provided locally with this project the WideWorldImporters.bak you can download from this like
`https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak`


Here we have 5 manipulation to do with these databases:
- Q1 \
Using the database WideWorldImporters, write a SQL query reoorts the conssitency between orders and their attached inovices.
\
\
The resultset should report for each (CustomerID, CustomerName)
- a. the total number of orders: TotalNBOrders
- b. the number of invoices converted from an order: TotalNBInvoices
- c. the total value of orders: OrdersTotalValue
- d. the total value of invoices; InovicesTotalValue
- f. the absolute value of difference between c - d: AbsoluteValueDifference.


\
The resultset must be sotred by highest vlaue of AbsoluteValueDifference, then by smallest to hightest value of TotalNBOrder and CustomerName in that order.
\
\
Please note all values in a & b must be identical by definition of the qeruy, ***as we are observing orders converted into invoices. \
We are looking for potential differences between c & b. \
But, you must find them consistent as the data is clean in WideWorldImporters. \
Resultset enclosed in Q1-Resultset_corrected.csv.
\
\
- Q2 \
![Second Query](./images/2.png)
\
For the CustoemrId = 1060 (CusstomerName = 'Anand Mudaliyar') \
I dentify the first InvoiceLine of his first Inovice, where "first" means the lowest respective IDs, and write an update query increasing the Uint this InvoiceLine by 20.
\
\
A re-run of the query in Q1 gives the result set in Q2-Resultset_Corrected.cv
\
\
- Q3 \
Using the database WideWorldImporters, write a T-SQL stored procedure called ReportCustomerTurnover. \
the procedure takes two paramters: Choice and Year, both integers.
\
\
When Choice = 1 and Year = <a year>, ReportCustomerTurnover selects all the customers names and their total monthly turnover <invocied value> for that year.
\
\
When Choice = 2 and Year = <a year>, ReportCustomerTurnover selects all the customers names and their total quarerly (3 months) turnover (invoiced value) for that year.
\
\
when Choice = 3, the vlaue of Year is ignored and ReportCustomerTurnover selects all the customers names and their total yearly turnover (invoiced value)
\
\
When no value is provided for paramter Choice, the default value of Choice must be 1 \
When no value if provided for the paramter Year, the default vaue is 2013. This doesn't impact Choice = 3.
\
\
For Choice = 3, the years can be hard-coded within the range of [2013-2016]
\
\
NULL values in the reultsets are not acceptable and must be substituted to be 0.
\
\
All output resultsets are ordered by customer names alphabetically.
\
\
Examples datasets are provided for the following calls:
- `EXEC dbo.ReportCustomerTurnover;`
- `EXEC dbo.ReportCustomerTurnover 1, 2014;`
- `EXEC dbo.ReportCustomerTurnover 2, 2015;`
- `EXEC dbo.ReportCustomerTurnover 3;`
\
\
- Q4 \
In the database WideWorldImporters, write a SQL query which reports the highest loss of money from orders not being converted into invoices, by customer category
\
\
The name and id of the customer who generated this highest loss must also be identified. The resultset is ordered by highest losss.
\
\
You should be able to write inp pure SQL, but if too challenging, you may use T-SQL and cursors. \
Resultset enclosed in Q4-Resultset.csv.
\
\
\
- Q5 \
In the database SQLPlayground, write a SQL query selecting all the custoemrs' data who have purchased all products AMD have bought more than 50 products in total(sum of all products).
\
\
Resultset enclosed in Q5-Resultset.csv


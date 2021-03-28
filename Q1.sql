

SELECT Cu.CustomerId AS CustomerID
	, Cu.CustomerName AS CustomerName
	,	(
			SELECT	COUNT(*)
			FROM	Sales.Orders AS Od
			WHERE	Od.CustomerID = Cu.CustomerID
	) AS TotalNBOrders
	,	(
			SELECT	COUNT(*)
			FROM	Sales.Invoices AS Iv
					, Sales.Orders AS Od 
			WHERE	Iv.CustomerID = Cu.CustomerID
					AND Iv.OrderID = Od.OrderID
	) As TotalNBInvoices
	,	(
			SELECT	SUM(Ol.UnitPrice * Ol.Quantity) AS OrderTotalValue
			FROM	Sales.Orders AS Od 
					, Sales.OrderLines AS Ol
			WHERE	Od.CustomerID = Cu.CustomerID
					AND Od.OrderID = Ol.OrderID
	) AS OrdersTotalValue
	,	(
			SELECT	SUM(Il.UnitPrice * Il.Quantity) AS InvoicesTotalValue
			FROM	Sales.Invoices Iv 
					, Sales.InvoiceLines AS Il
					, Sales.Orders AS Od 
			WHERE	Iv.CustomerID = Cu.CustomerID
					AND Iv.InvoiceID = Il.InvoiceID
					AND Iv.OrderID = Od.OrderID
	) AS InvoicesTotalValue
	, ABS(
		(
			SELECT	SUM(Ol.UnitPrice * Ol.Quantity) AS OrderTotalValue
			FROM	Sales.Orders AS Od 
					, Sales.OrderLines AS Ol
			WHERE	Od.CustomerID = Cu.CustomerID
					AND Od.OrderID = Ol.OrderID
		) 
	-
		(
			SELECT	SUM(Il.UnitPrice * Il.Quantity) AS InvoicesTotalValue
			FROM	Sales.Invoices Iv 
					, Sales.InvoiceLines AS Il
					, Sales.Orders AS Od 
			WHERE	Iv.CustomerID = Cu.CustomerID
					AND Iv.InvoiceID = Il.InvoiceID
					AND Iv.OrderID = Od.OrderID
		)
	) AS AbsoluteValueDifference
FROM		Sales.Customers AS Cu
-- checking the result of Q2 faster, uncomment the line below
-- WHERE Cu.CustomerID = 1060 
GROUP BY	Cu.CustomerId, CustomerName
ORDER BY	AbsoluteValueDifference DESC
			, TotalNBOrders ASC
			, CustomerName ASC
;

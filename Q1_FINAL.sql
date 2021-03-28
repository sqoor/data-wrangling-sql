SELECT	*
		, ABS(OrdersTotalValue - InvoicesTotalValue) AS AbsoluteValueDifference
FROM
(
  SELECT	Cu.CustomerID 
			, Cu.CustomerName
			, (
				SELECT	COUNT(DISTINCT Od.OrderID)
				FROM	Sales.Orders AS Od
						, Sales.Invoices AS Iv
				WHERE	Od.CustomerID = Cu.CustomerID
						AND Iv.OrderID = Od.OrderID
			) AS TotalNBOrders 
			, (
				  SELECT	COUNT(DISTINCT Iv.InvoiceID)
				  FROM		Sales.Invoices AS Iv 
							, Sales.Orders AS Od
				  WHERE		Iv.CustomerID = Cu.CustomerID
							AND Iv.OrderID = Od.OrderID -- TODO: this line should be removed thus we will get the REAL total number of orders whom did not turn into an invoice
			) AS TotalNBInvoices 
			, (
				  SELECT	SUM(Ol.UnitPrice * Ol.Quantity) AS OrderTotalValue
				  FROM		Sales.Orders AS Od 
							, Sales.OrderLines AS Ol
							, Sales.Invoices AS Iv
				  WHERE		Od.CustomerID = Cu.CustomerID
							AND Od.OrderID = Ol.OrderID
							AND Iv.OrderID = Od.OrderID -- TODO: this line should be removed thus we will get the REAL total number of orders whom did not turn into an invoice
			) AS OrdersTotalValue 
			, (
				  SELECT	SUM(Il.UnitPrice * Il.Quantity) AS InvoicesTotalValue
				  FROM		Sales.Invoices Iv 
							, Sales.InvoiceLines AS Il 
							, Sales.Orders AS Od
				  WHERE		Iv.CustomerID = Cu.CustomerID
							AND Iv.InvoiceID = Il.InvoiceID
							AND Iv.OrderID = Od.OrderID 
			) AS InvoicesTotalValue
   FROM		Sales.Customers AS Cu 
   -- WHERE	Cu.CustomerID = 1060 -- TEST: uncomment here to test question 2
) AS t
ORDER BY	AbsoluteValueDifference DESC 
			, TotalNBOrders ASC 
			, CustomerName ASC
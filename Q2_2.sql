
SELECT  CustomerId
		, CustomerName
		, SUM(UnitPrice * Quantity) AS InvoiceTotal
FROM	Sales.InvoiceLines	AS Il
		, Sales.Customers	AS Cu
WHERE	Il.InvoiceID= (
			-- First Invoice for the Customer 1060 
			SELECT TOP(1)	InvoiceID
			FROM			Sales.Invoices AS Iv
			WHERE			Iv.CustomerID = 1060
			ORDER BY		Iv.InvoiceID			
)
AND		Cu.CustomerID = 1060
GROUP BY	CustomerId
			, CustomerName
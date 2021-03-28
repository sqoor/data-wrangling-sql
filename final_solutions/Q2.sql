
UPDATE Sales.InvoiceLines
SET UnitPrice = (
	-- the UnitPrice of the first InvoiceLine for the first invoice for the Customer 1060
	SELECT  TOP(1)	UnitPrice
	FROM			Sales.InvoiceLines AS IL
	WHERE			Il.InvoiceID= (
					-- First Invoice for the Customer 1060 
						SELECT TOP(1) InvoiceID
						FROM		Sales.Invoices AS Iv
						WHERE		IV.CustomerID = 1060
						ORDER BY	Iv.InvoiceID			
					)
	ORDER BY		Il.InvoiceLineID
) + 20
WHERE InvoiceLineID = (
	-- the InvoiceLineID of the first InvoiceLine for the first invoice for the Customer 1060
	SELECT  TOP(1)	InvoiceLineID
	FROM			Sales.InvoiceLines AS IL
	WHERE			Il.InvoiceID= (
					-- First Invoice for the Customer 1060 
						SELECT TOP(1) InvoiceID
						FROM		Sales.Invoices AS Iv
						WHERE		IV.CustomerID = 1060
						ORDER BY	Iv.InvoiceID			
					)
	ORDER BY		Il.InvoiceLineID
)

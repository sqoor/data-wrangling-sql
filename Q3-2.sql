-- (1) if choice = 1 and year = ayear, 
-- then select all CUSTOMERS names and their total monthly turnover (invoiced value) for the year
	
-- (2) if choice = 2 and year = ayear, 
-- then select all the custmers names and their total quarterly (3 months) turnover (invoiced value) 
-- for the year
	
-- (3) if choice = 3 the year value is ignored, 
-- then select all cusomters name and their total yearly turnover (invoiced value).
	
-- choice defult value = 1
-- year defualt value = 2013 (this doesn't impoart choice =3)
-- choice = 3 years can be hard coded with range [2013-2016]
-- null values in the resultset not acceptable must be substited to 0
-- all resultsets ordered by customer names alpha
-- Exampples
-- ReportCustomerTurnOver
-- ReportCustomerTurnOver 1, 2014
-- ReportCustomerTurnOver 2, 2015
-- ReportCustomerTurnOver 3
-- ReportCustomerTurnOver

SELECT * FROM Sales.Customers ORDER BY CustomerName;
-- ID of Aakriti Byrraju = 832

SELECT	YEAR(ConfirmedDeliveryTime)
		, MONTH(ConfirmedDeliveryTime) 
FROM	SALES.Invoices 
WHERE	CustomerID = 832


SELECT * FROM SALES.InvoiceLines


-- a month in a year invoiced value for a customer 
SELECT	SUM(UnitPrice * Quantity) 
FROM	SALES.InvoiceLines
WHERE	InvoiceID IN (
			SELECT	InvoiceID 
			FROM	SALES.Invoices 
			WHERE	CustomerID = 832
					AND MONTH(ConfirmedDeliveryTime) = 10
					AND YEAR(ConfirmedDeliveryTime) = 2013
		)

SELECT		Cu.CustomerName
			, COALESCE( 
				(
					SELECT	SUM(UnitPrice * Quantity) 
					FROM	SALES.InvoiceLines
					WHERE	InvoiceID IN (
								SELECT	InvoiceID 
								FROM	SALES.Invoices 
								WHERE	CustomerID = Cu.CustomerId
										AND MONTH(ConfirmedDeliveryTime) = 1
										AND YEAR(ConfirmedDeliveryTime) = 2013)
				)
				, 0
			) AS Jan
			, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
									SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) = 2
											AND YEAR(ConfirmedDeliveryTime) = 2013)
					)
					, 0
				) AS Feb
			, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
									SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) = 3
											AND YEAR(ConfirmedDeliveryTime) = 2013)
					)
					, 0
				) AS Mar
			, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
									SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) = 4
											AND YEAR(ConfirmedDeliveryTime) = 2013)
					)
					, 0
				) AS Apr
			, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
									SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) = 5
											AND YEAR(ConfirmedDeliveryTime) = 2013)
					)
					, 0
				) AS May
			, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
									SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) = 6
											AND YEAR(ConfirmedDeliveryTime) = 2013)
					)
					, 0
				) AS Jun
			, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
									SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) = 7
											AND YEAR(ConfirmedDeliveryTime) = 2013)
					)
					, 0
				) AS Jul
			, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
									SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) = 8
											AND YEAR(ConfirmedDeliveryTime) = 2013)
					)
					, 0
				) AS Aug
			, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
									SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) = 9
											AND YEAR(ConfirmedDeliveryTime) = 2013)
					)
					, 0
				) AS Sep
			, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
									SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) = 10
											AND YEAR(ConfirmedDeliveryTime) = 2013)
					)
					, 0
				) AS Oct
			, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
									SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) = 11
											AND YEAR(ConfirmedDeliveryTime) = 2013)
					)
					, 0
				) AS Nov
			, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
									SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) = 12
											AND YEAR(ConfirmedDeliveryTime) = 2013)
					)
					, 0
				) AS [Dec]
FROM		SALES.Customers AS Cu
ORDER BY	Cu.CustomerName




	SELECT	Cu.CustomerName
				, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
							SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) IN (1, 2, 3)
											AND YEAR(ConfirmedDeliveryTime) = 2015
									)
					)
					, 0
				) AS Q1
				, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
							SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) IN (4, 5, 6)
											AND YEAR(ConfirmedDeliveryTime) = 2015
									)
					)
					, 0
				) AS Q2
				, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
							SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) IN (7, 8, 9)
											AND YEAR(ConfirmedDeliveryTime) = 2015
									)
					)
					, 0
				) AS Q3
				, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
							SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(ConfirmedDeliveryTime) IN (10, 11, 12)
											AND YEAR(ConfirmedDeliveryTime) = 2015
									)
					)
					, 0
				) AS Q4
		FROM		SALES.Customers AS Cu
		ORDER BY	Cu.CustomerName
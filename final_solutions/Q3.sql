SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Abdullah Daqdoqa>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE ReportCustomerTurnover
	@Choice AS INT = 1,
	@Year AS INT = 2013
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- if choice = 1 and year = ayear, then select all cusmters names and their total monthly turnover (invoiced vale) for the year
	-- if choice = 2 and year = ayear, then select all the custmers names and their total quarterly (3 months) turnover (invoiced value) for the year
	-- if choice = 3 the year value is ignored, then select all cusomters name and their total yearly turnover (invoiced value).
	-- choice  defult value = 1
	-- year defualt value = 2013 (this doesn't impoart choice =3)
	-- choice = 3 years can be hard coded with range [2013-2016]
	-- null values in the resultset not acceptable must be substited to 0
	-- all result sets ordered by customer names alpha
	-- Exampples
	-- ReportCustomerTurnOver
	-- ReportCustomerTurnOver 1, 2014
	-- ReportCustomerTurnOver 2, 2015
	-- ReportCustomerTurnOver 3

	IF @Choice = 1
	BEGIN
		SELECT	Cu.CustomerName
					, COALESCE( 
						(
							SELECT	SUM(UnitPrice * Quantity) 
							FROM	SALES.InvoiceLines
							WHERE	InvoiceID IN (
										SELECT	InvoiceID 
										FROM	SALES.Invoices 
										WHERE	CustomerID = Cu.CustomerId
												AND MONTH(InvoiceDate) = 1
												AND YEAR(InvoiceDate) = @Year)
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
													AND MONTH(InvoiceDate) = 2
													AND YEAR(InvoiceDate) = @Year)
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
													AND MONTH(InvoiceDate) = 3
													AND YEAR(InvoiceDate) = @Year)
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
													AND MONTH(InvoiceDate) = 4
													AND YEAR(InvoiceDate) = @Year)
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
													AND MONTH(InvoiceDate) = 5
													AND YEAR(InvoiceDate) = @Year)
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
													AND MONTH(InvoiceDate) = 6
													AND YEAR(InvoiceDate) = @Year)
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
													AND MONTH(InvoiceDate) = 7
													AND YEAR(InvoiceDate) = @Year)
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
													AND MONTH(InvoiceDate) = 8
													AND YEAR(InvoiceDate) = @Year)
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
													AND MONTH(InvoiceDate) = 9
													AND YEAR(InvoiceDate) = @Year)
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
													AND MONTH(InvoiceDate) = 10
													AND YEAR(InvoiceDate) = @Year)
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
													AND MONTH(InvoiceDate) = 11
													AND YEAR(InvoiceDate) = @Year)
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
													AND MONTH(InvoiceDate) = 12
													AND YEAR(InvoiceDate) = @Year)
							)
							, 0
						) AS [Dec]
		FROM		SALES.Customers AS Cu
		ORDER BY	Cu.CustomerName
	END

	IF @Choice = 2
	BEGIN
		SELECT	Cu.CustomerName
				, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
							SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId
											AND MONTH(InvoiceDate) IN (1, 2, 3)
											AND YEAR(InvoiceDate) = @Year
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
											AND MONTH(InvoiceDate) IN (4, 5, 6)
											AND YEAR(InvoiceDate) = @Year
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
											AND MONTH(InvoiceDate) IN (7, 8, 9)
											AND YEAR(InvoiceDate) = @Year
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
											AND MONTH(InvoiceDate) IN (10, 11, 12)
											AND YEAR(InvoiceDate) = @Year
									)
					)
					, 0
				) AS Q4
		FROM		SALES.Customers AS Cu
		ORDER BY	Cu.CustomerName
	END

	IF @Choice = 3
	BEGIN
		SELECT	Cu.CustomerName
				, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
							SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId 
											AND YEAR(InvoiceDate) = 2013
						)
					)
					, 0
				) AS [2013]
				
				, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
							SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId 
											AND YEAR(InvoiceDate) = 2014
						)
					)
					, 0
				) AS [2014]
				, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
							SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId 
											AND YEAR(InvoiceDate) = 2015
						)
					)
					, 0
				) AS [2015]
				, COALESCE( 
					(
						SELECT	SUM(UnitPrice * Quantity) 
						FROM	SALES.InvoiceLines
						WHERE	InvoiceID IN (
							SELECT	InvoiceID 
									FROM	SALES.Invoices 
									WHERE	CustomerID = Cu.CustomerId 
											AND YEAR(InvoiceDate) = 2016
						)
					)
					, 0
				) AS [2016]
		FROM		SALES.Customers AS Cu
		ORDER BY	Cu.CustomerName
	END

END
GO


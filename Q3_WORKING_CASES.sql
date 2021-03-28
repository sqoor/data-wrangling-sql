SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Abdullah Daqdoqa>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE OR ALTER PROCEDURE ReportCustomerTurnover3
	@Choice INT = 1, 
	@Year INT = 2013
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
	-- all resultsets ordered by customer names alpha
	-- Exampples
	-- ReportCustomerTurnOver
	-- ReportCustomerTurnOver 1, 2014
	-- ReportCustomerTurnOver 2, 2015
	-- ReportCustomerTurnOver 3


	IF @Choice = 1 
	BEGIN
		SELECT	Cu.CustomerName
				, SUM(CASE WHEN MONTH(Iv.InvoiceDate) = 1 THEN (Il.quantity * Il.unitprice) Else 0 END)  AS Jan
				, SUM(CASE WHEN MONTH(Iv.InvoiceDate) = 2 THEN (Il.quantity * Il.unitprice) Else 0 END)  AS Feb
				, SUM(CASE WHEN MONTH(Iv.InvoiceDate) = 3 THEN (Il.quantity * Il.unitprice) Else 0 END)  AS Mar
				, SUM(CASE WHEN MONTH(Iv.InvoiceDate) = 4 THEN (Il.quantity * Il.unitprice) Else 0 END)  AS Apr
				, SUM(CASE WHEN MONTH(Iv.InvoiceDate) = 5 THEN (Il.quantity * Il.unitprice) Else 0 END)  AS May
				, SUM(CASE WHEN MONTH(Iv.InvoiceDate) = 6 THEN (Il.quantity * Il.unitprice) Else 0 END)  AS Jun
				, SUM(CASE WHEN MONTH(Iv.InvoiceDate) = 7 THEN (Il.quantity * Il.unitprice) Else 0 END)  AS Jul
				, SUM(CASE WHEN MONTH(Iv.InvoiceDate) = 8 THEN (Il.quantity * Il.unitprice) Else 0 END)  AS Aug
				, SUM(CASE WHEN MONTH(Iv.InvoiceDate) = 9 THEN (Il.quantity * Il.unitprice) Else 0 END)  AS Sep
				, SUM(CASE WHEN MONTH(Iv.InvoiceDate) = 10 THEN (Il.quantity * Il.unitprice) Else 0 END)  AS Oct
				, SUM(CASE WHEN MONTH(Iv.InvoiceDate) = 11 THEN (Il.quantity * Il.unitprice) Else 0 END)  AS Nov
				, SUM(CASE WHEN MONTH(Iv.InvoiceDate) = 12 THEN (Il.quantity * Il.unitprice) Else 0 END)  AS [Dec]
		FROM	Sales.Customers AS Cu		
				, Sales.Invoices AS Iv
				, Sales.InvoiceLines AS Il	
		WHERE	Cu.CustomerID = Iv.CustomerID	
				AND IV.InvoiceID = IL.InvoiceID
				AND YEAR(Iv.InvoiceDate) = @Year
		GROUP BY Cu.CustomerName 
		ORDER BY Cu.CustomerName ASC
	END

	IF @Choice = 2 
	BEGIN
		SELECT	Cu.CustomerName
				, SUM(
					CASE 
						WHEN(MONTH(Iv.InvoiceDate) IN (1, 2, 3))
						THEN(Il.quantity * Il.unitprice) 
						ELSE 0 
					END
				)  AS Q1
				, SUM(
					CASE 
						WHEN(MONTH(Iv.InvoiceDate) IN (4, 5, 6))
						THEN (IL.quantity * IL.unitprice) 
						ELSE 0 
					END
				)  AS Q2
				, SUM(
					CASE 
						WHEN(MONTH(Iv.InvoiceDate) IN (7, 8, 9))
						THEN(Il.quantity * Il.unitprice) 
						ELSE 0 
					END
				)  AS Q3
				, SUM(
					CASE 
						WHEN(MONTH(Iv.InvoiceDate) IN (10, 11, 12))
						THEN (IL.quantity * IL.unitprice) 
						ELSE 0 
					END
				)  AS Q4
		FROM	Sales.Invoices			AS Iv
				, Sales.InvoiceLines	AS Il 
				, Sales.Customers		AS Cu 
		WHERE	Cu.CustomerID = Iv.CustomerID
				AND Iv.InvoiceID = Iv.InvoiceID
				AND YEAR(Iv.InvoiceDate) = @Year
		GROUP BY Cu.CustomerName 
		ORDER BY Cu.CustomerName ASC
	END

	IF @choice=3 
	BEGIN
		SELECT	Cu.CustomerName
				, SUM(CASE WHEN YEAR(Iv.InvoiceDate) = 2013 THEN (Il.quantity * Il.unitprice) Else 0 END) AS [2013]
				, SUM(CASE WHEN YEAR(Iv.InvoiceDate) = 2014 THEN (Il.quantity * Il.unitprice) Else 0 END) AS [2014]
				, SUM(CASE WHEN YEAR(Iv.InvoiceDate) = 2015 THEN (Il.quantity * Il.unitprice) Else 0 END) AS [2015]
				, SUM(CASE WHEN YEAR(Iv.InvoiceDate) = 2016 THEN (Il.quantity * Il.unitprice) Else 0 END) AS [2016]
		FROM	Sales.Invoices			AS Iv
				, SALES.InvoiceLines	AS Il
				, Sales.Customers		AS Cu 
		WHERE	Cu.CustomerID = Iv.CustomerID
				AND Iv.InvoiceID = Il.InvoiceID
		GROUP BY Cu.CustomerName 
		ORDER BY Cu.CustomerName ASC
	END
END

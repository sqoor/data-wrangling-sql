SELECT 
	t.CustomerCategoryName
	, (
		SELECT m.MostLoss
		FROM 
		(
			SELECT TOP(1) SUM(UnitPrice * Quantity) AS MostLoss
			FROM
				Sales.Customers				AS Cu
				, Sales.Orders				AS Od
				, Sales.OrderLines			AS Ol
				, Sales.CustomerCategories	AS Cc
			WHERE
				Cu.CustomerID = Od.CustomerID
				AND Ol.OrderID = Od.OrderID
				AND Cc.CustomerCategoryID = Cu.CustomerCategoryID
				AND NOT EXISTS
				(
					SELECT *
					FROM Sales.Invoices as Iv
					WHERE Iv.OrderId = Od.OrderID
				)
				AND CustomerCategoryName = t.CustomerCategoryName

			GROUP BY	Cu.CustomerID
						, Cu.CustomerName
						, Cu.CustomerCategoryID
						, CustomerCategoryName
			ORDER BY MostLoss DESC

		) AS m

	) AS MaxLoss
	, (
		SELECT n.CustomerName
		FROM 
		(
			SELECT TOP(1)	Cu.CustomerName
							, SUM(UnitPrice * Quantity) AS MostLoss
			FROM
				Sales.Customers				AS Cu
				, Sales.Orders				AS Od
				, Sales.OrderLines			AS Ol
				, Sales.CustomerCategories	AS Cc
			WHERE
				Cu.CustomerID = Od.CustomerID
				AND Ol.OrderID = Od.OrderID
				AND Cc.CustomerCategoryID = Cu.CustomerCategoryID
				AND NOT EXISTS
				(
					SELECT *
					FROM Sales.Invoices as Iv
					WHERE Iv.OrderId = Od.OrderID
				)
				AND CustomerCategoryName = t.CustomerCategoryName

			GROUP BY	Cu.CustomerID
						, Cu.CustomerName
						, Cu.CustomerCategoryID
						, CustomerCategoryName
			ORDER BY MostLoss DESC
		) AS n

	) AS CustomerName
	, (
		SELECT n.CustomerID
		FROM 
		(
			SELECT TOP(1)		Cu.CustomerID
								, SUM(UnitPrice * Quantity) AS MostLoss
			FROM
					Sales.Customers				AS Cu
					, Sales.Orders				AS Od
					, Sales.OrderLines			AS Ol
					, Sales.CustomerCategories	AS Cc
			WHERE
					Cu.CustomerID = Od.CustomerID
					AND Ol.OrderID = Od.OrderID
					AND Cc.CustomerCategoryID = Cu.CustomerCategoryID
					AND NOT EXISTS
					(
						SELECT *
						FROM Sales.Invoices as Iv
						WHERE Iv.OrderId = Od.OrderID
					)
					AND CustomerCategoryName = t.CustomerCategoryName

			GROUP BY	Cu.CustomerID
						, Cu.CustomerName
						, Cu.CustomerCategoryID
						, CustomerCategoryName
			ORDER BY MostLoss DESC
		) AS n
	) AS CustomerID
FROM 
(
-- NAME OF customer categories who made losses
SELECT	Cc.CustomerCategoryName AS CustomerCategoryName
FROM	Sales.Customers as Cu
		, Sales.Orders as Od
		, Sales.OrderLines AS Ol
		, Sales.CustomerCategories AS Cc
WHERE
		Cu.CustomerID = Od.CustomerID
		AND Ol.OrderID = Od.OrderID
		AND Cc.CustomerCategoryID = Cu.CustomerCategoryID
		AND NOT EXISTS
		(
			SELECT	*
			FROM	Sales.Invoices as Iv
			WHERE	Iv.OrderId = Od.OrderID
		)
GROUP BY CustomerCategoryName
) AS t
ORDER BY MaxLoss DESC
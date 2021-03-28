-- NAME OF customer categories who made losses
SELECT  
		t.CustomerCategoryName
		, t.CustomerName
	FROM 
	(
		SELECT 
				(
					SELECT	Cc.CustomerCategoryName
					FROM	Sales.CustomerCategories AS Cc
					WHERE	Cc.CustomerCategoryID = Cu.CustomerCategoryID
				) AS CustomerCategoryName
				, Cu.CustomerName
			FROM
				Sales.Customers as Cu
				, Sales.Orders as Od
				, Sales.OrderLines AS Ol

			WHERE
				Cu.CustomerID = Od.CustomerID
				AND Ol.OrderID = Od.OrderID
				AND NOT EXISTS
				(
					SELECT *
					FROM Sales.Invoices as Iv
					WHERE Iv.OrderId = Od.OrderID
				)

			GROUP BY	Cu.CustomerID
						, Cu.CustomerName
						, Cu.CustomerCategoryID
	) AS t

	GROUP BY t.CustomerCategoryName
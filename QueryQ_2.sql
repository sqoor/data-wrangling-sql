SELECT 	TOP(1)				
				Cc.CustomerCategoryName AS CustomerCategoryName
				, SUM(UnitPrice * Quantity) AS MaxLoss
				, Cu.CustomerID				AS CustomerID
				, Cu.CustomerName			AS CustomerName

			FROM
				Sales.Customers as Cu
				, Sales.Orders as Od
				, Sales.OrderLines AS Ol
				, Sales.CustomerCategories AS Cc
			WHERE
				Cu.CustomerID = Od.CustomerID
				AND Ol.OrderID = Od.OrderID
				AND Cc.CustomerCategoryID = Cu.CustomerCategoryID
				AND Cc.CustomerCategoryName = 'Supermarket'
				AND NOT EXISTS
				(
					SELECT *
					FROM Sales.Invoices as Iv
					WHERE Iv.OrderId = Od.OrderID
				)
			GROUP BY	Cu.CustomerID
						, Cu.CustomerName
						, Cu.CustomerCategoryID
						, Cc.CustomerCategoryName
		
			
			ORDER BY MaxLoss DESC
	)
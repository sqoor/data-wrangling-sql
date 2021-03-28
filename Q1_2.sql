

SELECT	Cu.CustomerID
		, Cu.CustomerName
		, COUNT(Od.OrderId) AS OrdersNumber
		, SUM(Ol.UnitPrice * Ol.Quantity) AS OrderTotalValue
FROM	Sales.Customers AS Cu
		, Sales.Orders AS Od
		, Sales.OrderLines AS Ol
WHERE	Cu.CustomerID = Od.CustomerID
		AND Od.OrderID = Ol.OrderID
		AND Cu.CustomerId = 1060
GROUP BY Cu.CustomerId, Cu.CustomerName


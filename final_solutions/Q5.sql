

SELECT	Cu.*
FROM	Customer AS Cu
WHERE	NOT EXISTS 
(
	SELECT	*
	FROM	Product AS Pr
	WHERE	NOT EXISTS		-- be integrated in the division query canvas
	(
		SELECT	*
		FROM	Purchase as Pu
		WHERE
			Pu.ProductId = Pr.ProductId
			AND Pu.CustomerId = Cu.CustomerId
	)
) 
AND  
(
	SELECT	SUM(Qty)
	FROM	Purchase AS Pu
	WHERE	Pu.CustomerId= Cu.CustomerId		
) >= 50



GO
CREATE   PROCEDURE [dbo].[Lab-2]
AS
BEGIN

-- Task 1
SELECT FirstName,LastName,HireDate
FROM DimEmployee
Where StartDate 
BETWEEN cast('2008/10/01' as datetime)
AND cast('2008/10/31' as datetime)

order by HireDate desc

-- Task 2
SELECT ResellerName
FROM DimReseller
WHERE BusinessType = 'Specialty Bike Shop';

-- Task 3
select top(5) b.EnglishProductname, count(a.ProductKey) as 'Quantity', b.SafetyStockLevel
from FactInternetSales as a 
inner join DimProduct as b on b.ProductKey = a.ProductKey
where b.SafetyStockLevel in ('800','500')
group by b.EnglishProductName, b.SafetyStockLevel 
order by Quantity desc

-- Task 5
SELECT TOP(2) EnglishPromotionName
FROM DimPromotion
ORDER BY DiscountPct DESC


END
Go
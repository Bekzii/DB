CREATE OR ALTER PROCEDURE Lab4
AS
BEGIN

SELECT FORMAT(CONVERT(date, CONVERT(nvarchar(10), OrderDateKey, 101)), 'yyyy-MM') as YearMonthName, SUM(SalesAmount) as SalesAmount
FROM FactInternetSales
GROUP BY FORMAT(CONVERT(date, CONVERT(nvarchar(10), OrderDateKey, 101)), 'yyyy-MM')
HAVING SUM(SalesAmount) > 1000000
ORDER BY YearMonthName

SELECT t.SalesTerritoryCountry + '/' + t.SalesTerritoryRegion as CountryRegionName , FORMAT(SUM(s.SalesAmount), '0,,mln') as SalesAmount
FROM FactResellerSales as s
INNER JOIN DimSalesTerritory as t
ON s.SalesTerritoryKey = t.SalesTerritoryKey
GROUP BY t.SalesTerritoryCountry + '/' + t.SalesTerritoryRegion
HAVING SUM(s.SalesAmount) BETWEEN 1999999 AND 5000000

SELECT p.EnglishProductName as ProductName, MAX(i.UnitsBalance) as Maxium, MIN(i.UnitsBalance) as Minium
FROM FactProductInventory as i
INNER JOIN DimProduct as p
ON i.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName
HAVING MAX(i.UnitsBalance) = MIN(i.UnitsBalance)

SELECT TOP 10 e.FirstName + ' ' + e.LastName as PersonName, MAX(e.BaseRate) as BaseRate
FROM DimEmployee as e
RIGHT OUTER JOIN FactResellerSales as s
ON e.EmployeeKey = e.EmployeeKey
GROUP BY e.FirstName + ' ' + e.LastName
ORDER BY MAX(e.BaseRate) DESC

SELECT p.EnglishProductName as ProductName, SUM(s.OrderQuantity) as OrderQuantity
FROM FactResellerSales as s
INNER JOIN DimProduct as p
ON s.ProductKey = p.ProductKey
GROUP BY p.EnglishProductName
HAVING SUM(OrderQuantity) % 60 = 0
END
GO
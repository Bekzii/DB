CREATE OR ALTER PROCEDURE Lab3
AS
BEGIN
SELECT CAST(DATEPART(YYYY, OrderDate) as varchar)  + '/' +  CAST(DATEPART(MM, OrderDate) as varchar) as YearAndMonth , SUM(SalesAmount) as SalesAmount
FROM FactInternetSales
GROUP BY OrderDate
ORDER BY OrderDate

SELECT T.SalesTerritoryCountry as CountryName , SUM(SalesAmount) as SalesAmount
FROM FactResellerSales as S
INNER JOIN DimSalesTerritory as T
ON S.SalesTerritoryKey = T.SalesTerritoryKey
GROUP BY T.SalesTerritoryCountry
ORDER BY SalesAmount DESC

SELECT PC.EnglishProductCategoryName , SUM(SalesAmount) as SalesAmount 
FROM  FactResellerSales as S
INNER JOIN DimProduct as P
ON S.ProductKey = P.ProductKey
INNER JOIN DimProductSubcategory as PS
ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey
INNER JOIN DimProductCategory as PC
ON PS.ProductCategoryKey = PC.ProductCategoryKey
GROUP BY PC.EnglishProductCategoryName
ORDER BY SalesAmount DESC

SELECT E.FirstName + ' ' +  E.LastName, SUM(SalesAmount) as SalesAmount
FROM FactResellerSales as S
INNER JOIN DimEmployee as E
ON S.EmployeeKey = E.EmployeeKey
GROUP BY E.FirstName + ' ' + E.LastName
ORDER BY SalesAmount

SELECT TOP 10  P.EnglishProductName as ProductName, COUNT(S.OrderQuantity) as OrderCount
FROM FactInternetSales as S
INNER JOIN DimProduct as P
ON S.ProductKey = P.ProductKey
GROUP BY P.EnglishProductName
ORDER BY OrderCount DESC
END
GO
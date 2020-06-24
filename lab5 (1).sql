CREATE OR ALTER PROCEDURE Lab5
AS
BEGIN
SELECT DSR.SalesReasonName, FORMAT(ROUND(SUM(S.SalesAmount)/1000000, 1), '0.0M') as SalesAmount
FROM FactInternetSales S
JOIN FactInternetSalesReason SR
ON S.SalesOrderNumber = SR.SalesOrderNumber
JOIN DimSalesReason DSR
ON SR.SalesReasonKey = DSR.SalesReasonKey
GROUP BY DSR.SalesReasonName
ORDER BY SalesAmount

SELECT (ST.SalesTerritoryCountry + '/' + ST.SalesTerritoryRegion) as CountryRegionName, FORMAT(ROUND(SUM(S.SalesAmount)/1000000, 1), '0.0M') as SalesAmount
FROM FactInternetSales S
JOIN DimSalesTerritory ST
ON ST.SalesTerritoryKey = S.SalesTerritoryKey
GROUP BY ST.SalesTerritoryCountry + '/' + ST.SalesTerritoryRegion
ORDER BY SalesAmount

SELECT TOP 10 P.EnglishProductName, MAX(FPI.UnitsBalance) as MaxUnitBalance, MIN(FPI.UnitsBalance) as MinUnitBalance
FROM FactProductInventory FPI
JOIN DimProduct P
ON P.ProductKey = FPI.ProductKey
GROUP BY P.EnglishProductName 

SELECT DD.EnglishDayNameOfWeek, FORMAT(ROUND(SUM(RS.SalesAmount)/1000000, 1), '0.0M') as SalesAmount
FROM FactResellerSales RS
JOIN DimDate DD
ON DD.DateKey = RS.OrderDateKey
GROUP BY DD.EnglishDayNameOfWeek

SELECT TOP 5 DG.StateProvinceName, COUNT(ProspectiveBuyerKey) as NumberOfProspectiveBuyers
FROM ProspectiveBuyer PB
JOIN DimGeography DG
ON PB.StateProvinceCode = DG.StateProvinceCode
GROUP BY DG.StateProvinceName
ORDER BY NumberOfProspectiveBuyers DESC

END 
GO
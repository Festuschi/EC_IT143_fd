SELECT c.CustomerID,
       p.FirstName, p.LastName,
       a.City AS ShipCity,
       soh.CreditCardApprovalCode AS PaymentMethod,
       SUM(sod.OrderQty) AS TotalBikesPurchased
FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product pr ON sod.ProductID = pr.ProductID
JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
WHERE pr.Name LIKE '%Bike%'
  AND soh.OrderDate >= DATEADD(QUARTER, -1, GETDATE())
GROUP BY c.CustomerID, p.FirstName, p.LastName, a.City, soh.CreditCardApprovalCode
ORDER BY TotalBikesPurchased DESC;

--Question: Report joining Sales.SalesOrderHeader, Sales.Customer, 
            --and Sales.SalesOrderDetail to provide the total number 
            --of bikes each customer purchased in the past quarter, 
            --along with shipment city and payment method.
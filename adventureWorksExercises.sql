----1. From the following table write a query in SQL to retrieve all rows and columns from the employee table in the Adventureworks database. Sort the result set in ascending order on jobtitle.
select *
from humanresources.employee
order by jobtitle asc

--2. From the following table write a query in SQL to retrieve all rows and columns from the employee table using table aliasing in the Adventureworks database. Sort the output in ascending order on lastname.
select *
from person.person
order by LastName asc

--- 3.From the following table write a query in SQL to return all rows and a subset of the columns (FirstName, LastName, businessentityid) from the person table in the AdventureWorks database. The third column heading is renamed to Employee_id. Arranged the output in ascending order by lastname.
select FirstName, LastName, businessentityid as EmployeeId
from person.person
order by LastName asc

---4. From the following table write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. Return productid, productnumber, and name. Arranged the output in ascending order on name.
select productid, productnumber, name
from production.Product
where sellstartdate is not null
and productline= 'T'
order by name asc

---5. From the following table write a query in SQL to return all rows from the salesorderheader table in Adventureworks database and calculate the percentage of tax on the subtotal have decided. Return salesorderid, customerid, orderdate, subtotal, percentage of tax column. Arranged the result set in ascending order on subtotal.
select salesorderid, customerid, orderdate, subtotal, (taxamt/(subtotal-taxamt))*100 as'percentage of tax'
from sales.salesorderheader
order by subtotal desc


---6. From the following table write a query in SQL to create a list of unique jobtitles in the employee table in Adventureworks database. Return jobtitle column and arranged the resultset in ascending order.
select distinct jobtitle
from HumanResources.Employee
order by jobtitle asc
--or
select jobtitle
from HumanResources.Employee
group by jobtitle
order by jobtitle asc

---7. From the following table write a query in SQL to calculate the total freight paid by each customer. Return customerid and total freight. Sort the output in ascending order on customerid.
select  customerid, sum(freight) 
from sales.salesorderheader
group by customerid
order by customerid asc

---8. From the following table write a query in SQL to find the average and the sum of the subtotal for every customer. Return customerid, average and sum of the subtotal. Grouped the result on customerid and salespersonid. Sort the result on customerid column in descending order.
select  customerid, sum(subtotal) as 'sum of the subtotal', avg(subtotal) as 'avg of the subtotal'
from sales.salesorderheader
group by customerid
order by customerid desc

---9. From the following table write a query in SQL to retrieve total quantity of each productid which are in shelf of 'A' or 'C' or 'H'. Filter the results for sum quantity is more than 500. Return productid and sum of the quantity. Sort the results according to the productid in ascending order.
select  productid, sum(quantity) as 'sum quantity'
from production.productinventory
where shelf in ('A','C', 'H')
group by productid
having SUM(quantity)>500
order by productid asc

---10. From the following table write a query in SQL to find the total quentity for a group of locationid multiplied by 10.
select SUM(quantity) as 'sum quantity', locationid 
from production.productinventory
group by locationid

---11. From the following tables write a query in SQL to find the persons whose last name starts with letter 'L'. Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.

select A.BusinessEntityID, A.firstname, A.lastname, B.phonenumber
from Person.Person as A
JOIN Person.PersonPhone AS B
on A.BusinessEntityID= B.BusinessEntityID
where lastname like 'L%'
order by LASTname, firstname

---12. From the following table write a query in SQL to find the sum of subtotal column. Group the sum on distinct salespersonid and customerid. Rolls up the results into subtotal and running total. Return salespersonid, customerid and sum of subtotal column i.e. sum_subtotal.

select SUM(subtotal) as 'sum subtotal', salespersonid, customerid
from sales.salesorderheader
 group by rollup (customerid, salespersonid)

 ---13. From the following table write a query in SQL to find the sum of the quantity of all combination of group of distinct locationid and shelf column. Return locationid, shelf and sum of quantity as TotalQuantity.
 select locationid, shelf, sum(quantity) as 'Total Quantity'
from production.productinventory
 group by cube (locationid, shelf)--- all combinations

  select locationid, shelf, sum(quantity) as 'Total Quantity'
from production.productinventory
 group by rollup (locationid, shelf)

 ---14. From the following table write a query in SQL to find the sum of the quantity with subtotal for each locationid. Group the results for all combination of distinct locationid and shelf column. Rolls up the results into subtotal and running total. Return locationid, shelf and sum of quantity as TotalQuantity.

select SUM(quantity) as 'Total Quantity', locationid, shelf
from production.productinventory
group by cube (locationid, shelf)
union all --(union all- return all records, union- returns unique records)
select SUM(quantity) as 'Total Quantity', locationid, shelf
from production.productinventory
group by rollup (locationid, shelf)
order by locationid, shelf

select SUM(quantity) as 'Total Quantity', locationid, shelf
from production.productinventory
group by grouping sets ( rollup (locationid, shelf), cube (locationid, shelf) )
order by select SUM(quantity) as 'Total Quantity', locationid, shelf
from production.productinventory
group by grouping sets ( rollup (locationid, shelf), cube (locationid, shelf) )
order by  locationid, shelf

-- 15. From the following table write a query in SQL to find the total quantity for each locationid and calculate the grand-total for all locations. Return locationid and total quantity. Group the results on locationid.
select SUM(quantity) as 'Total Quantity', locationid
from production.productinventory
group by rollup(locationid) 
order by locationid

---16. From the following table write a query in SQL to retrieve the number of employees for each City. Return city and number of employees. Sort the result in ascending order on city.
select ad.city, COUNT(bu.businessentityid) as "number of employees"
from Person.BusinessEntityAddress as bu
INNER join person.address as ad
 on ad.addressid= bu.addressid
inner join person.person as pe
 on bu.businessentityid= pe.businessentityid
 where pe.persontype in('EM', 'SC', 'SC')
 group by ad.city
order by city asc

---17. From the following table write a query in SQL to retrieve the total sales for each year. Return the year part of order date and total due amount. Sort the result in ascending order on year part of order date.
select SUM(TotalDue) AS ORDERAMOUNT, DATEPART(year, OrderDate) as 'YEAR'
from Sales.SalesOrderHeader
 group by DATEPART(year, OrderDate)
order by DATEPART(year, OrderDate)

---18. From the following table write a query in SQL to retrieve the total sales for each year. Filter the result set for those orders where order year is on or before 2016. Return the year part of orderdate and total due amount. Sort the result in ascending order on year part of order date.
select SUM(TotalDue) AS ORDERAMOUNT, DATEPART(year, OrderDate) as 'YEAR'
from Sales.SalesOrderHeader
 group by DATEPART(year, OrderDate)
order by DATEPART(year, OrderDate)

---19. From the following table write a query in SQL to find the contacts who are designated as a manager in various departments. Returns ContactTypeID, name. Sort the result set in descending order.
select  ContactTypeID, name
from Person.ContactType
where name like '%manager%'
order by ContactTypeID desc

--20. From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.
select  pe.businessentityid, pe.lastname, pe.firstname
from Person.person as pe
join Person.BusinessEntityContact as bu
on pe.businessentityid=bu.PersonID--- z dokumentacji  
join person.contacttype as co
on co.contacttypeid= bu.contacttypeid
where co.name='Purchasing manager'
order by lastname, firstname asc

---21. From the following tables write a query in SQL to retrieve the salesperson for each PostalCode who belongs to a territory and SalesYTD is not zero. Return row numbers of each group of PostalCode, last name, salesytd, postalcode column. Sort the salesytd of each postalcode group in descending order. Shorts the postalcode in ascending order.
select count(*) as rownumbers, lastname, salesytd, postalcode, pe.businessentityid
from Person.person as pe
join Sales.salesperson as sa
on pe.businessentityid=sa.businessentityid
join person.BusinessEntity as bu
on bu.BusinessEntityID= pe.BusinessEntityID
join person.BusinessEntityAddress as bea
on bu.BusinessEntityID=bea.BusinessEntityID
join person.Address as at
on bea.AddressID=at.AddressID
where TerritoryID is not null 
group by lastname, salesytd, postalcode, pe.businessentityid
having max(SalesYTD)>0

---22. From the following table write a query in SQL to count the number of contacts for combination of each type and name. Filter the output for those who have 100 or more contacts. Return ContactTypeID and ContactTypeName and BusinessEntityContact. Sort the result set in descending order on number of contacts.
select count(*) as count,  co.name as ContactTypeName, bu.ContactTypeID 
from Person.Contacttype as co
join Person.BusinessEntityContact as bu
on co.ContactTypeID=bu.ContactTypeID
group by bu.ContactTypeID, co.name
HAVING COUNT(*) >= 100


---23. From the following table write a query in SQL to retrieve the RateChangeDate, full name (first name, middle name and last name) and weekly salary (40 hours in a week) of employees. In the output the RateChangeDate should appears in date format. Sort the output in ascending order on NameInFull.
select CAST(eh.RateChangeDate AS DATE) AS DATE, eh.rate *40 as 'weekly salary', concat (pe.firstname,' ', pe.middlename,' ', pe.lastname) as 'full name'
from HumanResources.EmployeePayHistory as eh
join person.person as pe
on pe.BusinessEntityID= eh.BusinessEntityID


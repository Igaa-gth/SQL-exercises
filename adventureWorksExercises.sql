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


select SUM(quantity) as 'Total Quantity', locationid, shelf
from production.productinventory
group by grouping sets ( rollup (locationid, shelf), cube (locationid, shelf) )



--Write an SQL statement to transform the following tables into the expected output.--
select * from Cart1 full join Cart2 on Cart1.item = Cart2.item;
--Solution 2 
select a.Item, b.Item from Cart1  a left join Cart2  b on a.Item = b.Item 
union 
select a.Item, b.Item from Cart1  a right join Cart2  b on a.Item = b.Item; 
--union does not repeat the duplicate data whereas union all repeats the duplicate 
select a.Item, b.Item from Cart1  a left join Cart2  b on a.Item = b.Item 
union all
select a.Item, b.Item from Cart1  a right join Cart2  b on a.Item = b.Item; 

--- Puzzle 2 
-- This is simple query to get the manager name ] 
select e.employeeid as employee, m.employeeid as manager, e.jobtitle from Employees e left join Employees m on e.managerId = m.employeeid

-- puzzle 
WITH RECURSIVE cte_Recursion AS
( 
    SELECT  EmployeeID, ManagerID, JobTitle, 0 AS Depth
    FROM    Employees a
    WHERE   ManagerID IS NULL
    UNION ALL
    SELECT  b.EmployeeID, b.ManagerID, b.JobTitle, a.Depth + 1 AS Depth
    FROM    cte_Recursion a 
    INNER JOIN Employees b ON a.EmployeeID = b.ManagerID
)
SELECT  EmployeeID,
        ManagerID,
        JobTitle,
        Depth
FROM    cte_Recursion;

--Puzzle 4 
select * from StateOrders where deliverystate = 'TX' and customerid  in (select customerid from stateorders where deliverystate='CA')

select * from stateorders s join (select * from stateorders where deliverystate='CA' ) CACustomer on CACustomer.customerid = s.customerid 
where s.deliverystate = 'TX'


with tempCa as (select distinct(customerid) from stateorders where deliverystate='CA')
select * from tempCa join StateOrders on  tempCa.customerid = StateOrders.customerid where StateOrders.deliverystate = 'TX'

-- Puzzle 5 --Solution 1 

with CT_Cellular as (
    select CustomerID, PhoneNumber  
    from PhoneDirectory 
    where type = 'Cellular'
),
CT_Work as (
    select CustomerID, PhoneNumber  
    from PhoneDirectory 
    where type = 'Work'
),
CT_Home as (
    select CustomerID, PhoneNumber  
    from PhoneDirectory 
    where type = 'Home'
)

select a.CustomerID, c.PhoneNumber as Cellular, w.PhoneNumber as Work, h.PhoneNumber as Home 
from PhoneDirectory a 
left join CT_Cellular c on a.customerid = c.CustomerID
left join CT_Work w on a.customerid = w.CustomerID
left join CT_Home h on a.customerid = h.CustomerID;

-- Puzzle 5 --Solution 2
SELECT  CustomerID,
        MAX(CASE Type WHEN 'Cellular' THEN PhoneNumber END),
        MAX(CASE Type WHEN 'Work' THEN PhoneNumber END),
        MAX(CASE Type WHEN 'Home' THEN PhoneNumber END)
FROM    PhoneDirectory
GROUP BY CustomerID;

SELECT  CustomerID,Cellular,Work,Home
FROM    PhoneDirectory PIVOT
       (MAX(PhoneNumber) FOR Type IN (Cellular,Work,Home)) AS PivotClause;

-- find the customer which jas more than one number 
select customerid, count(*) from PhoneDirectory 
group by customerid
having count(*)>1

--Why max is used here 
SELECT  CustomerID,
        CASE Type WHEN 'Cellular' THEN PhoneNumber END AS Cellular,
        CASE WHEN Type = 'Work' THEN PhoneNumber END AS Work,
        CASE WHEN Type = 'Home' THEN PhoneNumber END AS Home
FROM    PhoneDirectory;

-- In the query you provided, the MAX function is used within each CASE statement to aggregate the PhoneNumber values for each Type (Cellular, Work, Home). This is necessary because a GROUP BY clause is used in the query, and without an aggregation function like MAX, MIN, SUM, etc., you cannot select non-aggregated columns in the SELECT clause.
--If you remove the MAX function from the query, it would result in an error because each CASE statement would be trying to return multiple values for each CustomerID, which violates the rules of SQL.
--However, if you want to retrieve the phone numbers without aggregation, you would need to either remove the GROUP BY clause or adjust the query accordingly. Here's how you might adjust the query to select individual phone numbers without aggregation
--SELECT  CustomerID,
--        CASE WHEN Type = 'Cellular' THEN PhoneNumber END AS Cellular,
 --       CASE WHEN Type = 'Work' THEN PhoneNumber END AS Work,
 --       CASE WHEN Type = 'Home' THEN PhoneNumber END AS Home
--FROM    PhoneDirectory;


select distinct(workflow) from workflowsteps 
where completionDate is null

-- Puzzles 7 
select * from CandidateSpace;
select * from requirements ;

SELECT  CandidateID
FROM    CandidateSpace
WHERE   Occupation IN (SELECT Requirement FROM Requirements)
GROUP BY CandidateID
HAVING COUNT(*) = (SELECT COUNT(*) FROM Requirements);


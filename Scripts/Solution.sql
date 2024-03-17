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
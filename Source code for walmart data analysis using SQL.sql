use walmart;


select * from walmartdataa;

-- FEATURE ENGINEERING ----------

-- time_of_the_day ---
select time,
(
case when time between "00:00:00" and "12:00:00" then "Morning"
     when time between "12:01:00" and "16:00:00" then "Afternoon"
	 else "Evening"
end ) as time_of_the_day
from walmartdataa;

alter table walmartdataa add time_of_the_day varchar(20);
select * from walmartdataa;

update walmartdataa
set time_of_the_day=
(case 
when time between "00:00:00" and "12:00:00" then "Morning"
when time between "12:01:00" and "16:00:00" then "Afternoon"
else "Evening"
end);
select * from walmartdataa;

-- day_name --
select date,dayname(date) as day_name from walmartdataa;

alter table walmartdataa
add day_name varchar(20);

update walmartdataa
set day_name=dayname(date) ;

select * from walmartdataa;

-- MONTH NAME ----
select date,monthname(date) as month_name from walmartdataa;

alter table walmartdataa
add month_name varchar(20);

update walmartdataa
set month_name = monthname(date);

select * from walmartdataa;

-- 1.Retrieve all columns for sales made in a specific branch(Ex: branch 'A')-------

select branch,round(sum(total),2) as tot_sale_branch from walmartdataa
group by branch;

-- 2. Find the total sales for each product line. ------------------------------

select product_line,round(sum(total),2) as total_sales from walmartdataa
group by product_line;

-- 3. List all sales transactions where the payment method was "Cash" -------------

select * from walmartdataa
where payment="cash";

-- 4. Calculate the total gross income generated in each city ------------------

Select City,round(sum(gross_income),2) as total_gross_income from walmartdataa
group by city;

-- 5. Find the average rating given by cutomers in each branch --------------------

Select branch,round(avg(Rating),2) as avg_rating from walmartdataa
group by branch;

-- 6.  Determine the total quantity of each product line sold. -----------------------

select product_line,sum(quantity) as total_quantity from walmartdataa
group by product_line;

-- 7. List the top 5 products by unit price-----------------------------

select product_line,unit_price from walmartdataa
order by unit_price desc limit 5;

-- 8. Find sales transactions with a gross income greater than 30. ------------

select invoice_id,gross_income,total from walmartdataa
where gross_income > 30;


-- 9. Retrieve sales transactions that occurred on weekends ------------------

select invoice_id,day_name,total from walmartdataa
where day_name in ('Saturday','Sunday');

-- 10. Calculate the total sales and gross income for each month -------------

Select month_name,round(sum(total),2) as tot_salefor_month,
round(sum(gross_income),2) as total_gross
from walmartdataa group by month_name;

-- 11. Find the number of sales transactions that occurred after 6 PM. ------------

select count(invoice_id) as no_of_transactions_after6PM from walmartdataa
where time between "18:00:00" and "23:59:59";

-- 12. List the sales transactions that have a higher total than the 
-- avearge total of all transactions----

select invoice_id,total from walmartdataa
where total >= (select avg(total) from walmartdataa);

-- 13. Calculate the cumulative gross income for each branch by date. -----------

SELECT Date,Branch,SUM(gross_income) AS cumulative_gross_income
FROM WalmartDataa
GROUP BY Date, Branch
ORDER BY Date, Branch;


-- 14. Find the total cogs for each customer type in each city. ----------------

select Customer_type,City,round(sum(cogs),2) as total_cogs from walmartdataa
group by Customer_type,City
order by city;



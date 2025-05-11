USE humanresource;


-- JOINS 
/* 

The process of linking tables is called joining
The SELECT statement can link multiple tables together
SQL provides many kinds of JOINS.

 */


SELECT 
    first_name, last_name job_title, department_name, salary
FROM
    employees e
        INNER JOIN
    departments d ON d.department_id = e.department_id
        INNER JOIN
    jobs j ON j.job_id = e.job_id
WHERE
    d.department_id IN (1 , 5, 7);


SELECT 
    c.country_id, country_name, city
FROM
    locations l
        RIGHT JOIN
    countries c ON l.country_id = c.country_id
WHERE
    c.country_id IN ('UK' , 'US', 'BE', 'CN');
    
--  SELFJOIN
/*

joining a table with itself.
We join a table to itself to evaluate the rows with other rows in the same table. 
To perform the self-join, we use either an inner join or left join clause.
Because the same table appears twice in a single query, we have to use the table aliases. 

*/


SELECT 
    column1, column2, column3
FROM
    table1 A
        INNER JOIN
    table1 B ON B.column1 = A.column2;



    
SELECT 
    CONCAT(e.last_name, ' ', e.first_name) AS employee,
    CONCAT(m.last_name, ' ', m.first_name) AS manager
FROM
    employees e
        LEFT JOIN
    employees m ON e.manager_id = m.employee_id;

-- to add separate the names using commas 
SELECT 
    CONCAT(e.last_name, ', ', e.first_name) AS employee,
    CONCAT(m.last_name, ' , ', m.first_name) AS manager
FROM
    employees e
        LEFT JOIN
    employees m ON e.manager_id = m.employee_id;
    
    
-- LEFT JOIN
-- returns all rows from the left table whether or not there is a matching row in the right table.

SELECT 
    A.n
FROM
    A
        LEFT JOIN
    B ON B.n = A.n;


SELECT 
    c.country_id, country_name, city
FROM
    countries c
        LEFT JOIN
    locations l ON l.country_id = c.country_id;
    
SELECT 
    c.country_id, country_name, city
FROM
    locations l
        LEFT JOIN
    countries c ON l.country_id = c.country_id;
    
SELECT 
    r.region_id, region_name, country_name, state_province, city
FROM
    countries c
        LEFT JOIN
    locations l ON l.country_id = c.country_id
        RIGHT JOIN
    regions r ON r.region_id = c.region_id;
    
SELECT 
    r.region_name, c.country_name, l.street_address, l.city
FROM
    regions r
        LEFT JOIN
    countries c ON c.region_id = r.region_id
        LEFT JOIN
    locations l ON l.country_id = c.country_id
WHERE
    c.country_id IN ('US' , 'UK', 'CN');
    
    
-- COMPOUND JOIN
-- join that involves multiple conditions, 
-- or multiple columns being used as the criteria for joining two tables

SELECT 
    columns
FROM
    table1
        JOIN
    table2 ON table1.column1 = table2.column1
        AND table1.column2 = table2.column2;




    
    


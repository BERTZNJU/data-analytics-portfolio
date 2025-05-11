/* 
A subquery is a query nested inside another query 
such as SELECT, INSERT, UPDATE, or DELETE statement.
The subquery can be used in many places such as:

With the IN or NOT IN operator
With comparison operators
With the EXISTS or NOT EXISTS operator
With the ANY or ALL operator
 in the FROM clause
 in the SELECT clause
*/

USE humanresource;

SELECT 
    first_name,
    last_name,
    YEAR(hire_date) year_hired,
    salary,
    department_name,
    job_title
FROM
    employees e
        JOIN
    (SELECT 
        department_id, department_name
    FROM
        departments) d ON d.department_id = e.department_id
        JOIN
    (SELECT 
        job_id, job_title
    FROM
        jobs) j ON j.job_id = e.job_id
ORDER BY salary DESC;




SELECT 
    first_name, last_name, YEAR(hire_date) year_hired, salary
FROM
    employees
WHERE
    department_id IN (SELECT 
            department_id
        FROM
            departments
        WHERE
            department_id IN (1 , 3));
            
SELECT 
    first_name, last_name, YEAR(hire_date) year_hired, salary
FROM
    employees
WHERE
    department_id IN (SELECT 
            department_id
        FROM
            departments
        WHERE
            department_id NOT IN (4 , 5, 7))
ORDER BY last_name DESC;

SELECT 
    first_name,
    last_name,
    YEAR(hire_date) year_hired,
    salary,
    department_name
FROM
    employees e
        JOIN
    departments d USING (department_id)
WHERE
    department_id IN (SELECT 
            department_id
        FROM
            departments
        WHERE
            department_id NOT IN (1 , 3, 5))
        AND salary > 10000
ORDER BY salary DESC;


SELECT 
    first_name, last_name, salary
FROM
    employees
WHERE
    salary = (SELECT 
            MAX(salary)
        FROM
            employees);
            
            
            
SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employees);
            
	
    
SELECT 
    department_name
FROM
    departments d
WHERE
    EXISTS( SELECT 
            1
        FROM
            employees e
        WHERE
            salary >= 10000
                AND e.department_id = d.department_id);


SELECT 
    first_name, last_name, salary
FROM
    employees e
WHERE
    EXISTS( SELECT 
            0
        FROM
            departments d
        WHERE
            d.department_id = e.department_id
                AND salary BETWEEN 12000 AND 15000);
                
                
SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary >= ALL (SELECT 
            MIN(salary)
        FROM
            employees
        GROUP BY department_id)
ORDER BY first_name , last_name;

SELECT 
    first_name, last_name, salary, department_id
FROM
    employees
WHERE
    salary < (SELECT 
            AVG(salary)
        FROM
            employees)
ORDER BY salary DESC;

                

USE sql_store;
SELECT DISTINCT
    customer_id, first_name, last_name
FROM
    customers c
        JOIN
    orders o USING (customer_id)
        JOIN
    order_items oi USING (order_id)
WHERE
    product_id = 3;
    
USE sql_invoicing;


SELECT 
    invoice_id, client_id
FROM
    invoices
WHERE
    invoice_total > ALL (SELECT 
            invoice_total
        FROM
            invoices
        WHERE
            client_id = 3);
            
USE HUMANRESOURCE;

SELECT 
    employee_id, first_name, last_name
FROM
    employees e
WHERE
    EXISTS( SELECT 
            1
        FROM
            dependents d
        WHERE
            e.employee_id = d.employee_id)
;

use invoicing;

SELECT 
    *
FROM
    clients c
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            invoices i
        WHERE
            c.client_id = i.client_id);
 
 USE sql_store;
SELECT 
    *
FROM
    products p
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            order_items
        WHERE
            p.product_id = product_id);


            

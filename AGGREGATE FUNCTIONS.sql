
SELECT 
    column_name, AGGREGATE_FUNCTION(c2)
FROM
    table_name
GROUP BY column_name;


-- Aggregate functions and JOINS 

SELECT 
    department_name, ROUND(AVG(salary)) average_salary
FROM
    employees e
        JOIN
    departments d ON d.department_id = e.department_id
GROUP BY department_name
ORDER BY average_salary DESC;


-- Aggregate functions and JOINS with USING  

SELECT 
    department_name, ROUND(AVG(salary)) average_salary
FROM
    employees e
        JOIN
    departments d USING (department_id)
GROUP BY department_name;

-- Aggregate functions and JOINS with subquery  

SELECT 
    department_name,
    ROUND(MAX(salary)) maximum_salary,
    ROUND(AVG(salary)) average_salary
FROM
    employees e
        JOIN
    (SELECT 
        department_id, department_name
    FROM
        departments) d ON d.department_id = e.department_id
GROUP BY department_name;

SELECT 
    department_name,
    ROUND(AVG(salary)) 'Average Salary',
    ROUND(MIN(salary)) Minimum,
    ROUND(MAX(salary)) Maximum
FROM
    employees e
        JOIN
    (SELECT 
        department_name, department_id
    FROM
        departments) d ON d.department_id = e.department_id
GROUP BY department_name
ORDER BY AVG(salary) DESC;

SELECT 
    department_name, SUM(salary)
FROM
    employees e
        JOIN
    departments d ON d.department_id = e.department_id
GROUP BY department_name
ORDER BY department_name ASC;

SELECT 
    department_name,
    ROUND(SUM(salary)) Sum,
    ROUND(AVG(salary)) Average,
    ROUND(MAX(salary)) Maximum
FROM
    employees e
        JOIN
    departments d ON d.department_id = e.department_id
WHERE
    AVG(salary) < 5000
GROUP BY department_name
ORDER BY department_name ASC;


SELECT 
    department_name, COUNT(*) headcount
FROM
    employees
        INNER JOIN
    departments USING (department_id)
GROUP BY department_name
ORDER BY department_name;


-- Aggregate functions with HAVING clause to filter 
-- HAVING - after GROUP BY 
-- only selected columns are referenced


SELECT 
    department_name, ROUND(AVG(salary)) average_salary
FROM
    employees e
        JOIN
    departments d USING (department_id)
GROUP BY department_name
HAVING COUNT(*) < 10
;


-- Aggregate function using WHERE 
-- Filter data before rows are GROUPED
-- any column can be referenced whether selected or not


-- select the departments with at least 5 employees
USE humanresource;

SELECT 
    department_id, d.department_name, COUNT(*) head_count
FROM
    employees e
        JOIN
    departments d USING (department_id)
GROUP BY department_id , department_name
HAVING head_count >= 5
ORDER BY head_count DESC
;


USE sql_store;
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM
    customers c
        JOIN
    orders o USING (customer_id)
        JOIN
    order_items oi USING (order_id)
WHERE
    state = 'VA'
GROUP BY c.customer_id , c.first_name , c.last_name
HAVING total_sales > 100;


USE sql_invoicing;

SELECT 
    'First half of 2019' AS date_range,
    ROUND(SUM(invoice_total)) AS total_sales,
    ROUND(SUM(payment_total)) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM
    invoices
WHERE
    invoice_date BETWEEN '2019-01-01' AND '2019-06-30' 
UNION SELECT 
    'Second half of 2019' AS date_range,
    ROUND(SUM(invoice_total)) AS total_sales,
    ROUND(SUM(payment_total)) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM
    invoices
WHERE
    invoice_date BETWEEN '2019-07-01' AND '2019-12-31' 
UNION SELECT 
    'Total' AS date_range,
    ROUND(SUM(invoice_total)) AS total_sales,
    ROUND(SUM(payment_total)) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM
    invoices
WHERE
    invoice_date BETWEEN '2019-01-01' AND '2019-12-31'
;

SELECT 
    date,
    pm.name AS payment_method,
    SUM(amount) AS total_payments
FROM
    payments p
        JOIN
    payment_methods pm ON pm.payment_method_id = p.payment_method
GROUP BY date , payment_method
ORDER BY date;

SELECT 
    client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(*) AS number_of_invoices
FROM
    invoices
GROUP BY client_id
HAVING total_sales > 500;

-- ROLLUP

SELECT 
    department_name, COUNT(*) employee_count
FROM
    employees e
        JOIN
    departments d ON e.department_id = d.department_id
GROUP BY department_name WITH ROLLUP;


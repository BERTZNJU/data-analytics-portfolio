/*
window_function_name ( expression ) OVER (
    partition_clause
    order_clause
    frame_clause
) */



SELECT DISTINCT
    e.department_id,
    department_name,
    ROUND(SUM(salary) OVER(PARTITION BY department_name)) 'total',
    ROUND(MIN(salary) OVER(PARTITION BY department_name)) 'minimum',
    ROUND(MAX(salary) OVER(PARTITION BY department_name)) 'maximum',
    ROUND(AVG(salary) OVER(PARTITION BY department_name)) 'average'
FROM
    employees e JOIN departments d ON d.department_id = e.department_id;
    
    
    
--  count employees by department 
SELECT DISTINCT
    e.department_id,
	department_name,
	COUNT(*) OVER(PARTITION BY department_id ) dept_cnt FROM employees e
JOIN departments d ON d.department_id = e.department_id;

-- OR --

SELECT 
    d.department_name, COUNT(e.employee_id) AS employee_count
FROM
    departments d
        JOIN
    employees e ON d.department_id = e.department_id
GROUP BY d.department_name;


-- show salary per employee & avg salary per department
SELECT 
	last_name,department_name,
	ROUND(salary) salary, 
    ROUND(AVG(salary) OVER(PARTITION BY department_name)) dept_avg 
FROM 
	employees e
JOIN departments d ON d.department_id = e.department_id;


-- rank employee by salary 
-- RANK and DENSE_RANK function  -> ORDER BY ASC OR DESC 

SELECT 
	d.department_name,
	ROUND(salary) salary,
	RANK() OVER (ORDER BY salary DESC) 'salary rank' 
FROM 
	employees e 
JOIN departments d ON d.department_id = e.department_id;


SELECT 
	d.department_name,
	ROUND(salary) salary,
	DENSE_RANK() OVER (ORDER BY salary DESC) 'salary rank' 
FROM 
	employees e JOIN departments d ON d.department_id = e.department_id;


-- compare salaries based on hire dates

SELECT 
	job_title,
	department_name,
	salary,
	LEAD(salary) OVER(ORDER BY salary DESC) next_salary
	FROM employees e 
JOIN jobs USING(job_id)
JOIN departments USING(department_id);

SELECT 
	job_title,
	department_name,
	salary,
	LAG(salary) OVER(ORDER BY salary ASC) next_salary
FROM 
	employees e 
JOIN jobs USING(job_id)
JOIN departments USING(department_id);
    

/*
   ROW_NUMBER()
Purpose: Assigns a unique sequential integer to rows within a partition of a result set.
Behavior with Ties: Always assigns a unique number to each row, 
even if there are ties in the ordering criteria.
Usage: When you need a unique identifier for each row within the partition, 
regardless of duplicates in the ordering criteria 
*/

SELECT 
	last_name,
	first_name,
	salary,
	department_name,
	ROW_NUMBER() OVER(PARTITION BY department_name ORDER BY salary DESC)rnk_num
FROM 
	employees
JOIN departments d USING (department_id);






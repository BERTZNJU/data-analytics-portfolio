USE sql_store;

DROP PROCEDURE IF EXISTS SaleStatistics; 

DELIMITER $$

CREATE PROCEDURE SaleStatistics (
	IN product_id INT,
    IN start_date DATE,
    IN end_date DATE
)
BEGIN 
    SELECT 
        DATE_FORMAT(order_date, '%Y %M') AS order_month, 
        p.product_id,
        p.name,
        COUNT(oi.quantity) AS quantity_sold,
        SUM(oi.unit_price * oi.quantity) AS total_sales,
        MAX(oi.unit_price * oi.quantity) AS highest_sale,
        MIN(oi.unit_price * oi.quantity) AS lowest_sale
    FROM 
        products p
        JOIN order_items oi USING (product_id)
        JOIN orders o USING (order_id)
    WHERE 
        (p.product_id = product_id OR product_id IS NULL)  -- Allows filtering by specific product or all products
        AND o.order_date BETWEEN start_date AND end_date
    GROUP BY 
        order_month, 
        p.product_id, 
        p.name
    ORDER BY 
        order_month, 
        p.product_id;
END $$

DELIMITER ;

USE humanresource; -- employee years of service

DROP PROCEDURE  IF EXISTS EmployeeAnniversary;

DELIMITER $$

CREATE PROCEDURE EmployeeAnniversary(
    IN p_ref_date DATE,
    IN p_filter VARCHAR(20),
    IN p_employee_id INT
)
BEGIN
    SELECT 
        e.employee_id,
        CONCAT(e.first_name, '  ', SUBSTRING(e.last_name, 1, 1),  '.') AS employee_name,
        j.job_title,
        d.department_name,
        TIMESTAMPDIFF(YEAR, e.hire_date, p_ref_date) AS anniversary_years
    FROM employees e
    JOIN jobs j ON e.job_id = j.job_id
    JOIN departments d ON e.department_id = d.department_id
    WHERE 
        (p_employee_id IS NULL OR p_employee_id = e.employee_id)
      AND (
            p_filter = 'ALL'
         OR (p_filter = 'TODAY' 
             AND MONTH(e.hire_date) = MONTH(p_ref_date)
             AND DAY(e.hire_date) = DAY(p_ref_date))
         OR (p_filter = 'MONTH' 
             AND MONTH(e.hire_date) = MONTH(p_ref_date))
      )
	ORDER BY anniversary_years DESC;
    
END $$



    
    
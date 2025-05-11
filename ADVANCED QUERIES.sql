USE sql_store;

SELECT 
    name,
    oi.unit_price,
    MONTHNAME(order_date) AS order_month,
    SUM(quantity) AS total_quantity_per_order,
    COUNT(*) AS product_count,
    SUM(quantity * oi.unit_price) AS total_order_amount
FROM
    orders o
        JOIN
    order_items oi USING (order_id)
        JOIN
    products p USING (product_id)
GROUP BY MONTHNAME(order_date) , name , unit_price
ORDER BY MONTHNAME(order_date);


SELECT 
    name,
    oi.unit_price,
    DATE_FORMAT(order_date, '%M %D %Y') AS order_month_day,
    SUM(quantity) AS total_quantity_per_order,
    COUNT(*) AS product_count,
    SUM(quantity * oi.unit_price) AS total_order_amount
FROM
    orders o
        JOIN
    order_items oi USING (order_id)
        JOIN
    products p USING (product_id)
GROUP BY DATE_FORMAT(order_date, '%M %D %Y') , name , unit_price
ORDER BY DATE_FORMAT(order_date, '%M %D %Y');


SELECT 
    name,
    oi.unit_price,
    DATE_FORMAT(order_date, '%M %D %Y') AS order_month_day,
    SUM(quantity) AS total_quantity_per_order,
    COUNT(*) AS product_count,
    SUM(quantity * oi.unit_price) AS total_order_amount
FROM
    orders o
        JOIN
    order_items oi USING (order_id)
        JOIN
    products p USING (product_id)
GROUP BY DATE_FORMAT(order_date, '%M %D %Y') , name , unit_price
HAVING SUM(quantity * oi.unit_price) > 50
ORDER BY DATE_FORMAT(order_date, '%M %D %Y');

SELECT 
    DATE_FORMAT(order_date, '%Y %M %d') order_date,
    p.product_id,
    name,
    oi.unit_price,
    SUM(quantity) total_qty_ordered,
    SUM(oi.unit_price * quantity) total_sales_amt
FROM
    products p
        JOIN
    order_items oi USING (product_id)
        JOIN
    orders o USING (order_id)
WHERE
    EXTRACT(YEAR FROM order_date) = '2018'
GROUP BY DATE_FORMAT(order_date, '%Y %M %d') , p.product_id , name , oi.unit_price
ORDER BY DATE_FORMAT(order_date, '%Y %M %d') DESC;
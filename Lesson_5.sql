USE lesson_5;

CREATE TABLE sales(
	sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee, fiscal_year)
);
INSERT INTO sales(sales_employee, fiscal_year, sale)
VALUES
('Bob', 2016, 100),
('Bob', 2017, 150),
('Bob', 2018, 200),
('Alice', 2016, 150),
('Alice', 2017, 100),
('Alice', 2018, 200),
('John', 2016, 200),
('John', 2017, 150),
('John', 2018, 250);

SELECT * FROM sales;

-- Пример агрегатной функции 

SELECT fiscal_year, SUM(sale) FROM sales GROUP BY fiscal_year;

CREATE TABLE Orders(
	Date DATE,
	Medium VARCHAR(50) NOT NULL,
    Conversions INT NOT NULL
);
INSERT INTO Orders(Date, Medium, Conversions)
VALUES
('2020-05-10', 'cpa', 1),
('2020-05-10', 'cpc', 2),
('2020-05-10', 'organic', 1),
('2020-05-11', 'cpa', 1),
('2020-05-11', 'cpc', 3),
('2020-05-11', 'organic', 2),
('2020-05-11', 'direct', 1),
('2020-05-12', 'cpc', 1),
('2020-05-12', 'organic', 2);

SELECT * FROM Orders;

SELECT Date, Medium, Conversions,
SUM(Conversions) OVER() AS 'Sum' 
FROM Orders;

-- PARTITION BY

SELECT Date, Medium, Conversions,
SUM(Conversions) OVER(PARTITION BY Date) AS 'Sum' 
FROM Orders;

SELECT Date, Medium, Conversions,
SUM(Conversions) OVER(PARTITION BY Date ORDER BY Medium) AS 'Sum' 
FROM Orders;

-- ROWS и RANGE 

SELECT Date, Medium, Conversions,
SUM(Conversions) OVER(PARTITION BY Date ORDER BY Conversions ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) 
AS 'Sum' 
FROM Orders;

-- Пример использования агрегатных функций с оконной конструкцией OVER:

SELECT Date, Medium, Conversions,
SUM(Conversions) OVER(PARTITION BY Date) AS 'Sum',
COUNT(Conversions) OVER(PARTITION BY Date) AS 'Count',
AVG(Conversions) OVER(PARTITION BY Date) AS 'Avg',
MAX(Conversions) OVER(PARTITION BY Date) AS 'Max',
MIN(Conversions) OVER(PARTITION BY Date) AS 'Min'
FROM Orders;

-- Ранжирующие функции

SELECT Date, Medium, Conversions,
ROW_NUMBER()
OVER(PARTITION BY Date ORDER BY Conversions) AS 'Row_number',
RANK()
OVER(PARTITION BY Date ORDER BY Conversions) AS 'Rank',
DENSE_RANK()
OVER(PARTITION BY Date ORDER BY Conversions) AS 'Dense_Rank',
NTILE(3)
OVER(PARTITION BY Date ORDER BY Conversions) AS 'Ntile'
FROM Orders;

-- Функции смещения

SELECT Date, Medium, Conversions,
LAG(Conversions) OVER(PARTITION BY Date ORDER BY Date) AS 'Lag',
LEAD(Conversions) OVER(PARTITION BY Date ORDER BY Date) AS 'Lead',
FIRST_VALUE(Conversions) OVER(PARTITION BY Date ORDER BY Date) AS 'First_Value',
LAST_VALUE(Conversions) OVER(PARTITION BY Date ORDER BY Date) AS 'Last_Value'
FROM Orders;

-- Представления

CREATE TABLE customer_archive(
	Customer_id INT,
	Customer_name VARCHAR(50) NOT NULL,
    Contact_no DECIMAL,
    Email VARCHAR(50),
    Purchased_amount FLOAT,
    City VARCHAR(50)
);
INSERT INTO customer_archive(Customer_id, Customer_name, Contact_no, Email, Purchased_amount, City)
VALUES
(184, 'Ravi Kumar', 9887463893, 'ravi@gmail.com', 8000.00, 'Kolkata'),
(987, 'Vinay Das', 9839878678, 'vinay@yahoo.in', 12000.00, 'Delhi'),
(452, 'K.Amarnath', 7598759387, 'amar@gmail.com', 15000.00, 'Kolkata'),
(874, 'Abhinash Desai', 7675878798, 'desai@gmail.com', 5000.00, 'Mumbai');
SELECT * FROM customer_archive;

CREATE VIEW customer_archive1 AS 
SELECT Customer_id, Customer_name, Contact_no, Email, Purchased_amount, City
FROM customer_archive
WHERE Purchased_amount > 10000;
SELECT * FROM customer_archive1;

-- Удаление виртуальной таблицы 

DROP VIEW customer_archive1;

-- Удаление таблицы

USE lesson_4;

DROP TABLE test;

-- Изменение представлений
-- Добавим новую колонку product_name

ALTER TABLE customer_archive ADD COLUMN Prouct_name VARCHAR(50);
ALTER TABLE customer_archive DROP COLUMN Prouct_name;
SELECT * FROM customer_archive;



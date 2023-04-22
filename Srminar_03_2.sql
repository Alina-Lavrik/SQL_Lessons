USE lesson_1;

/* 1.	Рассчитайте общее количество всех страниц dialy_typing_pages

2.	Выведите общее количество напечатанных страниц каждым человеком 
(с помощью предложения GROUP BY)  

3.	Посчитайте количество записей в таблице

4.	Выведите количество имен, которые являются уникальными 

5. 	Найдите среднее арифметическое по количеству ежедневных страниц 
для набора (daily_typing_pages) */

CREATE TABLE employee_tbl (
	id_emp INT AUTO_INCREMENT PRIMARY KEY,
	id INT NOT NULL,
	name VARCHAR(50) NOT NULL,
	work_date DATE,
	daily_typing_pages INT
);
SELECT * FROM employee_tbl;
-- Наполнение данными
INSERT INTO employee_tbl (id, name, work_date, daily_typing_pages)
VALUES
(1, 'John', '2007-01-24', 250),
(2, 'Ram',  '2007-05-27', 220),
(3, 'Jack', '2007-05-06', 170),
(3, 'Jack', '2007-04-06', 100),
(4, 'Jill', '2007-04-06', 220),
(5, 'Zara', '2007-06-06', 300),
(5, 'Zara', '2007-02-06', 350);
SELECT * FROM employee_tbl;
-- 1
SELECT SUM(daily_typing_pages) AS 'summ' FROM employee_tbl;

-- 2
SELECT name AS 'имя', SUM(daily_typing_pages) AS 'сумма' FROM employee_tbl
GROUP BY name;

-- 3
SELECT COUNT(*) AS 'Коол-во' FROM employee_tbl;
SELECT COUNT(id) AS 'Коол-во' FROM employee_tbl;
SELECT COUNT('hi') AS 'Коол-во' FROM employee_tbl;

-- 4
SELECT COUNT(DISTINCT name) FROM employee_tbl;

-- 5
SELECT AVG(daily_typing_pages) FROM employee_tbl;
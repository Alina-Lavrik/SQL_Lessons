USE gallery;

SELECT * FROM staff;

-- 1. Отсортируйте поле “зарплата” в порядке убывания и возрастания

SELECT salary FROM staff ORDER BY salary ASC;
SELECT salary FROM staff ORDER BY salary DESC;

-- 2. Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с наибольшей заработной платой (возможен подзапрос)

SELECT salary FROM staff ORDER BY salary DESC LIMIT 5;

-- 3. Выполните группировку всех сотрудников по специальности , суммарная зарплата которых превышает 100000 

SELECT post FROM staff GROUP BY post HAVING SUM(salary) > 100000;
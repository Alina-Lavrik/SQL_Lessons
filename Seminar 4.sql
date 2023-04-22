USE lesson_4;

CREATE TABLE members
(
member_id INT AUTO_INCREMENT,
name VARCHAR (100) ,
PRIMARY KEY (member_id)
);

CREATE TABLE committees
(
committee_id INT AUTO_INCREMENT,
name VARCHAR (100),
PRIMARY KEY (committee_id)
);

INSERT INTO members (name)
VALUES("John"), ("Jane"), ("wary"), ("David"), ("2melia");
INSERT INTO committees (name)
VALUES ("John"), ("Mary"), ("Amelial"), ("Joe");
SELECT * FROM members;
SELECT * FROM committees;

/* Задание:
Выведите участников, которые также являются членами комитета, 
используйте INNER JOIN (пересечение 2 таблиц по имени); */

SELECT * FROM members
INNER JOIN committees
USING(name);

-- FULL JOIN

-- Создание таблицы с товарами
   CREATE TABLE products1 (
     product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
     category INT NULL,
     product_name VARCHAR(100) NOT NULL
   );

   -- Создание таблицы с категориями
   CREATE TABLE categories (
     category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
     category_name VARCHAR(100) NOT NULL
   );

   -- Добавление данных в таблицу с товарами
   INSERT INTO products1(category, product_name)
     VALUES (1, 'Системный блок'),
            (1, 'Монитор'),
            (2, 'Холодильник'),
            (2, 'Телевизор'),
            (NULL, 'Операционная система');

   -- Добавление данных в таблицу с категориями
   INSERT INTO categories (category_name)
     VALUES ('Комплектующие компьютера'),
            ('Бытовая техника'),
            ('Мобильные устройства');
SELECT * FROM products1;
SELECT * FROM categories;
SELECT p.product_name, c.category_name
FROM products1 p
LEFT JOIN categories c
ON p.category = c.category_id
UNION
SELECT p.product_name, c.category_name
FROM products1 p
RIGHT JOIN categories c
ON p.category = c.category_id;

/* Задание:
1.	Выведите участников, которые являются членами комитета 
(Используя LEFT JOIN, выполните соединение двух таблиц  по полю “Имя”)
2.* 	Выведите участников, которые не являются членами комитета */

SELECT * FROM committees 
LEFT JOIN members USING(name) WHERE members.name IS NULL;

/*Задание:
1. 	Найти членов комитета, которых нет в members с помощью RIGHT JOIN
2.	Выполнить RIGHT JOIN между 2 таблицами по полю “Имя” */

SELECT * FROM committees
RIGHT JOIN members
USING(name) WHERE committees.name IS NULL;

SELECT * FROM committees 
RIGHT JOIN members 
USING(name);

--

CREATE TABLE t1(
    id INT PRIMARY KEY
);

CREATE TABLE t2 (
    id INT PRIMARY KEY
);

INSERT INTO t1 VALUES (1),(2),(3);
INSERT INTO t2 VALUES (2),(3),(4); -- UNION
SELECT id FROM t1
UNION
SELECT id FROM t2;

/* Задание:
1.	Получить список пользователей и клиентов, удалив одинаковых клиентов и пользователей
2.	Получить список пользователей и клиентов. Дубликаты удалять не нужно */

create table users
(
    id  int auto_increment primary key,
    login varchar(255) null,
    pass  varchar(255) null,
    male  tinyint      null
);

create table clients
(
    id    int auto_increment primary key,
    login varchar(255) null,
    pass  varchar(255) null,
    male  tinyint      null
);
INSERT INTO users (login, pass, male) VALUES ('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1),
('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1),
('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2),
('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1),
('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2),
('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);

INSERT INTO clients (login, pass, male) 
VALUES 
('alexander', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1),
('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1),
('Olia', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2),
('Dmitry', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1),
('Margaret', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2),
('Leonid', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1),
('Mikle', '$ws$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1),
('Olga', '$2y$10$88zbBCKLJklStIgTqBKIluijJUnbeZ5WqJI4RJgkksnFZon5kH14y', 2),
('Tom', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH20y', 1),
('Masha', '$2y$20$6SzbBCNRNklStIgTqBKIluijJUnbeZ4wqIu4RJgkksnFZon5kH20y', 2),
('alex', '$2y$10$6SzbBCMENklStIgTqBKIluijJUnbeZ5WqIu4RJgkksnFZon5kH14y', 1);

-- 1 
-- UNION удаляет повторяющиеся строки при объедении таблиц
SELECT * FROM users
UNION SELECT * FROM clients;

-- UNION ALL ( без удаления дубликатов)

SELECT * FROM users
UNION ALL SELECT * FROM clients;

-- IN 
/* Проверьте, присутствует ли буква “А” в последовательности 'A', 'B', 'C', 'D' 
Проверьте, присутствует ли буква “Z” в последовательности 'A', 'B', 'C', 'D' 
Получить столбцы из таблицы “clients” , в которых первое имя является набором значений.
Выберите все логины из таблицы “users”, кроме “Mikle”. */

SELECT "A" IN ('A', 'B', 'C', 'D' ); -- 1
SELECT "Z" IN ('A', 'B', 'C', 'D' ); -- 0

SELECT * FROM clients
WHERE login IN ('Mikle', 'Tom', 'Masha');

SELECT * FROM clients
WHERE login NOT IN ('Mikle');

-- EXISTS

CREATE TABLE Employee (
  Id INT PRIMARY KEY,
  Name VARCHAR(45) NOT NULL,
  Department VARCHAR(45) NOT NULL,
  Salary FLOAT NOT NULL,
  Gender VARCHAR(45) NOT NULL,
  Age INT NOT NULL,
  City VARCHAR(45) NOT NULL
);
INSERT INTO Employee (Id, `Name`, Department, Salary, Gender, Age, City) 
VALUES 
(1001, 'John Doe', 'IT', 35000, 'Male', 25, 'London'),
(1002, 'Mary Smith', 'HR', 45000, 'Female', 27, 'London'),
(1003, 'James Brown', 'Finance', 50000, 'Male', 28, 'London'),
(1004, 'Mike Walker', 'Finance', 50000, 'Male', 28, 'London'),
(1005, 'Linda Jones', 'HR', 75000, 'Female', 26, 'London'),
(1006, 'Anurag Mohanty', 'IT', 35000, 'Male', 25, 'Mumbai'),
(1007, 'Priyanla Dewangan', 'HR', 45000, 'Female', 27, 'Mumbai'),
(1008, 'Sambit Mohanty', 'IT', 50000, 'Male', 28, 'Mumbai'),
(1009, 'Pranaya Kumar', 'IT', 50000, 'Male', 28, 'Mumbai'),
(1010, 'Hina Sharma', 'HR', 75000, 'Female', 26, 'Mumbai');
SELECT * FROM Employee;

CREATE TABLE Projects (
 ProjectId INT PRIMARY KEY AUTO_INCREMENT,
      Title VARCHAR(200) NOT NULL,
     ClientId INT,
 EmployeeId INT,
     StartDate DATETIME,
     EndDate DATETIME
);
INSERT INTO Projects ( Title, ClientId, EmployeeId, StartDate, EndDate) VALUES 
('Develop ecommerse website from scratch', 1, 1003, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY)),
('WordPress website for our company', 1, 1002, NOW(), DATE_ADD(NOW(), INTERVAL 45 DAY)),
('Manage our company servers', 2, 1007, NOW(), DATE_ADD(NOW(), INTERVAL 45 DAY)),
('Hosting account is not working', 3, 1009, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY)),
('MySQL database from my desktop application', 4, 1010, NOW(), DATE_ADD(NOW(), INTERVAL 15 DAY)),
('Develop new WordPress plugin for my business website', 2, NULL, NOW(), DATE_ADD(NOW(), INTERVAL 10 DAY)),
('Migrate web application and database to new server', 2, NULL, NOW(), DATE_ADD(NOW(), INTERVAL 5 DAY)),
('Android Application development', 4, 1004, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY));
SELECT * FROM Projects;

/* 1.	Получите из таблицы "Сотрудники" только тех сотрудников, которые в данный момент работают над любым из активных проектов.

2.	Проверьте, существует ли сотрудник с идентификатором 1004 в таблице сотрудников или нет.*/

SELECT * FROM Employee
WHERE EXISTS (SELECT * FROM Projects
WHERE Employee.id = Projects.EmployeeID);

SELECT EXISTS (SELECT 'Name' FROM Employee WHERE id = 1004) AS res;
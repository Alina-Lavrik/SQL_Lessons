USE lesson_4;

CREATE TABLE Customers
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
	AccountSum DECIMAL
);
CREATE TABLE Empoyees
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL
);

INSERT INTO Customers(FirstName, LastName, AccountSum)
VALUES
('Tom', 'Smith', 2000),
('Sam', 'Brown', 3000),
('Mark', 'Adams', 2500),
('Paul', 'Ins', 4200) ,
('John', 'Smith', 2800),
('Tim', 'Cook', 2800);

SELECT * FROM Customers;

INSERT INTO Empoyees(FirstName, LastName)
VALUES
('Nikhil', 'Delhi'),
('Divya', 'Ranchi'),
('Ravi', 'Barailly'),
('Anna', 'Noida'),
('Surbhi', 'Jaipur');

SELECT * FROM Empoyees;

-- UNION удаляет повторяющиеся строки при объедении таблиц
SELECT FirstName, LastName
FROM Customers
UNION SELECT FirstName, LastName FROM Empoyees
ORDER BY FirstName;  -- отсортировали по полю FirstName

-- UNION ALL ( без удаления дубликатов)

SELECT FirstName, LastName
FROM Customers
UNION ALL SELECT FirstName, LastName FROM Empoyees
ORDER BY FirstName;

/* UNION в пределах одной таблицы. Начисление процентов на вклад:
Если сумма меньше 3000, то начисляются проценты в размере 10% от суммы на счете. 
Если на счете больше 3000, то проценты увеличиваются до 30% */

SELECT FirstName, LastName, AccountSum + AccountSum * 0.1 AS TotalSum
FROM Customers WHERE AccountSum < 3000
UNION SELECT FirstName, LastName, AccountSum + AccountSum * 0.3 AS TotalSum
FROM Customers WHERE AccountSum >= 3000;

-- INNER JOIN общее из 2 таблиц 

CREATE TABLE Products
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
	ProductCount INT DEFAULT 0,
    Price DECIMAL NOT NULL
);
CREATE TABLE NewCustomers
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	FirstName VARCHAR(20) NOT NULL
);
CREATE TABLE Orders
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    ProductId INT NOT NULL,
    CustomerId INT NOT NULL,
    CreatedAt INT NOT NULL,
	ProductCount INT DEFAULT 1,
    Price DECIMAL NOT NULL,
    FOREIGN KEY (ProductId) REFERENCES Products(id) ON DELETE CASCADE,
    FOREIGN KEY (CustomerId) REFERENCES NewCustomers(id) ON DELETE CASCADE
);
INSERT INTO Products(ProductName, Manufacturer, ProductCount, Price)
VALUES
('iPhone X', 'Apple', 3, 76000),
('iPhone 8', 'Apple', 2, 51000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 41000),
('P20 Pro', 'Huawei', 5, 36000);
INSERT INTO NewCustomers(FirstName)
VALUES
('Alex'),
('Mikle'),
('Albert'),
('Sasha'),
('Poll');
INSERT INTO Orders(ProductId, CustomerId, CreatedAt, ProductCount, Price)
VALUES
(1, 1, 2020-05-02, 1, 76000),
(2, 2, 2021-04-01, 1, 51000),
(3, 3, 2019-11-11, 1, 56000),
(4, 4, 2018-08-08, 1, 41000),
(5, 5, 2022-02-22, 1, 36000);
SELECT * FROM Orders;

-- Получить из табл. Orders дату открытия заказов и кол-во заказов, из табл Products имя продукта
SELECT Orders.CreatedAt, Orders.ProductCount, Products.ProductName
FROM Orders
JOIN Products ON Products.id = Orders.ProductId;

-- LEFT JOIN 
SELECT FirstName, CreatedAt, ProductCount, Price
FROM Orders LEFT JOIN NewCustomers
ON Orders.CustomerId = NewCustomers.id;

-- RIGHT JOIN
SELECT FirstName, CreatedAt, ProductCount, Price
FROM NewCustomers RIGHT JOIN Orders
ON Orders.CustomerId = NewCustomers.id;

-- FULL JOIN заменяет UNION

-- Оператор IN, выберем все товары из таблицы Products, на которые есть заказы в таблице Orders
SELECT * FROM Products
WHERE id IN (SELECT ProductId FROM Orders);

SELECT * FROM Products
WHERE id NOT IN (SELECT ProductId FROM Orders);

-- EXISTS
SELECT * FROM Products
WHERE EXISTS
(SELECT * FROM Orders WHERE Orders.ProductId = Products.id);

CREATE TABLE test
(
	Id INT, 
    Name VARCHAR(45)
);

INSERT INTO test
VALUES
(1, 'Bob'), (2, 'Tom'), (3, 'Tim');
SELECT * FROM test;

CREATE TABLE copy SELECT * FROM test;
SELECT * FROM copy;


USE lesson_5;

CREATE TABLE CARS(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	Name VARCHAR(50) NOT NULL,
    Cost INT
);
INSERT INTO CARS(Name, Cost)
VALUES ('Audi', 52642),
('Mercedes', 57127),
('Skoda', 9000),
('Volvo', 29000),
('Bentley', 35000),
('Citroen', 21000),
('Hummer', 41400),
('Volkswagen', 21600);
SELECT * FROM CARS;

-- 1.1.	Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов

CREATE VIEW Cheap_cars AS
SELECT Id, Name, Cost
FROM CARS
WHERE Cost < 25000;
SELECT * FROM Cheap_cars;

-- 1.2. Изменить в существующем представлении порог для стоимости: 
-- пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW) 

ALTER VIEW  Cheap_cars AS
SELECT Id, Name, Cost
FROM CARS
WHERE Cost < 30000;
SELECT * FROM Cheap_cars;

-- 1.3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”

CREATE VIEW Two_models AS
SELECT * FROM CARS
WHERE Name IN ('Skoda', 'Audi');
SELECT * FROM Two_models;

-- 2. 

CREATE TABLE Analysis(
	an_id INT,
	an_name VARCHAR(50) NOT NULL,
    an_cost INT,   # себестоимость
    an_price INT,
    an_group INT
);
CREATE TABLE Groups_analysis(
	gr_id INT,
	gr_name VARCHAR(50) NOT NULL,
    gr_temp VARCHAR(20)
);
CREATE TABLE Orders_new(
	ord_id INT,
	ord_datetime DATETIME,
    ord_an INT   # an_id анализа
);
INSERT INTO Analysis(an_id, an_name, an_cost, an_price, an_group)
VALUES
(11, 'ОАК', 200, 400, 1),
(12, 'Биохимический', 400, 600, 1),
(13, 'Гормональныйий', 800, 1200, 1),
(14, 'Серологический', 600, 1000, 1),
(15, 'Иммунология', 1000, 2000, 1);
SELECT * FROM Analysis;

INSERT INTO Groups_analysis(gr_id, gr_name, gr_temp)
VALUES
(1, 'Кровь', 'от 10 до 15'),
(2, 'Моча', 'от 10 до 15'),
(3, 'Соскоб', 'от 10 до 15');
SELECT * FROM Groups_analysis;

INSERT INTO Orders_new(ord_id, ord_datetime, ord_an)
VALUES
(100, '2020-01-14 10:00:00', 11),
(101, '2020-01-14 11:00:00', 12),
(102, '2020-01-18 12:00:00', 12),
(103, '2020-01-22 13:00:00', 13),
(104, '2020-01-27 08:00:00', 15),
(105, '2020-02-02 08:30:00', 11),
(106, '2020-02-03 16:00:00', 11),
(107, '2020-02-04 11:00:00', 14),
(108, '2020-02-05 08:00:00', 11),
(109, '2020-02-05 12:00:00', 12),
(110, '2020-02-10 16:00:00', 13),
(111, '2020-02-11 10:00:00', 14),
(112, '2020-02-14 18:00:00', 11),
(113, '2020-02-18 16:00:00', 15);
SELECT * FROM Orders_new;

-- Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.

SELECT an_name, an_price, ord_datetime
FROM Analysis
JOIN Orders_new
ON Analysis.an_id = Orders_new.ord_an
WHERE ord_datetime BETWEEN '2020-02-05' AND '2020-02-16';

-- 3. Добавьте новый столбец под названием «время до следующей станции».

CREATE TABLE Train(
	train_id INT,
    station  VARCHAR(20),
	station_time TIME
);
INSERT INTO Train(train_id, station, station_time)
VALUES
(110, 'San Francisco', '10:00:00'),
(110, 'Redwood City', '10:54:00'),
(110, 'Palo Alto', '11:02:00'),
(110, 'San Jose', '12:35:00'),
(120, 'San Francisco', '11:00:00'),
(120, 'Palo Alto', '12:49:00'),
(120, 'San Jose',  '13:30:00');
SELECT * FROM Train;

SELECT *,
SUBTIME(LEAD(station_time, 1) OVER(PARTITION BY train_id ORDER BY train_id), station_time)
AS 'time to next station'
FROM Train;

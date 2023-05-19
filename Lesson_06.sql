use lesson_6_2;

-- создаем таблицу accounts

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
	total DECIMAL (11,2) COMMENT 'Счет',
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Счета пользователей и интернет магазина';
INSERT INTO accounts (user_id, total) 
VALUES
	(4, 5000.00),
	(3, 0.00),
	(2, 200.00),
	(NULL, 25000.00);
SELECT * FROM accounts;

-- Начинаем транзакцию командой START TRANSACTION:

START TRANSACTION;
-- Далее выполняем команды, входящие в транзакцию:
	SELECT total FROM accounts WHERE user_id = 4;
	-- Убеждаемся, что на счету пользователя достаточно средств:
	UPDATE accounts SET total = total - 2000 WHERE user_id = 4;
	-- Снимаем средства со счета пользователя:
	UPDATE accounts SET total = total + 2000 WHERE user_id IS NULL;
-- Чтобы изменения вступили в
-- силу, мы должны выполнить команду COMMIT
COMMIT;
-- cкрипт выполнять полностью: начиная от первой и до самой последней строчки
SELECT * FROM accounts;

--  Чтобы отметить операцию мы можем воспользоваться командой ROLLBACK: 

START TRANSACTION;
	SELECT total FROM accounts WHERE user_id = 4;
	UPDATE accounts SET total = total - 2000 WHERE user_id = 4;
	UPDATE accounts SET total = total + 2000 WHERE user_id IS NULL;
ROLLBACK; -- Откат до исходного состояния

SELECT * FROM accounts;

/*Откат текущей транзакции может быть выполнен не к началу транзакции, а к точке сохранения.
Для работы с точками сохранения предназначены два оператора:
● SAVEPOINT
● ROLLBACK TO SAVEPOINT*/

START TRANSACTION;
	SELECT total FROM accounts WHERE user_id = 4;
	SAVEPOINT accounts_4;
	UPDATE accounts SET total = total - 2000 WHERE user_id = 4;
	-- Допустим мы хотим отменить транзакцию и вернуться в точку сохранения. В этом случае мы можем
	-- воспользоваться оператором ROLLBACK TO SAVEPOINT:
ROLLBACK TO SAVEPOINT accounts_4;
SELECT * FROM accounts;

# Переменные 

SELECT @total := COUNT(*) FROM accounts;
SELECT @total;

--  Команда SET, в отличие от оператора SELECT, не возвращает результирующую таблицу:

SET @last = NOW() - INTERVAL 5 DAY; -- от текущей даты отнять 5 дней
SELECT CURDATE(), @last;

# Временная таблица

CREATE TEMPORARY TABLE temp (id INT, name VARCHAR(255));
DESCRIBE temp; -- Показ всех столлбцов в таблице temp

# Процедуры

DELIMITER //

CREATE PROCEDURE my_version ()
BEGIN
  SELECT VERSION();
END //

-- CALL proc_name;
CALL my_version (); -- Вызов процедуры

SHOW PROCEDURE STATUS; -- Все процедуры

SHOW PROCEDURE STATUS LIKE 'my_version%'; -- Конкретная процедура
-- При использовании ключевого слова
-- LIKE можно вывести информацию только о тех процедурах, 
-- имена которых удовлетворяют шаблону

# Для удаления хранимых процедур и функций предназначены операторы DROP PROCEDURE и DROP FUNCTION

DROP PROCEDURE my_version;

DROP PROCEDURE IF EXISTS my_version;

# Функции

-- Рабочий вариант
DROP FUNCTION IF EXISTS get_version;
DELIMITER //

CREATE FUNCTION get_version ()
RETURNS TEXT DETERMINISTIC
BEGIN
	RETURN VERSION();
END//

SELECT get_version();

# Параметры процедур и функций

DELIMITER //

DROP PROCEDURE IF EXISTS set_x//
CREATE PROCEDURE set_x (IN value INT)
BEGIN
	SET @x = value;
	SET value = value - 1000;

END//
SET @y = 10000//
CALL set_x(@y)//
SELECT @x, @y// x = 10000, y =	10000

DELIMITER //

DROP PROCEDURE IF EXISTS set_x//
CREATE PROCEDURE set_x (OUT value INT)
BEGIN
	SET @x = value;
	SET value = 1000;
END//
SET @y = 10000//
CALL set_x(@y)//
SELECT @x, @y// x = NULL, y = 1000

DELIMITER //

DROP PROCEDURE IF EXISTS set_x//
CREATE PROCEDURE set_x (INOUT value INT)
BEGIN
	SET @x = value;
	SET value = value - 1000;
END//
SET @y = 10000//
CALL set_x(@y)//
SELECT @x, @y// -- x = 10000, y =	9000

DELIMITER //

DROP PROCEDURE IF EXISTS declare_var//
CREATE PROCEDURE declare_var ()
BEGIN
	DECLARE var TINYTEXT DEFAULT 'внешняя переменная';
	BEGIN
		DECLARE var TINYTEXT DEFAULT 'внутренняя переменная';
		SELECT var;
	END;
	SELECT var;
END//
CALL declare_var()//

# Ветвление

DELIMITER //

DROP PROCEDURE IF EXISTS format_now//
CREATE PROCEDURE format_now (format CHAR(4))
BEGIN
	IF(format = 'date') THEN
		SELECT DATE_FORMAT(NOW(), "%d.%m.%Y") AS format_now;
	END IF;
	IF(format = 'time') THEN
		SELECT DATE_FORMAT(NOW(), "%H:%i:%s") AS format_now;
	END IF;
END//

CALL format_now('date')//
CALL format_now('time')//

DELIMITER //

DROP PROCEDURE IF EXISTS format_now//
CREATE PROCEDURE format_now (format CHAR(4))
BEGIN
	IF(format = 'date') THEN
		SELECT DATE_FORMAT(NOW(), "%d.%m.%Y") AS format_now;
	ELSE
		SELECT DATE_FORMAT(NOW(), "%H:%i:%s") AS format_now;
	END IF;
END//


CALL format_now('date')//
CALL format_now('time')//

# Циклы

DELIMITER //
DROP PROCEDURE IF EXISTS while_cycle//
CREATE PROCEDURE while_cycle ()
BEGIN
	DECLARE i INT DEFAULT 3;
	WHILE i > 0 DO
		SELECT NOW();
		SET i = i - 1;
	END WHILE;
END//
CALL while_cycle()//

DELIMITER //
DROP PROCEDURE IF EXISTS while_cycle;
CREATE PROCEDURE while_cycle (IN num INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	IF (num > 0) THEN
		WHILE i < num DO
			SELECT NOW();
			SET i = i + 1;
		END WHILE;
	ELSE
		SELECT 'Ошибочное значение параметра';
	END IF;
END//

CALL while_cycle(2)//

DELIMITER //
DROP PROCEDURE IF EXISTS while_cycle//
CREATE PROCEDURE while_cycle (IN num INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	IF (num > 0) THEN
		cycle: WHILE i < num DO
		IF i >= 2 THEN LEAVE cycle;
		END IF;
		SELECT NOW();
		SET i = i + 1;
		END WHILE cycle;
	ELSE
		SELECT 'Ошибочное значение параметра';
	END IF;
END//
CALL while_cycle(1000)//

DELIMITER //
DROP PROCEDURE IF EXISTS numbers_string//
CREATE PROCEDURE numbers_string (IN num INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	DECLARE bin TINYTEXT DEFAULT '';
	IF (num > 0) THEN
		cycle : WHILE i < num DO
		SET i = i + 1;
		SET bin = CONCAT(bin, i);
		IF i > CEILING(num / 2) THEN ITERATE cycle;
 -- CEILING: возвращает наименьшее целое число
		END IF;
		SET bin = CONCAT(bin, i);
		END WHILE cycle;
		SELECT bin;
	ELSE
		SELECT 'Ошибочное значение параметра';
	END IF;
END//
CALL numbers_string(9)//

DELIMITER //
DROP PROCEDURE IF EXISTS repeat_cycle//
CREATE PROCEDURE repeat_cycle ()
BEGIN
	DECLARE i INT DEFAULT 3;
	REPEAT
		SELECT NOW();
		SET i = i - 1;
	UNTIL i <= 0
	END REPEAT;
END//

CALL repeat_cycle()//

/*Цикл LOOP, в отличие от операторов WHILE и REPEAT, не имеет условий выхода. Поэтому он
должен обязательно иметь в составе оператор LEAVE.
Так как мы используем оператор LEAVE, 
мы должны разместить перед ключевым словом LOOP и после END LOOP метку. 
Здесь она называется cycle.*/

DELIMITER //
DROP PROCEDURE IF EXISTS repeat_cycle//
CREATE PROCEDURE repeat_cycle ()
BEGIN
	DECLARE i INT DEFAULT 3;
	REPEAT
		SELECT NOW();
		SET i = i - 1;
	UNTIL i <= 0
	END REPEAT;
END//

CALL repeat_cycle()//


-- 1.1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
--      Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
USE sample;
INSERT INTO users SELECT * FROM shop.users WHERE id = 1;
USE shop;
DELETE FROM users WHERE id = 1;

-- 1.2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
USE shop;
CREATE VIEW presentation AS SELECT p.name AS product_name, c.name AS cat_name FROM products p JOIN catalogs c ON p.catalog_id = c.id; 
SELECT * FROM presentation;

-- 1.3. (по желанию) Пусть имеется таблица с календарным полем created_at. 
--      В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
--      Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
CREATE TABLE contacts (
  id int(11) NOT NULL AUTO_INCREMENT,
  created_at date DEFAULT NULL,
  PRIMARY KEY (id)
);
INSERT INTO contacts (created_at) VALUES ('2018-08-01'), ('2018-08-04'), ('2018-08-16'), ('2018-08-17');

DELIMITER //
    CREATE PROCEDURE mypro ()
    BEGIN
	CREATE TEMPORARY TABLE res (date_i DATE, status_id INT(10));
    SET @date_i := '2018-07-31';
    WHILE @date_i != '2018-08-31' DO
        INSERT INTO res VALUES (@date_i := DATE_ADD(@date_i, INTERVAL 1 DAY), IF(@date_i IN( SELECT created_at FROM contacts), 1, 0));
    END WHILE;
    SELECT * FROM res;
    DROP TABLE res;
END //

CALL mypro ();

-- 1.4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
--      Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
CREATE OR REPLACE VIEW posts_view AS SELECT * FROM posts ORDER BY created_at DESC LIMIT 5; -- работаем с таблицей posts базы данных vk
SELECT * FROM posts_view;
DELETE FROM posts WHERE id NOT IN (SELECT id FROM posts_view);
SELECT * FROM posts;

-- 2.1. Создайте двух пользователей которые имеют доступ к базе данных shop. 
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.

USE shop;
CREATE USER shop_read;
GRANT SELECT ON shop.* TO shop_read;

CREATE USER shop IDENTIFIED BY 'password'; -- в видеоуроке испольлзвалась конструкция "IDENTIFIED WITH sha256_password BY 'pass'", зачем нужна часть "WITH sha256_password"? 
GRANT ALL  ON shop.* TO shop;

-- 2.2. (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. 
-- Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. 
-- Создайте пользователя user_read, который бы не имел доступа к таблице accounts, однако, мог бы извлекать записи из представления username.
USE example;

CREATE TABLE accounts (id SERIAL, name VARCHAR(255), `password`  VARCHAR(255));
INSERT INTO accounts (name, `password`) VALUES ('Misha', 'hhhsdfa'), ('Igor', '4545fg'), ('Dima','adsfkuh!');

CREATE OR REPLACE VIEW usernames AS SELECT id, name FROM accounts;

CREATE USER user_read;
GRANT SELECT ON example.usernames TO user_read;

-- 3.1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //
CREATE FUNCTION hello()
RETURNS VARCHAR(255) NOT DETERMINISTIC
BEGIN
	DECLARE res VARCHAR(255);
	SET @hour_now = HOUR(NOW());
	IF (@hour_now >= '6' AND @hour_now < '12') THEN
		SET res = 'Доброе утро';
	ELSEIF (@hour_now >= '12' AND @hour_now < '18') THEN
		SET res = 'Добрый день';
	ELSEIF (@hour_now >= '18') THEN
		SET res = 'Добрый вечер';
	ELSE 
		SET res = 'Доброй ночи';
	END IF;
	RETURN res;
END//

SELECT hello();

-- 3.2.  В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

USE shop;
SELECT * FROM products;

DELIMITER //
CREATE TRIGGER null_check BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF (COALESCE(NEW.name, NEW.description) IS NULL) THEN
		SIGNAL SQLSTATE '23000' SET MESSAGE_TEXT = 'Ошибка вставки';
	END IF;
END//

DELIMITER //
CREATE TRIGGER null_check_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
	IF (COALESCE(NEW.name, NEW.description) IS NULL) THEN
		SIGNAL SQLSTATE '11000' SET MESSAGE_TEXT = 'Ошибка перезаписи';
	END IF;
END//

INSERT INTO products (name, description) VALUES (NULL, NULL);
UPDATE products SET name = NULL, description = NULL WHERE id = 2;

INSERT INTO products (name, description) VALUES ('Intel core i5', NULL);
UPDATE products SET name = NULL, description = 'some important information' WHERE id = 2;

SHOW TRIGGERS;

-- 3.3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

DELIMITER //
CREATE FUNCTION fibonacci (n INT)
RETURNS INT NOT DETERMINISTIC
BEGIN
	DECLARE num_1, num_2 INT DEFAULT 1;
	DECLARE temp INT;
	DECLARE i INT DEFAULT 2;
	WHILE i < n DO
		SET temp = num_2;
		SET num_2 = num_2 + num_1;
		SET num_1 = temp;
		SET i = i + 1;
	END WHILE;
	RETURN num_2;	
END//

SELECT fibonacci(10);



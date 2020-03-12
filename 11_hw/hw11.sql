-- Практическое задание по теме “Оптимизация запросов”

-- 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, 
-- название таблицы, идентификатор первичного ключа и содержимое поля name.

CREATE TABLE `logs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `table_name` char(10) DEFAULT NULL,
  `name_content` varchar(255) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='логи добавления записей в таблицы users, catalogs, products';


DROP TRIGGER IF EXISTS logs_fill;

DELIMITER //
CREATE TRIGGER users_logs_fill BEFORE INSERT ON users 
FOR EACH ROW 
BEGIN 
	INSERT INTO logs (table_name, name_content, updated_at) VALUES ('users', (SELECT name FROM users ORDER BY ID DESC LIMIT 1), NOW());
END//

DELIMITER //
CREATE TRIGGER catalogs_logs_fill BEFORE INSERT ON catalogs 
FOR EACH ROW 
BEGIN 
	INSERT INTO logs (table_name, name_content, updated_at) VALUES ('catalogs', (SELECT name FROM catalogs ORDER BY ID DESC LIMIT 1), NOW());
END//

DELIMITER //
CREATE TRIGGER products_logs_fill BEFORE INSERT ON users 
FOR EACH ROW 
BEGIN 
	INSERT INTO logs (table_name, name_content, updated_at) VALUES ('products', (SELECT name FROM products ORDER BY ID DESC LIMIT 1), NOW());
END//

-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

-- Предложено две реализации, чтобы эксперементально сравнить производительность.
-- 1-ая вставляем процедурно по одной строке
DELIMITER // 
CREATE PROCEDURE users_insert ()
BEGIN
	SET @i = 0;
    WHILE @i != 1000000  DO
        INSERT INTO users (name) VALUES (CONCAT('name_', @i));
       	SET @i = @i + 1;
    END WHILE;
END//

-- 2-ая вставляем процедурно по 10 строк
DELIMITER // 
CREATE PROCEDURE users_insert2 ()
BEGIN
	SET @i = 0;
    WHILE @i != 1000000  DO
        INSERT INTO users (name) VALUES (CONCAT('name_', @i)), (CONCAT('name_', @i + 1)), (CONCAT('name_', @i + 2)), (CONCAT('name_', @i + 3)), (CONCAT('name_', @i + 4)),
       									(CONCAT('name_', @i + 5)), (CONCAT('name_', @i + 6)), (CONCAT('name_', @i + 7)), (CONCAT('name_', @i + 8)), (CONCAT('name_', @i + 9));
       	SET @i = @i + 10;
    END WHILE;
END//

DROP PROCEDURE users_insert2;

CALL users_insert(); -- Query_time: 1954.239994  Lock_time: 0.000248 

CALL users_insert2(); -- Query_time: 256.394848  Lock_time: 0.000157

-- в результате одного эксперимента, вторая реализация более чем 7 раз быстрее, чем первая.

-- Практическое задание по теме “NoSQL”
-- 1. В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.

-- 2. При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.

-- 3. Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
> mongo

> use shop

> db.products_cat.insertMany([
  {'name': 'Intel Core i3-8100', 'description' : 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 'price' : 7890.00, 'cat' : 'Процессоры'},
  {'name': 'Intel Core i5-7400', 'description' : 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 'price' : 12700.00, 'cat' : 'Процессоры'},
  {'name': 'AMD FX-8320E', 'description' : 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 'price' : 4780.00, 'cat' : 'Процессоры'},
  {'name': 'AMD FX-8320', 'description' : 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 'price' : 7120.00, 'cat' : 'Процессоры'},
  {'name': 'ASUS ROG MAXIMUS X HERO', 'description' : 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 'price' : 19310.00, 'cat' : 'Материнские платы'},
  {'name': 'Gigabyte H310M S2H', 'description' : 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 'price' : 4790.00, 'cat' : 'Материнские платы'},
  {'name': 'MSI B250M GAMING PRO', 'description' : 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 'price' : 5060.00, 'cat' : 'Материнские платы'}])

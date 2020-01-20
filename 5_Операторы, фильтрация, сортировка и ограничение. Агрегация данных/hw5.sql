-- 1_1 Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name varchar(100) NOT NULL,
	created_at datetime,
	updated_at datetime
);

INSERT INTO users (name) VALUES 
	('Igor'),
	('Slava'),
	('Petr'),
	('Boris'),
	('Kirill'),
	('Galina');

SELECT * FROM users;

UPDATE users SET
	created_at = NOW(),
	updated_at = NOW();


-- 1_2 Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name varchar(100) NOT NULL,
	created_at varchar(100),
	updated_at varchar(100)
);


INSERT INTO users (name, created_at, updated_at) VALUES 
	('Igor', "20.10.2017 8:10", "20.11.2017 8:10"),
	('Slava', "21.10.2017 8:10", "21.10.2017 8:10"),
	('Petr', "22.10.2017 8:10", "22.10.2017 8:10"),
	('Boris', "25.10.2017 8:10", "20.10.2018 8:10"),
	('Kirill', "20.11.2017 8:10", "20.10.2019 6:10"),
	('Galina', "20.12.2017 8:15", "20.10.2019 9:10");

SELECT * FROM users u2;

UPDATE users SET
	created_at = str_to_date(created_at, '%d.%m.%Y %h:%i'),
	updated_at = str_to_date(updated_at, '%d.%m.%Y %h:%i');
ALTER TABLE users CHANGE created_at created_at datetime;
ALTER TABLE users CHANGE updated_at updated_at datetime;


-- 1_3 В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
-- Однако, нулевые запасы должны выводиться в конце, после всех записей.

-- Cоздаем и заполняем тестовыми данными таблицу для работы
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO storehouses_products (storehouse_id, product_id, value) VALUES
	(1, 1, 0),
	(1, 3, 3),
	(1, 2, 1),
	(2, 1, 0),
	(2, 2, 2),
	(2, 3, 0),
	(3, 1, 1),
	(3, 2, 0),
	(3, 3, 11);

-- выгружаем отсортированную таблицу
SELECT * FROM storehouses_products ORDER BY 1/value DESC;


-- 1_4 (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий ('may', 'august')

-- создаем таблицу
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

-- заполняем тестовыми данными
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('1', 'Oscar Rempel', '1971-04-18', '2018-09-17 05:01:54', '1973-07-20 01:12:18');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('2', 'Shakira Toy', '2009-08-03', '2005-02-25 04:30:52', '2017-07-16 05:41:10');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('3', 'Houston Zemlak', '1973-06-01', '1994-12-09 19:30:10', '1977-10-02 09:22:03');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('4', 'Glen Waelchi', '1998-08-11', '1985-12-19 00:21:05', '1987-04-11 01:04:24');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('5', 'Frederique O\'Kon', '1988-07-11', '1973-11-29 17:47:15', '2003-10-15 10:48:51');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('6', 'Prof. Jerod Pagac', '1972-09-22', '1987-11-28 16:26:49', '1991-07-13 06:45:20');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('7', 'Lucio Runte', '1998-07-04', '1985-12-06 06:08:14', '1987-09-24 03:51:09');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('8', 'Una Toy', '2009-11-11', '1994-08-10 10:42:25', '1985-04-14 05:14:13');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('9', 'Arvilla Considine', '1986-10-26', '1983-10-11 23:36:23', '1997-04-09 06:49:50');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('10', 'Loraine Kub', '2004-02-28', '1970-12-11 01:24:42', '1979-12-30 15:26:17');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('11', 'Arely Bauch', '2013-01-25', '1970-09-19 05:21:01', '2015-04-16 11:49:49');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('12', 'Brooks Dooley', '1972-06-12', '1986-03-29 11:52:57', '1992-09-03 01:41:57');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('13', 'Henri Padberg', '1971-04-03', '1996-09-30 20:01:10', '2013-06-25 04:22:28');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('14', 'Prof. Everette Hilll MD', '2017-08-30', '2003-09-15 01:23:02', '1998-11-27 00:58:44');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('15', 'Roscoe Gerhold II', '2006-07-15', '1992-10-15 14:21:17', '1988-04-30 22:46:19');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('16', 'Tod Pagac', '2014-01-14', '1976-01-01 15:00:28', '2007-02-27 07:59:12');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('17', 'Nico Bashirian', '1977-07-28', '1980-10-10 02:32:51', '2005-07-21 09:20:58');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('18', 'Dr. Israel Hagenes IV', '2016-02-11', '2016-04-24 00:18:33', '2015-09-20 07:48:07');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('19', 'Durward Wunsch', '2003-10-04', '1974-06-03 20:13:13', '1976-12-16 03:56:52');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('20', 'Chester Goldner', '2015-05-09', '1996-07-31 20:57:56', '1992-02-01 16:15:25');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('21', 'Morgan Bernhard', '1971-08-08', '1979-06-24 08:55:25', '1984-03-19 00:43:05');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('22', 'Brayan Prohaska', '2018-01-20', '1998-08-25 22:15:44', '2007-10-11 19:41:24');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('23', 'Jacey Crona', '1982-04-29', '2011-05-29 18:17:59', '2004-05-29 19:03:12');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('24', 'Aiyana Schoen', '1984-02-12', '2010-02-12 08:00:09', '1980-08-18 16:09:05');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('25', 'Ms. Jewel Daugherty', '1979-04-19', '2009-03-31 18:17:35', '2007-04-10 23:20:29');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('26', 'Shanie West', '1990-06-25', '1974-02-15 07:46:27', '1993-12-27 21:48:47');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('27', 'Rupert Armstrong I', '2006-10-08', '2007-03-10 02:10:39', '1997-08-03 02:08:59');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('28', 'Kaya Nienow', '2009-05-25', '1976-10-16 13:40:38', '2012-09-29 02:48:30');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('29', 'Daphney Christiansen', '2016-03-14', '2008-07-19 05:19:49', '2006-02-12 02:08:35');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('30', 'Janiya Abernathy', '1985-08-21', '1998-11-04 00:49:58', '1991-12-14 19:03:54');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('31', 'Jamir Bergnaum', '1985-06-19', '1992-04-08 17:30:55', '2003-12-15 06:36:03');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('32', 'Elian Robel', '2008-09-13', '1991-04-11 21:58:30', '2008-07-26 16:45:28');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('33', 'Darrel Beahan', '2016-06-06', '2004-06-23 05:16:12', '1990-03-13 13:58:23');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('34', 'Prof. Lilly Spinka DVM', '2006-03-17', '2004-03-20 06:44:11', '2003-01-13 00:53:02');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('35', 'Hector Schmidt Jr.', '2004-10-29', '1993-06-20 00:52:18', '1991-10-31 11:51:48');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('36', 'Dr. Floyd Cronin IV', '2011-04-01', '1985-02-16 06:02:51', '1977-07-24 03:26:15');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('37', 'Prof. Miller Jenkins Jr.', '2013-11-07', '2015-02-24 19:47:20', '1976-12-11 05:21:58');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('38', 'Winnifred Barton', '2002-01-31', '1993-03-14 09:15:11', '1998-05-10 05:05:21');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('39', 'Prof. Jason Ernser IV', '1991-12-11', '2005-02-09 18:21:57', '1970-01-13 06:08:46');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('40', 'Lexus Tromp', '1996-04-01', '1970-09-09 17:13:42', '1999-04-30 08:26:50');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('41', 'Kaela Jast', '1999-09-26', '2016-07-25 00:28:19', '2005-04-09 21:25:25');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('42', 'Flavio Wilkinson', '1980-04-19', '1994-12-05 12:39:18', '1992-11-05 17:37:23');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('43', 'Prof. June Carter', '1975-04-07', '2013-07-29 04:30:36', '2019-04-27 21:22:14');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('44', 'Aisha Bednar', '2014-01-06', '2010-01-01 23:46:26', '1978-08-18 01:31:19');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('45', 'Hollis Schuster I', '2006-06-05', '2012-12-14 06:35:20', '1987-02-02 01:09:54');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('46', 'Sierra Turner', '1980-04-09', '1991-04-16 12:58:08', '1989-01-07 07:33:24');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('47', 'Kayleigh Lueilwitz', '2016-11-16', '1974-09-23 17:47:47', '1989-12-01 04:10:53');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('48', 'Jermain Terry DDS', '1987-12-15', '2008-03-31 05:44:39', '2016-11-14 10:58:31');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('49', 'Rylee Ondricka', '1993-11-23', '1978-01-07 03:13:05', '1974-06-08 20:16:59');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('50', 'Prof. Kaylie Pollich III', '1985-09-04', '1975-01-08 18:11:27', '2012-11-13 17:59:52');

SELECT * FROM users LIMIT 10;

-- выгружаем строки с информацией о пользователях, родившихся в мае или августе

SELECT * FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august');


-- 1_5 (по желанию). Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
-- Отсортируйте записи в порядке, заданном в списке IN.

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (DEFAULT, 'Процессоры'),
  (DEFAULT, 'Мат.платы'),
  (DEFAULT, 'Оп. память'),
  (DEFAULT, 'Жесткие диски'),
  (DEFAULT, 'Мышки'),
  (DEFAULT, 'Клавиатуры'),
  (DEFAULT, 'Дисплеи'),
  (DEFAULT, 'Видео карты'),
  (DEFAULT, 'Видеокарты');
  
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);


-- 2_1 Подсчитайте средний возраст пользователей в таблице users
SELECT FLOOR(AVG(timestampdiff(YEAR, birthday_at, NOW()))) AS average_age FROM users;


-- 2_2 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.
SELECT COUNT(*), WEEKDAY(birthday_at) as week_day FROM users u2 GROUP BY week_day;


-- 2_3 (по желанию) Подсчитайте произведение чисел в столбце таблицы
SELECT EXP(SUM(LOG(id))) as mult FROM users;


 
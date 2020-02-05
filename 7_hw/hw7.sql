-- задание 1
-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT name FROM users LEFT JOIN orders ON users.id = orders.user_id WHERE orders.id  IS NOT NULL GROUP BY name;

-- задание 2
-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT p.name AS product_name, c.name AS type_name FROM products AS p JOIN catalogs AS c ON p.catalog_id = c.id;

-- задание 3
-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

SELECT id, c.name AS `from`, c1.name AS `to` FROM (flights AS f JOIN cities AS c ON f.from = c.label) JOIN cities AS c1 ON f.to = c1.label;

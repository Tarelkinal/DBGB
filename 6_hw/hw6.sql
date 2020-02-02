-- задание 2
-- Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

-- Условие выбора: 1) Друг пользователя id = 65, сумма отправленных и полученных сообщений заданному пользователю наибольшая. Значение для сообщений is_delivered не учитывал.  
SELECT (SELECT CONCAT(first_name, ' ', last_name) FROM users u2 WHERE id = friend_id) AS friend_name, COUNT(*) AS contacts_num FROM
((SELECT to_user_id AS friend_id FROM messages
  WHERE to_user_id IN(
	(SELECT friend_id 
	   FROM friendship 
	  WHERE user_id = 65
	    AND confirmed_at IS NOT NULL
	    AND status_id IN (
	   		SELECT id 
	   		  FROM friendship_statuses 
	   		 WHERE name = 'Confirmed'))  		 
	  UNION
	(SELECT user_id 
	   FROM friendship 
	  WHERE friend_id = 65
	  	AND confirmed_at IS NOT NULL
		AND status_id IN (
			SELECT id 
			  FROM friendship_statuses 
			 WHERE name = 'Confirmed')))  
	 AND from_user_id = 65)
  UNION ALL
(SELECT from_user_id FROM messages
  WHERE from_user_id IN (
	(SELECT friend_id 
	   FROM friendship
	  WHERE user_id = 65
		AND confirmed_at IS NOT NULL
		AND status_id IN (
	   		SELECT id 
	   		  FROM friendship_statuses 
	   		 WHERE name = 'Confirmed'))  		 
	  UNION
	(SELECT user_id 
	   FROM friendship 
	  WHERE friend_id = 65
	  	AND confirmed_at IS NOT NULL
		AND status_id IN (
			SELECT id 
			  FROM friendship_statuses 
			 WHERE name = 'Confirmed')))  
    AND to_user_id = 65)) t GROUP BY friend_id ORDER BY contacts_num DESC LIMIT 1;
 
   
-- Задача 3
-- Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
DROP TABLE IF EXISTS top10_media_size_users;
CREATE TEMPORARY TABLE top10_media_size_users (id SERIAL,user_id INT);
INSERT INTO top10_media_size_users (user_id) SELECT user_id FROM profiles p ORDER BY birthday DESC LIMIT 10;

SELECT COUNT(*) AS likes_num FROM likes WHERE content_type_id = 3 AND content_id IN (SELECT user_id FROM top10_media_size_users); -- Здесь и далее, если напрямую под IN подставить запрос (SELECT user_id FROM profiles p ORDER BY birthday DESC LIMIT 10) выдает ошибку


-- Задача 4
-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
DROP TABLE IF EXISTS men;
DROP TABLE IF EXISTS women;

CREATE TEMPORARY TABLE men (user_id INT);
INSERT INTO men SELECT user_id FROM profiles p WHERE sex = 'm';
SELECT COUNT(*) FROM likes WHERE user_id IN (SELECT * FROM men);

CREATE TEMPORARY TABLE women (user_id INT);
INSERT INTO women SELECT user_id FROM profiles p WHERE sex = 'f';
SELECT COUNT(*) FROM likes l WHERE user_id IN (SELECT * FROM women);

SELECT IF(
	(SELECT COUNT(*) FROM likes WHERE user_id IN (SELECT * FROM men)) > (SELECT COUNT(*) FROM likes l WHERE user_id IN (SELECT * FROM women)), 'мужчины', 'женщины') 
AS 'кто больше поставил лайков (всего) - мужчины или женщины?';


-- Задача 5
-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
-- Модель: 
-- Выбираем все таблицы где может проявляется активность пользователя - к примеру таблица сообщений, таблица лайков, таблица постов и др.
-- Создаем временную таблицу, заносим туда пользователя с рейтингом 2, если он вообще не фигурирует в таблице в качетсве актора, с рейтингом 1, если он один из тех, кто проявлял активность наиболее давно.
-- Суммируем рейтинг неактивности пользователей, которые попали во временную таблицу и выдаем топ 10 неактивных.
-- Можно менять модель, меняя коэффициенты рейтинга неактивности. Я реализовал, для примера, на 4-х таблицах. 
DROP TABLE IF EXISTS users_inactivity;

CREATE TEMPORARY TABLE users_inactivity (rating INT DEFAULT(1), user_id INT);

INSERT INTO users_inactivity (rating, user_id) SELECT 2, id FROM users WHERE id NOT IN (SELECT from_user_id FROM messages); 
INSERT INTO users_inactivity (user_id) SELECT from_user_id FROM (SELECT from_user_id, created_at FROM messages ORDER BY created_at LIMIT 10) g GROUP BY from_user_id;

INSERT INTO users_inactivity (rating, user_id) SELECT 2, id FROM users WHERE id NOT IN (SELECT user_id FROM likes); 
INSERT INTO users_inactivity (user_id) SELECT user_id FROM (SELECT user_id, created_at FROM likes ORDER BY created_at LIMIT 10) g GROUP BY user_id;

INSERT INTO users_inactivity (rating, user_id) SELECT 2, id FROM users WHERE id NOT IN (SELECT user_id FROM posts); 
INSERT INTO users_inactivity (user_id) SELECT user_id FROM (SELECT user_id, created_at FROM posts ORDER BY created_at LIMIT 10) g GROUP BY user_id;

INSERT INTO users_inactivity (rating, user_id) SELECT 2, id FROM users WHERE id NOT IN (SELECT user_id FROM friendship); 
INSERT INTO users_inactivity (user_id) SELECT user_id FROM (SELECT user_id, requested_at FROM friendship ORDER BY requested_at LIMIT 10) g GROUP BY user_id;

SELECT SUM(rating) AS top_inactives, user_id FROM(SELECT rating, user_id FROM users_inactivity) t GROUP BY user_id ORDER BY top_inactives DESC LIMIT 10;

	





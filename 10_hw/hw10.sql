-- Доработка ДЗ к уроку 9
-- 1.1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
--      Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
-- Ваш комментарий: "Сам подход верен, но нужно использовать транзакцию".

START TRANSACTION;
USE sample;
INSERT INTO users SELECT * FROM shop.users WHERE id = 1;
USE shop;
DELETE FROM users WHERE id = 1;
COMMIT;

-- 1. Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.
-- информация профиля, история сообщений пользователя, список друзей пользователя

CREATE UNIQUE INDEX user_email_uq ON users(email);

CREATE INDEX friendship_idx ON friendship(user_id, friend_id, status_id);

CREATE INDEX profiles_birthday_idx ON profiles(birthday);

CREATE INDEX media_user_id_media_type_id_idx ON media(user_id, media_type_id);

CREATE INDEX messages_from_user_id_to_user_id_idx ON messages(from_user_id, to_user_id);

CREATE INDEX likes_user_id_idx ON likes(user_id);

/* 2. Задание на оконные функции
Построить запрос, который будет выводить следующие столбцы:
имя группы
среднее количество пользователей в группах
самый молодой пользователь в группе
самый пожилой пользователь в группе
общее количество пользователей в группе
всего пользователей в системе
отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100 */

SELECT DISTINCT c.name,
       COUNT(cu.user_id) OVER() / (SELECT COUNT(*) FROM communities) AS avg_num,
       FIRST_VALUE(p.user_id) OVER (PARTITION BY c.id ORDER BY p.birthday) AS youngest_user_id,
       FIRST_VALUE(p.user_id) OVER (PARTITION BY c.id ORDER BY p.birthday DESC) AS oldest_user_id,
       COUNT(*) OVER (PARTITION BY c.id) AS users_num,
       (SELECT COUNT(*) FROM profiles) AS total_users_in_system,
       COUNT(*) OVER (PARTITION BY c.id) * 100 / (SELECT COUNT(*) FROM profiles) AS ratio_in_percentages
  FROM communities c 
  JOIN communities_users cu ON cu.community_id = c.id
  JOIN profiles p ON cu.user_id = p.user_id;
 
SELECT * FROM communities c;
SELECT * FROM profiles p ORDER BY birthday;
SELECT * FROM communities_users;




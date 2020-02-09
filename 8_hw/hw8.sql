-- 1. Добавить необходимые внешние ключи для всех таблиц базы данных vk (приложить команды).
ALTER TABLE profiles
ADD CONSTRAINT fk_user_id
FOREIGN KEY (user_id)
REFERENCES users (id)
ON DELETE CASCADE         -- если не прописывать действия, то по умолчанию будет NO ACTION?
ON UPDATE CASCADE;

ALTER TABLE profiles CHANGE photo_id photo_id INT(10) UNSIGNED;

ALTER TABLE profiles
ADD CONSTRAINT fk_photo_id
FOREIGN KEY (photo_id)
REFERENCES media (id)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE posts CHANGE user_id user_id INT(10) UNSIGNED;

ALTER TABLE posts 
ADD CONSTRAINT fk_post_user_id 
FOREIGN KEY (user_id) 
REFERENCES users (id) 
ON DELETE SET NULL 
ON UPDATE CASCADE;

ALTER TABLE posts 
FOREIGN KEY (media_id) 
REFERENCES media (id) 
ON DELETE SET NULL 
ON UPDATE CASCADE;

DESC messages;

ALTER TABLE messages CHANGE from_user_id from_user_id INT(10) UNSIGNED;
ALTER TABLE messages CHANGE to_user_id to_user_id INT(10) UNSIGNED;

ALTER TABLE messages 
FOREIGN KEY (from_user_id) 
REFERENCES users (id) 
ON DELETE SET NULL 
ON UPDATE CASCADE;

ALTER TABLE messages 
FOREIGN KEY (to_user_id) 
REFERENCES users (id) 
ON DELETE SET NULL 
ON UPDATE CASCADE;

ALTER TABLE media 
FOREIGN KEY (media_type_id) 
REFERENCES media_types (id)  
ON UPDATE CASCADE;

ALTER TABLE media CHANGE user_id user_id INT(10) UNSIGNED;

ALTER TABLE media 
FOREIGN KEY (user_id) 
REFERENCES users (id)
ON DELETE SET NULL 
ON UPDATE CASCADE;

ALTER TABLE communities_users
ADD FOREIGN KEY (community_id) 
REFERENCES communities (id)
ON UPDATE CASCADE;

ALTER TABLE communities_users
ADD FOREIGN KEY (user_id) 
REFERENCES users (id)
ON UPDATE CASCADE;

ALTER TABLE friendship
ADD FOREIGN KEY (user_id) 
REFERENCES users (id)
ON UPDATE CASCADE;

ALTER TABLE friendship
ADD FOREIGN KEY (friend_id) 
REFERENCES users (id)
ON UPDATE CASCADE;

ALTER TABLE friendship
ADD FOREIGN KEY (status_id) 
REFERENCES friendship_statuses (id)
ON UPDATE CASCADE;

ALTER TABLE likes
ADD FOREIGN KEY (user_id) 
REFERENCES users (id)
ON UPDATE CASCADE;

ALTER TABLE likes
ADD FOREIGN KEY (content_type_id) 
REFERENCES content_types (id)
ON UPDATE CASCADE;

-- как можно построить ключ для поля content_id, таблицы likes, если в зависимости от поля content_type_id ссылка в content_id идет на разные таблицы?

-- 3. Переписать запросы, заданые к ДЗ урока 6 с использованием JOIN (четыре запроса).

-- 3.1. Пусть задан некоторый пользователь. ID = 65 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
-- IF(user_id = 65, friend_id, user_id) AS friend,  m.from_user_id, m.to_user_id

SELECT COUNT(*) AS contacts_num, IF(user_id = 65, friend_id, user_id) AS friend, first_name, last_name
  FROM friendship f 
  JOIN friendship_statuses fs ON f.status_id = fs.id 
  JOIN messages m ON (IF(user_id = 65, friend_id, user_id) = m.from_user_id OR IF(user_id = 65, friend_id, user_id) = m.to_user_id)
  JOIN users u ON IF(user_id = 65, friend_id, user_id) = u.id
 WHERE fs.name = 'Confirmed' AND (user_id = 65 OR friend_id = 65) AND (from_user_id = 65 OR to_user_id = 65)
 GROUP BY friend, first_name, last_name 
 ORDER BY COUNT(*) DESC LIMIT 1;

-- 3.2. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
-- Реализация с использованием вложенного запроса
SELECT COUNT(ct.id) AS likes_num
  FROM (SELECT * FROM profiles ORDER BY birthday DESC LIMIT 10) AS t10
  LEFT JOIN (likes JOIN content_types ct ON content_type_id = ct.id AND ct.content_name = 'User') ON t10.user_id = content_id;
	
-- Здесь принципиально не использоввал вложенные запросы. Удалось получить следующий результат: 
SELECT COUNT(ct.id), birthday, p.user_id
  FROM profiles p
  LEFT JOIN likes l ON p.user_id = content_id
  LEFT JOIN content_types ct ON content_type_id = ct.id AND ct.content_name = 'User'
 GROUP BY birthday, p.user_id 
 ORDER BY birthday DESC LIMIT 10; 

-- 3.3. Определить кто больше поставил лайков (всего) - мужчины или женщины?
-- Таблица 
SELECT COUNT(*), sex FROM profiles p JOIN likes l ON p.user_id = l.user_id GROUP BY sex; 

-- Ответ на вопрос задачи
SELECT 
    IF((SELECT COUNT(*) FROM profiles p JOIN likes l ON p.user_id = l.user_id WHERE sex = 'm') > 
       (SELECT COUNT(*) FROM profiles p JOIN likes l ON p.user_id = l.user_id WHERE sex = 'f'),
       'Men', 'Women'
      ) 
    AS 'Кто больше поставил лайков?';
   
-- 3.4. Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
SELECT COUNT(*), CONCAT(first_name, ' ', last_name) 
  FROM users u
  LEFT JOIN messages ON u.id = from_user_id
  LEFT JOIN media m ON u.id = m.user_id
  LEFT JOIN likes l ON u.id = l.user_id
 GROUP BY u.id
 ORDER BY COUNT(*) LIMIT 10;



 
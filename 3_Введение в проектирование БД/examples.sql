
CREATE DATABASE vk;

USE vk;


CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,  
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  phone VARCHAR(120) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);


CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY,
  sex CHAR(1) NOT NULL,
  birthday DATE,
  hometown VARCHAR(100),
  photo_id INT UNSIGNED NOT NULL
);


CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  is_important BOOLEAN,
  is_delivered BOOLEAN,
  created_at DATETIME DEFAULT NOW()
);


CREATE TABLE friendship (
  user_id INT UNSIGNED NOT NULL,
  friend_id INT UNSIGNED NOT NULL,
  status_id INT UNSIGNED NOT NULL,
  requested_at DATETIME DEFAULT NOW(),
  confirmed_at DATETIME,
  PRIMARY KEY (user_id, friend_id)
);


CREATE TABLE friendship_statuses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);



CREATE TABLE communities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL UNIQUE
);


CREATE TABLE communities_users (
  community_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (community_id, user_id)
);


CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  media_type_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  filename VARCHAR(255) NOT NULL,
  size INT NOT NULL,
  metadata JSON,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE media_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

-- вставляем данные 

INSERT INTO communities (id, name) VALUES (27, 'a');
INSERT INTO communities (id, name) VALUES (52, 'ab');
INSERT INTO communities (id, name) VALUES (99, 'accusamus');
INSERT INTO communities (id, name) VALUES (64, 'accusantium');
INSERT INTO communities (id, name) VALUES (95, 'adipisci');
INSERT INTO communities (id, name) VALUES (6, 'at');
INSERT INTO communities (id, name) VALUES (13, 'atque');
INSERT INTO communities (id, name) VALUES (31, 'aut');
INSERT INTO communities (id, name) VALUES (55, 'autem');
INSERT INTO communities (id, name) VALUES (14, 'beatae');
INSERT INTO communities (id, name) VALUES (93, 'consectetur');
INSERT INTO communities (id, name) VALUES (5, 'consequatur');
INSERT INTO communities (id, name) VALUES (97, 'culpa');
INSERT INTO communities (id, name) VALUES (16, 'cum');
INSERT INTO communities (id, name) VALUES (45, 'debitis');
INSERT INTO communities (id, name) VALUES (74, 'delectus');
INSERT INTO communities (id, name) VALUES (46, 'dicta');
INSERT INTO communities (id, name) VALUES (98, 'distinctio');
INSERT INTO communities (id, name) VALUES (68, 'dolor');
INSERT INTO communities (id, name) VALUES (59, 'doloremque');
INSERT INTO communities (id, name) VALUES (65, 'dolores');
INSERT INTO communities (id, name) VALUES (91, 'doloribus');
INSERT INTO communities (id, name) VALUES (42, 'dolorum');
INSERT INTO communities (id, name) VALUES (36, 'ducimus');
INSERT INTO communities (id, name) VALUES (49, 'ea');


INSERT INTO communities (id, name) VALUES (92, 'eaque');
INSERT INTO communities (id, name) VALUES (38, 'earum');
INSERT INTO communities (id, name) VALUES (76, 'eligendi');
INSERT INTO communities (id, name) VALUES (22, 'enim');
INSERT INTO communities (id, name) VALUES (89, 'error');
INSERT INTO communities (id, name) VALUES (35, 'est');
INSERT INTO communities (id, name) VALUES (17, 'et');
INSERT INTO communities (id, name) VALUES (34, 'eum');
INSERT INTO communities (id, name) VALUES (80, 'eveniet');
INSERT INTO communities (id, name) VALUES (96, 'ex');
INSERT INTO communities (id, name) VALUES (70, 'exercitationem');
INSERT INTO communities (id, name) VALUES (2, 'fugiat');
INSERT INTO communities (id, name) VALUES (43, 'fugit');
INSERT INTO communities (id, name) VALUES (73, 'hic');
INSERT INTO communities (id, name) VALUES (72, 'id');
INSERT INTO communities (id, name) VALUES (82, 'in');
INSERT INTO communities (id, name) VALUES (20, 'incidunt');
INSERT INTO communities (id, name) VALUES (87, 'inventore');
INSERT INTO communities (id, name) VALUES (53, 'ipsam');
INSERT INTO communities (id, name) VALUES (100, 'ipsum');
INSERT INTO communities (id, name) VALUES (83, 'iure');
INSERT INTO communities (id, name) VALUES (12, 'iusto');
INSERT INTO communities (id, name) VALUES (19, 'labore');
INSERT INTO communities (id, name) VALUES (90, 'laboriosam');
INSERT INTO communities (id, name) VALUES (44, 'libero');
INSERT INTO communities (id, name) VALUES (79, 'magni');
INSERT INTO communities (id, name) VALUES (67, 'maiores');
INSERT INTO communities (id, name) VALUES (57, 'maxime');
INSERT INTO communities (id, name) VALUES (69, 'minima');
INSERT INTO communities (id, name) VALUES (24, 'minus');
INSERT INTO communities (id, name) VALUES (63, 'modi');
INSERT INTO communities (id, name) VALUES (3, 'molestiae');
INSERT INTO communities (id, name) VALUES (32, 'nam');
INSERT INTO communities (id, name) VALUES (58, 'natus');
INSERT INTO communities (id, name) VALUES (66, 'necessitatibus');
INSERT INTO communities (id, name) VALUES (51, 'nemo');
INSERT INTO communities (id, name) VALUES (48, 'nihil');
INSERT INTO communities (id, name) VALUES (39, 'nisi');
INSERT INTO communities (id, name) VALUES (47, 'nobis');
INSERT INTO communities (id, name) VALUES (77, 'non');
INSERT INTO communities (id, name) VALUES (88, 'nostrum');
INSERT INTO communities (id, name) VALUES (75, 'occaecati');
INSERT INTO communities (id, name) VALUES (56, 'omnis');
INSERT INTO communities (id, name) VALUES (9, 'pariatur');
INSERT INTO communities (id, name) VALUES (25, 'perspiciatis');
INSERT INTO communities (id, name) VALUES (62, 'quam');
INSERT INTO communities (id, name) VALUES (71, 'quas');
INSERT INTO communities (id, name) VALUES (86, 'quasi');
INSERT INTO communities (id, name) VALUES (78, 'qui');
INSERT INTO communities (id, name) VALUES (85, 'quia');
INSERT INTO communities (id, name) VALUES (18, 'quis');
INSERT INTO communities (id, name) VALUES (4, 'quo');
INSERT INTO communities (id, name) VALUES (54, 'reiciendis');
INSERT INTO communities (id, name) VALUES (11, 'repellat');
INSERT INTO communities (id, name) VALUES (41, 'repellendus');
INSERT INTO communities (id, name) VALUES (84, 'saepe');
INSERT INTO communities (id, name) VALUES (37, 'sed');
INSERT INTO communities (id, name) VALUES (15, 'sequi');
INSERT INTO communities (id, name) VALUES (1, 'similique');
INSERT INTO communities (id, name) VALUES (81, 'sint');
INSERT INTO communities (id, name) VALUES (29, 'sit');
INSERT INTO communities (id, name) VALUES (21, 'soluta');
INSERT INTO communities (id, name) VALUES (28, 'sunt');
INSERT INTO communities (id, name) VALUES (23, 'tempora');
INSERT INTO communities (id, name) VALUES (60, 'tempore');
INSERT INTO communities (id, name) VALUES (94, 'temporibus');
INSERT INTO communities (id, name) VALUES (7, 'ut');
INSERT INTO communities (id, name) VALUES (61, 'vel');
INSERT INTO communities (id, name) VALUES (30, 'velit');
INSERT INTO communities (id, name) VALUES (33, 'veritatis');
INSERT INTO communities (id, name) VALUES (10, 'voluptas');
INSERT INTO communities (id, name) VALUES (26, 'voluptatem');
INSERT INTO communities (id, name) VALUES (8, 'voluptates');
INSERT INTO communities (id, name) VALUES (50, 'voluptatibus');
INSERT INTO communities (id, name) VALUES (40, 'voluptatum');


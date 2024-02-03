CREATE DATABASE `development` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'development'@'%' IDENTIFIED BY 'development';
GRANT ALL PRIVILEGES ON `development` . * TO 'development'@'%';

CREATE DATABASE `test` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'test'@'%' IDENTIFIED BY 'test';
GRANT ALL PRIVILEGES ON `test` . * TO 'test'@'%';
-- rails db:setup etc. will also run on test, so give development access to both environments
GRANT ALL PRIVILEGES ON `test` . * TO 'development'@'%';

FLUSH PRIVILEGES;

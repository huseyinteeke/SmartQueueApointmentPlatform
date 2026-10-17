-- Creates the project database and the application user.
-- Run once as the MySQL root user:
--   mysql -u root -p < sql/create_database.sql
-- Tables will be added in Milestone 2 (schema.sql).

CREATE DATABASE IF NOT EXISTS smartqueue
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_turkish_ci;

-- Change 'change-me' to your own password and write the same value into .env as DB_PASSWORD
CREATE USER IF NOT EXISTS 'smartqueue_app'@'localhost' IDENTIFIED BY 'change-me';

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP, INDEX, REFERENCES
    ON smartqueue.* TO 'smartqueue_app'@'localhost';

FLUSH PRIVILEGES;

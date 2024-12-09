CREATE DATABASE project_managements;
USE project_management;


-- Create Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL
);

-- Create Clients Table
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Create Projects Table
CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(255) NOT NULL,
    client_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT,
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
);

-- Create Project Users Mapping Table
CREATE TABLE project_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT,
    user_id INT,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO users (username, password_hash) VALUES 
('manu', 'hashed_password1'),
('pc', 'hashed_password2'),
('manasvibagal@gmail.com', 'hashed_password3');

INSERT INTO clients (client_name, created_by) VALUES 
('Nimap', 1), 
('Infotech', 1);

INSERT INTO project_users (project_id, user_id) VALUES 
(1, 1), 
(1, 2), 
(2, 3);

SELECT 
    clients.id, 
    clients.client_name, 
    clients.created_at, 
    users.username AS created_by 
FROM clients
LEFT JOIN users ON clients.created_by = users.id;

SELECT 
    clients.id AS client_id, 
    clients.client_name, 
    projects.id AS project_id, 
    projects.project_name 
FROM clients
LEFT JOIN projects ON clients.id = projects.client_id
WHERE clients.id = 1;  -- Replace 1 with the desired client ID

UPDATE clients 
SET client_name = 'Updated Company Name'
WHERE id = 1;  -- Replace 1 with the desired client ID

INSERT INTO projects (project_name, client_id, created_by) 
VALUES ('New Project', 1, 2);  -- Replace values as needed

SELECT 
    projects.id AS project_id, 
    projects.project_name, 
    projects.created_at 
FROM projects
JOIN project_users ON projects.id = project_users.project_id
WHERE project_users.user_id = 1;  -- Replace 1 with the logged-in user's ID


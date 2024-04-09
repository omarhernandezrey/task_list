--crear base de datos
CREATE DATABASE todo_tutorial;
--SHOW databases;
--USE todo_tutorial;

--crear tablas
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255)
);

CREATE TABLE todos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    completed BOOLEAN DEFAULT false,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

SHOW tables;

CREATE TABLE shared_todos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  todo_id INT,
  user_id INT,
  shared_with_id INT,
  FOREIGN KEY (todo_id) REFERENCES todos(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (shared_with_id) REFERENCES users(id) ON DELETE CASCADE
);


--Ingresar datos
INSERT INTO users (name, email, password) 
VALUES ('Omar', 'user1@example.com', 'password1');
INSERT INTO users (name, email, password)
VALUES ('Alberto', 'user2@example.com', 'password2');

--querys
--select * from users;
--select * from users where id = 1;
--select * from users where id = 2;

--vamos a insertar unos todos para ver en la aplicacion
INSERT INTO todos (title, user_id)
VALUES
('🏃 Go for a morning run 🌅', 1),
('📊 Work on project presentation 💼', 1),
('🛒 Go grocery shopping 🛍️', 1),
('📖 Read 30 pages of book 📚', 1),
('🚴 Ride bike to the park 🚲', 1),
('🍳 Cook dinner for family 🍽️', 1),
('🧘 Practice yoga 🧘', 1),
('🎧 Listen to a podcast 🎧', 1),
('🧹 Clean the house 🏠', 1),
('😴 Get 8 hours of sleep 😴', 1);

--select * from todos;

--select * from todos where user_id = 1;
--select * from todos where user_id = 2;

--eliminamos la tercera tabla shared_todos y pegamos la que editamos
--drop table shared_todos;
--describe shared_todos;

-- share todo 1 of user 1 with user 2
INSERT INTO shared_todos (todo_id, user_id, shared_with_id)
VALUES (1, 1, 2);

--Get todos including shared todos by id
SELECT todos.*, shared_todos.shared_with_id
FROM todos
LEFT JOIN shared_todos ON todos.id = shared_todos.todo_id
WHERE todos.user_id = [user_id] OR shared_todos.shared_with_id = [user_id];


/* SELECT todos.*, shared_todos.shared_with_id
FROM todos
LEFT JOIN shared_todos ON todos.id = shared_todos.todo_id
WHERE todos.user_id = 1 OR shared_todos.shared_with_id = 1;

SELECT todos.*, shared_todos.shared_with_id
FROM todos
LEFT JOIN shared_todos ON todos.id = shared_todos.todo_id
WHERE todos.user_id = 2 OR shared_todos.shared_with_id = 2; */

--select * from todos where user_id = 2;
--YATEMEMOS LA LOGICA DE COMPARTIR EDITAR Y ELIMINAR
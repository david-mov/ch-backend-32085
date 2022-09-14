CREATE USER 'coder1234'@'localhost' IDENTIFIED BY 'pass1234';

GRANT ALL PRIVILIGES ON * . * TO 'coder1234'@'localhost';

quit

mysql -u coder1234 -p

CREATE DATABASE coderhouse;

SHOW DATABASES;

USE DATABASE coderhouse;

CREATE TABLE IF NOT EXISTS Estudiante 
(  
id int AUTO_INCREMENT NOT NULL,
nombre varchar(255) NOT NULL,
edad int,
nacionalidad varchar(255),
PRIMARY KEY (id)
);

INSERT INTO Estudiante (nombre, edad, nacionalidad) VALUES ('Maria', 20, 'Argentina');
INSERT INTO Estudiante (nombre, edad, nacionalidad) VALUES ('Jorge', 30, 'Colombia');
INSERT INTO Estudiante (nombre, edad, nacionalidad) VALUES ('Teresa', 30, 'Chile');
INSERT INTO Estudiante (nombre, edad) VALUES ('Daniel', 40);
INSERT INTO Estudiante (nombre, edad) VALUES ('Carlos', 25, 'Chile');

CREATE TABLE IF NOT EXISTS Profesor 
(  
id int AUTO_INCREMENT NOT NULL,
nombre varchar(255) NOT NULL,
antiguedad int NOT NULL,
PRIMARY KEY (id)
);

INSERT INTO Profesor (nombre, antiguedad) VALUES ('Kevin', 3);

CREATE TABLE IF NOT EXISTS Admin
(
id int AUTO_INCREMENT NOT NULL,
nombre varchar(255) NOT NULL,
PRIMARY KEY (id)
);

INSERT INTO Admin (nombre) VALUES ('Matias');
INSERT INTO Admin (nombre) VALUES ('Camila');

CREATE TABLE IF NOT EXISTS Curso
(
id int AUTO_INCREMENT NOT NULL,
titulo varchar(255) NOT NULL,
idProfesor int NOT NULL,
idAdmin int NOT NULL UNIQUE,
PRIMARY KEY (id),
FOREIGN KEY (idProfesor) REFERENCES Profesor(id),
FOREIGN KEY (idAdmin) REFERENCES Admin(id)
);

INSERT INTO Curso (titulo, idProfesor, idAdmin) VALUES ('Back-end', 1, 1);
INSERT INTO Curso (titulo, idProfesor, idAdmin) VALUES ('React', 1, 2);

CREATE TABLE IF NOT EXISTS CursoXEstudiante
(
idCurso INT ,
idEstudiante INT,
PRIMARY KEY (idCurso, idEstudiante),
FOREIGN KEY (idCurso) REFERENCES Curso(id),
FOREIGN KEY (idEstudiante) REFERENCES Estudiante(id)
);

INSERT INTO CursoXEstudiante (idCurso, idEstudiante) VALUES (1, 1);
INSERT INTO CursoXEstudiante (idCurso, idEstudiante) VALUES (1, 3);
INSERT INTO CursoXEstudiante (idCurso, idEstudiante) VALUES (2, 4);
INSERT INTO CursoXEstudiante (idCurso, idEstudiante) VALUES (2, 5);

CREATE TABLE IF NOT EXISTS ParaBorrar 
(
id INT AUTO_INCREMENT NOT NULL,
PRIMARY KEY (id)
);

DROP TABLE IF EXISTS ParaBorrar;

SELECT * FROM Estudiante;
SELECT * FROM Curso;

SELECT * FROM Estudiante WHERE nacionalidad = 'Chile';
SELECT * FROM Estudiante WHERE edad >= 20;

SELECT * FROM Estudiante WHERE edad > 20 AND nacionalidad = 'Chile';
SELECT * FROM Estudiante WHERE edad > 40 OR nacionalidad = 'Argentina';

DELETE FROM Estudiante WHERE nombre = 'Jorge';
UPDATE Estudiante SET nombre = 'David', nacionalidad = 'Argentina' WHERE id=3;

SELECT * FROM Curso INNER JOIN Profesor ON Curso.idProfesor = Profesor.id;

SELECT * FROM CursoXEstudiante;

SELECT * FROM CursoXEstudiante 
INNER JOIN Estudiante ON CursoXEstudiante.idEstudiante = Estudiante.id;

SELECT * FROM CursoXEstudiante 
INNER JOIN Curso ON CursoXEstudiante.idCurso = Curso.id;
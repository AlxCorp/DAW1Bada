DROP DATABASE IF EXISTS academia;
CREATE DATABASE academia;
USE academia;

CREATE TABLE profesores (
	dni VARCHAR(9) PRIMARY KEY,
	nombre VARCHAR(50) UNIQUE NOT NULL,
	tutulacion VARCHAR(50) NOT NULL,
	direccion VARCHAR(100) NOT NULL,
	cuotahora DECIMAL (5,2) NOT NULL,
);

CREATE TABLE cursos (
	cod INT(2) AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50) UNIQUE NOT NULL,
	num_max INT NOT NULL,
	fecha_inicio DATE,
	fecha_fin DATE,
	num_horas INT,
	dni_prof VARCHAR(9), 
	FOREIGN KEY (dni_prof) REFERENCES profesores (dni)
	ON DELETE RESTRICT
);

CREATE TABLE alumnos (
	dni VARCHAR(9) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellidos VARCHAR(80) NOT NULL,
	direccion VARCHAR(100) NOT NULL,
	fechaNac DATE NOT NULL,
	sexo CHAR(1) CHECK (sexo='H' OR sexo='M'),
	cod_curso INT(2),
	FOREIGN KEY (cod_curso) REFERENCES cursos (cod)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);


INSERT INTO profesores VALUES (
	'32432455', 'Juan Arch López', 'Ing. Informática', 'Puerta Negra, 4', 100.00);
INSERT INTO profesores VALUES (
	'43215643', 'María Oliva Rubio', 'Lda. Fil. Inglesa', 'Juan Alfonso 32', 140.00);
/*INSERT INTO alumnos VALUES (
	NULL, 'pepe', 'fernandez', 'c/alba, 4', '01/10/90', 'H', 1);*/
INSERT INTO cursos VALUES (null,'Inglés Básico',15,'01/11/12','22/12/12',120,'43215643'); 
INSERT INTO cursos VALUES (null,'Administración Linux',20,'01/09/12','12/10/12',80,'32432455');
INSERT INTO alumnos VALUES (123523, 'Lucas', 'Manilva López', 'Alhamar 3', 'H', '1979/01/11', 1);
INSERT INTO alumnos VALUES (2567567, 'Antonia', 'López Alcantara', 'Maniquí 21', 'M', NULL, 2);
INSERT INTO alumnos VALUES (3123689, 'Manuel', 'Alcantara Pedrós', 'Julian 22', 'M', NULL, 1);
INSERT INTO alumnos VALUES (4896765, 'José', 'Pérez Caballar', 'Jarcha 5', 'H', '1977/03/02', 1);

COMMIT;

ALTER TABLE profesores ADD CONSTRAINT CHECK (edad >= 18 AND edad <= 65);
ALTER TABLE cursos ADD CONSTRAINT CHECK (num_max >= 10);
ALTER TABLE cursos ADD CONSTRAINT CHECK (num_horas > 100);
  
DESCRIBE profesores;
DESCRIBE cursos;
DESCRIBE alumnos;
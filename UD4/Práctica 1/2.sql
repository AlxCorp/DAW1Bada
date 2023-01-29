DROP DATABASE IF EXISTS academia;
CREATE DATABASE academia;
USE academia;


CREATE TABLE profesores (
	dni VARCHAR(9) PRIMARY KEY,
	nombre VARCHAR(50),
	tutulacion VARCHAR(50),
	direccion VARCHAR(100),
	cuotahora DECIMAL (5,2),
);


CREATE TABLE cursos (
	cod INT(2) AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50),
	num_max INT,
	fecha_inicio DATE,
	fecha_fin DATE,
	num_horas INT,
	dni_prof VARCHAR(9), 
);


CREATE TABLE alumnos (
	dni VARCHAR(9) PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellidos VARCHAR(80) NOT NULL,
	direccion VARCHAR(100) NOT NULL,
	fechaNac DATE NOT NULL,
	sexo CHAR(1) CHECK (sexo='H' OR sexo='M')
);



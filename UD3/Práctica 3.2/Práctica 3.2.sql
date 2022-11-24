-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Practica3_2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Practica3_2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Practica3_2` DEFAULT CHARACTER SET utf8 ;
USE `Practica3_2` ;

-- -----------------------------------------------------
-- Table `Practica3_2`.`Autobuses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Practica3_2`.`Autobuses` ;

CREATE TABLE IF NOT EXISTS `Practica3_2`.`Autobuses` (
  `Matricula` VARCHAR(7) NOT NULL,
  `FechaAdquisicion` DATE NOT NULL,
  `Potencia` VARCHAR(45) NOT NULL,
  `TipoTransoporte` VARCHAR(45) NULL,
  `Anchura` DECIMAL(2) NULL,
  `Longitud` DECIMAL(2) NULL,
  `Color` VARCHAR(45) NULL,
  `AnoFabricacion` YEAR NULL,
  `Modelo` VARCHAR(45) NULL,
  `Marca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Matricula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Practica3_2`.`Empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Practica3_2`.`Empleados` ;

CREATE TABLE IF NOT EXISTS `Practica3_2`.`Empleados` (
  `NIF` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NULL,
  `FechaNacimiento` DATE NULL,
  `FechaIngreso` DATE NOT NULL,
  `Telefono` INT(9) NOT NULL,
  `Tipo` ENUM("Mecanicos", "Conductores", "Administrativos") NULL,
  PRIMARY KEY (`NIF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Practica3_2`.`Mecanicos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Practica3_2`.`Mecanicos` ;

CREATE TABLE IF NOT EXISTS `Practica3_2`.`Mecanicos` (
  `Empleados_NIF` INT NOT NULL,
  `Especialidad` VARCHAR(45) NOT NULL,
  INDEX `fk_Mecanicos_Empleados1_idx` (`Empleados_NIF` ASC) VISIBLE,
  PRIMARY KEY (`Empleados_NIF`),
  CONSTRAINT `fk_Mecanicos_Empleados1`
    FOREIGN KEY (`Empleados_NIF`)
    REFERENCES `Practica3_2`.`Empleados` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Practica3_2`.`Reparaciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Practica3_2`.`Reparaciones` ;

CREATE TABLE IF NOT EXISTS `Practica3_2`.`Reparaciones` (
  `idReparaciones` INT NOT NULL AUTO_INCREMENT,
  `Averia` VARCHAR(45) NOT NULL,
  `Autobuses_Matricula` VARCHAR(45) NOT NULL,
  `Mecanicos_Empleados_NIF` INT NOT NULL,
  PRIMARY KEY (`idReparaciones`),
  INDEX `fk_Reparaciones_Autobuses_idx` (`Autobuses_Matricula` ASC) VISIBLE,
  INDEX `fk_Reparaciones_Mecanicos1_idx` (`Mecanicos_Empleados_NIF` ASC) VISIBLE,
  CONSTRAINT `fk_Reparaciones_Autobuses`
    FOREIGN KEY (`Autobuses_Matricula`)
    REFERENCES `Practica3_2`.`Autobuses` (`Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reparaciones_Mecanicos1`
    FOREIGN KEY (`Mecanicos_Empleados_NIF`)
    REFERENCES `Practica3_2`.`Mecanicos` (`Empleados_NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Practica3_2`.`Conductores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Practica3_2`.`Conductores` ;

CREATE TABLE IF NOT EXISTS `Practica3_2`.`Conductores` (
  `Empleados_NIF` INT NOT NULL,
  `FechaReconocimientoMedico` DATE NOT NULL,
  INDEX `fk_Conductores_Empleados1_idx` (`Empleados_NIF` ASC) VISIBLE,
  PRIMARY KEY (`Empleados_NIF`),
  CONSTRAINT `fk_Conductores_Empleados1`
    FOREIGN KEY (`Empleados_NIF`)
    REFERENCES `Practica3_2`.`Empleados` (`NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Practica3_2`.`CONDUCEN`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Practica3_2`.`CONDUCEN` ;

CREATE TABLE IF NOT EXISTS `Practica3_2`.`CONDUCEN` (
  `Autobuses_Matricula` VARCHAR(7) NOT NULL,
  `Conductores_Empleados_NIF` INT NOT NULL,
  `Periodo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Autobuses_Matricula`, `Conductores_Empleados_NIF`),
  INDEX `fk_Autobuses_has_Conductores_Conductores1_idx` (`Conductores_Empleados_NIF` ASC) VISIBLE,
  INDEX `fk_Autobuses_has_Conductores_Autobuses1_idx` (`Autobuses_Matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Autobuses_has_Conductores_Autobuses1`
    FOREIGN KEY (`Autobuses_Matricula`)
    REFERENCES `Practica3_2`.`Autobuses` (`Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Autobuses_has_Conductores_Conductores1`
    FOREIGN KEY (`Conductores_Empleados_NIF`)
    REFERENCES `Practica3_2`.`Conductores` (`Empleados_NIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Practica3_2`.`Piezas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Practica3_2`.`Piezas` ;

CREATE TABLE IF NOT EXISTS `Practica3_2`.`Piezas` (
  `Cod` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Coste` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`Cod`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Practica3_2`.`USAR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Practica3_2`.`USAR` ;

CREATE TABLE IF NOT EXISTS `Practica3_2`.`USAR` (
  `Reparaciones_idReparaciones` INT NOT NULL,
  `Piezas_Cod` INT NOT NULL,
  PRIMARY KEY (`Reparaciones_idReparaciones`, `Piezas_Cod`),
  INDEX `fk_Reparaciones_has_Piezas_Piezas1_idx` (`Piezas_Cod` ASC) VISIBLE,
  INDEX `fk_Reparaciones_has_Piezas_Reparaciones1_idx` (`Reparaciones_idReparaciones` ASC) VISIBLE,
  CONSTRAINT `fk_Reparaciones_has_Piezas_Reparaciones1`
    FOREIGN KEY (`Reparaciones_idReparaciones`)
    REFERENCES `Practica3_2`.`Reparaciones` (`idReparaciones`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reparaciones_has_Piezas_Piezas1`
    FOREIGN KEY (`Piezas_Cod`)
    REFERENCES `Practica3_2`.`Piezas` (`Cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Practica3_2`.`Proveedores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Practica3_2`.`Proveedores` ;

CREATE TABLE IF NOT EXISTS `Practica3_2`.`Proveedores` (
  `CIF` INT NOT NULL,
  `Direccion` VARCHAR(45) NULL,
  `Telefono` INT(9) NULL,
  `Fax` INT(9) NULL,
  `Email` VARCHAR(45) NULL,
  PRIMARY KEY (`CIF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Practica3_2`.`SUMINISTRAN`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Practica3_2`.`SUMINISTRAN` ;

CREATE TABLE IF NOT EXISTS `Practica3_2`.`SUMINISTRAN` (
  `Piezas_Cod` INT NOT NULL,
  `Proveedores_CIF` INT NOT NULL,
  PRIMARY KEY (`Piezas_Cod`, `Proveedores_CIF`),
  INDEX `fk_Piezas_has_Proveedores_Proveedores1_idx` (`Proveedores_CIF` ASC) VISIBLE,
  INDEX `fk_Piezas_has_Proveedores_Piezas1_idx` (`Piezas_Cod` ASC) VISIBLE,
  CONSTRAINT `fk_Piezas_has_Proveedores_Piezas1`
    FOREIGN KEY (`Piezas_Cod`)
    REFERENCES `Practica3_2`.`Piezas` (`Cod`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Piezas_has_Proveedores_Proveedores1`
    FOREIGN KEY (`Proveedores_CIF`)
    REFERENCES `Practica3_2`.`Proveedores` (`CIF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

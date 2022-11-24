-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema practica3_7
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema practica3_7
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `practica3_7` DEFAULT CHARACTER SET utf8 ;
USE `practica3_7` ;

-- -----------------------------------------------------
-- Table `practica3_7`.`Salones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `practica3_7`.`Salones` ;

CREATE TABLE IF NOT EXISTS `practica3_7`.`Salones` (
  `Nombre` VARCHAR(45) NOT NULL,
  `Fumadores` ENUM('Si', 'No') NOT NULL,
  PRIMARY KEY (`Nombre`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `practica3_7`.`TV`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `practica3_7`.`TV` ;

CREATE TABLE IF NOT EXISTS `practica3_7`.`TV` (
  `idTV` INT NOT NULL,
  `Pulgadas` VARCHAR(45) NOT NULL,
  `Marca` VARCHAR(45) NULL,
  `Salones_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTV`),
  INDEX `fk_TV_Salones_idx` (`Salones_Nombre` ASC) VISIBLE,
  CONSTRAINT `fk_TV_Salones`
    FOREIGN KEY (`Salones_Nombre`)
    REFERENCES `practica3_7`.`Salones` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `practica3_7`.`Mesas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `practica3_7`.`Mesas` ;

CREATE TABLE IF NOT EXISTS `practica3_7`.`Mesas` (
  `idMesas` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  `Material` VARCHAR(45) NULL,
  `Color` VARCHAR(45) NULL,
  `Salones_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMesas`, `Salones_Nombre`),
  INDEX `fk_Mesas_Salones1_idx` (`Salones_Nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Mesas_Salones1`
    FOREIGN KEY (`Salones_Nombre`)
    REFERENCES `practica3_7`.`Salones` (`Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `practica3_7`.`Facturas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `practica3_7`.`Facturas` ;

CREATE TABLE IF NOT EXISTS `practica3_7`.`Facturas` (
  `idFacturas` INT NOT NULL,
  `Mesas_idMesas` INT NOT NULL,
  `Mesas_Salones_Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFacturas`),
  INDEX `fk_Facturas_Mesas1_idx` (`Mesas_idMesas` ASC, `Mesas_Salones_Nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Facturas_Mesas1`
    FOREIGN KEY (`Mesas_idMesas` , `Mesas_Salones_Nombre`)
    REFERENCES `practica3_7`.`Mesas` (`idMesas` , `Salones_Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `practica3_7`.`Items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `practica3_7`.`Items` ;

CREATE TABLE IF NOT EXISTS `practica3_7`.`Items` (
  `idItems` INT NOT NULL,
  `Precio` FLOAT(2) NOT NULL,
  `Descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idItems`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `practica3_7`.`COMPONER`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `practica3_7`.`COMPONER` ;

CREATE TABLE IF NOT EXISTS `practica3_7`.`COMPONER` (
  `Items_idItems` INT NOT NULL,
  `Facturas_idFacturas` INT NOT NULL,
  `Cantidad` INT NOT NULL,
  PRIMARY KEY (`Items_idItems`, `Facturas_idFacturas`),
  INDEX `fk_Items_has_Facturas_Facturas1_idx` (`Facturas_idFacturas` ASC) VISIBLE,
  INDEX `fk_Items_has_Facturas_Items1_idx` (`Items_idItems` ASC) VISIBLE,
  CONSTRAINT `fk_Items_has_Facturas_Items1`
    FOREIGN KEY (`Items_idItems`)
    REFERENCES `practica3_7`.`Items` (`idItems`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Items_has_Facturas_Facturas1`
    FOREIGN KEY (`Facturas_idFacturas`)
    REFERENCES `practica3_7`.`Facturas` (`idFacturas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `practica3_7`.`Mozos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `practica3_7`.`Mozos` ;

CREATE TABLE IF NOT EXISTS `practica3_7`.`Mozos` (
  `DNI` INT NOT NULL,
  `NombreApellido` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DNI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `practica3_7`.`SUSTITUIR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `practica3_7`.`SUSTITUIR` ;

CREATE TABLE IF NOT EXISTS `practica3_7`.`SUSTITUIR` (
  `Mozos_DNI` INT NOT NULL,
  `Mozos_DNI1` INT NOT NULL,
  PRIMARY KEY (`Mozos_DNI`, `Mozos_DNI1`),
  INDEX `fk_Mozos_has_Mozos_Mozos2_idx` (`Mozos_DNI1` ASC) VISIBLE,
  INDEX `fk_Mozos_has_Mozos_Mozos1_idx` (`Mozos_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_Mozos_has_Mozos_Mozos1`
    FOREIGN KEY (`Mozos_DNI`)
    REFERENCES `practica3_7`.`Mozos` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mozos_has_Mozos_Mozos2`
    FOREIGN KEY (`Mozos_DNI1`)
    REFERENCES `practica3_7`.`Mozos` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `practica3_7`.`ASIGNADAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `practica3_7`.`ASIGNADAS` ;

CREATE TABLE IF NOT EXISTS `practica3_7`.`ASIGNADAS` (
  `Mesas_idMesas` INT NOT NULL,
  `Mesas_Salones_Nombre` VARCHAR(45) NOT NULL,
  `Mozos_DNI` INT NOT NULL,
  `Periodo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Mesas_idMesas`, `Mesas_Salones_Nombre`, `Mozos_DNI`),
  INDEX `fk_Mesas_has_Mozos_Mozos1_idx` (`Mozos_DNI` ASC) VISIBLE,
  INDEX `fk_Mesas_has_Mozos_Mesas1_idx` (`Mesas_idMesas` ASC, `Mesas_Salones_Nombre` ASC) VISIBLE,
  CONSTRAINT `fk_Mesas_has_Mozos_Mesas1`
    FOREIGN KEY (`Mesas_idMesas` , `Mesas_Salones_Nombre`)
    REFERENCES `practica3_7`.`Mesas` (`idMesas` , `Salones_Nombre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mesas_has_Mozos_Mozos1`
    FOREIGN KEY (`Mozos_DNI`)
    REFERENCES `practica3_7`.`Mozos` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

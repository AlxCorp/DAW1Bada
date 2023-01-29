-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `biblioteca` DEFAULT CHARACTER SET utf8 ;
USE `biblioteca` ;

-- -----------------------------------------------------
-- Table `biblioteca`.`Autores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `biblioteca`.`Autores` ;

CREATE TABLE IF NOT EXISTS `biblioteca`.`Autores` (
  `codAUTOR` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codAUTOR`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Libros`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `biblioteca`.`Libros` ;

CREATE TABLE IF NOT EXISTS `biblioteca`.`Libros` (
  `codLIBROS` INT NOT NULL,
  `Titulo` VARCHAR(45) NOT NULL,
  `ISBN` INT NOT NULL,
  `Editorial` VARCHAR(45) NULL,
  `Paginas` INT NOT NULL,
  PRIMARY KEY (`codLIBROS`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`ESCRIBIR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `biblioteca`.`ESCRIBIR` ;

CREATE TABLE IF NOT EXISTS `biblioteca`.`ESCRIBIR` (
  `AUTOR_codAUTOR` INT NOT NULL,
  `LIBROS_codLIBROS` INT NOT NULL,
  PRIMARY KEY (`AUTOR_codAUTOR`, `LIBROS_codLIBROS`),
  INDEX `fk_AUTOR_has_LIBROS_LIBROS1_idx` (`LIBROS_codLIBROS` ASC) VISIBLE,
  INDEX `fk_AUTOR_has_LIBROS_AUTOR_idx` (`AUTOR_codAUTOR` ASC) VISIBLE,
  CONSTRAINT `fk_AUTOR_has_LIBROS_AUTOR`
    FOREIGN KEY (`AUTOR_codAUTOR`)
    REFERENCES `biblioteca`.`Autores` (`codAUTOR`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AUTOR_has_LIBROS_LIBROS1`
    FOREIGN KEY (`LIBROS_codLIBROS`)
    REFERENCES `biblioteca`.`Libros` (`codLIBROS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Ejemplares`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `biblioteca`.`Ejemplares` ;

CREATE TABLE IF NOT EXISTS `biblioteca`.`Ejemplares` (
  `codEjemplar` INT NOT NULL,
  `Localizacion` VARCHAR(45) NOT NULL,
  `Libros_codLIBROS` INT NOT NULL,
  PRIMARY KEY (`codEjemplar`),
  INDEX `fk_Ejemplar_Libros1_idx` (`Libros_codLIBROS` ASC) VISIBLE,
  CONSTRAINT `fk_Ejemplar_Libros1`
    FOREIGN KEY (`Libros_codLIBROS`)
    REFERENCES `biblioteca`.`Libros` (`codLIBROS`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`Usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `biblioteca`.`Usuarios` ;

CREATE TABLE IF NOT EXISTS `biblioteca`.`Usuarios` (
  `codUsuario` INT NOT NULL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Telefono` INT NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`codUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`SACAR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `biblioteca`.`SACAR` ;

CREATE TABLE IF NOT EXISTS `biblioteca`.`SACAR` (
  `Usuario_codUsuario` INT NOT NULL,
  `Ejemplar_codEjemplar` INT NOT NULL,
  `FechaDev` DATE NOT NULL,
  `FechaPres` DATE NOT NULL,
  PRIMARY KEY (`Usuario_codUsuario`, `Ejemplar_codEjemplar`),
  INDEX `fk_Usuario_has_Ejemplar_Ejemplar1_idx` (`Ejemplar_codEjemplar` ASC) VISIBLE,
  INDEX `fk_Usuario_has_Ejemplar_Usuario1_idx` (`Usuario_codUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Ejemplar_Usuario1`
    FOREIGN KEY (`Usuario_codUsuario`)
    REFERENCES `biblioteca`.`Usuarios` (`codUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Ejemplar_Ejemplar1`
    FOREIGN KEY (`Ejemplar_codEjemplar`)
    REFERENCES `biblioteca`.`Ejemplares` (`codEjemplar`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

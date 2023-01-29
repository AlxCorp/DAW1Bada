-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CONCIERTOS
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CONCIERTOS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CONCIERTOS` DEFAULT CHARACTER SET utf8 ;
USE `CONCIERTOS` ;

-- -----------------------------------------------------
-- Table `CONCIERTOS`.`Temporada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CONCIERTOS`.`Temporada` ;

CREATE TABLE IF NOT EXISTS `CONCIERTOS`.`Temporada` (
  `idTemporada` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTemporada`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CONCIERTOS`.`Conciertos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CONCIERTOS`.`Conciertos` ;

CREATE TABLE IF NOT EXISTS `CONCIERTOS`.`Conciertos` (
  `idConciertos` INT NOT NULL,
  `fecha-hora` VARCHAR(45) NOT NULL,
  `duración` FLOAT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `Temporada_idTemporada` INT NOT NULL,
  PRIMARY KEY (`idConciertos`),
  INDEX `fk_Conciertos_Temporada_idx` (`Temporada_idTemporada` ASC) VISIBLE,
  CONSTRAINT `fk_Conciertos_Temporada`
    FOREIGN KEY (`Temporada_idTemporada`)
    REFERENCES `CONCIERTOS`.`Temporada` (`idTemporada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CONCIERTOS`.`Programas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CONCIERTOS`.`Programas` ;

CREATE TABLE IF NOT EXISTS `CONCIERTOS`.`Programas` (
  `idProgramas` INT NOT NULL,
  PRIMARY KEY (`idProgramas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CONCIERTOS`.`CONSTA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CONCIERTOS`.`CONSTA` ;

CREATE TABLE IF NOT EXISTS `CONCIERTOS`.`CONSTA` (
  `Conciertos_idConciertos` INT NOT NULL,
  `Programas_idProgramas` INT NOT NULL,
  PRIMARY KEY (`Conciertos_idConciertos`, `Programas_idProgramas`),
  INDEX `fk_Conciertos_has_Programas_Programas1_idx` (`Programas_idProgramas` ASC) VISIBLE,
  INDEX `fk_Conciertos_has_Programas_Conciertos1_idx` (`Conciertos_idConciertos` ASC) VISIBLE,
  CONSTRAINT `fk_Conciertos_has_Programas_Conciertos1`
    FOREIGN KEY (`Conciertos_idConciertos`)
    REFERENCES `CONCIERTOS`.`Conciertos` (`idConciertos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Conciertos_has_Programas_Programas1`
    FOREIGN KEY (`Programas_idProgramas`)
    REFERENCES `CONCIERTOS`.`Programas` (`idProgramas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CONCIERTOS`.`PiezasMusicales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CONCIERTOS`.`PiezasMusicales` ;

CREATE TABLE IF NOT EXISTS `CONCIERTOS`.`PiezasMusicales` (
  `idPiezasMusicales` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `autor` VARCHAR(45) NULL COMMENT 'Este atributo es multievaluado',
  PRIMARY KEY (`idPiezasMusicales`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CONCIERTOS`.`TIENE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CONCIERTOS`.`TIENE` ;

CREATE TABLE IF NOT EXISTS `CONCIERTOS`.`TIENE` (
  `Programas_idProgramas` INT NOT NULL,
  `PiezasMusicales_idPiezasMusicales` INT NOT NULL,
  PRIMARY KEY (`Programas_idProgramas`, `PiezasMusicales_idPiezasMusicales`),
  INDEX `fk_Programas_has_PiezasMusicales_PiezasMusicales1_idx` (`PiezasMusicales_idPiezasMusicales` ASC) VISIBLE,
  INDEX `fk_Programas_has_PiezasMusicales_Programas1_idx` (`Programas_idProgramas` ASC) VISIBLE,
  CONSTRAINT `fk_Programas_has_PiezasMusicales_Programas1`
    FOREIGN KEY (`Programas_idProgramas`)
    REFERENCES `CONCIERTOS`.`Programas` (`idProgramas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Programas_has_PiezasMusicales_PiezasMusicales1`
    FOREIGN KEY (`PiezasMusicales_idPiezasMusicales`)
    REFERENCES `CONCIERTOS`.`PiezasMusicales` (`idPiezasMusicales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CONCIERTOS`.`Interpretes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CONCIERTOS`.`Interpretes` ;

CREATE TABLE IF NOT EXISTS `CONCIERTOS`.`Interpretes` (
  `idInterpretes` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `cv` VARCHAR(45) NOT NULL,
  `tipo` ENUM('individuales', 'grupos', 'orquesta') NOT NULL,
  PRIMARY KEY (`idInterpretes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CONCIERTOS`.`TOCAN`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CONCIERTOS`.`TOCAN` ;

CREATE TABLE IF NOT EXISTS `CONCIERTOS`.`TOCAN` (
  `PiezasMusicales_idPiezasMusicales` INT NOT NULL,
  `Interpretes_idInterpretes` INT NOT NULL,
  PRIMARY KEY (`PiezasMusicales_idPiezasMusicales`, `Interpretes_idInterpretes`),
  INDEX `fk_PiezasMusicales_has_Interpretes_Interpretes1_idx` (`Interpretes_idInterpretes` ASC) VISIBLE,
  INDEX `fk_PiezasMusicales_has_Interpretes_PiezasMusicales1_idx` (`PiezasMusicales_idPiezasMusicales` ASC) VISIBLE,
  CONSTRAINT `fk_PiezasMusicales_has_Interpretes_PiezasMusicales1`
    FOREIGN KEY (`PiezasMusicales_idPiezasMusicales`)
    REFERENCES `CONCIERTOS`.`PiezasMusicales` (`idPiezasMusicales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PiezasMusicales_has_Interpretes_Interpretes1`
    FOREIGN KEY (`Interpretes_idInterpretes`)
    REFERENCES `CONCIERTOS`.`Interpretes` (`idInterpretes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CONCIERTOS`.`Individuales`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CONCIERTOS`.`Individuales` ;

CREATE TABLE IF NOT EXISTS `CONCIERTOS`.`Individuales` (
  `idIndividuales` INT NOT NULL,
  `Interpretes_idInterpretes` INT NOT NULL,
  `instrumento` INT NOT NULL,
  INDEX `fk_Individuales_Interpretes1_idx` (`Interpretes_idInterpretes` ASC) VISIBLE,
  PRIMARY KEY (`idIndividuales`),
  CONSTRAINT `fk_Individuales_Interpretes1`
    FOREIGN KEY (`Interpretes_idInterpretes`)
    REFERENCES `CONCIERTOS`.`Interpretes` (`idInterpretes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CONCIERTOS`.`Grupos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CONCIERTOS`.`Grupos` ;

CREATE TABLE IF NOT EXISTS `CONCIERTOS`.`Grupos` (
  `idGrupos` INT NOT NULL,
  `Interpretes_idInterpretes` INT NOT NULL,
  `tipoFormacion` VARCHAR(45) NULL,
  INDEX `fk_Grupos_Interpretes1_idx` (`Interpretes_idInterpretes` ASC) VISIBLE,
  PRIMARY KEY (`idGrupos`),
  CONSTRAINT `fk_Grupos_Interpretes1`
    FOREIGN KEY (`Interpretes_idInterpretes`)
    REFERENCES `CONCIERTOS`.`Interpretes` (`idInterpretes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CONCIERTOS`.`Orquesta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CONCIERTOS`.`Orquesta` ;

CREATE TABLE IF NOT EXISTS `CONCIERTOS`.`Orquesta` (
  `Interpretes_idInterpretes` INT NOT NULL,
  `numeroMusicos` INT NOT NULL,
  `nombreDirector` VARCHAR(45) NOT NULL,
  INDEX `fk_Orquesta_Interpretes1_idx` (`Interpretes_idInterpretes` ASC) VISIBLE,
  CONSTRAINT `fk_Orquesta_Interpretes1`
    FOREIGN KEY (`Interpretes_idInterpretes`)
    REFERENCES `CONCIERTOS`.`Interpretes` (`idInterpretes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CONCIERTOS`.`Entradas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CONCIERTOS`.`Entradas` ;

CREATE TABLE IF NOT EXISTS `CONCIERTOS`.`Entradas` (
  `fila` INT NOT NULL,
  `asiento` INT NOT NULL,
  `precio` FLOAT(2) NOT NULL,
  `Conciertos_idConciertos` INT NOT NULL,
  PRIMARY KEY (`fila`, `asiento`, `Conciertos_idConciertos`),
  INDEX `fk_Entradas_Conciertos1_idx` (`Conciertos_idConciertos` ASC) VISIBLE,
  CONSTRAINT `fk_Entradas_Conciertos1`
    FOREIGN KEY (`Conciertos_idConciertos`)
    REFERENCES `CONCIERTOS`.`Conciertos` (`idConciertos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CONCIERTOS`.`FORMAN`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CONCIERTOS`.`FORMAN` ;

CREATE TABLE IF NOT EXISTS `CONCIERTOS`.`FORMAN` (
  `Individuales_idIndividuales` INT NOT NULL,
  `Grupos_idGrupos` INT NOT NULL,
  PRIMARY KEY (`Individuales_idIndividuales`, `Grupos_idGrupos`),
  INDEX `fk_Individuales_has_Grupos_Grupos1_idx` (`Grupos_idGrupos` ASC) VISIBLE,
  INDEX `fk_Individuales_has_Grupos_Individuales1_idx` (`Individuales_idIndividuales` ASC) VISIBLE,
  CONSTRAINT `fk_Individuales_has_Grupos_Individuales1`
    FOREIGN KEY (`Individuales_idIndividuales`)
    REFERENCES `CONCIERTOS`.`Individuales` (`idIndividuales`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Individuales_has_Grupos_Grupos1`
    FOREIGN KEY (`Grupos_idGrupos`)
    REFERENCES `CONCIERTOS`.`Grupos` (`idGrupos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

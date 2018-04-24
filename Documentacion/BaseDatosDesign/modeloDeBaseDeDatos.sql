-- MySQL Script generated by MySQL Workbench
-- 04/24/18 17:23:00
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema BaseDatosSuve
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BaseDatosSuve
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BaseDatosSuve` DEFAULT CHARACTER SET utf8 ;
USE `BaseDatosSuve` ;

-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Usuario` (
  `idUsuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `dni` INT NOT NULL,
  `mail` VARCHAR(45) NULL,
  `password` VARCHAR(45) NOT NULL,
  `tipo` ENUM('Administrador', 'Pasajero', 'Cargador') NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC),
  UNIQUE INDEX `DNI_UNIQUE` (`dni` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Tarjeta` (
  `idTarjeta` INT(11) NOT NULL AUTO_INCREMENT,
  `saldo` FLOAT NOT NULL,
  `idUsuario` INT(11) NULL,
  `activa` TINYINT(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`idTarjeta`),
  INDEX `fk_Tarjeta_Usuario_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_Tarjeta_Usuario`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `BaseDatosSuve`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Transporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Transporte` (
  `idTransporte` INT(11) NOT NULL AUTO_INCREMENT,
  `linea` VARCHAR(45) NOT NULL,
  `tipoTransporte` INT NOT NULL,
  PRIMARY KEY (`idTransporte`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Estacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Estacion` (
  `idEstacion` INT(11) NOT NULL AUTO_INCREMENT,
  `idTransporte` INT(11) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  INDEX `fk_Estacion_Transporte1_idx` (`idTransporte` ASC),
  PRIMARY KEY (`idEstacion`),
  CONSTRAINT `fk_Estacion_Transporte1`
    FOREIGN KEY (`idTransporte`)
    REFERENCES `BaseDatosSuve`.`Transporte` (`idTransporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Boleto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Boleto` (
  `idBoleto` INT(11) NOT NULL AUTO_INCREMENT,
  `idTransporte` INT(11) NOT NULL,
  `idTarjeta` INT(11) NOT NULL,
  `fecha` DATETIME(6) NOT NULL,
  `precio` FLOAT NOT NULL,
  `cerrado` TINYINT(1) NOT NULL DEFAULT b'0',
  `estacionSubida` INT(11) NULL,
  `estacionBajada` INT(11) NULL,
  PRIMARY KEY (`idBoleto`),
  INDEX `fk_Boleto_Transporte1_idx` (`idTransporte` ASC),
  INDEX `fk_Boleto_Tarjeta1_idx` (`idTarjeta` ASC),
  INDEX `fk_Boleto_Estacion2_idx` (`estacionBajada` ASC),
  INDEX `fk_Boleto_Estacion1_idx` (`estacionSubida` ASC),
  CONSTRAINT `fk_Boleto_Transporte1`
    FOREIGN KEY (`idTransporte`)
    REFERENCES `BaseDatosSuve`.`Transporte` (`idTransporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Boleto_Tarjeta1`
    FOREIGN KEY (`idTarjeta`)
    REFERENCES `BaseDatosSuve`.`Tarjeta` (`idTarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Boleto_Estacion2`
    FOREIGN KEY (`estacionBajada`)
    REFERENCES `BaseDatosSuve`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Boleto_Estacion1`
    FOREIGN KEY (`estacionSubida`)
    REFERENCES `BaseDatosSuve`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Recarga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Recarga` (
  `idRecarga` INT(11) NOT NULL AUTO_INCREMENT,
  `idTarjeta` INT(11) NOT NULL,
  `fecha` DATETIME(6) NOT NULL,
  `saldo` FLOAT NOT NULL,
  PRIMARY KEY (`idRecarga`),
  CONSTRAINT `fk_Recarga_Tarjeta1`
    FOREIGN KEY (`idTarjeta`)
    REFERENCES `BaseDatosSuve`.`Tarjeta` (`idTarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Seccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Seccion` (
  `idSeccion` INT(11) NOT NULL AUTO_INCREMENT,
  `precio` FLOAT NOT NULL,
  PRIMARY KEY (`idSeccion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Tramo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Tramo` (
  `idTramo` INT(11) NOT NULL AUTO_INCREMENT,
  `eIngreso` INT(11) NOT NULL,
  `eSalida` INT(11) NOT NULL,
  `idSeccion` INT(11) NOT NULL,
  PRIMARY KEY (`idTramo`),
  INDEX `fk_Tramo_Estacion1_idx` (`eIngreso` ASC),
  INDEX `fk_Tramo_Estacion2_idx` (`eSalida` ASC),
  INDEX `fk_Tramo_Seccion1_idx` (`idSeccion` ASC),
  CONSTRAINT `fk_Tramo_Estacion1`
    FOREIGN KEY (`eIngreso`)
    REFERENCES `BaseDatosSuve`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tramo_Estacion2`
    FOREIGN KEY (`eSalida`)
    REFERENCES `BaseDatosSuve`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tramo_Seccion1`
    FOREIGN KEY (`idSeccion`)
    REFERENCES `BaseDatosSuve`.`Seccion` (`idSeccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Beneficio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Beneficio` (
  `idBeneficio` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idBeneficio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`UsuarioXBeneficio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`UsuarioXBeneficio` (
  `idUsuario` INT(11) NOT NULL,
  `idBeneficio` INT(11) NOT NULL,
  PRIMARY KEY (`idUsuario`, `idBeneficio`),
  INDEX `fk_Usuario_has_Beneficio_Beneficio1_idx` (`idBeneficio` ASC),
  INDEX `fk_Usuario_has_Beneficio_Usuario1_idx` (`idUsuario` ASC),
  CONSTRAINT `fk_Usuario_has_Beneficio_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `BaseDatosSuve`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Beneficio_Beneficio1`
    FOREIGN KEY (`idBeneficio`)
    REFERENCES `BaseDatosSuve`.`Beneficio` (`idBeneficio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

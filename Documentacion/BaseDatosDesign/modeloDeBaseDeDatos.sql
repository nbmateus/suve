-- MySQL Script generated by MySQL Workbench
-- Tue May 15 14:38:19 2018
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
  `tipoUsuario` INT NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC),
  UNIQUE INDEX `DNI_UNIQUE` (`dni` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Tarjeta` (
  `idTarjeta` INT(11) NOT NULL AUTO_INCREMENT,
  `monto` FLOAT NOT NULL,
  `idUsuario` INT(11) NULL,
  `activa` TINYINT(1) NOT NULL DEFAULT b'0',
  `numeroSerieTarjeta` INT NOT NULL,
  PRIMARY KEY (`idTarjeta`),
  INDEX `fk_Tarjeta_Usuario_idx` (`idUsuario` ASC),
  UNIQUE INDEX `numeroSerieTarjeta_UNIQUE` (`numeroSerieTarjeta` ASC),
  CONSTRAINT `fk_Tarjeta_Usuario`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `BaseDatosSuve`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Lectora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Lectora` (
  `idLectora` INT(11) NOT NULL AUTO_INCREMENT,
  `numeroSerieLectora` INT NOT NULL,
  PRIMARY KEY (`idLectora`),
  UNIQUE INDEX `numeroSerieLectora_UNIQUE` (`numeroSerieLectora` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Movimiento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Movimiento` (
  `idMovimiento` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `monto` FLOAT NULL,
  `idTarjeta` INT(11) NOT NULL,
  `idLectora` INT(11) NOT NULL,
  PRIMARY KEY (`idMovimiento`),
  INDEX `fk_Movimiento_Tarjeta1_idx` (`idTarjeta` ASC),
  INDEX `fk_Movimiento_Lectora1_idx` (`idLectora` ASC),
  CONSTRAINT `fk_Movimiento_Tarjeta1`
    FOREIGN KEY (`idTarjeta`)
    REFERENCES `BaseDatosSuve`.`Tarjeta` (`idTarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Movimiento_Lectora1`
    FOREIGN KEY (`idLectora`)
    REFERENCES `BaseDatosSuve`.`Lectora` (`idLectora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`SeccionViaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`SeccionViaje` (
  `idSeccionViaje` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `monto` FLOAT NOT NULL,
  PRIMARY KEY (`idSeccionViaje`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`TramoColectivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`TramoColectivo` (
  `idTramoColectivo` INT(11) NOT NULL AUTO_INCREMENT,
  `kMin` FLOAT NULL,
  `kMax` FLOAT NULL,
  `idSeccionViaje` INT(11) NOT NULL,
  PRIMARY KEY (`idTramoColectivo`),
  INDEX `fk_TramoColectivo_SeccionViaje1_idx` (`idSeccionViaje` ASC),
  CONSTRAINT `fk_TramoColectivo_SeccionViaje1`
    FOREIGN KEY (`idSeccionViaje`)
    REFERENCES `BaseDatosSuve`.`SeccionViaje` (`idSeccionViaje`)
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
-- Table `BaseDatosSuve`.`TramoTrenYSubte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`TramoTrenYSubte` (
  `idTramoTrenYSubte` INT(11) NOT NULL AUTO_INCREMENT,
  `estacionA` INT(11) NOT NULL,
  `estacionB` INT(11) NULL,
  `idSeccionViaje` INT(11) NOT NULL,
  INDEX `fk_TramoTrenYSubte_Estacion1_idx` (`estacionA` ASC),
  INDEX `fk_TramoTrenYSubte_Estacion2_idx` (`estacionB` ASC),
  PRIMARY KEY (`idTramoTrenYSubte`),
  INDEX `fk_TramoTrenYSubte_SeccionViaje1_idx` (`idSeccionViaje` ASC),
  CONSTRAINT `fk_TramoTrenYSubte_Estacion1`
    FOREIGN KEY (`estacionA`)
    REFERENCES `BaseDatosSuve`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TramoTrenYSubte_Estacion2`
    FOREIGN KEY (`estacionB`)
    REFERENCES `BaseDatosSuve`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TramoTrenYSubte_SeccionViaje1`
    FOREIGN KEY (`idSeccionViaje`)
    REFERENCES `BaseDatosSuve`.`SeccionViaje` (`idSeccionViaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Boleto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Boleto` (
  `idMovimiento` INT(11) NOT NULL AUTO_INCREMENT,
  `intRedSube` INT NULL,
  `idTramoColectivo` INT(11) NULL,
  `idTramoTrenYSubte` INT(11) NULL,
  PRIMARY KEY (`idMovimiento`),
  INDEX `fk_Boleto_Movimiento1_idx` (`idMovimiento` ASC),
  INDEX `fk_Boleto_TramoColectivo1_idx` (`idTramoColectivo` ASC),
  INDEX `fk_Boleto_TramoTrenYSubte1_idx` (`idTramoTrenYSubte` ASC),
  CONSTRAINT `fk_Boleto_Movimiento1`
    FOREIGN KEY (`idMovimiento`)
    REFERENCES `BaseDatosSuve`.`Movimiento` (`idMovimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Boleto_TramoColectivo1`
    FOREIGN KEY (`idTramoColectivo`)
    REFERENCES `BaseDatosSuve`.`TramoColectivo` (`idTramoColectivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Boleto_TramoTrenYSubte1`
    FOREIGN KEY (`idTramoTrenYSubte`)
    REFERENCES `BaseDatosSuve`.`TramoTrenYSubte` (`idTramoTrenYSubte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`Recarga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`Recarga` (
  `idMovimiento` INT(11) NOT NULL AUTO_INCREMENT,
  `saldoPendiente` TINYINT(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`idMovimiento`),
  INDEX `fk_Recarga_Movimiento1_idx` (`idMovimiento` ASC),
  CONSTRAINT `fk_Recarga_Movimiento1`
    FOREIGN KEY (`idMovimiento`)
    REFERENCES `BaseDatosSuve`.`Movimiento` (`idMovimiento`)
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


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`TarjetaXBeneficio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`TarjetaXBeneficio` (
  `idTarjeta` INT(11) NOT NULL,
  `idBeneficio` INT(11) NOT NULL,
  PRIMARY KEY (`idTarjeta`, `idBeneficio`),
  INDEX `fk_Tarjeta_has_Beneficio_Beneficio1_idx` (`idBeneficio` ASC),
  INDEX `fk_Tarjeta_has_Beneficio_Tarjeta1_idx` (`idTarjeta` ASC),
  CONSTRAINT `fk_Tarjeta_has_Beneficio_Tarjeta1`
    FOREIGN KEY (`idTarjeta`)
    REFERENCES `BaseDatosSuve`.`Tarjeta` (`idTarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tarjeta_has_Beneficio_Beneficio1`
    FOREIGN KEY (`idBeneficio`)
    REFERENCES `BaseDatosSuve`.`Beneficio` (`idBeneficio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`TarifaSocial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`TarifaSocial` (
  `porcentajeDescuento` FLOAT NULL,
  `idBeneficio` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idBeneficio`),
  CONSTRAINT `fk_TarifaSocial_Beneficio1`
    FOREIGN KEY (`idBeneficio`)
    REFERENCES `BaseDatosSuve`.`Beneficio` (`idBeneficio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`BoletoEstudiantil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`BoletoEstudiantil` (
  `intervalo` DATETIME NULL,
  `monto` FLOAT NULL,
  `idBeneficio` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idBeneficio`),
  CONSTRAINT `fk_Asignacion_Beneficio1`
    FOREIGN KEY (`idBeneficio`)
    REFERENCES `BaseDatosSuve`.`Beneficio` (`idBeneficio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`LectoraTrenYSubte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`LectoraTrenYSubte` (
  `idLectora` INT(11) NOT NULL AUTO_INCREMENT,
  `idEstacion` INT(11) NOT NULL,
  PRIMARY KEY (`idLectora`),
  INDEX `fk_LectoraTrenYSubte_Lectora1_idx` (`idLectora` ASC),
  INDEX `fk_LectoraTrenYSubte_Estacion1_idx` (`idEstacion` ASC),
  CONSTRAINT `fk_LectoraTrenYSubte_Lectora1`
    FOREIGN KEY (`idLectora`)
    REFERENCES `BaseDatosSuve`.`Lectora` (`idLectora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LectoraTrenYSubte_Estacion1`
    FOREIGN KEY (`idEstacion`)
    REFERENCES `BaseDatosSuve`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`LectoraColectivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`LectoraColectivo` (
  `idLectora` INT(11) NOT NULL AUTO_INCREMENT,
  `idTransporte` INT(11) NOT NULL,
  PRIMARY KEY (`idLectora`),
  INDEX `fk_LectoraColectivo_Transporte1_idx` (`idTransporte` ASC),
  CONSTRAINT `fk_LectoraColectivo_Lectora1`
    FOREIGN KEY (`idLectora`)
    REFERENCES `BaseDatosSuve`.`Lectora` (`idLectora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LectoraColectivo_Transporte1`
    FOREIGN KEY (`idTransporte`)
    REFERENCES `BaseDatosSuve`.`Transporte` (`idTransporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`LectoraAutonoma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`LectoraAutonoma` (
  `ubicacion` VARCHAR(45) NOT NULL,
  `idLectora` INT(11) NOT NULL,
  `idEstacion` INT(11) NOT NULL,
  PRIMARY KEY (`idLectora`),
  INDEX `fk_LectoraAutonomoa_Lectora1_idx` (`idLectora` ASC),
  INDEX `fk_LectoraAutonomoa_Estacion1_idx` (`idEstacion` ASC),
  CONSTRAINT `fk_LectoraAutonomoa_Lectora1`
    FOREIGN KEY (`idLectora`)
    REFERENCES `BaseDatosSuve`.`Lectora` (`idLectora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LectoraAutonomoa_Estacion1`
    FOREIGN KEY (`idEstacion`)
    REFERENCES `BaseDatosSuve`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BaseDatosSuve`.`LectoraCarga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BaseDatosSuve`.`LectoraCarga` (
  `idEstacion` INT(11) NOT NULL,
  `idLectora` INT(11) NOT NULL,
  INDEX `fk_LectoraCarga_Estacion1_idx` (`idEstacion` ASC),
  INDEX `fk_LectoraCarga_Lectora1_idx` (`idLectora` ASC),
  CONSTRAINT `fk_LectoraCarga_Estacion1`
    FOREIGN KEY (`idEstacion`)
    REFERENCES `BaseDatosSuve`.`Estacion` (`idEstacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LectoraCarga_Lectora1`
    FOREIGN KEY (`idLectora`)
    REFERENCES `BaseDatosSuve`.`Lectora` (`idLectora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

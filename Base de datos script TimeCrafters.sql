-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BD_TimeCrafters
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BD_TimeCrafters
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BD_TimeCrafters` DEFAULT CHARACTER SET utf8 ;
USE `BD_TimeCrafters` ;

-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`ciudades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`ciudades` (
  `ciudades_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ciudades_nombre` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`ciudades_id`),
  UNIQUE INDEX `ciudades_nombre_UNIQUE` (`ciudades_nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`usuarios` (
  `usuarios_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `usuarios_nombres` VARCHAR(60) NOT NULL,
  `usuarios_apellidos` VARCHAR(70) NOT NULL,
  `usuarios_identificacion` BIGINT(12) UNSIGNED NOT NULL,
  `usuarios_correo` VARCHAR(80) NOT NULL,
  `usuarios_ciudades_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`usuarios_id`, `usuarios_ciudades_id`),
  UNIQUE INDEX `usuarios_correo_UNIQUE` (`usuarios_correo` ASC) VISIBLE,
  UNIQUE INDEX `usuarios_identificacion_UNIQUE` (`usuarios_identificacion` ASC) VISIBLE,
  INDEX `fk_usuarios_ciudades1_idx` (`usuarios_ciudades_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_ciudades1`
    FOREIGN KEY (`usuarios_ciudades_id`)
    REFERENCES `BD_TimeCrafters`.`ciudades` (`ciudades_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`login` (
  `login_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `login_user` BIGINT(12) NOT NULL,
  `login_password` VARCHAR(100) NOT NULL,
  `usuarios_usuarios_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`login_id`, `usuarios_usuarios_id`),
  UNIQUE INDEX `login_user_UNIQUE` (`login_user` ASC) VISIBLE,
  UNIQUE INDEX `login_password_UNIQUE` (`login_password` ASC) VISIBLE,
  INDEX `fk_login_usuarios1_idx` (`usuarios_usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_login_usuarios1`
    FOREIGN KEY (`usuarios_usuarios_id`)
    REFERENCES `BD_TimeCrafters`.`usuarios` (`usuarios_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`instructores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`instructores` (
  `instructores_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `instructores_tipo_contrato` ENUM('Contratista', 'Planta') NOT NULL,
  `instructores_horas_laboradas` TINYINT NOT NULL,
  `instructores_fecha_inicio_contrato` DATE NOT NULL,
  `instructores_fecha_fin_contrato` DATE NOT NULL,
  `instructores_estado_contrato` ENUM('Activo', 'Contrado finalizado', 'Cancelado') NOT NULL,
  `instructores_usuarios_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`instructores_id`, `instructores_usuarios_id`),
  INDEX `fk_instructores_usuarios1_idx` (`instructores_usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_instructores_usuarios1`
    FOREIGN KEY (`instructores_usuarios_id`)
    REFERENCES `BD_TimeCrafters`.`usuarios` (`usuarios_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`coordinadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`coordinadores` (
  `coordinadores_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `coordinadores_area_cargo` ENUM('Academico', 'Disciplinario') NOT NULL,
  `coordinadores_usuarios_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`coordinadores_id`, `coordinadores_usuarios_id`),
  INDEX `fk_coordinadores_usuarios1_idx` (`coordinadores_usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_coordinadores_usuarios1`
    FOREIGN KEY (`coordinadores_usuarios_id`)
    REFERENCES `BD_TimeCrafters`.`usuarios` (`usuarios_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`barrios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`barrios` (
  `barrios_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `barrios_nombre` VARCHAR(80) NOT NULL,
  `barrios_ciudades_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`barrios_id`, `barrios_ciudades_id`),
  UNIQUE INDEX `barrios_nombre_UNIQUE` (`barrios_nombre` ASC) VISIBLE,
  INDEX `fk_barrios_ciudades1_idx` (`barrios_ciudades_id` ASC) VISIBLE,
  CONSTRAINT `fk_barrios_ciudades1`
    FOREIGN KEY (`barrios_ciudades_id`)
    REFERENCES `BD_TimeCrafters`.`ciudades` (`ciudades_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`departamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`departamentos` (
  `departamentos_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `departamentos_nombre` VARCHAR(60) NOT NULL,
  `departamentos_ciudades_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`departamentos_id`, `departamentos_ciudades_id`),
  UNIQUE INDEX `departamentos_nombre_UNIQUE` (`departamentos_nombre` ASC) VISIBLE,
  INDEX `fk_departamentos_ciudades1_idx` (`departamentos_ciudades_id` ASC) VISIBLE,
  CONSTRAINT `fk_departamentos_ciudades1`
    FOREIGN KEY (`departamentos_ciudades_id`)
    REFERENCES `BD_TimeCrafters`.`ciudades` (`ciudades_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`profesiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`profesiones` (
  `profesiones_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `profesiones_nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`profesiones_id`),
  UNIQUE INDEX `profesiones_nombre_UNIQUE` (`profesiones_nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`tituladas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`tituladas` (
  `tituladas_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tituladas_nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`tituladas_id`),
  UNIQUE INDEX `tituladas_nombre_UNIQUE` (`tituladas_nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`competencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`competencias` (
  `competencias_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `competencias_nombre` VARCHAR(60) NOT NULL,
  `competencias_tiempo` SMALLINT NOT NULL,
  `competencias_fecha_inicio` DATE NOT NULL,
  `competencias_fecha_fin` DATE NOT NULL,
  `competencias_resultados_competencias_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`competencias_id`, `competencias_resultados_competencias_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`ambientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`ambientes` (
  `ambientes_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ambientes_numero_ambiente` VARCHAR(60) NOT NULL,
  `ambientes_numero_bloque` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ambientes_id`),
  UNIQUE INDEX `ambientes_numero_ambiente_UNIQUE` (`ambientes_numero_ambiente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`jornadas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`jornadas` (
  `jornadas_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `jornadas_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`jornadas_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`fichas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`fichas` (
  `fichas_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fichas_numero` BIGINT(12) UNSIGNED NOT NULL,
  `fichas_fecha_inicio` DATE NOT NULL,
  `fichas_fecha_fin` DATE NOT NULL,
  `fichas_estado` ENUM('En formacion', 'Finalizada') NOT NULL,
  `fichas_tituladas_id` INT UNSIGNED NOT NULL,
  `fichas_jornadas_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`fichas_id`, `fichas_tituladas_id`, `fichas_jornadas_id`),
  UNIQUE INDEX `ficha_numero_UNIQUE` (`fichas_numero` ASC) VISIBLE,
  INDEX `fk_fichas_tituladas1_idx` (`fichas_tituladas_id` ASC) VISIBLE,
  INDEX `fk_fichas_jornadas1_idx` (`fichas_jornadas_id` ASC) VISIBLE,
  CONSTRAINT `fk_fichas_tituladas1`
    FOREIGN KEY (`fichas_tituladas_id`)
    REFERENCES `BD_TimeCrafters`.`tituladas` (`tituladas_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_fichas_jornadas1`
    FOREIGN KEY (`fichas_jornadas_id`)
    REFERENCES `BD_TimeCrafters`.`jornadas` (`jornadas_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`horarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`horarios` (
  `horarios_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `horarios_hora_inicio` TIME NOT NULL,
  `horarios_hora_fin` TIME NOT NULL,
  `horarios_fecha` DATE NOT NULL,
  `ambientes_ambientes_id` INT UNSIGNED NOT NULL,
  `fichas_fichas_id` INT UNSIGNED NOT NULL,
  `instructores_instructores_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`horarios_id`, `ambientes_ambientes_id`, `fichas_fichas_id`, `instructores_instructores_id`),
  INDEX `fk_horarios_ambientes1_idx` (`ambientes_ambientes_id` ASC) VISIBLE,
  INDEX `fk_horarios_fichas1_idx` (`fichas_fichas_id` ASC) VISIBLE,
  INDEX `fk_horarios_instructores1_idx` (`instructores_instructores_id` ASC) VISIBLE,
  CONSTRAINT `fk_horarios_ambientes1`
    FOREIGN KEY (`ambientes_ambientes_id`)
    REFERENCES `BD_TimeCrafters`.`ambientes` (`ambientes_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_horarios_fichas1`
    FOREIGN KEY (`fichas_fichas_id`)
    REFERENCES `BD_TimeCrafters`.`fichas` (`fichas_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_horarios_instructores1`
    FOREIGN KEY (`instructores_instructores_id`)
    REFERENCES `BD_TimeCrafters`.`instructores` (`instructores_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`niveles_formativos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`niveles_formativos` (
  `niveles_formativos_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `niveles_formativos_nombre` ENUM('Tecnico', 'Tecnologo') NOT NULL,
  PRIMARY KEY (`niveles_formativos_id`),
  UNIQUE INDEX `niveles_formativos_nombre_UNIQUE` (`niveles_formativos_nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`aprendices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`aprendices` (
  `aprendices_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `aprendices_usuarios_id` INT UNSIGNED NOT NULL,
  `aprendices_niveles_formativos_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`aprendices_id`, `aprendices_usuarios_id`, `aprendices_niveles_formativos_id`),
  INDEX `fk_aprendices_usuarios1_idx` (`aprendices_usuarios_id` ASC) VISIBLE,
  INDEX `fk_aprendices_niveles_formativos1_idx` (`aprendices_niveles_formativos_id` ASC) VISIBLE,
  CONSTRAINT `fk_aprendices_usuarios1`
    FOREIGN KEY (`aprendices_usuarios_id`)
    REFERENCES `BD_TimeCrafters`.`usuarios` (`usuarios_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_aprendices_niveles_formativos1`
    FOREIGN KEY (`aprendices_niveles_formativos_id`)
    REFERENCES `BD_TimeCrafters`.`niveles_formativos` (`niveles_formativos_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`coordinadores_instructores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`coordinadores_instructores` (
  `coordinadores_instructores_instructores_id` INT UNSIGNED NOT NULL,
  `coordinadores_instructores_coordinadores_id` INT UNSIGNED NOT NULL,
  `coordinadores_instructores_fecha_inicio` DATE NOT NULL,
  `coordinadores_instructores_fecha_fin` DATE NOT NULL,
  PRIMARY KEY (`coordinadores_instructores_instructores_id`, `coordinadores_instructores_coordinadores_id`),
  INDEX `fk_instructores_has_coordinadores_coordinadores1_idx` (`coordinadores_instructores_coordinadores_id` ASC) VISIBLE,
  INDEX `fk_instructores_has_coordinadores_instructores_idx` (`coordinadores_instructores_instructores_id` ASC) VISIBLE,
  CONSTRAINT `fk_instructores_has_coordinadores_instructores`
    FOREIGN KEY (`coordinadores_instructores_instructores_id`)
    REFERENCES `BD_TimeCrafters`.`instructores` (`instructores_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_instructores_has_coordinadores_coordinadores1`
    FOREIGN KEY (`coordinadores_instructores_coordinadores_id`)
    REFERENCES `BD_TimeCrafters`.`coordinadores` (`coordinadores_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`cursos_asociados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`cursos_asociados` (
  `cursos_asociados_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `cursos_asociados_nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`cursos_asociados_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`competencias_tituladas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`competencias_tituladas` (
  `competencias_tituladas_competencias_id` INT UNSIGNED NOT NULL,
  `competencias_tituladas_tituladas_id` INT UNSIGNED NOT NULL,
  `competencias_tituladas_resultado` ENUM('Calificado', 'Pendiente', 'Sin calificar') NOT NULL,
  PRIMARY KEY (`competencias_tituladas_competencias_id`, `competencias_tituladas_tituladas_id`),
  INDEX `fk_competencias_has_tituladas_tituladas1_idx` (`competencias_tituladas_tituladas_id` ASC) VISIBLE,
  INDEX `fk_competencias_has_tituladas_competencias1_idx` (`competencias_tituladas_competencias_id` ASC) VISIBLE,
  CONSTRAINT `fk_competencias_has_tituladas_competencias1`
    FOREIGN KEY (`competencias_tituladas_competencias_id`)
    REFERENCES `BD_TimeCrafters`.`competencias` (`competencias_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_competencias_has_tituladas_tituladas1`
    FOREIGN KEY (`competencias_tituladas_tituladas_id`)
    REFERENCES `BD_TimeCrafters`.`tituladas` (`tituladas_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`instructores_profesiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`instructores_profesiones` (
  `instructores_profesiones_instructores_id` INT UNSIGNED NOT NULL,
  `instructores_profesiones_profesiones_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`instructores_profesiones_instructores_id`, `instructores_profesiones_profesiones_id`),
  INDEX `fk_instructores_has_profesiones_profesiones1_idx` (`instructores_profesiones_profesiones_id` ASC) VISIBLE,
  INDEX `fk_instructores_has_profesiones_instructores1_idx` (`instructores_profesiones_instructores_id` ASC) VISIBLE,
  CONSTRAINT `fk_instructores_has_profesiones_instructores1`
    FOREIGN KEY (`instructores_profesiones_instructores_id`)
    REFERENCES `BD_TimeCrafters`.`instructores` (`instructores_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_instructores_has_profesiones_profesiones1`
    FOREIGN KEY (`instructores_profesiones_profesiones_id`)
    REFERENCES `BD_TimeCrafters`.`profesiones` (`profesiones_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`cursos_asociados_instructores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`cursos_asociados_instructores` (
  `cursos_asociados_instructores_id` INT UNSIGNED NOT NULL,
  `cursos_asociados_cursos asociados_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`cursos_asociados_instructores_id`, `cursos_asociados_cursos asociados_id`),
  INDEX `fk_instructores_has_cursos asociados_cursos asociados1_idx` (`cursos_asociados_cursos asociados_id` ASC) VISIBLE,
  INDEX `fk_instructores_has_cursos asociados_instructores1_idx` (`cursos_asociados_instructores_id` ASC) VISIBLE,
  CONSTRAINT `fk_instructores_has_cursos asociados_instructores1`
    FOREIGN KEY (`cursos_asociados_instructores_id`)
    REFERENCES `BD_TimeCrafters`.`instructores` (`instructores_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_instructores_has_cursos asociados_cursos asociados1`
    FOREIGN KEY (`cursos_asociados_cursos asociados_id`)
    REFERENCES `BD_TimeCrafters`.`cursos_asociados` (`cursos_asociados_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`aprendices_fichas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`aprendices_fichas` (
  `aprendices_fichas_fichas_id` INT UNSIGNED NOT NULL,
  `aprendices_fichas_aprendices_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`aprendices_fichas_fichas_id`, `aprendices_fichas_aprendices_id`),
  INDEX `fk_fichas_has_aprendices_aprendices1_idx` (`aprendices_fichas_aprendices_id` ASC) VISIBLE,
  INDEX `fk_fichas_has_aprendices_fichas1_idx` (`aprendices_fichas_fichas_id` ASC) VISIBLE,
  CONSTRAINT `fk_fichas_has_aprendices_fichas1`
    FOREIGN KEY (`aprendices_fichas_fichas_id`)
    REFERENCES `BD_TimeCrafters`.`fichas` (`fichas_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_fichas_has_aprendices_aprendices1`
    FOREIGN KEY (`aprendices_fichas_aprendices_id`)
    REFERENCES `BD_TimeCrafters`.`aprendices` (`aprendices_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`roles` (
  `roles_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `roles_nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`roles_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_TimeCrafters`.`roles_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_TimeCrafters`.`roles_usuarios` (
  `roles_usuarios_usuarios_id` INT UNSIGNED NOT NULL,
  `roles_usuarios_roles_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`roles_usuarios_usuarios_id`, `roles_usuarios_roles_id`),
  INDEX `fk_usuarios_has_roles_roles1_idx` (`roles_usuarios_roles_id` ASC) VISIBLE,
  INDEX `fk_usuarios_has_roles_usuarios1_idx` (`roles_usuarios_usuarios_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_has_roles_usuarios1`
    FOREIGN KEY (`roles_usuarios_usuarios_id`)
    REFERENCES `BD_TimeCrafters`.`usuarios` (`usuarios_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_usuarios_has_roles_roles1`
    FOREIGN KEY (`roles_usuarios_roles_id`)
    REFERENCES `BD_TimeCrafters`.`roles` (`roles_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- MySQL Workbench Forward Engineering



-- -----------------------------------------------------
-- Schema compressor_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema compressor_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `compressor_db` DEFAULT CHARACTER SET utf8 ;
USE `compressor_db` ;

-- -----------------------------------------------------
-- Table `compressor_db`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compressor_db`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `compressor_db`.`falha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compressor_db`.`falha` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `compressor_db`.`compressor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compressor_db`.`compressor` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `senai` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `compressor_db`.`registro_compressor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compressor_db`.`registro_compressor` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `data_hora` DATETIME NULL,
  `estado` TINYINT NULL,
  `temperatura_ar_Comprimido` FLOAT NULL,
  `temperatura_ambiente` FLOAT NULL,
  `temperatura_oleo` FLOAT NULL,
  `pressao_ar_comprimido` FLOAT NULL,
  `hora_carga` FLOAT NULL,
  `hora_total` FLOAT NULL,
  `pressao_carga` FLOAT NULL,
  `falha_idFalha` INT NULL,
  `compressor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_registro compressor_falha1_idx` (`falha_idFalha` ASC) VISIBLE,
  INDEX `fk_registro_compressor_compressor1_idx` (`compressor_id` ASC) VISIBLE,
  CONSTRAINT `fk_registro compressor_falha1`
    FOREIGN KEY (`falha_idFalha`)
    REFERENCES `compressor_db`.`falha` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registro_compressor_compressor1`
    FOREIGN KEY (`compressor_id`)
    REFERENCES `compressor_db`.`compressor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `compressor_db`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compressor_db`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `compressor_db`.`usuario_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `compressor_db`.`usuario_roles` (
  `roles_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`roles_id`, `usuario_id`),
  INDEX `fk_roles_has_usuario_usuario1_idx` (`usuario_id` ASC) VISIBLE,
  INDEX `fk_roles_has_usuario_roles1_idx` (`roles_id` ASC) VISIBLE,
  CONSTRAINT `fk_roles_has_usuario_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `compressor_db`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_roles_has_usuario_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `compressor_db`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;







-- ------------------------------------------------------------------------------------------ --

-- compressor ---

-- ------------------------------------------------------------------------------------------ --

INSERT INTO compressor_db.compressor (nome, senai) VALUES ("Compressor Teste", "Senai 601");
INSERT INTO compressor_db.compressor (nome, senai) VALUES ("Compressor 2", "Senai 001");

-- ------------------------------------------------------------------------------------------ --

-- registro_compressor --

-- ------------------------------------------------------------------------------------------ --

INSERT INTO compressor_db.registro_compressor
(data_hora, estado, hora_carga, hora_total, pressao_ar_comprimido, pressao_carga,
 temperatura_ambiente, temperatura_ar_comprimido, temperatura_oleo, compressor_id)
VALUES
('2025-10-03 09:30:00', true, 120, 540, 7.5, 8.0, 25.3, 45.2, 60.8, 1);

INSERT INTO compressor_db.registro_compressor
(data_hora, estado, hora_carga, hora_total, pressao_ar_comprimido, pressao_carga,
 temperatura_ambiente, temperatura_ar_comprimido, temperatura_oleo, compressor_id)
VALUES
('2025-10-03 09:35:00', false, 120, 540, 7.5, 8.0, 25.3, 45.2, 60.8, 1);

INSERT INTO compressor_db.registro_compressor
(data_hora, estado, hora_carga, hora_total, pressao_ar_comprimido, pressao_carga,
 temperatura_ambiente, temperatura_ar_comprimido, temperatura_oleo, compressor_id)
VALUES
('2025-10-03 09:30:00', false, 120, 540, 7.5, 8.0, 25.3, 45.2, 60.8, 2);

-- ------------------------------------------------------------------------------------------ --

-- usuario/roles --

-- ------------------------------------------------------------------------------------------ --

INSERT INTO compressor_db.roles (nome) VALUES ("admin");
INSERT INTO compressor_db.roles (nome) VALUES ("basic");

-- ------------------------------------------------------------------------------------------ --
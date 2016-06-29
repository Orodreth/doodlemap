-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema doodlemap_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema doodlemap_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `doodlemap_db` DEFAULT CHARACTER SET utf8 ;
USE `doodlemap_db` ;

-- -----------------------------------------------------
-- Table `doodlemap_db`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doodlemap_db`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doodlemap_db`.`surveys`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doodlemap_db`.`surveys` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NULL,
  `created_at` DATETIME NULL,
  `updated_at` VARCHAR(45) NULL,
  `created_by` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_surveys_users_idx` (`created_by` ASC),
  CONSTRAINT `fk_surveys_users`
    FOREIGN KEY (`created_by`)
    REFERENCES `doodlemap_db`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doodlemap_db`.`options`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doodlemap_db`.`options` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `survey_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_options_surveys1_idx` (`survey_id` ASC),
  CONSTRAINT `fk_options_surveys1`
    FOREIGN KEY (`survey_id`)
    REFERENCES `doodlemap_db`.`surveys` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doodlemap_db`.`fav_surveys`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doodlemap_db`.`fav_surveys` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  `survey_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fav_surveys_users1_idx` (`user_id` ASC),
  INDEX `fk_fav_surveys_surveys1_idx` (`survey_id` ASC),
  CONSTRAINT `fk_fav_surveys_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `doodlemap_db`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fav_surveys_surveys1`
    FOREIGN KEY (`survey_id`)
    REFERENCES `doodlemap_db`.`surveys` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doodlemap_db`.`votes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doodlemap_db`.`votes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `voter_id` INT NOT NULL,
  `option_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_votes_users1_idx` (`voter_id` ASC),
  INDEX `fk_votes_options1_idx` (`option_id` ASC),
  CONSTRAINT `fk_votes_users1`
    FOREIGN KEY (`voter_id`)
    REFERENCES `doodlemap_db`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_votes_options1`
    FOREIGN KEY (`option_id`)
    REFERENCES `doodlemap_db`.`options` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doodlemap_db`.`locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doodlemap_db`.`locations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doodlemap_db`.`fav_locations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doodlemap_db`.`fav_locations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  `location_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_fav_locations_users1_idx` (`user_id` ASC),
  INDEX `fk_fav_locations_locations1_idx` (`location_id` ASC),
  CONSTRAINT `fk_fav_locations_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `doodlemap_db`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fav_locations_locations1`
    FOREIGN KEY (`location_id`)
    REFERENCES `doodlemap_db`.`locations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `doodlemap_db`.`configs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doodlemap_db`.`configs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `conf_key` VARCHAR(255) NULL,
  `conf_value` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into configs(conf_key, conf_value) values("email_regex","^[a-zA-Z0-9\.\+_-]+@[a-zA-Z0-9\._-]+\.[a-zA-Z]*$");
insert into configs(conf_key, conf_value) values("pwd_len","8");
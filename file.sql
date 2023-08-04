-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema lib
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lib
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lib` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `lib` ;

-- -----------------------------------------------------
-- Table `lib`.`book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lib`.`book` (
  `book_id` VARCHAR(50) NOT NULL,
  `title` VARCHAR(50) NULL DEFAULT NULL,
  `author` VARCHAR(50) NULL DEFAULT NULL,
  `publication_year` YEAR NULL DEFAULT NULL,
  `pub_id` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`book_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `lib`.`book_det`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lib`.`book_det` (
  `pub_id` VARCHAR(50) NOT NULL,
  `pub_name` VARCHAR(50) NULL DEFAULT NULL,
  `lang` VARCHAR(50) NULL DEFAULT NULL,
  `genre` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`pub_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `lib`.`mem_add`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lib`.`mem_add` (
  `MEM_id` VARCHAR(45) NOT NULL,
  `flat` VARCHAR(40) NULL DEFAULT NULL,
  `bldg` VARCHAR(50) NULL DEFAULT NULL,
  `City` VARCHAR(40) NULL DEFAULT NULL,
  PRIMARY KEY (`MEM_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `lib`.`members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lib`.`members` (
  `mem_id` VARCHAR(50) NOT NULL,
  `mem_name` VARCHAR(50) NULL DEFAULT NULL,
  `mem_type` VARCHAR(50) NULL DEFAULT NULL,
  `m_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`mem_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `lib`.`purchase`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lib`.`purchase` (
  `purchase_id` VARCHAR(50) NOT NULL,
  `book` VARCHAR(50) NULL DEFAULT NULL,
  `mem_id` VARCHAR(50) NULL DEFAULT NULL,
  `trans_type` VARCHAR(50) NULL DEFAULT NULL,
  `pur_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`purchase_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `lib`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lib`.`transactions` (
  `tran_key` VARCHAR(50) NOT NULL,
  `book_key` VARCHAR(50) NULL DEFAULT NULL,
  `member_key` VARCHAR(50) NULL DEFAULT NULL,
  `t_type` VARCHAR(50) NULL DEFAULT NULL,
  `dat` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`tran_key`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- MySQL Script generated by MySQL Workbench
-- Fri Dec  6 01:22:57 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema findmynest
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema findmynest
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `findmynest` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `findmynest` ;

-- -----------------------------------------------------
-- Table `findmynest`.`Universities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `findmynest`.`Universities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `location` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `findmynest`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `findmynest`.`Users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `mobile_number` VARCHAR(20) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `university_id` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  UNIQUE INDEX `mobile_number` (`mobile_number` ASC) VISIBLE,
  INDEX `university_id` (`university_id` ASC) VISIBLE,
  CONSTRAINT `users_ibfk_1`
    FOREIGN KEY (`university_id`)
    REFERENCES `findmynest`.`Universities` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `findmynest`.`Comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `findmynest`.`Comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `listing_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `comment` TEXT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `listing_id` (`listing_id` ASC) VISIBLE,
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `comments_ibfk_1`
    FOREIGN KEY (`listing_id`)
    REFERENCES `findmynest`.`Listings` (`id`),
  CONSTRAINT `comments_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `findmynest`.`Users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `findmynest`.`Listing_Photos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `findmynest`.`Listing_Photos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `listing_id` INT NOT NULL,
  `photo_url` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `listing_id` (`listing_id` ASC) VISIBLE,
  CONSTRAINT `listing_photos_ibfk_1`
    FOREIGN KEY (`listing_id`)
    REFERENCES `findmynest`.`Listings` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 43
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `findmynest`.`Messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `findmynest`.`Messages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sender_id` INT NOT NULL,
  `receiver_id` INT NOT NULL,
  `content` TEXT NOT NULL,
  `is_read` TINYINT(1) NULL DEFAULT '0',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `sender_id` (`sender_id` ASC) VISIBLE,
  INDEX `receiver_id` (`receiver_id` ASC) VISIBLE,
  CONSTRAINT `messages_ibfk_1`
    FOREIGN KEY (`sender_id`)
    REFERENCES `findmynest`.`Users` (`id`),
  CONSTRAINT `messages_ibfk_2`
    FOREIGN KEY (`receiver_id`)
    REFERENCES `findmynest`.`Users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `findmynest`.`Ratings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `findmynest`.`Ratings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `listing_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `rating` INT NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `listing_id` (`listing_id` ASC) VISIBLE,
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `ratings_ibfk_1`
    FOREIGN KEY (`listing_id`)
    REFERENCES `findmynest`.`Listings` (`id`),
  CONSTRAINT `ratings_ibfk_2`
    FOREIGN KEY (`user_id`)
    REFERENCES `findmynest`.`Users` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `findmynest`.`listings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `findmynest`.`listings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `university_id` INT NOT NULL,
  `title` VARCHAR(255) NULL DEFAULT NULL,
  `building_name` VARCHAR(255) NULL DEFAULT NULL,
  `building_type` VARCHAR(100) NULL DEFAULT NULL,
  `address` TEXT NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `bedrooms` INT NULL DEFAULT NULL,
  `bathrooms` INT NULL DEFAULT NULL,
  `monthly_rent` DECIMAL(10,2) NULL DEFAULT NULL,
  `security_deposit` DECIMAL(10,2) NULL DEFAULT NULL,
  `lease_type` ENUM('Lease', 'Sublease') NULL DEFAULT NULL,
  `sq_feet` INT NULL DEFAULT NULL,
  `amenities` TEXT NULL DEFAULT NULL,
  `contact_email` VARCHAR(255) NULL DEFAULT NULL,
  `contact_mobile` VARCHAR(20) NULL DEFAULT NULL,
  `fees_policies` TEXT NULL DEFAULT NULL,
  `location_coordinates` VARCHAR(255) NULL DEFAULT NULL,
  `availability` ENUM('Available', 'Sold Out') NULL DEFAULT 'Available',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `lease_duration` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  INDEX `university_id` (`university_id` ASC) VISIBLE,
  CONSTRAINT `listings_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `findmynest`.`Users` (`id`),
  CONSTRAINT `listings_ibfk_2`
    FOREIGN KEY (`university_id`)
    REFERENCES `findmynest`.`Universities` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
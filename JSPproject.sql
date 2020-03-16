-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema jspproject
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `jspproject` ;

-- -----------------------------------------------------
-- Schema jspproject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `jspproject` DEFAULT CHARACTER SET utf8 ;
USE `jspproject` ;

-- -----------------------------------------------------
-- Table `jspproject`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jspproject`.`member` ;

CREATE TABLE IF NOT EXISTS `jspproject`.`member` (
  `m_id` VARCHAR(15) NOT NULL,
  `m_pass` VARCHAR(15) NOT NULL,
  `m_nick` VARCHAR(10) NOT NULL,
  `m_email` VARCHAR(30) NOT NULL,
  `m_birth` VARCHAR(8) NOT NULL,
  `m_gender` CHAR(1) NOT NULL,
  `m_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `m_file` VARCHAR(20),
  `m_comment` VARCHAR(50),
  PRIMARY KEY (`m_id`),
  UNIQUE INDEX `m_nick` (`m_nick` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jspproject`.`content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jspproject`.`content` ;

CREATE TABLE IF NOT EXISTS `jspproject`.`content` (
  `c_num` INT(11) NOT NULL AUTO_INCREMENT,
  `c_writer_id` VARCHAR(15) NULL DEFAULT NULL,
  `c_nick` VARCHAR(10) NULL DEFAULT NULL,
  `c_content` TEXT NOT NULL,
  `c_img` VARCHAR(20) NULL DEFAULT NULL,
  `c_writer_file` VARCHAR(20) NULL DEFAULT NULL,
  `c_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`c_num`),
  INDEX `c_writer_id` (`c_writer_id` ASC) ,
  CONSTRAINT `content_ibfk_1`
    FOREIGN KEY (`c_writer_id`)
    REFERENCES `jspproject`.`member` (`m_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jspproject`.`follow`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jspproject`.`follow` ;

CREATE TABLE IF NOT EXISTS `jspproject`.`follow` (
  `following_id` VARCHAR(15) NULL DEFAULT NULL,
  `follower_id` VARCHAR(15) NULL DEFAULT NULL,
  INDEX `follwing_id_idx` (`following_id` ASC) ,
  INDEX `follower_id_idx` (`follower_id` ASC) ,
  CONSTRAINT `follwing_id`
    FOREIGN KEY (`following_id`)
    REFERENCES `jspproject`.`member` (`m_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `follower_id`
    FOREIGN KEY (`follower_id`)
    REFERENCES `jspproject`.`member` (`m_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jspproject`.`like_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jspproject`.`like_content` ;

CREATE TABLE IF NOT EXISTS `jspproject`.`like_content` (
  `lc_num` INT(11) NULL DEFAULT NULL,
  `lc_id` VARCHAR(15) NULL DEFAULT NULL,
  `lc_file` VARCHAR(20) NULL,
  INDEX `lc_id_idx` (`lc_id` ASC) ,
  INDEX `lc_num_idx` (`lc_num` ASC) ,
  CONSTRAINT `lc_id`
    FOREIGN KEY (`lc_id`)
    REFERENCES `jspproject`.`member` (`m_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `lc_num`
    FOREIGN KEY (`lc_num`)
    REFERENCES `jspproject`.`content` (`c_num`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jspproject`.`search_content`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jspproject`.`search_content` ;

CREATE TABLE IF NOT EXISTS `jspproject`.`search_content` (
  `sc_content` VARCHAR(30) NULL DEFAULT NULL,
  `sc_birth` VARCHAR(8) NULL DEFAULT NULL,
  `sc_gender` VARCHAR(1) NULL DEFAULT NULL,
  `sc_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sc_id` VARCHAR(15) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jspproject`.`test_code`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jspproject`.`test_code` ;

CREATE TABLE IF NOT EXISTS `jspproject`.`test_code` (
  `m_email` VARCHAR(30) NULL DEFAULT NULL,
  `code` INT(11) NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `jspproject`.`comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jspproject`.`comment` ;

CREATE TABLE IF NOT EXISTS `jspproject`.`comment` (
  `com_num` INT primary key AUTO_INCREMENT,
  `com_write_id` VARCHAR(15) NULL,
  `com_write_nick` VARCHAR(10) NULL,
  `com_content_num` INT NULL,
  `com_content` TEXT NULL,
  `com_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `com_write_file` VARCHAR(20) NULL,
  INDEX `com_write_id_idx` (`com_write_id` ASC) ,
  INDEX `com_content_num_idx` (`com_content_num` ASC) ,
  CONSTRAINT `com_write_id`
    FOREIGN KEY (`com_write_id`)
    REFERENCES `jspproject`.`member` (`m_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `com_content_num`
    FOREIGN KEY (`com_content_num`)
    REFERENCES `jspproject`.`content` (`c_num`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `jspproject`.`direct_message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jspproject`.`direct_message` ;

CREATE TABLE IF NOT EXISTS `jspproject`.`direct_message` (
  `dm_send_id` VARCHAR(15) NULL,
  `dm_receive_id` VARCHAR(15) NULL,
  `dm_content` TEXT NULL,
  `dm_date` TIMESTAMP NULL,
  INDEX `dm_send_id_idx` (`dm_send_id` ASC) ,
  INDEX `dm_receive_id_idx` (`dm_receive_id` ASC) ,
  CONSTRAINT `dm_send_id`
    FOREIGN KEY (`dm_send_id`)
    REFERENCES `jspproject`.`member` (`m_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `dm_receive_id`
    FOREIGN KEY (`dm_receive_id`)
    REFERENCES `jspproject`.`member` (`m_id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

SELECT * FROM member;
alter database jspproject default character set utf8;
alter table comment default character set utf8;
alter table content default character set utf8;
alter table direct_message default character set utf8;
alter table follow default character set utf8;
alter table like_content default character set utf8;
alter table member default character set utf8;
alter table search_content default character set utf8;
alter table test_code default character set utf8;


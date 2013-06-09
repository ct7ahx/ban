SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `ban` ;
CREATE SCHEMA IF NOT EXISTS `ban` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `ban` ;

-- -----------------------------------------------------
-- Table `ban`.`author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ban`.`author` ;

CREATE  TABLE IF NOT EXISTS `ban`.`author` (
  `idauthor` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `firstname` VARCHAR(45) NOT NULL ,
  `lastname` VARCHAR(45) NOT NULL ,
  `othernames` VARCHAR(255) NULL ,
  PRIMARY KEY (`idauthor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ban`.`journal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ban`.`journal` ;

CREATE  TABLE IF NOT EXISTS `ban`.`journal` (
  `idjournal` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`idjournal`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ban`.`conference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ban`.`conference` ;

CREATE  TABLE IF NOT EXISTS `ban`.`conference` (
  `idconference` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `name` VARCHAR(255) NOT NULL ,
  `institution` INT NULL ,
  PRIMARY KEY (`idconference`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ban`.`publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ban`.`publisher` ;

CREATE  TABLE IF NOT EXISTS `ban`.`publisher` (
  `idpublisher` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `name` VARCHAR(255) NOT NULL ,
  `address` VARCHAR(255) NULL ,
  PRIMARY KEY (`idpublisher`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ban`.`paper`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ban`.`paper` ;

CREATE  TABLE IF NOT EXISTS `ban`.`paper` (
  `idpaper` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `title` VARCHAR(255) NOT NULL ,
  `type` SET('article','book','techreport') NOT NULL DEFAULT 'article' ,
  `year` YEAR NOT NULL ,
  `journal` INT NULL ,
  `conference` INT NULL ,
  `publisher` INT NULL ,
  `month` SET('january','february','march','april','may','june','july','august','september','october','november','december') NULL ,
  `volume` INT NULL ,
  `number` INT NULL ,
  `pages` VARCHAR(20) NULL ,
  `url` VARCHAR(255) NULL ,
  `doi` VARCHAR(255) NULL ,
  `codeid` VARCHAR(100) NULL ,
  `isbn` VARCHAR(20) NULL ,
  `abstract` TEXT NOT NULL ,
  `reason` TEXT NOT NULL ,
  PRIMARY KEY (`idpaper`) ,
  INDEX `paper-publisher_idx` (`publisher` ASC) ,
  INDEX `paper-conference_idx` (`conference` ASC) ,
  INDEX `paper-journal_idx` (`journal` ASC) ,
  CONSTRAINT `paper-journal`
    FOREIGN KEY (`journal` )
    REFERENCES `ban`.`journal` (`idjournal` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `paper-conference`
    FOREIGN KEY (`conference` )
    REFERENCES `ban`.`conference` (`idconference` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `paper-publisher`
    FOREIGN KEY (`publisher` )
    REFERENCES `ban`.`publisher` (`idpublisher` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ban`.`authors-papers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ban`.`authors-papers` ;

CREATE  TABLE IF NOT EXISTS `ban`.`authors-papers` (
  `author` INT UNSIGNED NOT NULL ,
  `paper` INT UNSIGNED NOT NULL ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  PRIMARY KEY (`author`, `paper`) ,
  INDEX `author_idx` (`author` ASC) ,
  INDEX `paper_idx` (`paper` ASC) ,
  CONSTRAINT `paper-author`
    FOREIGN KEY (`author` )
    REFERENCES `ban`.`author` (`idauthor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `author-paper`
    FOREIGN KEY (`paper` )
    REFERENCES `ban`.`paper` (`idpaper` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ban`.`citations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ban`.`citations` ;

CREATE  TABLE IF NOT EXISTS `ban`.`citations` (
  `citer` INT UNSIGNED NOT NULL ,
  `citee` INT UNSIGNED NOT NULL ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  PRIMARY KEY (`citer`, `citee`) ,
  CONSTRAINT `citer-paper`
    FOREIGN KEY ()
    REFERENCES `ban`.`paper` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `citee-paper`
    FOREIGN KEY (`citer` , `citee` )
    REFERENCES `ban`.`paper` (`idpaper` , `idpaper` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ban`.`keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ban`.`keyword` ;

CREATE  TABLE IF NOT EXISTS `ban`.`keyword` (
  `idkeyword` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `word` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`idkeyword`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ban`.`keywords-papers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ban`.`keywords-papers` ;

CREATE  TABLE IF NOT EXISTS `ban`.`keywords-papers` (
  `keyword` INT UNSIGNED NOT NULL ,
  `paper` INT UNSIGNED NOT NULL ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  PRIMARY KEY (`keyword`, `paper`) ,
  INDEX `paper-keyword_idx` (`keyword` ASC) ,
  INDEX `keyword-paper_idx` (`paper` ASC) ,
  CONSTRAINT `paper-keyword`
    FOREIGN KEY (`keyword` )
    REFERENCES `ban`.`keyword` (`idkeyword` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `keyword-paper`
    FOREIGN KEY (`paper` )
    REFERENCES `ban`.`paper` (`idpaper` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `ban` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

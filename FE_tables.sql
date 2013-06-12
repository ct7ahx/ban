SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP TABLE IF EXISTS `keyword-paper` ;
DROP TABLE IF EXISTS `author-paper` ;
DROP TABLE IF EXISTS `citation` ;
DROP TABLE IF EXISTS `keyword` ;
DROP TABLE IF EXISTS `paper` ;
DROP TABLE IF EXISTS `publisher` ;
DROP TABLE IF EXISTS `conference` ;
DROP TABLE IF EXISTS `journal` ;
DROP TABLE IF EXISTS `author` ;

-- -----------------------------------------------------
-- Table `author`
-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `author` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `firstname` VARCHAR(45) NOT NULL ,
  `lastname` VARCHAR(45) NOT NULL ,
  `othernames` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `journal`
-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `journal` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `conference`
-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `conference` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `publisher`
-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `publisher` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `name` VARCHAR(255) NOT NULL ,
  `address` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paper`
-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `paper` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `title` VARCHAR(255) NOT NULL ,
  `type` SET('article','book','techreport') NOT NULL DEFAULT 'article' ,
  `year` YEAR NOT NULL ,
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
  `journal` INT UNSIGNED NULL ,
  `conference` INT UNSIGNED NULL ,
  `publisher_idpublisher` INT UNSIGNED NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_paper_journal` (`journal` ASC) ,
  INDEX `fk_paper_conference` (`conference` ASC) ,
  INDEX `fk_paper_publisher` (`publisher_idpublisher` ASC) ,
  CONSTRAINT `fk_paper_journal`
    FOREIGN KEY (`journal` )
    REFERENCES `journal` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paper_conference`
    FOREIGN KEY (`conference` )
    REFERENCES `conference` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paper_publisher`
    FOREIGN KEY (`publisher_idpublisher` )
    REFERENCES `publisher` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `keyword`
-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `keyword` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `word` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `citation`
-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `citation` (
  `citer` INT UNSIGNED NOT NULL ,
  `citee` INT UNSIGNED NOT NULL ,
  `created` TIMESTAMP NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  PRIMARY KEY (`citer`, `citee`) ,
  INDEX `fk_paper_has_paper_paper2` (`citee` ASC) ,
  INDEX `fk_paper_has_paper_paper1` (`citer` ASC) ,
  CONSTRAINT `fk_paper_has_paper_paper1`
    FOREIGN KEY (`citer` )
    REFERENCES `paper` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_paper_has_paper_paper2`
    FOREIGN KEY (`citee` )
    REFERENCES `paper` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `author-paper`
-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `author-paper` (
  `author` INT UNSIGNED NOT NULL ,
  `paper` INT UNSIGNED NOT NULL ,
  `created` TIMESTAMP NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  PRIMARY KEY (`author`, `paper`) ,
  INDEX `fk_author_has_paper_paper1` (`paper` ASC) ,
  INDEX `fk_author_has_paper_author1` (`author` ASC) ,
  CONSTRAINT `fk_author_has_paper_author1`
    FOREIGN KEY (`author` )
    REFERENCES `author` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_author_has_paper_paper1`
    FOREIGN KEY (`paper` )
    REFERENCES `paper` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `keyword-paper`
-- -----------------------------------------------------

CREATE  TABLE IF NOT EXISTS `keyword-paper` (
  `keyword` INT UNSIGNED NOT NULL ,
  `paper` INT UNSIGNED NOT NULL ,
  `created` TIMESTAMP NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  PRIMARY KEY (`keyword`, `paper`) ,
  INDEX `fk_keyword_has_paper_paper1` (`paper` ASC) ,
  INDEX `fk_keyword_has_paper_keyword1` (`keyword` ASC) ,
  CONSTRAINT `fk_keyword_has_paper_keyword1`
    FOREIGN KEY (`keyword` )
    REFERENCES `keyword` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_keyword_has_paper_paper1`
    FOREIGN KEY (`paper` )
    REFERENCES `paper` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

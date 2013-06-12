SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

-- -----------------------------------------------------
-- Table `fban`.`author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fban`.`author` ;

CREATE  TABLE IF NOT EXISTS `fban`.`author` (
  `idauthor` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `firstname` VARCHAR(45) NOT NULL ,
  `lastname` VARCHAR(45) NOT NULL ,
  `othernames` VARCHAR(255) NULL ,
  PRIMARY KEY (`idauthor`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fban`.`journal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fban`.`journal` ;

CREATE  TABLE IF NOT EXISTS `fban`.`journal` (
  `idjournal` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `name` VARCHAR(255) NOT NULL ,
  PRIMARY KEY (`idjournal`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fban`.`conference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fban`.`conference` ;

CREATE  TABLE IF NOT EXISTS `fban`.`conference` (
  `idconference` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `name` VARCHAR(255) NOT NULL ,
  `institution` INT NULL ,
  PRIMARY KEY (`idconference`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fban`.`publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fban`.`publisher` ;

CREATE  TABLE IF NOT EXISTS `fban`.`publisher` (
  `idpublisher` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `name` VARCHAR(255) NOT NULL ,
  `address` VARCHAR(255) NULL ,
  PRIMARY KEY (`idpublisher`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fban`.`paper`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fban`.`paper` ;

CREATE  TABLE IF NOT EXISTS `fban`.`paper` (
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
    REFERENCES `fban`.`journal` (`idjournal` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `paper-conference`
    FOREIGN KEY (`conference` )
    REFERENCES `fban`.`conference` (`idconference` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `paper-publisher`
    FOREIGN KEY (`publisher` )
    REFERENCES `fban`.`publisher` (`idpublisher` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fban`.`authors-papers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fban`.`authors-papers` ;

CREATE  TABLE IF NOT EXISTS `fban`.`authors-papers` (
  `author` INT UNSIGNED NOT NULL ,
  `paper` INT UNSIGNED NOT NULL ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  PRIMARY KEY (`author`, `paper`) ,
  INDEX `author_idx` (`author` ASC) ,
  INDEX `paper_idx` (`paper` ASC) ,
  CONSTRAINT `paper-author`
    FOREIGN KEY (`author` )
    REFERENCES `fban`.`author` (`idauthor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `author-paper`
    FOREIGN KEY (`paper` )
    REFERENCES `fban`.`paper` (`idpaper` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fban`.`citations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fban`.`citations` ;

CREATE  TABLE IF NOT EXISTS `fban`.`citations` (
  `citer` INT UNSIGNED NOT NULL ,
  `citee` INT UNSIGNED NOT NULL ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  PRIMARY KEY (`citer`, `citee`) ,
  CONSTRAINT `citer-paper`
    FOREIGN KEY ()
    REFERENCES `fban`.`paper` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `citee-paper`
    FOREIGN KEY (`citer` , `citee` )
    REFERENCES `fban`.`paper` (`idpaper` , `idpaper` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fban`.`keyword`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fban`.`keyword` ;

CREATE  TABLE IF NOT EXISTS `fban`.`keyword` (
  `idkeyword` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  `word` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`idkeyword`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fban`.`keywords-papers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fban`.`keywords-papers` ;

CREATE  TABLE IF NOT EXISTS `fban`.`keywords-papers` (
  `keyword` INT UNSIGNED NOT NULL ,
  `paper` INT UNSIGNED NOT NULL ,
  `created` TIMESTAMP NOT NULL ,
  `modified` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP ,
  PRIMARY KEY (`keyword`, `paper`) ,
  INDEX `paper-keyword_idx` (`keyword` ASC) ,
  INDEX `keyword-paper_idx` (`paper` ASC) ,
  CONSTRAINT `paper-keyword`
    FOREIGN KEY (`keyword` )
    REFERENCES `fban`.`keyword` (`idkeyword` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `keyword-paper`
    FOREIGN KEY (`paper` )
    REFERENCES `fban`.`paper` (`idpaper` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

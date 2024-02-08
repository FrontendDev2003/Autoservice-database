/* SQL Manager Lite for MySQL                              5.8.0.53936 */
/* ------------------------------------------------------------------- */
/* Host     : localhost                                                */
/* Port     : 3306                                                     */
/* Database : autoservice                                              */


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES 'utf8mb4' */;

SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE `autoservice`
    CHARACTER SET 'utf8'
    COLLATE 'utf8_general_ci';

USE `autoservice`;

/* Structure for the `client` table : */

CREATE TABLE `client` (
  `client_id` INTEGER(11) NOT NULL,
  `Name` TEXT COLLATE utf8_general_ci,
  `Lastname` TEXT COLLATE utf8_general_ci,
  `Middlename` TEXT COLLATE utf8_general_ci,
  `Nom_tel` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`client_id`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Structure for the `auto` table : */

CREATE TABLE `auto` (
  `auto_id` INTEGER(11) NOT NULL,
  `Marka_auto` TEXT COLLATE utf8_general_ci,
  `Model_auto` TEXT COLLATE utf8_general_ci,
  `Reg_nom_auto` TEXT COLLATE utf8_general_ci,
  `client_id` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`auto_id`),
  KEY `client` USING BTREE (`client_id`),
  CONSTRAINT `client` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Structure for the `specialization` table : */

CREATE TABLE `specialization` (
  `specialization_id` INTEGER(11) NOT NULL,
  `specialization` TEXT COLLATE utf8_general_ci,
  PRIMARY KEY USING BTREE (`specialization_id`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Structure for the `master` table : */

CREATE TABLE `master` (
  `master_id` INTEGER(11) NOT NULL,
  `Name` TEXT COLLATE utf8_general_ci,
  `Lastname` TEXT COLLATE utf8_general_ci,
  `Middlename` TEXT COLLATE utf8_general_ci,
  `Passport_dan` TEXT COLLATE utf8_general_ci,
  `Nom_tel` INTEGER(11) DEFAULT NULL,
  `specialization` TEXT COLLATE utf8_general_ci,
  `specialization_id` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`master_id`),
  KEY `specialization_1` USING BTREE (`specialization_id`),
  CONSTRAINT `specialization_1` FOREIGN KEY (`specialization_id`) REFERENCES `specialization` (`specialization_id`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Structure for the `master_specialization` table : */

CREATE TABLE `master_specialization` (
  `master_specialization_id` INTEGER(11) NOT NULL,
  `master_id` INTEGER(11) DEFAULT NULL,
  `specialization_id` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`master_specialization_id`),
  KEY `master` USING BTREE (`master_id`),
  KEY `specialization` USING BTREE (`specialization_id`),
  CONSTRAINT `master` FOREIGN KEY (`master_id`) REFERENCES `master` (`master_id`),
  CONSTRAINT `specialization` FOREIGN KEY (`specialization_id`) REFERENCES `specialization` (`specialization_id`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Structure for the `postavshik` table : */

CREATE TABLE `postavshik` (
  `postavshik_id` INTEGER(11) NOT NULL,
  `email` TEXT COLLATE utf8_general_ci,
  `Nom_tel` INTEGER(11) DEFAULT NULL,
  `Zak_poz` TEXT COLLATE utf8_general_ci,
  PRIMARY KEY USING BTREE (`postavshik_id`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Structure for the `spare_part` table : */

CREATE TABLE `spare_part` (
  `Spare_part _id` INTEGER(11) NOT NULL,
  `Name_sp` TEXT COLLATE utf8_general_ci,
  `postavshik_id` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`Spare_part _id`),
  KEY `postavshik_1` USING BTREE (`postavshik_id`),
  CONSTRAINT `postavshik_1` FOREIGN KEY (`postavshik_id`) REFERENCES `postavshik` (`postavshik_id`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Structure for the `postavshik–spare_part` table : */

CREATE TABLE `postavshik–spare_part` (
  `postavshik–spare_part_id` INTEGER(11) NOT NULL,
  `postavshik_id` INTEGER(11) DEFAULT NULL,
  `Spare_part_id` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`postavshik–spare_part_id`),
  KEY `postavshik` USING BTREE (`postavshik_id`),
  KEY `spare_part` USING BTREE (`Spare_part_id`),
  CONSTRAINT `postavshik` FOREIGN KEY (`postavshik_id`) REFERENCES `postavshik` (`postavshik_id`),
  CONSTRAINT `spare_part` FOREIGN KEY (`Spare_part_id`) REFERENCES `spare_part` (`Spare_part _id`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Structure for the `remont` table : */

CREATE TABLE `remont` (
  `remont_id` INTEGER(11) NOT NULL,
  `Data_time` TEXT COLLATE utf8_general_ci,
  `Yzel_tr_remont` TEXT COLLATE utf8_general_ci,
  `price` INTEGER(11) DEFAULT NULL,
  `auto_id` INTEGER(11) DEFAULT NULL,
  `master_id` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`remont_id`),
  KEY `auto` USING BTREE (`auto_id`),
  KEY `master_1` USING BTREE (`master_id`),
  CONSTRAINT `auto` FOREIGN KEY (`auto_id`) REFERENCES `auto` (`auto_id`),
  CONSTRAINT `master_1` FOREIGN KEY (`master_id`) REFERENCES `master` (`master_id`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/* Structure for the `remont–spare_part` table : */

CREATE TABLE `remont–spare_part` (
  `remont–spare_part_id` INTEGER(11) NOT NULL,
  `remont_id` INTEGER(11) DEFAULT NULL,
  `Spare_part _id` INTEGER(11) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`remont–spare_part_id`),
  KEY `remont` USING BTREE (`remont_id`),
  KEY `spare_part_1` USING BTREE (`Spare_part _id`),
  CONSTRAINT `remont` FOREIGN KEY (`remont_id`) REFERENCES `remont` (`remont_id`),
  CONSTRAINT `spare_part_1` FOREIGN KEY (`Spare_part _id`) REFERENCES `spare_part` (`Spare_part _id`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'utf8' COLLATE 'utf8_general_ci'
;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: localhost (MySQL 5.5.25)
# Database: comp353
# Generation Time: 2012-11-17 09:30:12 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table addresses
# ------------------------------------------------------------

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `province` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `country` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `postal_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='http://stackoverflow.com/questions/217945/can-i-have-multipl';



# Dump of table admins
# ------------------------------------------------------------

CREATE TABLE `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `member_id_UNIQUE` (`member_id`),
  KEY `id_idx` (`member_id`),
  KEY `fk_admin_members_idx` (`member_id`),
  CONSTRAINT `fk_admin_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table bids
# ------------------------------------------------------------

CREATE TABLE `bids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `id_idx` (`member_id`),
  KEY `fk_bids_offers_idx` (`offer_id`),
  KEY `fk_bids_types_idx` (`type_id`),
  CONSTRAINT `fk_bids_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bids_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bids_types` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categories
# ------------------------------------------------------------

CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `fk_categories_types` (`type_id`),
  CONSTRAINT `fk_categories_types` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table comments
# ------------------------------------------------------------

CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` text NOT NULL,
  `member_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_comments_transactions_idx` (`transaction_id`),
  KEY `fk_comments_members_idx` (`member_id`),
  CONSTRAINT `fk_comments_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_transactions` FOREIGN KEY (`transaction_id`) REFERENCES `transacts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table credit_card_types
# ------------------------------------------------------------

CREATE TABLE `credit_card_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table credit_cards
# ------------------------------------------------------------

CREATE TABLE `credit_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `credit_card_type_id` int(11) NOT NULL,
  `number` char(16) NOT NULL DEFAULT '',
  `expire` char(4) NOT NULL,
  `verification_code` char(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `number_UNIQUE` (`number`),
  UNIQUE KEY `member_id_UNIQUE` (`member_id`),
  KEY `id_idx` (`member_id`),
  KEY `fk_credit_cards_credit_card_types` (`credit_card_type_id`),
  CONSTRAINT `fk_credit_cards_credit_card_types` FOREIGN KEY (`credit_card_type_id`) REFERENCES `credit_card_types` (`id`),
  CONSTRAINT `fk_credit_cards_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table domains
# ------------------------------------------------------------

CREATE TABLE `domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table emails
# ------------------------------------------------------------

CREATE TABLE `emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `domain_id` int(11) NOT NULL,
  `top_level_domain_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`domain_id`,`top_level_domain_id`),
  KEY `fk_emails_domains` (`domain_id`),
  KEY `fk_emails_top_level_domains` (`top_level_domain_id`),
  CONSTRAINT `fk_emails_domains` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`),
  CONSTRAINT `fk_emails_top_level_domains` FOREIGN KEY (`top_level_domain_id`) REFERENCES `top_level_domains` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table member_reserves
# ------------------------------------------------------------

CREATE TABLE `member_reserves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `reserve_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_member_reserves_members_idx` (`member_id`),
  KEY `fk_member_reserves_offers_idx` (`offer_id`),
  KEY `fk_member_reserves_members_idx1` (`member_id`),
  KEY `fk_member_reserves_offers_idx1` (`offer_id`),
  CONSTRAINT `fk_member_reserves_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_member_reserves_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table members
# ------------------------------------------------------------

CREATE TABLE `members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `email_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `visitor_id` int(11) NOT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `visitor_id_UNIQUE` (`visitor_id`),
  KEY `id_idx` (`address_id`),
  KEY `fk_members_visitors_idx` (`visitor_id`),
  KEY `fk_members_emails` (`email_id`),
  CONSTRAINT `fk_members_emails` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`),
  CONSTRAINT `fk_members_addresses` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`),
  CONSTRAINT `fk_members_visitors` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table offers
# ------------------------------------------------------------

CREATE TABLE `offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_offers_categories` (`category_id`),
  CONSTRAINT `fk_offers_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table posts
# ------------------------------------------------------------

CREATE TABLE `posts` (
  `member_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  KEY `fk_posts_members_idx` (`member_id`),
  KEY `fk_posts_offers_idx` (`offer_id`),
  KEY `fk_posts_members_idx1` (`member_id`),
  KEY `fk_posts_offers_idx1` (`offer_id`),
  CONSTRAINT `fk_posts_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ratings
# ------------------------------------------------------------

CREATE TABLE `ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rate` int(1) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `id_idx` (`transaction_id`),
  KEY `id_idx1` (`member_id`),
  KEY `fk_ratings__idx` (`transaction_id`),
  KEY `fk_ratings_members_idx` (`member_id`),
  CONSTRAINT `fk_ratings_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ratings_transactions` FOREIGN KEY (`transaction_id`) REFERENCES `transacts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sessions
# ------------------------------------------------------------

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `session` varchar(255) NOT NULL DEFAULT '',
  `expire` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_sessions_members_idx` (`member_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table top_level_domains
# ------------------------------------------------------------

CREATE TABLE `top_level_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table transacts
# ------------------------------------------------------------

CREATE TABLE `transacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL,
  `buyer_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `transact_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `offer_id_UNIQUE` (`offer_id`),
  KEY `id_idx` (`offer_id`),
  KEY `id_idx1` (`buyer_id`,`seller_id`),
  KEY `fk_transactions_offers_idx` (`offer_id`),
  KEY `fk_transactions_members_idx` (`buyer_id`),
  KEY `fk_transactions_members_idx1` (`seller_id`),
  KEY `fk_transactions_members_idx2` (`seller_id`),
  CONSTRAINT `fk_transactions_members` FOREIGN KEY (`buyer_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table types
# ------------------------------------------------------------

CREATE TABLE `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table visitor_reserves
# ------------------------------------------------------------

CREATE TABLE `visitor_reserves` (
  `visitor_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `reserve_time` datetime NOT NULL,
  KEY `fk_visitor_reserves_visitors_idx` (`visitor_id`),
  KEY `fk_visitor_reserves_offers` (`offer_id`),
  CONSTRAINT `fk_visitor_reserves_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_visitor_reserves_visitors` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table visitors
# ------------------------------------------------------------

CREATE TABLE `visitors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL DEFAULT '',
  `last_name` varchar(255) NOT NULL DEFAULT '',
  `phone_number` varchar(255) NOT NULL DEFAULT '',
  `join_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `visitors_id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

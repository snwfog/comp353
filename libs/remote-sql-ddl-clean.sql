# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: localhost (MySQL 5.5.25)
# Database: comp353
# Generation Time: 2012-12-01 23:57:03 +0000
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
  `category_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `description` text NOT NULL,
  `expire` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `id_idx` (`member_id`),
  KEY `fk_bids_offers_idx` (`offer_id`),
  KEY `fk_bids_categories` (`category_id`),
  CONSTRAINT `fk_bids_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `fk_bids_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_bids_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`snwfog`@`132.205.%.%` */ /*!50003 TRIGGER `after_bids_insert` AFTER INSERT ON `bids` FOR EACH ROW BEGIN
 INSERT INTO notify_bid (member_id, offer_id) VALUES (NEW.member_id, NEW.offer_id);
END */;;
/*!50003 SET SESSION SQL_MODE="" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`snwfog`@`132.205.%.%` */ /*!50003 TRIGGER `after_bids_update` AFTER UPDATE ON `bids` FOR EACH ROW BEGIN
  IF (NEW.expire = 1) THEN
    INSERT INTO notify_queue (bid_id) VALUES (NEW.id);
  END IF;
END */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


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



# Dump of table credit_card_transactions
# ------------------------------------------------------------

CREATE TABLE `credit_card_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `credit_card_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `amount` float(12,2) NOT NULL,
  `description` varchar(256) NOT NULL,
  `fee_type` varchar(256) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_credit_card_transactions_credit_cards_idx` (`credit_card_id`),
  KEY `fk_credit_card_transactions_offer_idx` (`offer_id`),
  CONSTRAINT `fk_credit_card_transactions_credit_cards` FOREIGN KEY (`credit_card_id`) REFERENCES `credit_cards` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_credit_card_transactions_offer` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`snwfog`@`132.205.%.%` */ /*!50003 TRIGGER `check_amount` BEFORE INSERT ON `credit_card_transactions` FOR EACH ROW BEGIN
	IF NOT NEW.amount > 0.00 THEN
		SET NEW.credit_card_id = NULL;
		SET NEW.offer_id = NULL;
		SET NEW.amount = NULL;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


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
  `holder_name` varchar(256) NOT NULL,
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



# Dump of table feedbacks
# ------------------------------------------------------------

CREATE TABLE `feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rater_id` int(11) NOT NULL,
  `ratee_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_feedbacks_members_raters` (`rater_id`),
  KEY `fk_feedbacks_members_ratees` (`ratee_id`),
  CONSTRAINT `fk_feedbacks_members_ratees` FOREIGN KEY (`ratee_id`) REFERENCES `members` (`id`),
  CONSTRAINT `fk_feedbacks_members_raters` FOREIGN KEY (`rater_id`) REFERENCES `members` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table garages
# ------------------------------------------------------------

CREATE TABLE `garages` (
   `id` INT(11) NOT NULL DEFAULT '0',
   `transact_id` INT(11) NOT NULL,
   `acquire_date` DATE DEFAULT NULL,
   `pickup_date` DATE DEFAULT NULL,
   `weight` ENUM('light','medium','heavy') DEFAULT NULL
) ENGINE=MyISAM;



# Dump of table giveaways
# ------------------------------------------------------------

CREATE TABLE `giveaways` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_giveaways_offers` (`offer_id`),
  CONSTRAINT `fk_giveaways_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table member_stats
# ------------------------------------------------------------

CREATE TABLE `member_stats` (
   `id` INT(11) NOT NULL DEFAULT '0',
   `username` VARCHAR(255) NOT NULL DEFAULT '',
   `posts` BIGINT(21) DEFAULT NULL,
   `buys` BIGINT(21) DEFAULT NULL,
   `sells` BIGINT(21) DEFAULT NULL,
   `rating` DECIMAL(11) DEFAULT NULL
) ENGINE=MyISAM;



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
  `active` int(1) NOT NULL DEFAULT '1',
  `warning` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `visitor_id_UNIQUE` (`visitor_id`),
  KEY `id_idx` (`address_id`),
  KEY `fk_members_visitors_idx` (`visitor_id`),
  KEY `fk_members_emails` (`email_id`),
  CONSTRAINT `fk_members_addresses` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`),
  CONSTRAINT `fk_members_emails` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`),
  CONSTRAINT `fk_members_visitors` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`snwfog`@`132.205.%.%` */ /*!50003 TRIGGER `after_members_update` AFTER UPDATE ON `members` FOR EACH ROW BEGIN
  IF (NEW.warning > 3) THEN
    UPDATE members SET NEW.active = 0 WHERE id = NEW.id;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


# Dump of table notify_acquire
# ------------------------------------------------------------

CREATE TABLE `notify_acquire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storage_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notify_acquire_storages` (`storage_id`),
  CONSTRAINT `fk_notify_acquire_storages` FOREIGN KEY (`storage_id`) REFERENCES `storages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notify_bid
# ------------------------------------------------------------

CREATE TABLE `notify_bid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_notfiy_bids_members` (`member_id`),
  KEY `fk_notfiy_bids_offers` (`offer_id`),
  CONSTRAINT `fk_notfiy_bids_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`),
  CONSTRAINT `fk_notfiy_bids_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table notify_modify
# ------------------------------------------------------------

CREATE TABLE `notify_modify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notify_modify_offers` (`offer_id`),
  KEY `fk_notify_modify_members` (`member_id`),
  CONSTRAINT `fk_notify_modify_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`),
  CONSTRAINT `fk_notify_modify_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table notify_pickup
# ------------------------------------------------------------

CREATE TABLE `notify_pickup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storage_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notify_pickup_storages` (`storage_id`),
  CONSTRAINT `fk_notify_pickup_storages` FOREIGN KEY (`storage_id`) REFERENCES `storages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notify_queue
# ------------------------------------------------------------

CREATE TABLE `notify_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bid_id` int(11) NOT NULL,
  `expire_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_notify_queue_bids` (`bid_id`),
  CONSTRAINT `fk_notify_queue_bids` FOREIGN KEY (`bid_id`) REFERENCES `bids` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notify_receive
# ------------------------------------------------------------

CREATE TABLE `notify_receive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storage_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notify_receive_storages` (`storage_id`),
  CONSTRAINT `fk_notify_receive_storages` FOREIGN KEY (`storage_id`) REFERENCES `storages` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table notify_warn
# ------------------------------------------------------------

CREATE TABLE `notify_warn` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notify_warn_posts` (`post_id`),
  CONSTRAINT `fk_notify_warn_posts` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table offers
# ------------------------------------------------------------

CREATE TABLE `offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` float(12,2) NOT NULL,
  `category_id` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `expire` int(1) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_offers_categories` (`category_id`),
  CONSTRAINT `fk_offers_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`snwfog`@`132.205.%.%` */ /*!50003 TRIGGER `after_offers_insert` AFTER INSERT ON `offers` FOR EACH ROW BEGIN
  IF (NEW.price = 0) THEN
    INSERT INTO giveaways(offer_id) VALUES (NEW.id);
  END IF;
END */;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`snwfog`@`132.205.%.%` */ /*!50003 TRIGGER `after_offers_update` AFTER UPDATE ON `offers` FOR EACH ROW BEGIN
  	IF (NEW.expire = 1) THEN
  		UPDATE bids SET expire = NEW.expire WHERE offer_id = NEW.id;
  	ELSE
		INSERT INTO notify_modify (member_id, offer_id) 
		(SELECT bids.member_id, offer_id FROM bids WHERE offer_id = NEW.id);
	END IF;
END */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


# Dump of table posts
# ------------------------------------------------------------

CREATE TABLE `posts` (
  `member_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `fk_posts_members_idx` (`member_id`),
  KEY `fk_posts_offers_idx` (`offer_id`),
  KEY `fk_posts_members_idx1` (`member_id`),
  KEY `fk_posts_offers_idx1` (`offer_id`),
  CONSTRAINT `fk_posts_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_posts_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table prices
# ------------------------------------------------------------

CREATE TABLE `prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fee_name` varchar(256) NOT NULL DEFAULT '',
  `amount` float(12,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table reserves
# ------------------------------------------------------------

CREATE TABLE `reserves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitor_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `reserve_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `visitor_id` (`visitor_id`,`offer_id`),
  KEY `fk_reserves_offers` (`offer_id`),
  CONSTRAINT `fk_reserves_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`),
  CONSTRAINT `fk_reserves_visitors` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`)
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



# Dump of table storages
# ------------------------------------------------------------

CREATE TABLE `storages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transact_id` int(11) NOT NULL,
  `acquire_date` date DEFAULT NULL,
  `pickup_date` date DEFAULT NULL,
  `weight` enum('light','medium','heavy') DEFAULT NULL,
  `volume` enum('small','medium','large') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_storages_transact_idx` (`transact_id`),
  CONSTRAINT `fk_storages_transact` FOREIGN KEY (`transact_id`) REFERENCES `transacts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DELIMITER ;;
/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO" */;;
/*!50003 CREATE */ /*!50017 DEFINER=`snwfog`@`132.205.%.%` */ /*!50003 TRIGGER `after_storages_update` AFTER UPDATE ON `storages` FOR EACH ROW BEGIN
  IF (NEW.pickup_date IS NOT NULL) THEN
    INSERT INTO notify_pickup(storage_id) VALUES (NEW.id);
  ELSEIF (NEW.acquire_date IS NOT NULL) THEN
	INSERT INTO notify_receive(storage_id) VALUES (NEW.id);
    INSERT INTO notify_acquire(storage_id) VALUES (NEW.id);
  END IF;
END */;;
DELIMITER ;
/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;


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
  `bid_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `offer_id_UNIQUE` (`offer_id`),
  KEY `id_idx` (`offer_id`),
  KEY `id_idx1` (`buyer_id`,`seller_id`),
  KEY `fk_transactions_offers_idx` (`offer_id`),
  KEY `fk_transactions_members_idx` (`buyer_id`),
  KEY `fk_transactions_members_idx1` (`seller_id`),
  KEY `fk_transactions_members_idx2` (`seller_id`),
  KEY `fk_transacts_bids_idx` (`bid_id`),
  CONSTRAINT `fk_transactions_members` FOREIGN KEY (`buyer_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_transactions_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_transacts_bids` FOREIGN KEY (`bid_id`) REFERENCES `bids` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table types
# ------------------------------------------------------------

CREATE TABLE `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table view_emails
# ------------------------------------------------------------

CREATE TABLE `view_emails` (
   `member_id` INT(11) NOT NULL DEFAULT '0',
   `email` TEXT NOT NULL
) ENGINE=MyISAM;



# Dump of table view_hot_offers
# ------------------------------------------------------------

CREATE TABLE `view_hot_offers` (
   `id` INT(11) NOT NULL DEFAULT '0',
   `title` VARCHAR(255) NOT NULL,
   `description` TEXT NOT NULL,
   `price` FLOAT(12) NOT NULL,
   `category_id` INT(11) NOT NULL,
   `image_url` VARCHAR(255) DEFAULT NULL,
   `expire` INT(1) NOT NULL
) ENGINE=MyISAM;



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





# Replace placeholder table for view_hot_offers with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_hot_offers`;
CREATE ALGORITHM=UNDEFINED DEFINER=`snwfog`@`132.205.%.%` SQL SECURITY DEFINER VIEW `view_hot_offers`
AS select
   `offers`.`id` AS `id`,
   `offers`.`title` AS `title`,
   `offers`.`description` AS `description`,
   `offers`.`price` AS `price`,
   `offers`.`category_id` AS `category_id`,
   `offers`.`image_url` AS `image_url`,
   `offers`.`expire` AS `expire`
from `offers`
where ((`offers`.`price` < 7.99) and (`offers`.`expire` <> 1) and (not(exists(select 1 from `giveaways`
where (`giveaways`.`offer_id` = `offers`.`id`)))));


# Replace placeholder table for garages with correct view syntax
# ------------------------------------------------------------

DROP TABLE `garages`;
CREATE ALGORITHM=UNDEFINED DEFINER=`snwfog`@`132.205.%.%` SQL SECURITY DEFINER VIEW `garages`
AS select
   `storages`.`id` AS `id`,
   `storages`.`transact_id` AS `transact_id`,
   `storages`.`acquire_date` AS `acquire_date`,
   `storages`.`pickup_date` AS `pickup_date`,
   `storages`.`weight` AS `weight`
from `storages`
where ((`storages`.`acquire_date` is not null) and isnull(`storages`.`pickup_date`) and ((cast(curdate() as date) - cast(`storages`.`acquire_date` as date)) > 14));


# Replace placeholder table for member_stats with correct view syntax
# ------------------------------------------------------------

DROP TABLE `member_stats`;
CREATE ALGORITHM=UNDEFINED DEFINER=`snwfog`@`132.205.%.%` SQL SECURITY DEFINER VIEW `member_stats`
AS select
   `m`.`id` AS `id`,
   `m`.`username` AS `username`,(select count(0)
from `posts` `p`
where (`p`.`member_id` = `m`.`id`)) AS `posts`,(select count(0) from `transacts` `t`
where (`t`.`buyer_id` = `m`.`id`)) AS `buys`,(select count(0) from `transacts` `t`
where (`t`.`seller_id` = `m`.`id`)) AS `sells`,round(avg(`f`.`rating`),0) AS `rating` from (`members` `m` left join `feedbacks` `f` on((`f`.`ratee_id` = `m`.`id`))) group by `m`.`id`;


# Replace placeholder table for view_emails with correct view syntax
# ------------------------------------------------------------

DROP TABLE `view_emails`;
CREATE ALGORITHM=UNDEFINED DEFINER=`snwfog`@`132.205.%.%` SQL SECURITY DEFINER VIEW `view_emails`
AS select
   `members`.`id` AS `member_id`,concat(`emails`.`name`,'@',`domains`.`name`,'.',`top_level_domains`.`name`) AS `email`
from (`emails` join ((`domains` join `top_level_domains`) join `members`) on(((`domains`.`id` = `emails`.`domain_id`) and (`top_level_domains`.`id` = `emails`.`top_level_domain_id`) and (`members`.`email_id` = `emails`.`id`))));

--
-- Dumping routines (PROCEDURE) for database 'comp353'
--
DELIMITER ;;

# Dump of PROCEDURE getHotOffers
# ------------------------------------------------------------

/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`snwfog`@`132.205.%.%`*/ /*!50003 PROCEDURE `getHotOffers`(IN p INT)
BEGIN
  SELECT * FROM offers o WHERE o.price < p AND o.expire != 1;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
# Dump of PROCEDURE get_hot_offers
# ------------------------------------------------------------

/*!50003 SET SESSION SQL_MODE="NO_AUTO_VALUE_ON_ZERO"*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`snwfog`@`132.205.%.%`*/ /*!50003 PROCEDURE `get_hot_offers`(IN max INT)
BEGIN 
  SELECT * FROM offers WHERE price <= `max`;
END */;;

/*!50003 SET SESSION SQL_MODE=@OLD_SQL_MODE */;;
DELIMITER ;

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

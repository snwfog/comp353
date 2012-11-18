# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: localhost (MySQL 5.5.25)
# Database: comp353
# Generation Time: 2012-11-18 07:34:07 +0000
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

DROP TABLE IF EXISTS `addresses`;

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `province` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `country` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `postal_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='http://stackoverflow.com/questions/217945/can-i-have-multipl';

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;

INSERT INTO `addresses` (`id`, `address`, `city`, `province`, `country`, `postal_code`)
VALUES
	(1,'123 Fake Street','Montreal','Quebec','Canada','H3H1P1');

/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table admins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admins`;

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

DROP TABLE IF EXISTS `bids`;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

LOCK TABLES `bids` WRITE;
/*!40000 ALTER TABLE `bids` DISABLE KEYS */;

INSERT INTO `bids` (`id`, `member_id`, `offer_id`, `category_id`, `price`, `description`, `expire`)
VALUES
	(1,1,12,32,234,'Ill trade it with my beauty make up',0),
	(2,1,12,35,34,'Ill give u my monthly cycle for it',0),
	(3,1,12,13,48,'Ill trade with you for my pair of old ski still in good condition',0),
	(4,1,12,24,99090909,'my starwars posters from college',0);

/*!40000 ALTER TABLE `bids` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `fk_categories_types` (`type_id`),
  CONSTRAINT `fk_categories_types` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;

INSERT INTO `categories` (`id`, `type_id`, `name`)
VALUES
	(3,2,'Cars & Vehicles'),
	(4,2,'Housing'),
	(5,2,'Baby'),
	(6,2,'Bikes'),
	(7,2,'Boats'),
	(8,2,'Books'),
	(9,2,'Business'),
	(10,2,'Computer'),
	(11,2,'Household'),
	(12,2,'Jewelry'),
	(13,2,'Sporting'),
	(14,2,'Tickets'),
	(15,2,'Tools'),
	(16,2,'Appliances'),
	(17,2,'Arts'),
	(18,2,'Auto'),
	(19,2,'Cars'),
	(20,2,'CD'),
	(21,2,'Cellphone'),
	(22,2,'Clothes'),
	(23,2,'Electronics'),
	(24,2,'Collectibles'),
	(25,2,'Furniture'),
	(26,2,'Motorcycles'),
	(27,2,'Music Instruments'),
	(28,2,'Photo'),
	(29,2,'Video'),
	(30,2,'Toys and Games'),
	(31,2,'Video Gaming'),
	(32,1,'Beauty'),
	(33,1,'Computer'),
	(34,1,'Creative'),
	(35,1,'Cycle'),
	(36,1,'Event'),
	(37,1,'Financial'),
	(38,1,'Legal'),
	(39,1,'Lessons'),
	(40,1,'Pet'),
	(41,1,'Automotive'),
	(42,1,'Farm and Garden'),
	(43,1,'Household'),
	(44,1,'Labor and Move'),
	(45,1,'Real Estate'),
	(46,1,'Skill and Trade'),
	(47,1,'Therapeutic'),
	(48,1,'Travel'),
	(49,1,'Write');

/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comments`;

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

DROP TABLE IF EXISTS `credit_card_types`;

CREATE TABLE `credit_card_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table credit_cards
# ------------------------------------------------------------

DROP TABLE IF EXISTS `credit_cards`;

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

DROP TABLE IF EXISTS `domains`;

CREATE TABLE `domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `domains` WRITE;
/*!40000 ALTER TABLE `domains` DISABLE KEYS */;

INSERT INTO `domains` (`id`, `name`)
VALUES
	(1,'gmail');

/*!40000 ALTER TABLE `domains` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table emails
# ------------------------------------------------------------

DROP TABLE IF EXISTS `emails`;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `emails` WRITE;
/*!40000 ALTER TABLE `emails` DISABLE KEYS */;

INSERT INTO `emails` (`id`, `name`, `domain_id`, `top_level_domain_id`)
VALUES
	(1,'donchoa',1,1);

/*!40000 ALTER TABLE `emails` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table member_reserves
# ------------------------------------------------------------

DROP TABLE IF EXISTS `member_reserves`;

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

DROP TABLE IF EXISTS `members`;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;

INSERT INTO `members` (`id`, `username`, `password`, `email_id`, `address_id`, `visitor_id`, `avatar_url`)
VALUES
	(1,'snw','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4',1,1,1,NULL);

/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table offers
# ------------------------------------------------------------

DROP TABLE IF EXISTS `offers`;

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;

INSERT INTO `offers` (`id`, `title`, `description`, `price`, `category_id`, `image_url`)
VALUES
	(2,'asdlfkjaskdlfj','kljaskldjfklasjdklf',0,41,'NULL'),
	(3,'alksdflkasdjfklj','lkjflaksdjfklajskdlfjaklsdfklajsdklf',0,41,'NULL'),
	(4,'asdkfjaslkdfj','jlkajskldfjaklsdjflkajskldf\r\n',0,12,'NULL'),
	(5,'asdjfaskjdfhjk','jklasdjfklajsdklfjaskdlfj\r\n',0,41,'NULL'),
	(6,'asldkfjaklsdfj','jlkjaskdlfj',0,41,'NULL'),
	(7,'alsdjfklasdjfkl','lkajsdklfjaklsdjflkajsdklfjasdf',0,12,'NULL'),
	(8,'Eye lash','Integer at massa diam. Etiam euismod lectus in metus suscipit eget mattis dolor pharetra. Nulla ultrices vestibulum arcu, ac ornare risus posuere vel. Fusce gravida sagittis justo, nec vestibulum sapien tincidunt sit amet. Nullam tempor ante et purus luctus pretium quis in erat. Morbi hendrerit hendrerit metus, nec vehicula magna lacinia sed. Vivamus ac mi odio. Nam viverra erat nec metus scelerisque tempus. Donec eleifend feugiat nunc, eget scelerisque neque varius vitae. Vivamus facilisis, risus sed varius rutrum, leo ipsum sodales lectus, vitae adipiscing sapien tellus non lorem. Maecenas felis odio, auctor sit amet condimentum at, condimentum non ligula. Mauris non arcu odio, sed tristique nibh. Morbi eu felis a nisi sodales laoreet at eu odio. Suspendisse aliquam bibendum orci ut lacinia. Praesent sem erat, gravida a accumsan quis, tempus ut tortor.\r\n\r\nSed massa nulla, facilisis tristique faucibus vel, euismod eu arcu. Pellentesque ultrices gravida justo, sit amet interdum ligula eleifend quis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus consectetur lobortis elit, quis euismod enim mattis sit amet. Cras viverra nibh erat. Fusce tincidunt venenatis est, et scelerisque tortor scelerisque nec. Mauris porttitor, augue at aliquet accumsan, metus elit scelerisque ipsum, id auctor diam ante vel ',12323,32,'NULL'),
	(9,'Sup sup sup','<p>\r\nPraesent rhoncus, sapien eu luctus faucibus, dolor purus semper metus, vitae ultrices velit neque eleifend odio. Sed laoreet eros scelerisque libero rhoncus a faucibus ligula sollicitudin. In diam justo, elementum ac venenatis id, laoreet a turpis. Nunc elit dolor, aliquam vel tempor id, interdum ullamcorper tortor. Donec ultrices tincidunt ligula, et pharetra felis ultricies quis. Aenean faucibus nibh non nunc interdum quis facilisis justo pharetra. Aenean aliquam fermentum orci, sed cursus nisl accumsan at. Aliquam lacus neque, auctor a accumsan sit amet, tempus et lacus. Sed vitae nibh eget enim lobortis lobortis. Sed lacinia ipsum eget mauris placerat laoreet. Suspendisse laoreet quam et diam consectetur molestie. Cras ultricies sagittis congue. Aliquam neque elit, tempus nec feugiat id, condimentum a mauris.\r\n</p>\r\n<p>\r\nQuisque tempus adipiscing enim, nec rutrum elit dignissim fringilla. Praesent vitae mauris eget velit condimentum euismod sit amet eu arcu. Quisque volutpat lobortis dui, vel tristique ante ullamcorper non. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti. Aenean nec neque ac dolor dignissim fringilla. Aenean condimentum, risus eu malesuada mollis, mi leo auctor risus, vitae gravida purus mauris non sem. Sed et nisi quis eros pharetra rhoncus eu vitae massa. Vestibulum luctus metus in massa lobortis volutpat. Suspendisse semper odio ullamcorper dui porttitor consequat. Suspendisse porttitor, orci eget suscipit blandit, turpis magna tincidunt tortor, vel egestas nisi purus et nibh. Cras in lobortis dolor. Integer ut lectus massa, a vestibulum mauris.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse suscipit tristique consequat. Suspendisse nibh nisi, tempor sit amet congue a, sollicitudin eu orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus eget dapibus tortor. Phasellus quis porttitor sapien. Nulla neque nisl, tempor pulvinar auctor eu, viverra at tellus. Nam non turpis vitae magna porttitor pretium et quis eros. Donec facilisis egestas lacinia. Curabitur tortor velit, bibendum sit amet dapibus id, adipiscing volutpat arcu. Donec et nunc quis justo suscipit fringilla vel vel nisl. Duis sit amet urna urna.\r\n</p>',23942394,3,'NULL'),
	(10,'Sup sup sup','<p>\r\nPraesent rhoncus, sapien eu luctus faucibus, dolor purus semper metus, vitae ultrices velit neque eleifend odio. Sed laoreet eros scelerisque libero rhoncus a faucibus ligula sollicitudin. In diam justo, elementum ac venenatis id, laoreet a turpis. Nunc elit dolor, aliquam vel tempor id, interdum ullamcorper tortor. Donec ultrices tincidunt ligula, et pharetra felis ultricies quis. Aenean faucibus nibh non nunc interdum quis facilisis justo pharetra. Aenean aliquam fermentum orci, sed cursus nisl accumsan at. Aliquam lacus neque, auctor a accumsan sit amet, tempus et lacus. Sed vitae nibh eget enim lobortis lobortis. Sed lacinia ipsum eget mauris placerat laoreet. Suspendisse laoreet quam et diam consectetur molestie. Cras ultricies sagittis congue. Aliquam neque elit, tempus nec feugiat id, condimentum a mauris.\r\n</p>\r\n<p>\r\nQuisque tempus adipiscing enim, nec rutrum elit dignissim fringilla. Praesent vitae mauris eget velit condimentum euismod sit amet eu arcu. Quisque volutpat lobortis dui, vel tristique ante ullamcorper non. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti. Aenean nec neque ac dolor dignissim fringilla. Aenean condimentum, risus eu malesuada mollis, mi leo auctor risus, vitae gravida purus mauris non sem. Sed et nisi quis eros pharetra rhoncus eu vitae massa. Vestibulum luctus metus in massa lobortis volutpat. Suspendisse semper odio ullamcorper dui porttitor consequat. Suspendisse porttitor, orci eget suscipit blandit, turpis magna tincidunt tortor, vel egestas nisi purus et nibh. Cras in lobortis dolor. Integer ut lectus massa, a vestibulum mauris.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse suscipit tristique consequat. Suspendisse nibh nisi, tempor sit amet congue a, sollicitudin eu orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus eget dapibus tortor. Phasellus quis porttitor sapien. Nulla neque nisl, tempor pulvinar auctor eu, viverra at tellus. Nam non turpis vitae magna porttitor pretium et quis eros. Donec facilisis egestas lacinia. Curabitur tortor velit, bibendum sit amet dapibus id, adipiscing volutpat arcu. Donec et nunc quis justo suscipit fringilla vel vel nisl. Duis sit amet urna urna.\r\n</p>',23942394,3,'NULL'),
	(11,'Hello Kitty Tooth brush','<p>\r\nPraesent rhoncus, sapien eu luctus faucibus, dolor purus semper metus, vitae ultrices velit neque eleifend odio. Sed laoreet eros scelerisque libero rhoncus a faucibus ligula sollicitudin. In diam justo, elementum ac venenatis id, laoreet a turpis. Nunc elit dolor, aliquam vel tempor id, interdum ullamcorper tortor. Donec ultrices tincidunt ligula, et pharetra felis ultricies quis. Aenean faucibus nibh non nunc interdum quis facilisis justo pharetra. Aenean aliquam fermentum orci, sed cursus nisl accumsan at. Aliquam lacus neque, auctor a accumsan sit amet, tempus et lacus. Sed vitae nibh eget enim lobortis lobortis. Sed lacinia ipsum eget mauris placerat laoreet. Suspendisse laoreet quam et diam consectetur molestie. Cras ultricies sagittis congue. Aliquam neque elit, tempus nec feugiat id, condimentum a mauris.\r\n</p>\r\n<p>\r\nQuisque tempus adipiscing enim, nec rutrum elit dignissim fringilla. Praesent vitae mauris eget velit condimentum euismod sit amet eu arcu. Quisque volutpat lobortis dui, vel tristique ante ullamcorper non. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti. Aenean nec neque ac dolor dignissim fringilla. Aenean condimentum, risus eu malesuada mollis, mi leo auctor risus, vitae gravida purus mauris non sem. Sed et nisi quis eros pharetra rhoncus eu vitae massa. Vestibulum luctus metus in massa lobortis volutpat. Suspendisse semper odio ullamcorper dui porttitor consequat. Suspendisse porttitor, orci eget suscipit blandit, turpis magna tincidunt tortor, vel egestas nisi purus et nibh. Cras in lobortis dolor. Integer ut lectus massa, a vestibulum mauris.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse suscipit tristique consequat. Suspendisse nibh nisi, tempor sit amet congue a, sollicitudin eu orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus eget dapibus tortor. Phasellus quis porttitor sapien. Nulla neque nisl, tempor pulvinar auctor eu, viverra at tellus. Nam non turpis vitae magna porttitor pretium et quis eros. Donec facilisis egestas lacinia. Curabitur tortor velit, bibendum sit amet dapibus id, adipiscing volutpat arcu. Donec et nunc quis justo suscipit fringilla vel vel nisl. Duis sit amet urna urna.\r\n</p>',23,32,'NULL'),
	(12,'Mega Man Atari Game','<p>\r\nPraesent rhoncus, sapien eu luctus faucibus, dolor purus semper metus, vitae ultrices velit neque eleifend odio. Sed laoreet eros scelerisque libero rhoncus a faucibus ligula sollicitudin. In diam justo, elementum ac venenatis id, laoreet a turpis. Nunc elit dolor, aliquam vel tempor id, interdum ullamcorper tortor. Donec ultrices tincidunt ligula, et pharetra felis ultricies quis. Aenean faucibus nibh non nunc interdum quis facilisis justo pharetra. Aenean aliquam fermentum orci, sed cursus nisl accumsan at. Aliquam lacus neque, auctor a accumsan sit amet, tempus et lacus. Sed vitae nibh eget enim lobortis lobortis. Sed lacinia ipsum eget mauris placerat laoreet. Suspendisse laoreet quam et diam consectetur molestie. Cras ultricies sagittis congue. Aliquam neque elit, tempus nec feugiat id, condimentum a mauris.\r\n</p>\r\n<p>\r\nQuisque tempus adipiscing enim, nec rutrum elit dignissim fringilla. Praesent vitae mauris eget velit condimentum euismod sit amet eu arcu. Quisque volutpat lobortis dui, vel tristique ante ullamcorper non. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti. Aenean nec neque ac dolor dignissim fringilla. Aenean condimentum, risus eu malesuada mollis, mi leo auctor risus, vitae gravida purus mauris non sem. Sed et nisi quis eros pharetra rhoncus eu vitae massa. Vestibulum luctus metus in massa lobortis volutpat. Suspendisse semper odio ullamcorper dui porttitor consequat. Suspendisse porttitor, orci eget suscipit blandit, turpis magna tincidunt tortor, vel egestas nisi purus et nibh. Cras in lobortis dolor. Integer ut lectus massa, a vestibulum mauris.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse suscipit tristique consequat. Suspendisse nibh nisi, tempor sit amet congue a, sollicitudin eu orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus eget dapibus tortor. Phasellus quis porttitor sapien. Nulla neque nisl, tempor pulvinar auctor eu, viverra at tellus. Nam non turpis vitae magna porttitor pretium et quis eros. Donec facilisis egestas lacinia. Curabitur tortor velit, bibendum sit amet dapibus id, adipiscing volutpat arcu. Donec et nunc quis justo suscipit fringilla vel vel nisl. Duis sit amet urna urna.\r\n</p>',2,31,'NULL');

/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table posts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `posts`;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;

INSERT INTO `posts` (`member_id`, `offer_id`, `id`)
VALUES
	(1,8,1),
	(1,10,2),
	(1,11,3),
	(1,12,4);

/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ratings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ratings`;

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

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `session` varchar(255) NOT NULL DEFAULT '',
  `expire` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_sessions_members_idx` (`member_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;

INSERT INTO `sessions` (`id`, `member_id`, `session`, `expire`)
VALUES
	(1,1,'28b49417d514d5a281f99d7bffdeb2ac880d30b1f3030b506cbce8a0546ab2d5',0);

/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table top_level_domains
# ------------------------------------------------------------

DROP TABLE IF EXISTS `top_level_domains`;

CREATE TABLE `top_level_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `top_level_domains` WRITE;
/*!40000 ALTER TABLE `top_level_domains` DISABLE KEYS */;

INSERT INTO `top_level_domains` (`id`, `name`)
VALUES
	(1,'com');

/*!40000 ALTER TABLE `top_level_domains` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table transacts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `transacts`;

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

DROP TABLE IF EXISTS `types`;

CREATE TABLE `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;

INSERT INTO `types` (`id`, `name`)
VALUES
	(1,'Service'),
	(2,'Good');

/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table visitor_reserves
# ------------------------------------------------------------

DROP TABLE IF EXISTS `visitor_reserves`;

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

DROP TABLE IF EXISTS `visitors`;

CREATE TABLE `visitors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL DEFAULT '',
  `last_name` varchar(255) NOT NULL DEFAULT '',
  `phone_number` varchar(255) NOT NULL DEFAULT '',
  `join_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `visitors_id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

LOCK TABLES `visitors` WRITE;
/*!40000 ALTER TABLE `visitors` DISABLE KEYS */;

INSERT INTO `visitors` (`id`, `first_name`, `last_name`, `phone_number`, `join_date`)
VALUES
	(1,'Charles','Yang','5148826452','2012-11-17');

/*!40000 ALTER TABLE `visitors` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

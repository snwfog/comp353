﻿-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 30, 2012 at 02:07 AM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `comp353`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`snwfog`@`132.205.%.%` PROCEDURE `getHotOffers`(IN p INT)
BEGIN
  SELECT * FROM offers o WHERE o.price < p AND o.expire != 1;
END$$

CREATE DEFINER=`snwfog`@`132.205.%.%` PROCEDURE `get_hot_offers`(IN max INT)
BEGIN 
  SELECT * FROM offers WHERE price <= `max`;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE IF NOT EXISTS `addresses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `city` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `province` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `country` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `postal_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='http://stackoverflow.com/questions/217945/can-i-have-multipl' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `address`, `city`, `province`, `country`, `postal_code`) VALUES
(1, '123 Fake Street', 'Montreal', 'Quebec', 'Canada', 'H3H1P1'),
(2, '123 Real Street', 'Toronto', 'Ontario', 'Canada', '8898934'),
(3, '7979 de madere', 'Montreal', 'Quebec', 'Canada', 'h1p3c7'),
(4, '543 Near Lake', 'Boston', 'Maryland', 'US', '9394893');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE IF NOT EXISTS `admins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `member_id_UNIQUE` (`member_id`),
  KEY `id_idx` (`member_id`),
  KEY `fk_admin_members_idx` (`member_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `member_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `bids`
--

CREATE TABLE IF NOT EXISTS `bids` (
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
  KEY `fk_bids_categories` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `bids`
--

INSERT INTO `bids` (`id`, `member_id`, `offer_id`, `category_id`, `price`, `description`, `expire`) VALUES
(1, 1, 12, 32, 234, 'Ill trade it with my beauty make up', 1),
(2, 1, 12, 35, 34, 'Ill give u my monthly cycle for it', 1),
(3, 1, 12, 13, 48, 'Ill trade with you for my pair of old ski still in good condition', 1),
(4, 1, 12, 24, 99090909, 'my starwars posters from college', 1),
(5, 1, 12, 33, 0, 'Gonna repair your computer for free lolz', 1),
(6, 2, 8, 36, 123, 'Will host one birthday party at your home for free.', 1),
(7, 2, 8, 34, 45, 'Will draw your naked portrait', 1),
(8, 1, 33, 37, 89, 'financial helping you.', 1),
(9, 1, 33, 40, 89, 'Ill give your pet a nice grooming, worth of 89 dollar', 1);

--
-- Triggers `bids`
--
DROP TRIGGER IF EXISTS `after_bids_update`;
DELIMITER //
CREATE TRIGGER `after_bids_update` AFTER UPDATE ON `bids`
 FOR EACH ROW BEGIN
  IF (NEW.expire = 1) THEN
    INSERT INTO notify_queue (bid_id, expire_date) VALUES (NEW.id, curdate());
  END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `fk_categories_types` (`type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=50 ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `type_id`, `name`) VALUES
(3, 2, 'Cars & Vehicles'),
(4, 2, 'Housing'),
(5, 2, 'Baby'),
(6, 2, 'Bikes'),
(7, 2, 'Boats'),
(8, 2, 'Books'),
(9, 2, 'Business'),
(10, 2, 'Computer'),
(11, 2, 'Household'),
(12, 2, 'Jewelry'),
(13, 2, 'Sporting'),
(14, 2, 'Tickets'),
(15, 2, 'Tools'),
(16, 2, 'Appliances'),
(17, 2, 'Arts'),
(18, 2, 'Auto'),
(19, 2, 'Cars'),
(20, 2, 'CD'),
(21, 2, 'Cellphone'),
(22, 2, 'Clothes'),
(23, 2, 'Electronics'),
(24, 2, 'Collectibles'),
(25, 2, 'Furniture'),
(26, 2, 'Motorcycles'),
(27, 2, 'Music Instruments'),
(28, 2, 'Photo'),
(29, 2, 'Video'),
(30, 2, 'Toys and Games'),
(31, 2, 'Video Gaming'),
(32, 1, 'Beauty'),
(33, 1, 'Computer'),
(34, 1, 'Creative'),
(35, 1, 'Cycle'),
(36, 1, 'Event'),
(37, 1, 'Financial'),
(38, 1, 'Legal'),
(39, 1, 'Lessons'),
(40, 1, 'Pet'),
(41, 1, 'Automotive'),
(42, 1, 'Farm and Garden'),
(43, 1, 'Household'),
(44, 1, 'Labor and Move'),
(45, 1, 'Real Estate'),
(46, 1, 'Skill and Trade'),
(47, 1, 'Therapeutic'),
(48, 1, 'Travel'),
(49, 1, 'Write');

-- --------------------------------------------------------

--
-- Table structure for table `credit_cards`
--

CREATE TABLE IF NOT EXISTS `credit_cards` (
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
  KEY `fk_credit_cards_credit_card_types` (`credit_card_type_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `credit_cards`
--

INSERT INTO `credit_cards` (`id`, `member_id`, `credit_card_type_id`, `number`, `expire`, `verification_code`, `holder_name`) VALUES
(1, 2, 1, '1010101', '512', '123', 'FUCK'),
(2, 1, 1, '01010101', '0512', '123', 'FUCK'),
(5, 3, 1, '109283091', '0110', '191', 'Mike');

-- --------------------------------------------------------

--
-- Table structure for table `credit_card_transactions`
--

CREATE TABLE IF NOT EXISTS `credit_card_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `credit_card_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `amount` float(12,2) NOT NULL,
  `description` varchar(256) NOT NULL,
  `fee_type` varchar(256) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_credit_card_transactions_credit_cards_idx` (`credit_card_id`),
  KEY `fk_credit_card_transactions_offer_idx` (`offer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `credit_card_transactions`
--

INSERT INTO `credit_card_transactions` (`id`, `credit_card_id`, `offer_id`, `amount`, `description`, `fee_type`, `date`) VALUES
(8, 1, 33, 4.45, 'This is a service charge for offer, Database assignment tutoring, at the price of 89$', 'service', '2012-11-29 04:39:39');

--
-- Triggers `credit_card_transactions`
--
DROP TRIGGER IF EXISTS `check_amount`;
DELIMITER //
CREATE TRIGGER `check_amount` BEFORE INSERT ON `credit_card_transactions`
 FOR EACH ROW BEGIN
	IF NOT NEW.amount > 0.00 THEN
		SET NEW.credit_card_id = NULL;
		SET NEW.offer_id = NULL;
		SET NEW.amount = NULL;
	END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `credit_card_types`
--

CREATE TABLE IF NOT EXISTS `credit_card_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `credit_card_types`
--

INSERT INTO `credit_card_types` (`id`, `type`) VALUES
(1, 'PokemonBadge'),
(2, 'PokemonCard');

-- --------------------------------------------------------

--
-- Table structure for table `domains`
--

CREATE TABLE IF NOT EXISTS `domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `domains`
--

INSERT INTO `domains` (`id`, `name`) VALUES
(1, 'gmail'),
(2, 'hotmail');

-- --------------------------------------------------------

--
-- Table structure for table `emails`
--

CREATE TABLE IF NOT EXISTS `emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `domain_id` int(11) NOT NULL,
  `top_level_domain_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`domain_id`,`top_level_domain_id`),
  KEY `fk_emails_domains` (`domain_id`),
  KEY `fk_emails_top_level_domains` (`top_level_domain_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `emails`
--

INSERT INTO `emails` (`id`, `name`, `domain_id`, `top_level_domain_id`) VALUES
(1, 'donchoa', 1, 1),
(2, 'donchoa11', 1, 1),
(4, 'needmoneyz', 2, 1),
(3, 'viet_mike.pham', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

CREATE TABLE IF NOT EXISTS `feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rater_id` int(11) NOT NULL,
  `ratee_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `fk_feedbacks_members_raters` (`rater_id`),
  KEY `fk_feedbacks_members_ratees` (`ratee_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `feedbacks`
--

INSERT INTO `feedbacks` (`id`, `rater_id`, `ratee_id`, `rating`, `comment`) VALUES
(1, 2, 1, 1, 'asdfkasjdfklasjdlf\r\n'),
(2, 2, 1, 3, 'aasdfasdflakjsdlfjasldkf\r\naksdjflaksdjf'),
(3, 2, 1, 9, 'asdlfkjasdklfjaskldfj\r\nasdkfjasldkjf\r\nalskdjflkasdjf'),
(4, 2, 1, 4, 'alksdjflkasdf;lkajsdf\r\nasdlfkjaslkdfja\r\nlkasdjfklasjdklf'),
(5, 2, 1, 6, 'lkasdjfklasjdlfkjaskdlf\r\naskldfjaklsdjfkl;a\r\n;lasdjflkajsdklf\r\nkasdjfklasjdklfasdf'),
(6, 1, 2, 1, 'asdfasdfasdf'),
(7, 2, 1, 6, 'This guy sucks.'),
(8, 1, 2, 1, 'hes alright i guess.');

-- --------------------------------------------------------

--
-- Stand-in structure for view `garages`
--
CREATE TABLE IF NOT EXISTS `garages` (
`id` int(11)
,`transact_id` int(11)
,`acquire_date` date
,`pickup_date` date
,`weight` enum('light','medium','heavy')
);
-- --------------------------------------------------------

--
-- Table structure for table `giveaways`
--

CREATE TABLE IF NOT EXISTS `giveaways` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_giveaways_offers` (`offer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `giveaways`
--

INSERT INTO `giveaways` (`id`, `offer_id`) VALUES
(1, 31),
(2, 37),
(3, 38),
(4, 48);

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE IF NOT EXISTS `members` (
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
  KEY `fk_members_emails` (`email_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `username`, `password`, `email_id`, `address_id`, `visitor_id`, `avatar_url`) VALUES
(1, 'snw', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 1, 1, 1, NULL),
(2, 'fog', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 2, 2, 2, NULL),
(3, 'mike', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 3, 3, 3, NULL),
(4, 'scavenger101', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 4, 4, 4, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notify_acquire`
--

CREATE TABLE IF NOT EXISTS `notify_acquire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storage_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notify_acquire_storages` (`storage_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Dumping data for table `notify_acquire`
--

INSERT INTO `notify_acquire` (`id`, `storage_id`) VALUES
(18, 1),
(19, 3),
(20, 3);

-- --------------------------------------------------------

--
-- Table structure for table `notify_modify`
--

CREATE TABLE IF NOT EXISTS `notify_modify` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notify_modify_offers` (`offer_id`),
  KEY `fk_notify_modify_members` (`member_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

-- --------------------------------------------------------

--
-- Table structure for table `notify_pickup`
--

CREATE TABLE IF NOT EXISTS `notify_pickup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storage_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notify_pickup_storages` (`storage_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `notify_pickup`
--

INSERT INTO `notify_pickup` (`id`, `storage_id`) VALUES
(12, 3);

-- --------------------------------------------------------

--
-- Table structure for table `notify_queue`
--

CREATE TABLE IF NOT EXISTS `notify_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bid_id` int(11) NOT NULL,
  `expire_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notify_queue_bids` (`bid_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=51 ;

--
-- Dumping data for table `notify_queue`
--

INSERT INTO `notify_queue` (`id`, `bid_id`, `expire_date`) VALUES
(1, 1, '2012-11-22'),
(2, 2, '2012-11-22'),
(11, 8, '2012-11-28'),
(12, 9, '2012-11-28'),
(13, 8, '2012-11-28'),
(14, 9, '2012-11-28'),
(15, 8, '2012-11-28'),
(16, 9, '2012-11-28'),
(17, 8, '2012-11-28'),
(18, 9, '2012-11-28'),
(19, 8, '2012-11-28'),
(20, 9, '2012-11-28'),
(21, 8, '2012-11-28'),
(22, 9, '2012-11-28'),
(23, 8, '2012-11-28'),
(24, 9, '2012-11-28'),
(25, 8, '2012-11-28'),
(26, 9, '2012-11-28'),
(27, 8, '2012-11-29'),
(28, 9, '2012-11-29'),
(29, 1, '2012-11-29'),
(30, 2, '2012-11-29'),
(31, 3, '2012-11-29'),
(32, 4, '2012-11-29'),
(33, 5, '2012-11-29'),
(34, 6, '2012-11-29'),
(35, 7, '2012-11-29'),
(36, 1, '2012-11-29'),
(37, 2, '2012-11-29'),
(38, 3, '2012-11-29'),
(39, 4, '2012-11-29'),
(40, 5, '2012-11-29'),
(41, 1, '2012-11-29'),
(42, 2, '2012-11-29'),
(43, 3, '2012-11-29'),
(44, 4, '2012-11-29'),
(45, 5, '2012-11-29'),
(46, 1, '2012-11-29'),
(47, 2, '2012-11-29'),
(48, 3, '2012-11-29'),
(49, 4, '2012-11-29'),
(50, 5, '2012-11-29');

-- --------------------------------------------------------

--
-- Table structure for table `notify_receive`
--

CREATE TABLE IF NOT EXISTS `notify_receive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storage_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_notify_receive_storages` (`storage_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `notify_receive`
--

INSERT INTO `notify_receive` (`id`, `storage_id`) VALUES
(9, 1),
(10, 3),
(11, 3);

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE IF NOT EXISTS `offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` float(12,2) NOT NULL,
  `category_id` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `expire` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_offers_categories` (`category_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=53 ;

--
-- Dumping data for table `offers`
--

INSERT INTO `offers` (`id`, `title`, `description`, `price`, `category_id`, `image_url`, `expire`) VALUES
(8, 'Eye lash', 'Integer at massa diam. Etiam euismod lectus in metus suscipit eget mattis dolor pharetra. Nulla ultrices vestibulum arcu, ac ornare risus posuere vel. Fusce gravida sagittis justo, nec vestibulum sapien tincidunt sit amet. Nullam tempor ante et purus luctus pretium quis in erat. Morbi hendrerit hendrerit metus, nec vehicula magna lacinia sed. Vivamus ac mi odio. Nam viverra erat nec metus scelerisque tempus. Donec eleifend feugiat nunc, eget scelerisque neque varius vitae. Vivamus facilisis, risus sed varius rutrum, leo ipsum sodales lectus, vitae adipiscing sapien tellus non lorem. Maecenas felis odio, auctor sit amet condimentum at, condimentum non ligula. Mauris non arcu odio, sed tristique nibh. Morbi eu felis a nisi sodales laoreet at eu odio. Suspendisse aliquam bibendum orci ut lacinia. Praesent sem erat, gravida a accumsan quis, tempus ut tortor.\r\n\r\nSed massa nulla, facilisis tristique faucibus vel, euismod eu arcu. Pellentesque ultrices gravida justo, sit amet interdum ligula eleifend quis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus consectetur lobortis elit, quis euismod enim mattis sit amet. Cras viverra nibh erat. Fusce tincidunt venenatis est, et scelerisque tortor scelerisque nec. Mauris porttitor, augue at aliquet accumsan, metus elit scelerisque ipsum, id auctor diam ante vel ', 12323.00, 32, '', 1),
(9, 'Sup sup sup', '<p>\r\nPraesent rhoncus, sapien eu luctus faucibus, dolor purus semper metus, vitae ultrices velit neque eleifend odio. Sed laoreet eros scelerisque libero rhoncus a faucibus ligula sollicitudin. In diam justo, elementum ac venenatis id, laoreet a turpis. Nunc elit dolor, aliquam vel tempor id, interdum ullamcorper tortor. Donec ultrices tincidunt ligula, et pharetra felis ultricies quis. Aenean faucibus nibh non nunc interdum quis facilisis justo pharetra. Aenean aliquam fermentum orci, sed cursus nisl accumsan at. Aliquam lacus neque, auctor a accumsan sit amet, tempus et lacus. Sed vitae nibh eget enim lobortis lobortis. Sed lacinia ipsum eget mauris placerat laoreet. Suspendisse laoreet quam et diam consectetur molestie. Cras ultricies sagittis congue. Aliquam neque elit, tempus nec feugiat id, condimentum a mauris.\r\n</p>\r\n<p>\r\nQuisque tempus adipiscing enim, nec rutrum elit dignissim fringilla. Praesent vitae mauris eget velit condimentum euismod sit amet eu arcu. Quisque volutpat lobortis dui, vel tristique ante ullamcorper non. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti. Aenean nec neque ac dolor dignissim fringilla. Aenean condimentum, risus eu malesuada mollis, mi leo auctor risus, vitae gravida purus mauris non sem. Sed et nisi quis eros pharetra rhoncus eu vitae massa. Vestibulum luctus metus in massa lobortis volutpat. Suspendisse semper odio ullamcorper dui porttitor consequat. Suspendisse porttitor, orci eget suscipit blandit, turpis magna tincidunt tortor, vel egestas nisi purus et nibh. Cras in lobortis dolor. Integer ut lectus massa, a vestibulum mauris.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse suscipit tristique consequat. Suspendisse nibh nisi, tempor sit amet congue a, sollicitudin eu orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus eget dapibus tortor. Phasellus quis porttitor sapien. Nulla neque nisl, tempor pulvinar auctor eu, viverra at tellus. Nam non turpis vitae magna porttitor pretium et quis eros. Donec facilisis egestas lacinia. Curabitur tortor velit, bibendum sit amet dapibus id, adipiscing volutpat arcu. Donec et nunc quis justo suscipit fringilla vel vel nisl. Duis sit amet urna urna.\r\n</p>', 23942394.00, 3, '', 0),
(10, 'Sup sup sup', '<p>\r\nPraesent rhoncus, sapien eu luctus faucibus, dolor purus semper metus, vitae ultrices velit neque eleifend odio. Sed laoreet eros scelerisque libero rhoncus a faucibus ligula sollicitudin. In diam justo, elementum ac venenatis id, laoreet a turpis. Nunc elit dolor, aliquam vel tempor id, interdum ullamcorper tortor. Donec ultrices tincidunt ligula, et pharetra felis ultricies quis. Aenean faucibus nibh non nunc interdum quis facilisis justo pharetra. Aenean aliquam fermentum orci, sed cursus nisl accumsan at. Aliquam lacus neque, auctor a accumsan sit amet, tempus et lacus. Sed vitae nibh eget enim lobortis lobortis. Sed lacinia ipsum eget mauris placerat laoreet. Suspendisse laoreet quam et diam consectetur molestie. Cras ultricies sagittis congue. Aliquam neque elit, tempus nec feugiat id, condimentum a mauris.\r\n</p>\r\n<p>\r\nQuisque tempus adipiscing enim, nec rutrum elit dignissim fringilla. Praesent vitae mauris eget velit condimentum euismod sit amet eu arcu. Quisque volutpat lobortis dui, vel tristique ante ullamcorper non. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti. Aenean nec neque ac dolor dignissim fringilla. Aenean condimentum, risus eu malesuada mollis, mi leo auctor risus, vitae gravida purus mauris non sem. Sed et nisi quis eros pharetra rhoncus eu vitae massa. Vestibulum luctus metus in massa lobortis volutpat. Suspendisse semper odio ullamcorper dui porttitor consequat. Suspendisse porttitor, orci eget suscipit blandit, turpis magna tincidunt tortor, vel egestas nisi purus et nibh. Cras in lobortis dolor. Integer ut lectus massa, a vestibulum mauris.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse suscipit tristique consequat. Suspendisse nibh nisi, tempor sit amet congue a, sollicitudin eu orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus eget dapibus tortor. Phasellus quis porttitor sapien. Nulla neque nisl, tempor pulvinar auctor eu, viverra at tellus. Nam non turpis vitae magna porttitor pretium et quis eros. Donec facilisis egestas lacinia. Curabitur tortor velit, bibendum sit amet dapibus id, adipiscing volutpat arcu. Donec et nunc quis justo suscipit fringilla vel vel nisl. Duis sit amet urna urna.\r\n</p>', 23942394.00, 3, '', 1),
(11, 'Hello Kitty Tooth brush', '<p>\r\nPraesent rhoncus, sapien eu luctus faucibus, dolor purus semper metus, vitae ultrices velit neque eleifend odio. Sed laoreet eros scelerisque libero rhoncus a faucibus ligula sollicitudin. In diam justo, elementum ac venenatis id, laoreet a turpis. Nunc elit dolor, aliquam vel tempor id, interdum ullamcorper tortor. Donec ultrices tincidunt ligula, et pharetra felis ultricies quis. Aenean faucibus nibh non nunc interdum quis facilisis justo pharetra. Aenean aliquam fermentum orci, sed cursus nisl accumsan at. Aliquam lacus neque, auctor a accumsan sit amet, tempus et lacus. Sed vitae nibh eget enim lobortis lobortis. Sed lacinia ipsum eget mauris placerat laoreet. Suspendisse laoreet quam et diam consectetur molestie. Cras ultricies sagittis congue. Aliquam neque elit, tempus nec feugiat id, condimentum a mauris.\r\n</p>\r\n<p>\r\nQuisque tempus adipiscing enim, nec rutrum elit dignissim fringilla. Praesent vitae mauris eget velit condimentum euismod sit amet eu arcu. Quisque volutpat lobortis dui, vel tristique ante ullamcorper non. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti. Aenean nec neque ac dolor dignissim fringilla. Aenean condimentum, risus eu malesuada mollis, mi leo auctor risus, vitae gravida purus mauris non sem. Sed et nisi quis eros pharetra rhoncus eu vitae massa. Vestibulum luctus metus in massa lobortis volutpat. Suspendisse semper odio ullamcorper dui porttitor consequat. Suspendisse porttitor, orci eget suscipit blandit, turpis magna tincidunt tortor, vel egestas nisi purus et nibh. Cras in lobortis dolor. Integer ut lectus massa, a vestibulum mauris.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse suscipit tristique consequat. Suspendisse nibh nisi, tempor sit amet congue a, sollicitudin eu orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus eget dapibus tortor. Phasellus quis porttitor sapien. Nulla neque nisl, tempor pulvinar auctor eu, viverra at tellus. Nam non turpis vitae magna porttitor pretium et quis eros. Donec facilisis egestas lacinia. Curabitur tortor velit, bibendum sit amet dapibus id, adipiscing volutpat arcu. Donec et nunc quis justo suscipit fringilla vel vel nisl. Duis sit amet urna urna.\r\n</p>', 23.00, 32, '', 1),
(12, 'Mega Man Atari Game LOLOLOL', 'Praesent rhoncus, sapien eu luctus faucibus, dolor purus semper metus, vitae ultrices velit neque eleifend odio. Sed laoreet eros scelerisque libero rhoncus a faucibus ligula sollicitudin. In diam justo, elementum ac venenatis id, laoreet a turpis. Nunc elit dolor, aliquam vel tempor id, interdum ullamcorper tortor. Donec ultrices tincidunt ligula, et pharetra felis ultricies quis. Aenean faucibus nibh non nunc interdum quis facilisis justo pharetra. Aenean aliquam fermentum orci, sed cursus nisl accumsan at. Aliquam lacus neque, auctor a accumsan sit amet, tempus et lacus. Sed vitae nibh eget enim lobortis lobortis. Sed lacinia ipsum eget mauris placerat laoreet. Suspendisse laoreet quam et diam consectetur molestie. Cras ultricies sagittis congue. Aliquam neque elit, tempus nec feugiat id, condimentum a mauris.\r\n\r\nQuisque tempus adipiscing enim, nec rutrum elit dignissim fringilla. Praesent vitae mauris eget velit condimentum euismod sit amet eu arcu. Quisque volutpat lobortis dui, vel tristique ante ullamcorper non. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti. Aenean nec neque ac dolor dignissim fringilla. Aenean condimentum, risus eu malesuada mollis, mi leo auctor risus, vitae gravida purus mauris non sem. Sed et nisi quis eros pharetra rhoncus eu vitae massa. Vestibulum luctus metus in massa lobortis volutpat. Suspendisse semper odio ullamcorper dui porttitor consequat. Suspendisse porttitor, orci eget suscipit blandit, turpis magna tincidunt tortor, vel egestas nisi purus et nibh. Cras in lobortis dolor. Integer ut lectus massa, a vestibulum mauris.\r\n\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse suscipit tristique consequat. Suspendisse nibh nisi, tempor sit amet congue a, sollicitudin eu orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus eget dapibus tortor. Phasellus quis porttitor sapien. Nulla neque nisl, tempor pulvinar auctor eu, viverra at tellus. Nam non turpis vitae magna porttitor pretium et quis eros. Donec facilisis egestas lacinia. Curabitur tortor velit, bibendum sit amet dapibus id, adipiscing volutpat arcu. Donec et nunc quis justo suscipit fringilla vel vel nisl. Duis sit amet urna urna.\r\n', 2.00, 31, '', 0),
(13, 'Apple iPad Mini Black', 'Brand new Apple iPad mini in black. Asking for 400. Cash only. SErious offer contact.', 400.00, 23, '', 1),
(14, '', '', 0.00, 32, '', 1),
(15, '', '', 0.00, 32, '', 1),
(16, '', '', 0.00, 32, '', 1),
(17, '', '', 0.00, 32, '', 1),
(18, 'MenBody Magazine July 1983', 'Selling my July 1983 MenBodys magazine. In good shape, used by my grand parents.', 3.99, 13, '', 1),
(25, 'Old car 1980', 'Giving away my little car from my grand dad.', 4.00, 19, '', 1),
(31, 'Baby clothes', 'Give away 3 years old baby clothes', 0.00, 5, '', 1),
(32, 'Macbook pro 13 in 2009', 'still in good condition. PST', 800.00, 33, '', 1),
(33, 'Database assignment tutoring', '99 Dollar per hours for database comp353 tutoring.', 99.00, 39, '', 1),
(34, 'asdfasdf', 'asdfasdfasdf', 33343.00, 32, '', 1),
(35, '123 123 123', '123123123123', 234234240.00, 5, '', 0),
(36, 'Unicorn rainbow candy', 'Selling unicorn rainbow cotton candy. Will grant you 3 wishes upon eating them.', 9999999.00, 30, '', 0),
(37, 'Staring', 'Contest', 0.00, 32, '', 1),
(38, 'New staring contest', 'Contest', 0.00, 32, '', 0),
(39, 'test', 'test', 234.00, 32, '', 0),
(40, 'test', 'test', 234.00, 32, '', 0),
(41, 'test', 'test', 234.00, 32, '', 0),
(42, 'test', 'test', 234.00, 32, '5feceb66ffc86f38d952786c6d696c79c2dbc239dd4e91b46729d73a27fb57e9.jpg', 0),
(43, '234234', 'asdfasdfasdf', 234234.00, 32, '', 0),
(44, '234234', 'asdfasdfasdf', 234.00, 34, '', 0),
(45, 'asdfasdf', 'asdfasdf', 234234.00, 32, '', 0),
(46, 'kasdjfkasdf', 'testets', 34.00, 32, '', 0),
(47, 'my offer', 'bye world', 123123.00, 32, '', 0),
(48, 'new elegant offer', 'new elegant offer', 0.00, 32, '', 0),
(49, 'asdf', 'asdfasdf', 234.00, 32, '', 0),
(50, '234234', 'asdfasdf', 234234.00, 32, '', 0),
(51, 'Another elegant offer', 'aksdfjkasdjfkasdf', 199999.00, 32, '', 0),
(52, 'new elegant offer with picture', 'dadfasdfasdf', 293493280.00, 32, '5feceb66ffc86f38d952786c6d696c79c2dbc239dd4e91b46729d73a27fb57e9.jpg', 0);

--
-- Triggers `offers`
--
DROP TRIGGER IF EXISTS `after_offers_insert`;
DELIMITER //
CREATE TRIGGER `after_offers_insert` AFTER INSERT ON `offers`
 FOR EACH ROW BEGIN
  IF (NEW.price = 0) THEN
    INSERT INTO giveaways(offer_id) VALUES (NEW.id);
  END IF;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `after_offers_update`;
DELIMITER //
CREATE TRIGGER `after_offers_update` AFTER UPDATE ON `offers`
 FOR EACH ROW BEGIN
  	IF (NEW.expire = 1) THEN
  		UPDATE bids SET expire = NEW.expire WHERE offer_id = NEW.id;
  	ELSE
		INSERT INTO notify_modify (member_id, offer_id) 
		(SELECT bids.member_id, offer_id FROM bids WHERE offer_id = NEW.id);
	END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
  `member_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `fk_posts_members_idx` (`member_id`),
  KEY `fk_posts_offers_idx` (`offer_id`),
  KEY `fk_posts_members_idx1` (`member_id`),
  KEY `fk_posts_offers_idx1` (`offer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=41 ;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`member_id`, `offer_id`, `id`) VALUES
(1, 8, 1),
(1, 10, 2),
(1, 11, 3),
(1, 12, 4),
(1, 13, 5),
(1, 14, 6),
(1, 15, 7),
(1, 16, 8),
(1, 17, 9),
(1, 18, 11),
(1, 25, 17),
(1, 31, 19),
(1, 32, 20),
(2, 33, 21),
(1, 34, 22),
(1, 35, 23),
(1, 36, 24),
(1, 37, 25),
(1, 38, 26),
(1, 39, 27),
(1, 40, 28),
(1, 41, 29),
(1, 42, 30),
(1, 43, 31),
(1, 44, 32),
(1, 45, 33),
(1, 46, 34),
(1, 47, 35),
(1, 48, 36),
(1, 49, 37),
(1, 50, 38),
(1, 51, 39),
(1, 52, 40);

-- --------------------------------------------------------

--
-- Table structure for table `prices`
--

CREATE TABLE IF NOT EXISTS `prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fee_name` varchar(256) NOT NULL DEFAULT '',
  `amount` float(12,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `prices`
--

INSERT INTO `prices` (`id`, `fee_name`, `amount`) VALUES
(7, 'service', 0.05),
(8, 'base_storage', 5.00),
(9, 'volume', 0.12),
(10, 'weight_light', 10.00),
(11, 'weight_medium', 15.00),
(12, 'weight_heavy', 20.00),
(13, 'volume_small', 8.00),
(14, 'volume_medium', 10.00),
(15, 'volume_large', 12.00);

-- --------------------------------------------------------

--
-- Table structure for table `reserves`
--

CREATE TABLE IF NOT EXISTS `reserves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visitor_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `reserve_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `visitor_id` (`visitor_id`,`offer_id`),
  KEY `fk_reserves_offers` (`offer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `session` varchar(255) NOT NULL DEFAULT '',
  `expire` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_sessions_members_idx` (`member_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=107 ;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `member_id`, `session`, `expire`) VALUES
(1, 1, '28b49417d514d5a281f99d7bffdeb2ac880d30b1f3030b506cbce8a0546ab2d5', 1),
(2, 1, '1361753fad134688e205c2544a18331aa05a460aaabe0b6acda44542f6de4b20', 1),
(3, 1, '507504e8c0f58d329eabe5556acc76167c93f7e93004214ea511e0ec02cb7ae4', 1),
(4, 1, '8acecc82af19d4825e506d75017dae9d685def9bd1b6bd27f66abe3512c264f7', 1),
(5, 2, 'fa9faa030bcaebe090e8ec7d3063f7d6b7c54f24b0baf424503d9e2c3ef3b5ea', 1),
(6, 1, '7f1238f9a49fb00530adb1d157ad78d5cf8d54807d18fed6d82bd113c75e7741', 1),
(7, 2, '6c3af288214e2ade20c8a32644831fc212692ac18c93528da6eeb8f8238ec85b', 1),
(8, 1, 'a903de29e3eca5d4272485b8fa236759364a9918924c5563a06164bbcbdfc251', 1),
(9, 3, 'ee13a2a6c10281a734a081e6e98077cc824c911d9394178bb4efc3bc7918dc14', 1),
(10, 1, '8f910d44f6cce53f2afc7c4edc9766dea9bc5de0f120bc3d01054e61233b632b', 1),
(11, 2, 'cb43750921b327077a59b07dc6f6946be20bd05b81011e4f24a1612fd55cf33d', 1),
(12, 4, '9c2492694b84912a1ee23daad344a3da231ef22037d678d2f353b489b0ceb6eb', 1),
(13, 4, '3712a42378f1e74e88b710f64f55012b2afb4ff9599fa0c9013113597d9958a9', 1),
(14, 1, '37a70e3400281d38cf2348254c58f52fee92bb00f6db43bfdbf34036596a660e', 1),
(15, 1, '81eac6c5d625d8292257a08196ca9a51088e5296d6681bfc015ed3a9313eb6c9', 1),
(16, 1, '2f6ef088d6a6f399e4249d9c311beaeb8cc8d9d7aa08d1caf59429255a4de4ec', 1),
(17, 1, 'c9df527ae0ece4e85a6c4b80b1362d7b841bfc6697b40d229202c42a69386613', 1),
(18, 1, '52fc216dcb409a1f971d68828946e4cd8c94807ff2fab77119f148f8248b53cd', 1),
(19, 1, '9cb6d48473cf5415ee07fc16cea6a8d135d2042308eb92281377c549ce86e780', 1),
(20, 1, '3260c9b6c451470da6f9af6a42bef9a8072c58f3651793bc7d4fa0726465a3e4', 1),
(21, 1, '5f66f35586cb3bdd73b2c77fe1ac1128d87833e683c30dc21183742b8f54e176', 1),
(22, 1, '2d615b7a818596053525048a8ae61ba6a9cef3405286f720007d51ebe121035b', 1),
(23, 1, '50cf953ef9a248d8339dae01d428d80ae21d7e81be8811bee532ff04571585d9', 1),
(24, 1, 'bed196f9c11408329f7c10819401e7fa9e3f6f4a5184a3cae228f8230f983ffc', 1),
(25, 2, 'af817734435122556f4405f4dee6f66a3c6383b9e52e0a05bdb49b7162e0630e', 1),
(26, 2, '6884032b21278762f376462c030d688956a0544f13b2ea4aa135be02a44ef683', 1),
(27, 1, 'c419dc823cf698f357ffbf6cb74bd0d947e8d5bed2d8e03bfa781b00847462cb', 1),
(28, 1, 'b9b0e60ddf36e5d0dcdf143b542f8871f801a84e074f7079601cfa58a13fd2c4', 1),
(29, 1, 'b2874193ad17ee39ccb6f845ab1f302680472a943492ff084b9d699588212953', 1),
(30, 1, '38afeecdc7e21af8e4361d939b87dacd252bf221242795396d7eb8b406226cac', 1),
(31, 1, '8416dd32483e89767f169cea1ce9eaad1f3c9d284ecd26d2467b1a8f2da91402', 1),
(32, 1, 'e1be1863c2cc71b12050e86f7cd2b71043696660346b1965896c15f114d7d25c', 1),
(33, 1, 'a168e736763bbce4a694bfe489fc870bf793069c0feb02c374305c44e7193e5c', 1),
(34, 1, '795eb0bd729c97d9dd91b0f56e4a1679ee459488b186f95bd9922d721b1fb30f', 1),
(35, 1, 'db8e8035cc398f62ef21e31eb9d7b20c585603f9efa6466e67dde370af24b8fe', 1),
(36, 1, '6b76820dbe9b6a6ad09f0ee06a7d43e167fe26296648bf4da4c6df9458eedd94', 1),
(37, 1, 'b74284f9a71e24783eb30fdd7526b985f051a761fd6de69a1d4a385b55d9cddf', 1),
(38, 1, 'b4970f2151cc08454938e2c03b6ed2ede90bbf5b429bd7bc0a442689827b2c67', 1),
(39, 1, '96e37155cb5b26968202f287cf7cac8461ccf6ddca820f56f87e89d3fde05e48', 1),
(40, 1, 'dc1da6ff99697b930ffbfaf13de39e1d13c1dd5b84d7a3ac85a027539c49b1bf', 1),
(41, 1, 'd5ef19535a12f3afb755d783be6f83c26210f766cbfb6767c0ee15942642e6bc', 1),
(42, 1, '329e1cdb708dc76bf21b1291b261b5c6ca3cb6793cf1f09716b0576d2f375080', 1),
(43, 1, 'b8a7e65a629fbc70360747effd6a7c7502589a01db643cd202647795dc7daeed', 1),
(44, 1, 'a3e4ee398ffd6471bdfd40cb314765194cd2d40a379dd1d066d0a035f8d5d07c', 1),
(45, 1, '56123fea01756b6d63c62d8187329cdb2fda97a2d5813b86210d02ce890d0b1d', 1),
(46, 1, '971f379ed2592358cfe3b3d404ec698fbc0b3ba5e3993ffd41b6db45e9d5d509', 1),
(47, 2, '5d9d769417a83ad04708ab0088d5fad537038e3f645f902c28cdb07cdc9a5894', 1),
(48, 1, '1bb5f74b258e4b8dfbf06262c21ea80567fbf26b7dd0a4c6e799d826e68a0323', 1),
(49, 2, '088271669683141d15e8ebca2ba2780a96209a19dc17c583c1e935e49d08a837', 1),
(50, 1, '3277ea3146dbe3529e33c3c1f4b10f7a17d5cd917ba86519ed5d490a2909403b', 1),
(51, 1, '23f21e0dabc812c8fe892843fc49a76b0466fee8ee312354d099f5e0279b2c53', 1),
(52, 1, 'd879c8bb6aecd2ef5b97ee80334dd4ec06cb23d8c6ec9874631b9b3c1c9bc5ce', 1),
(53, 1, '582079334f9a5ceae9c7ac3fd645bac74ec933ef3d145f3373bdab8e4295d348', 1),
(54, 1, 'd6d81a7a831530f79ded951b02ebac8038508dfec49becb016e9d73cae7ecaee', 1),
(55, 1, '625524ee49ce4b10e06acca452ed547a8cfba3ba060cf15b63a7d4f3c1905a23', 1),
(56, 1, '8c0fa121525383550fb6874b55660eb2814e62a87fb149e9f2a266b34dd6ceef', 1),
(57, 1, 'aa26db8d58fcd22d2877483fcf4d27a5191ffb17d3b6470ba915c7f2849be9be', 1),
(58, 1, '7822328bfc01b531dc94cea9aeb77685df6405a039b7c2f0b38b87c6207b130d', 1),
(59, 1, '0c91f56e4fc01c15cbff07ad6062c2f4f316e005f1094d9d29bfaac0be461dd1', 1),
(60, 1, 'e6ff98738dd45d29ebbe31b1e46f30f34380d1a0cdff981d6806958b6b2f8c3d', 1),
(61, 1, '24eba33ae19e5044cc7518ad1ee85342695dcdff2d6a6f5545f46615730bc565', 1),
(62, 1, '370124177985e2b9bfb9462ae3ae3c09c8ee921e9f2a49780b569f5c6430fd22', 1),
(63, 1, '30fdbe795de89fd6fed4a2b0ccff4e863024f02ad7193be4b0dd5d947bdb0074', 1),
(64, 2, 'd208fb1f4fdd32aa6b91c22896c1b1d32402720e81bbd4f193cfdff23683d9ac', 1),
(65, 2, 'ba886df02dc44d675a4c0ea225cefeccef375580ff7858d894d652826d5e5463', 1),
(66, 1, '32610e7bf60886a6ada3f1acc6fd9fb92d58552a1779d03694c5cd58e9d57446', 1),
(67, 1, 'd9ad142000088e09dbe4de0ed41527d7099767bbdc902a31134bbc8ea8ff9aa3', 1),
(68, 2, '852933ad8981c5210077d4c5218d17440c8eec3c2f382fbd75c0562393fe6d50', 1),
(69, 1, 'f6a3c1a117811d2d0c298b1686a1bdafa067f155e55895e3486060c11cc2ac74', 1),
(70, 1, '3bdc6729778591ca5b6140fecebbf660eb71cb06c6f62794999caaaecda7e4ce', 1),
(71, 1, '72f682ccfafcd5f95c157d6feca2c120f81b42f635ecfd403e8781037247b191', 1),
(72, 2, '3d2429597094571deb95026ec6e1a877d54a41ca48978dd242c34e564381dc6b', 1),
(73, 1, '81cf9741cb0ed56fc5d2358e3527cbc4ea4d8e17cf1021edabc3f452c525ea46', 1),
(74, 1, '3b89c538f439c2f25afdce6a78294d0018d2f0e7fda3cba7017bcfc7ed7fc76a', 1),
(75, 1, '52e79d98ce477c2d32c89512d4a2951924ad9558cd3acc3e7faa9599d46a5b2f', 1),
(76, 1, '9c0bc77aba9c2a9f30980cc15d6a53c97cf270d61cc1ade7b0ce40b204036af4', 1),
(77, 1, 'b1dac1b21162d23287cc2806c3b93843aca59f4ea44b38f433353e1832e519d8', 1),
(78, 1, '7774be148cbbbf2be4744e11395e3136a43915d36729a4262ce13c225c486449', 1),
(79, 1, '5dcba98bf066febb547cfaaea41af16124ac138de2b201fb278f356d2d4b7289', 1),
(80, 1, '1e3feeeb7a254b5a1d8dad1b19732deeb4c86eb41815d1fa9cc70ee0802411bc', 1),
(81, 1, '2dff0de8625dfdc16dcedaf18e60de295ebaf4778b82f242c48b216111a50d3b', 1),
(82, 1, '71d313fb9fcd3f6aa54a2681e559682b23f2ddc0af8e55bd6d46900f777b09d8', 1),
(83, 1, 'fa2c5a892d458eaa298c0d14192264b91c663deadc5cb90774f4fa174215c04a', 1),
(84, 1, '5740b2d78b614315b50acc25a51a7fcffe147b952d244cf248a693c352e6ecdd', 1),
(85, 2, '34b041d018d02b4b0967bd4ef0dd8761418167121f17f80df56a298fa914ab78', 1),
(86, 1, 'b7db3f3ba0e6a97b98956c7e1b634b36cf78f0024ef97f17b5bb51f773493928', 1),
(87, 1, '174ef43500ac8080338c9fea4c237e6004a837ffdc45652e75c1c1f607c1ea84', 1),
(88, 1, '37a5448707c569bdc576d56751aaef91a1714f76306c952d0d8d145a8d58aca4', 1),
(89, 1, '8468aac1254da1eb8776765abad2e644ab03a87fd67ea340f2ce0f5ed8ee5b9d', 1),
(90, 1, '1c5b6fbf232029a820880608d1b3fbb6a2b38a4954031a53abe1ca5d59b620c8', 1),
(91, 1, 'cdf129f36179c52a99115ebfcd02086d5df255dafe2182e175a0c5a8324f50c5', 1),
(92, 1, 'f48c9e6dbc4f0fb7a391ed82b4e84c319674bd424d032d4e85372150d5a367b4', 1),
(93, 1, 'ce6509b235dd00e383aff4e78c2d483845fb67b09ae302f0174235022d020051', 1),
(94, 1, '18e7b23e1f84ffb1c7cfb74bcdd6798ca7ca2525048d75989d8a9968a29d2f8c', 1),
(95, 2, '8d7bd593a8b3d596df078eadad182ea44618fdce18ccbba9029c9c247ed3c907', 1),
(96, 1, '8fd61b1abf0019a26cc506014de4cb020154a2b7f5d1d173198ec08f02b5bc3f', 1),
(97, 1, 'd0be35b336b1834f7142b52767fdde220b09f1bf7b4c914a47d7395b199f9903', 1),
(98, 1, '09db34f769a754a865555c89ec2a601d98851740d889529adf2db9525696b794', 1),
(99, 2, '22363b4eb1c8d6ab8237e212dd6507134a51f67639fd2f5dfbf9736730dd66d8', 1),
(100, 2, '9ea4a5b71eca48fcda16fe0a9147eeee616d309d10a5f9ab578d230f9014f60c', 1),
(101, 2, '15a3bf888e862bc90dae3b7ca769a5907d11a904ef3c19a248d178bec89c7659', 1),
(102, 1, 'ce0ec85b44d7feb8222ece16cd38baad37bc3372ca680b125f33240f31141c60', 1),
(103, 1, '3b5a5fe37ad37dc525f42acaf85fc93d05a35efc25bd561a3a97358ededde0a4', 1),
(104, 2, '4c350e3f1fb0c3e5946e4b2ce92d5ce995a7a0c45309ae259df419184cccfbe9', 1),
(105, 2, '79a8675457b580e03ed34f997a7fa6b50ac9ab4c42f7dd63576c65739de7ae0a', 0),
(106, 1, 'ce4ec1671e714a05cce8e681dadf2da3b9618928ed08ebe773d23ac158ed4f69', 0);

-- --------------------------------------------------------

--
-- Table structure for table `storages`
--

CREATE TABLE IF NOT EXISTS `storages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transact_id` int(11) NOT NULL,
  `acquire_date` date DEFAULT NULL,
  `pickup_date` date DEFAULT NULL,
  `weight` enum('light','medium','heavy') DEFAULT NULL,
  `volume` enum('small','medium','large') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_storages_transact_idx` (`transact_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `storages`
--

INSERT INTO `storages` (`id`, `transact_id`, `acquire_date`, `pickup_date`, `weight`, `volume`) VALUES
(1, 3, '2012-11-23', NULL, 'medium', 'medium'),
(3, 11, NULL, NULL, NULL, NULL);

--
-- Triggers `storages`
--
DROP TRIGGER IF EXISTS `after_storages_update`;
DELIMITER //
CREATE TRIGGER `after_storages_update` AFTER UPDATE ON `storages`
 FOR EACH ROW BEGIN
  IF (NEW.pickup_date IS NOT NULL) THEN
    INSERT INTO notify_pickup(storage_id) VALUES (NEW.id);
  ELSEIF (NEW.acquire_date IS NOT NULL) THEN
	INSERT INTO notify_receive(storage_id) VALUES (NEW.id);
    INSERT INTO notify_acquire(storage_id) VALUES (NEW.id);
  END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `top_level_domains`
--

CREATE TABLE IF NOT EXISTS `top_level_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `top_level_domains`
--

INSERT INTO `top_level_domains` (`id`, `name`) VALUES
(1, 'com');

-- --------------------------------------------------------

--
-- Table structure for table `transacts`
--

CREATE TABLE IF NOT EXISTS `transacts` (
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
  KEY `fk_transacts_bids_idx` (`bid_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `transacts`
--

INSERT INTO `transacts` (`id`, `offer_id`, `buyer_id`, `seller_id`, `transact_date`, `bid_id`) VALUES
(3, 12, 1, 1, '2012-11-19', 1),
(11, 33, 1, 2, '2012-11-29', 8);

-- --------------------------------------------------------

--
-- Table structure for table `types`
--

CREATE TABLE IF NOT EXISTS `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `types`
--

INSERT INTO `types` (`id`, `name`) VALUES
(1, 'Service'),
(2, 'Good');

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_emails`
--
CREATE TABLE IF NOT EXISTS `view_emails` (
`member_id` int(11)
,`email` text
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `view_hot_offers`
--
CREATE TABLE IF NOT EXISTS `view_hot_offers` (
`id` int(11)
,`title` varchar(255)
,`description` text
,`price` float(12,2)
,`category_id` int(11)
,`image_url` varchar(255)
,`expire` int(1)
);
-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

CREATE TABLE IF NOT EXISTS `visitors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL DEFAULT '',
  `last_name` varchar(255) NOT NULL DEFAULT '',
  `phone_number` varchar(255) NOT NULL DEFAULT '',
  `join_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `visitors_id_UNIQUE` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `visitors`
--

INSERT INTO `visitors` (`id`, `first_name`, `last_name`, `phone_number`, `join_date`) VALUES
(1, 'Charles', 'Yang', '5148826452', '2012-11-17'),
(2, 'Charles', 'Yang', '5148826454', '2012-11-18'),
(3, 'mike', 'pham', '5142911195', '2012-11-19'),
(4, 'Real', 'Lipoor', '51412345678', '2012-11-19');

-- --------------------------------------------------------

--
-- Structure for view `garages`
--
DROP TABLE IF EXISTS `garages`;

CREATE ALGORITHM=UNDEFINED DEFINER=`snwfog`@`132.205.%.%` SQL SECURITY DEFINER VIEW `garages` AS select `storages`.`id` AS `id`,`storages`.`transact_id` AS `transact_id`,`storages`.`acquire_date` AS `acquire_date`,`storages`.`pickup_date` AS `pickup_date`,`storages`.`weight` AS `weight` from `storages` where ((`storages`.`acquire_date` is not null) and ((cast(curdate() as date) - cast(`storages`.`acquire_date` as date)) > 14));

-- --------------------------------------------------------

--
-- Structure for view `view_emails`
--
DROP TABLE IF EXISTS `view_emails`;

CREATE ALGORITHM=UNDEFINED DEFINER=`snwfog`@`132.205.%.%` SQL SECURITY DEFINER VIEW `view_emails` AS select `members`.`id` AS `member_id`,concat(`emails`.`name`,'@',`domains`.`name`,'.',`top_level_domains`.`name`) AS `email` from (`emails` join ((`domains` join `top_level_domains`) join `members`) on(((`domains`.`id` = `emails`.`domain_id`) and (`top_level_domains`.`id` = `emails`.`top_level_domain_id`) and (`members`.`email_id` = `emails`.`id`))));

-- --------------------------------------------------------

--
-- Structure for view `view_hot_offers`
--
DROP TABLE IF EXISTS `view_hot_offers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`snwfog`@`132.205.%.%` SQL SECURITY DEFINER VIEW `view_hot_offers` AS select `offers`.`id` AS `id`,`offers`.`title` AS `title`,`offers`.`description` AS `description`,`offers`.`price` AS `price`,`offers`.`category_id` AS `category_id`,`offers`.`image_url` AS `image_url`,`offers`.`expire` AS `expire` from `offers` where ((`offers`.`price` < 7.99) and (`offers`.`expire` <> 1) and (not(exists(select 1 from `giveaways` where (`giveaways`.`offer_id` = `offers`.`id`)))));

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `fk_admin_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `bids`
--
ALTER TABLE `bids`
  ADD CONSTRAINT `fk_bids_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `fk_bids_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_bids_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_categories_types` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`);

--
-- Constraints for table `credit_cards`
--
ALTER TABLE `credit_cards`
  ADD CONSTRAINT `fk_credit_cards_credit_card_types` FOREIGN KEY (`credit_card_type_id`) REFERENCES `credit_card_types` (`id`),
  ADD CONSTRAINT `fk_credit_cards_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `credit_card_transactions`
--
ALTER TABLE `credit_card_transactions`
  ADD CONSTRAINT `fk_credit_card_transactions_credit_cards` FOREIGN KEY (`credit_card_id`) REFERENCES `credit_cards` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_credit_card_transactions_offer` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `emails`
--
ALTER TABLE `emails`
  ADD CONSTRAINT `fk_emails_domains` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`),
  ADD CONSTRAINT `fk_emails_top_level_domains` FOREIGN KEY (`top_level_domain_id`) REFERENCES `top_level_domains` (`id`);

--
-- Constraints for table `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD CONSTRAINT `fk_feedbacks_members_ratees` FOREIGN KEY (`ratee_id`) REFERENCES `members` (`id`),
  ADD CONSTRAINT `fk_feedbacks_members_raters` FOREIGN KEY (`rater_id`) REFERENCES `members` (`id`);

--
-- Constraints for table `giveaways`
--
ALTER TABLE `giveaways`
  ADD CONSTRAINT `fk_giveaways_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`);

--
-- Constraints for table `members`
--
ALTER TABLE `members`
  ADD CONSTRAINT `fk_members_addresses` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`),
  ADD CONSTRAINT `fk_members_emails` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`),
  ADD CONSTRAINT `fk_members_visitors` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `notify_acquire`
--
ALTER TABLE `notify_acquire`
  ADD CONSTRAINT `fk_notify_acquire_storages` FOREIGN KEY (`storage_id`) REFERENCES `storages` (`id`);

--
-- Constraints for table `notify_modify`
--
ALTER TABLE `notify_modify`
  ADD CONSTRAINT `fk_notify_modify_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`),
  ADD CONSTRAINT `fk_notify_modify_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`);

--
-- Constraints for table `notify_pickup`
--
ALTER TABLE `notify_pickup`
  ADD CONSTRAINT `fk_notify_pickup_storages` FOREIGN KEY (`storage_id`) REFERENCES `storages` (`id`);

--
-- Constraints for table `notify_queue`
--
ALTER TABLE `notify_queue`
  ADD CONSTRAINT `fk_notify_queue_bids` FOREIGN KEY (`bid_id`) REFERENCES `bids` (`id`);

--
-- Constraints for table `notify_receive`
--
ALTER TABLE `notify_receive`
  ADD CONSTRAINT `fk_notify_receive_storages` FOREIGN KEY (`storage_id`) REFERENCES `storages` (`id`);

--
-- Constraints for table `offers`
--
ALTER TABLE `offers`
  ADD CONSTRAINT `fk_offers_categories` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `fk_posts_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_posts_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `reserves`
--
ALTER TABLE `reserves`
  ADD CONSTRAINT `fk_reserves_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`),
  ADD CONSTRAINT `fk_reserves_visitors` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`);

--
-- Constraints for table `storages`
--
ALTER TABLE `storages`
  ADD CONSTRAINT `fk_storages_transact` FOREIGN KEY (`transact_id`) REFERENCES `transacts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `transacts`
--
ALTER TABLE `transacts`
  ADD CONSTRAINT `fk_transactions_members` FOREIGN KEY (`buyer_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_transactions_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_transacts_bids` FOREIGN KEY (`bid_id`) REFERENCES `bids` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
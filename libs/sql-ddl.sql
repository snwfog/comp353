-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 19, 2012 at 06:50 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='http://stackoverflow.com/questions/217945/can-i-have-multipl' AUTO_INCREMENT=3 ;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `address`, `city`, `province`, `country`, `postal_code`) VALUES
(1, '123 Fake Street', 'Montreal', 'Quebec', 'Canada', 'H3H1P1'),
(2, '123 Real Street', 'Toronto', 'Ontario', 'Canada', '8898934');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `bids`
--

INSERT INTO `bids` (`id`, `member_id`, `offer_id`, `category_id`, `price`, `description`, `expire`) VALUES
(1, 1, 12, 32, 234, 'Ill trade it with my beauty make up', 0),
(2, 1, 12, 35, 34, 'Ill give u my monthly cycle for it', 0),
(3, 1, 12, 13, 48, 'Ill trade with you for my pair of old ski still in good condition', 0),
(4, 1, 12, 24, 99090909, 'my starwars posters from college', 0),
(5, 1, 12, 33, 0, 'Gonna repair your computer for free lolz', 0);

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
  PRIMARY KEY (`id`),
  UNIQUE KEY `number_UNIQUE` (`number`),
  UNIQUE KEY `member_id_UNIQUE` (`member_id`),
  KEY `id_idx` (`member_id`),
  KEY `fk_credit_cards_credit_card_types` (`credit_card_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `credit_card_types`
--

CREATE TABLE IF NOT EXISTS `credit_card_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `domains`
--

CREATE TABLE IF NOT EXISTS `domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `domains`
--

INSERT INTO `domains` (`id`, `name`) VALUES
(1, 'gmail');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `emails`
--

INSERT INTO `emails` (`id`, `name`, `domain_id`, `top_level_domain_id`) VALUES
(1, 'donchoa', 1, 1),
(2, 'donchoa11', 1, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `feedbacks`
--

INSERT INTO `feedbacks` (`id`, `rater_id`, `ratee_id`, `rating`, `comment`) VALUES
(1, 2, 1, 1, 'asdfkasjdfklasjdlf\r\n'),
(2, 2, 1, 3, 'aasdfasdflakjsdlfjasldkf\r\naksdjflaksdjf'),
(3, 2, 1, 9, 'asdlfkjasdklfjaskldfj\r\nasdkfjasldkjf\r\nalskdjflkasdjf'),
(4, 2, 1, 4, 'alksdjflkasdf;lkajsdf\r\nasdlfkjaslkdfja\r\nlkasdjfklasjdklf'),
(5, 2, 1, 6, 'lkasdjfklasjdlfkjaskdlf\r\naskldfjaklsdjfkl;a\r\n;lasdjflkajsdklf\r\nkasdjfklasjdklfasdf'),
(6, 1, 2, 1, 'asdfasdfasdf');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `username`, `password`, `email_id`, `address_id`, `visitor_id`, `avatar_url`) VALUES
(1, 'snw', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 1, 1, 1, NULL),
(2, 'fog', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 2, 2, 2, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member_reserves`
--

CREATE TABLE IF NOT EXISTS `member_reserves` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `reserve_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_member_reserves_members_idx` (`member_id`),
  KEY `fk_member_reserves_offers_idx` (`offer_id`),
  KEY `fk_member_reserves_members_idx1` (`member_id`),
  KEY `fk_member_reserves_offers_idx1` (`offer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `offers`
--

INSERT INTO `offers` (`id`, `title`, `description`, `price`, `category_id`, `image_url`, `expire`) VALUES
(2, 'asdlfkjaskdlfj', 'kljaskldjfklasjdklf', 0.00, 41, 'NULL', 0),
(3, 'alksdflkasdjfklj', 'lkjflaksdjfklajskdlfjaklsdfklajsdklf', 0.00, 41, 'NULL', 0),
(4, 'asdkfjaslkdfj', 'jlkajskldfjaklsdjflkajskldf\r\n', 0.00, 12, 'NULL', 0),
(5, 'asdjfaskjdfhjk', 'jklasdjfklajsdklfjaskdlfj\r\n', 0.00, 41, 'NULL', 0),
(6, 'asldkfjaklsdfj', 'jlkjaskdlfj', 0.00, 41, 'NULL', 0),
(7, 'alsdjfklasdjfkl', 'lkajsdklfjaklsdjflkajsdklfjasdf', 0.00, 12, 'NULL', 0),
(8, 'Eye lash', 'Integer at massa diam. Etiam euismod lectus in metus suscipit eget mattis dolor pharetra. Nulla ultrices vestibulum arcu, ac ornare risus posuere vel. Fusce gravida sagittis justo, nec vestibulum sapien tincidunt sit amet. Nullam tempor ante et purus luctus pretium quis in erat. Morbi hendrerit hendrerit metus, nec vehicula magna lacinia sed. Vivamus ac mi odio. Nam viverra erat nec metus scelerisque tempus. Donec eleifend feugiat nunc, eget scelerisque neque varius vitae. Vivamus facilisis, risus sed varius rutrum, leo ipsum sodales lectus, vitae adipiscing sapien tellus non lorem. Maecenas felis odio, auctor sit amet condimentum at, condimentum non ligula. Mauris non arcu odio, sed tristique nibh. Morbi eu felis a nisi sodales laoreet at eu odio. Suspendisse aliquam bibendum orci ut lacinia. Praesent sem erat, gravida a accumsan quis, tempus ut tortor.\r\n\r\nSed massa nulla, facilisis tristique faucibus vel, euismod eu arcu. Pellentesque ultrices gravida justo, sit amet interdum ligula eleifend quis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus consectetur lobortis elit, quis euismod enim mattis sit amet. Cras viverra nibh erat. Fusce tincidunt venenatis est, et scelerisque tortor scelerisque nec. Mauris porttitor, augue at aliquet accumsan, metus elit scelerisque ipsum, id auctor diam ante vel ', 12323.00, 32, 'NULL', 0),
(9, 'Sup sup sup', '<p>\r\nPraesent rhoncus, sapien eu luctus faucibus, dolor purus semper metus, vitae ultrices velit neque eleifend odio. Sed laoreet eros scelerisque libero rhoncus a faucibus ligula sollicitudin. In diam justo, elementum ac venenatis id, laoreet a turpis. Nunc elit dolor, aliquam vel tempor id, interdum ullamcorper tortor. Donec ultrices tincidunt ligula, et pharetra felis ultricies quis. Aenean faucibus nibh non nunc interdum quis facilisis justo pharetra. Aenean aliquam fermentum orci, sed cursus nisl accumsan at. Aliquam lacus neque, auctor a accumsan sit amet, tempus et lacus. Sed vitae nibh eget enim lobortis lobortis. Sed lacinia ipsum eget mauris placerat laoreet. Suspendisse laoreet quam et diam consectetur molestie. Cras ultricies sagittis congue. Aliquam neque elit, tempus nec feugiat id, condimentum a mauris.\r\n</p>\r\n<p>\r\nQuisque tempus adipiscing enim, nec rutrum elit dignissim fringilla. Praesent vitae mauris eget velit condimentum euismod sit amet eu arcu. Quisque volutpat lobortis dui, vel tristique ante ullamcorper non. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti. Aenean nec neque ac dolor dignissim fringilla. Aenean condimentum, risus eu malesuada mollis, mi leo auctor risus, vitae gravida purus mauris non sem. Sed et nisi quis eros pharetra rhoncus eu vitae massa. Vestibulum luctus metus in massa lobortis volutpat. Suspendisse semper odio ullamcorper dui porttitor consequat. Suspendisse porttitor, orci eget suscipit blandit, turpis magna tincidunt tortor, vel egestas nisi purus et nibh. Cras in lobortis dolor. Integer ut lectus massa, a vestibulum mauris.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse suscipit tristique consequat. Suspendisse nibh nisi, tempor sit amet congue a, sollicitudin eu orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus eget dapibus tortor. Phasellus quis porttitor sapien. Nulla neque nisl, tempor pulvinar auctor eu, viverra at tellus. Nam non turpis vitae magna porttitor pretium et quis eros. Donec facilisis egestas lacinia. Curabitur tortor velit, bibendum sit amet dapibus id, adipiscing volutpat arcu. Donec et nunc quis justo suscipit fringilla vel vel nisl. Duis sit amet urna urna.\r\n</p>', 23942394.00, 3, 'NULL', 0),
(10, 'Sup sup sup', '<p>\r\nPraesent rhoncus, sapien eu luctus faucibus, dolor purus semper metus, vitae ultrices velit neque eleifend odio. Sed laoreet eros scelerisque libero rhoncus a faucibus ligula sollicitudin. In diam justo, elementum ac venenatis id, laoreet a turpis. Nunc elit dolor, aliquam vel tempor id, interdum ullamcorper tortor. Donec ultrices tincidunt ligula, et pharetra felis ultricies quis. Aenean faucibus nibh non nunc interdum quis facilisis justo pharetra. Aenean aliquam fermentum orci, sed cursus nisl accumsan at. Aliquam lacus neque, auctor a accumsan sit amet, tempus et lacus. Sed vitae nibh eget enim lobortis lobortis. Sed lacinia ipsum eget mauris placerat laoreet. Suspendisse laoreet quam et diam consectetur molestie. Cras ultricies sagittis congue. Aliquam neque elit, tempus nec feugiat id, condimentum a mauris.\r\n</p>\r\n<p>\r\nQuisque tempus adipiscing enim, nec rutrum elit dignissim fringilla. Praesent vitae mauris eget velit condimentum euismod sit amet eu arcu. Quisque volutpat lobortis dui, vel tristique ante ullamcorper non. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti. Aenean nec neque ac dolor dignissim fringilla. Aenean condimentum, risus eu malesuada mollis, mi leo auctor risus, vitae gravida purus mauris non sem. Sed et nisi quis eros pharetra rhoncus eu vitae massa. Vestibulum luctus metus in massa lobortis volutpat. Suspendisse semper odio ullamcorper dui porttitor consequat. Suspendisse porttitor, orci eget suscipit blandit, turpis magna tincidunt tortor, vel egestas nisi purus et nibh. Cras in lobortis dolor. Integer ut lectus massa, a vestibulum mauris.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse suscipit tristique consequat. Suspendisse nibh nisi, tempor sit amet congue a, sollicitudin eu orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus eget dapibus tortor. Phasellus quis porttitor sapien. Nulla neque nisl, tempor pulvinar auctor eu, viverra at tellus. Nam non turpis vitae magna porttitor pretium et quis eros. Donec facilisis egestas lacinia. Curabitur tortor velit, bibendum sit amet dapibus id, adipiscing volutpat arcu. Donec et nunc quis justo suscipit fringilla vel vel nisl. Duis sit amet urna urna.\r\n</p>', 23942394.00, 3, 'NULL', 0),
(11, 'Hello Kitty Tooth brush', '<p>\r\nPraesent rhoncus, sapien eu luctus faucibus, dolor purus semper metus, vitae ultrices velit neque eleifend odio. Sed laoreet eros scelerisque libero rhoncus a faucibus ligula sollicitudin. In diam justo, elementum ac venenatis id, laoreet a turpis. Nunc elit dolor, aliquam vel tempor id, interdum ullamcorper tortor. Donec ultrices tincidunt ligula, et pharetra felis ultricies quis. Aenean faucibus nibh non nunc interdum quis facilisis justo pharetra. Aenean aliquam fermentum orci, sed cursus nisl accumsan at. Aliquam lacus neque, auctor a accumsan sit amet, tempus et lacus. Sed vitae nibh eget enim lobortis lobortis. Sed lacinia ipsum eget mauris placerat laoreet. Suspendisse laoreet quam et diam consectetur molestie. Cras ultricies sagittis congue. Aliquam neque elit, tempus nec feugiat id, condimentum a mauris.\r\n</p>\r\n<p>\r\nQuisque tempus adipiscing enim, nec rutrum elit dignissim fringilla. Praesent vitae mauris eget velit condimentum euismod sit amet eu arcu. Quisque volutpat lobortis dui, vel tristique ante ullamcorper non. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti. Aenean nec neque ac dolor dignissim fringilla. Aenean condimentum, risus eu malesuada mollis, mi leo auctor risus, vitae gravida purus mauris non sem. Sed et nisi quis eros pharetra rhoncus eu vitae massa. Vestibulum luctus metus in massa lobortis volutpat. Suspendisse semper odio ullamcorper dui porttitor consequat. Suspendisse porttitor, orci eget suscipit blandit, turpis magna tincidunt tortor, vel egestas nisi purus et nibh. Cras in lobortis dolor. Integer ut lectus massa, a vestibulum mauris.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse suscipit tristique consequat. Suspendisse nibh nisi, tempor sit amet congue a, sollicitudin eu orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus eget dapibus tortor. Phasellus quis porttitor sapien. Nulla neque nisl, tempor pulvinar auctor eu, viverra at tellus. Nam non turpis vitae magna porttitor pretium et quis eros. Donec facilisis egestas lacinia. Curabitur tortor velit, bibendum sit amet dapibus id, adipiscing volutpat arcu. Donec et nunc quis justo suscipit fringilla vel vel nisl. Duis sit amet urna urna.\r\n</p>', 23.00, 32, 'NULL', 0),
(12, 'Mega Man Atari Game', '<p>\r\nPraesent rhoncus, sapien eu luctus faucibus, dolor purus semper metus, vitae ultrices velit neque eleifend odio. Sed laoreet eros scelerisque libero rhoncus a faucibus ligula sollicitudin. In diam justo, elementum ac venenatis id, laoreet a turpis. Nunc elit dolor, aliquam vel tempor id, interdum ullamcorper tortor. Donec ultrices tincidunt ligula, et pharetra felis ultricies quis. Aenean faucibus nibh non nunc interdum quis facilisis justo pharetra. Aenean aliquam fermentum orci, sed cursus nisl accumsan at. Aliquam lacus neque, auctor a accumsan sit amet, tempus et lacus. Sed vitae nibh eget enim lobortis lobortis. Sed lacinia ipsum eget mauris placerat laoreet. Suspendisse laoreet quam et diam consectetur molestie. Cras ultricies sagittis congue. Aliquam neque elit, tempus nec feugiat id, condimentum a mauris.\r\n</p>\r\n<p>\r\nQuisque tempus adipiscing enim, nec rutrum elit dignissim fringilla. Praesent vitae mauris eget velit condimentum euismod sit amet eu arcu. Quisque volutpat lobortis dui, vel tristique ante ullamcorper non. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse potenti. Aenean nec neque ac dolor dignissim fringilla. Aenean condimentum, risus eu malesuada mollis, mi leo auctor risus, vitae gravida purus mauris non sem. Sed et nisi quis eros pharetra rhoncus eu vitae massa. Vestibulum luctus metus in massa lobortis volutpat. Suspendisse semper odio ullamcorper dui porttitor consequat. Suspendisse porttitor, orci eget suscipit blandit, turpis magna tincidunt tortor, vel egestas nisi purus et nibh. Cras in lobortis dolor. Integer ut lectus massa, a vestibulum mauris.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse suscipit tristique consequat. Suspendisse nibh nisi, tempor sit amet congue a, sollicitudin eu orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Phasellus eget dapibus tortor. Phasellus quis porttitor sapien. Nulla neque nisl, tempor pulvinar auctor eu, viverra at tellus. Nam non turpis vitae magna porttitor pretium et quis eros. Donec facilisis egestas lacinia. Curabitur tortor velit, bibendum sit amet dapibus id, adipiscing volutpat arcu. Donec et nunc quis justo suscipit fringilla vel vel nisl. Duis sit amet urna urna.\r\n</p>', 2.00, 31, 'NULL', 1),
(13, 'Apple iPad Mini Black', 'Brand new Apple iPad mini in black. Asking for 400. Cash only. SErious offer contact.', 400.00, 23, 'NULL', 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`member_id`, `offer_id`, `id`) VALUES
(1, 8, 1),
(1, 10, 2),
(1, 11, 3),
(1, 12, 4),
(1, 13, 5);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `member_id`, `session`, `expire`) VALUES
(1, 1, '28b49417d514d5a281f99d7bffdeb2ac880d30b1f3030b506cbce8a0546ab2d5', 1),
(2, 1, '1361753fad134688e205c2544a18331aa05a460aaabe0b6acda44542f6de4b20', 1),
(3, 1, '507504e8c0f58d329eabe5556acc76167c93f7e93004214ea511e0ec02cb7ae4', 1),
(4, 1, '8acecc82af19d4825e506d75017dae9d685def9bd1b6bd27f66abe3512c264f7', 1),
(5, 2, 'fa9faa030bcaebe090e8ec7d3063f7d6b7c54f24b0baf424503d9e2c3ef3b5ea', 1),
(6, 1, '7f1238f9a49fb00530adb1d157ad78d5cf8d54807d18fed6d82bd113c75e7741', 0),
(7, 2, '6c3af288214e2ade20c8a32644831fc212692ac18c93528da6eeb8f8238ec85b', 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `transacts`
--

INSERT INTO `transacts` (`id`, `offer_id`, `buyer_id`, `seller_id`, `transact_date`, `bid_id`) VALUES
(3, 12, 1, 1, '2012-11-19', 1);

-- --------------------------------------------------------

--
-- Table structure for table `types`
--

CREATE TABLE IF NOT EXISTS `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `types`
--

INSERT INTO `types` (`id`, `name`) VALUES
(1, 'Service'),
(2, 'Good');

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `visitors`
--

INSERT INTO `visitors` (`id`, `first_name`, `last_name`, `phone_number`, `join_date`) VALUES
(1, 'Charles', 'Yang', '5148826452', '2012-11-17'),
(2, 'Charles', 'Yang', '5148826454', '2012-11-18');

-- --------------------------------------------------------

--
-- Table structure for table `visitor_reserves`
--

CREATE TABLE IF NOT EXISTS `visitor_reserves` (
  `visitor_id` int(11) NOT NULL,
  `offer_id` int(11) NOT NULL,
  `reserve_time` datetime NOT NULL,
  KEY `fk_visitor_reserves_visitors_idx` (`visitor_id`),
  KEY `fk_visitor_reserves_offers` (`offer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
-- Constraints for table `members`
--
ALTER TABLE `members`
  ADD CONSTRAINT `fk_members_emails` FOREIGN KEY (`email_id`) REFERENCES `emails` (`id`),
  ADD CONSTRAINT `fk_members_addresses` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`),
  ADD CONSTRAINT `fk_members_visitors` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `member_reserves`
--
ALTER TABLE `member_reserves`
  ADD CONSTRAINT `fk_member_reserves_members` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_member_reserves_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
-- Constraints for table `transacts`
--
ALTER TABLE `transacts`
  ADD CONSTRAINT `fk_transacts_bids` FOREIGN KEY (`bid_id`) REFERENCES `bids` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_transactions_members` FOREIGN KEY (`buyer_id`) REFERENCES `members` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_transactions_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `visitor_reserves`
--
ALTER TABLE `visitor_reserves`
  ADD CONSTRAINT `fk_visitor_reserves_offers` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_visitor_reserves_visitors` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

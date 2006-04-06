-- phpMyAdmin SQL Dump
-- version 2.8.0.2
-- http://www.phpmyadmin.net
-- 
-- Host: db.berlios.de
-- Generation Time: Apr 06, 2006 at 12:22 AM
-- Server version: 3.23.37
-- PHP Version: 4.3.4
-- 
-- Database: `paperprogs`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `phpnub`
-- 

CREATE TABLE IF NOT EXISTS `phpnub` (
  `id` int(11) NOT NULL auto_increment,
  `command` varchar(80) NOT NULL default '',
  `url` text,
  `exec` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `command` (`command`)
) TYPE=MyISAM AUTO_INCREMENT=29 ;

-- 
-- Dumping data for table `phpnub`
-- 

INSERT INTO `phpnub` (`id`, `command`, `url`, `exec`) VALUES (27, 'add', 'http://paperprogs.berlios.de/nub/add.php', 0),
(28, 'digg', 'http://digg.com', 0),
(24, 'google', 'http://www.google.com/search?q=REPLACE', 0);

CREATE TABLE IF NOT EXISTS `phpnub_users` (
  `id` int(11) NOT NULL auto_increment,
  `user` varchar(30) default NULL,
  `passhash` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user` (`user`)
) TYPE=MyISAM AUTO_INCREMENT=3 ;

-- 
-- Dumping data for table `phpnub_users`
-- 

INSERT INTO `phpnub_users` (`id`, `user`, `passhash`) VALUES (1, 'admin', '$adminp')



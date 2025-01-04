-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 27, 2024 at 07:44 AM
-- Server version: 8.2.0
-- PHP Version: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `conference_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

DROP TABLE IF EXISTS `attendance`;
CREATE TABLE IF NOT EXISTS `attendance` (
  `attendance_id` int NOT NULL AUTO_INCREMENT,
  `participant_id` int NOT NULL,
  `session_id` int NOT NULL,
  `check_in_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`attendance_id`),
  KEY `participant_id` (`participant_id`),
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `participants`
--

DROP TABLE IF EXISTS `participants`;
CREATE TABLE IF NOT EXISTS `participants` (
  `Log_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`Log_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `participants`
--

INSERT INTO `participants` (`Log_id`, `name`, `email`, `password`) VALUES
(1, 'puwan', 'spidytomzen@gmail.com', '$2y$10$SevAjJFBefLHLrqXiHTMauDl/M3QPI5Hnt74IOvgQ4dCRtaK98.pC'),
(2, 'Thujee', 'pavithranpuwan@gmail.com', '$2y$10$mUzV.HUEPOiRxnp4niytY.5c4kEA/OBMqcf4lBCToIMYib9YlsfrK'),
(3, 'pavithran', '123@gmail.com', 'abcdefg'),
(4, 'Danusanka', 'qwerty@gmail.com', 'qwerty'),
(5, 'Danusanka puwan', 'ytrewq@gmail.com', 'ytrewq'),
(6, 'Danusanka', 'qwerty123@gmail.com', 'qwertyuiop'),
(8, 'Danusanka puwan', 'qwerty1234@gmail.com', 'qwertyuiop'),
(9, 'pavithran puwan', 'asdfghjkl@gmail.com', 'lkjhgfdsa'),
(11, 'puwan', 'spidy@gmail.com', 'tomholland+zendaya'),
(12, 'manju', 'manju@gmail.com', 'rajapalani'),
(13, 'pethum', 'pavithran@gmail.com', 'bgyhfld'),
(14, 'Praveen', 'praveen@gmail.com', 'asdfghjkepo;vjhwvw');

-- --------------------------------------------------------

--
-- Table structure for table `registration`
--

DROP TABLE IF EXISTS `registration`;
CREATE TABLE IF NOT EXISTS `registration` (
  `session_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `institution` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `session_name` varchar(255) NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `fk_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `registration`
--

INSERT INTO `registration` (`session_id`, `name`, `email`, `institution`, `session_name`) VALUES
(1, 'Danusanka', 'qwerty@gmail.com', 'ITUM', ''),
(3, 'puwan', 'spidy@gmail.com', 'ITUM', ''),
(4, 'manju', 'manju@gmail.com', NULL, 'Effective Time Management Techniques'),
(5, 'pavithran', '123@gmail.com', 'ITUM', 'Building a Personal Brand Online'),
(6, 'pavithran', '123@gmail.com', 'ITUM', 'Building a Personal Brand Online'),
(7, 'pavithranPuwan', '123@gmail.com', 'ITUM', 'Building a Personal Brand Online'),
(8, 'pavithran', '123@gmail.com', 'ITUM', 'Introduction to Web Development'),
(9, 'pavithran', '123@gmail.com', 'ITUM', 'Introduction to Web Development'),
(10, 'pavithranPuwan', '123@gmail.com', 'ITUM', 'Introduction to Web Development'),
(11, 'praveen', 'praveen@gmail.com', 'ITUM', 'Effective Time Management Techniques'),
(12, 'praveen', 'praveen@gmail.com', 'ITUM', 'Effective Time Management Techniques'),
(13, 'puwan', 'praveen@gmail.com', 'ITUM', 'Effective Time Management Techniques'),
(14, 'puwan', 'praveen@gmail.com', 'ITUM', 'Effective Time Management Techniques');

-- --------------------------------------------------------

--
-- Table structure for table `tracks`
--

DROP TABLE IF EXISTS `tracks`;
CREATE TABLE IF NOT EXISTS `tracks` (
  `track_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `description` text,
  PRIMARY KEY (`track_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`participant_id`) REFERENCES `participants` (`Log_id`),
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`session_id`) REFERENCES `registration` (`session_id`);

--
-- Constraints for table `registration`
--
ALTER TABLE `registration`
  ADD CONSTRAINT `fk_email` FOREIGN KEY (`email`) REFERENCES `participants` (`email`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

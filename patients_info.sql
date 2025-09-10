-- --------------------------------------------------------
-- 主機:                           127.0.0.1
-- 伺服器版本:                        5.5.13 - MySQL Community Server (GPL)
-- 伺服器操作系統:                      Win32
-- HeidiSQL 版本:                  10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 傾印 segmentation 的資料庫結構
CREATE DATABASE IF NOT EXISTS `segmentation` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `segmentation`;

-- 傾印  表格 segmentation.hc_people 結構
CREATE TABLE IF NOT EXISTS `hc_people` (
  `HC_ID` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 正在傾印表格  segmentation.hc_people 的資料：1 rows
/*!40000 ALTER TABLE `hc_people` DISABLE KEYS */;
INSERT INTO `hc_people` (`HC_ID`, `password`) VALUES
	('lee', 'aaa');
/*!40000 ALTER TABLE `hc_people` ENABLE KEYS */;

-- 傾印  表格 segmentation.patients 結構
CREATE TABLE IF NOT EXISTS `patients` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `age` int(3) unsigned DEFAULT NULL,
  `gender` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood_pressure` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `blood_sugar` int(3) unsigned DEFAULT NULL,
  `heart_rate` int(3) unsigned DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 正在傾印表格  segmentation.patients 的資料：10 rows
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` (`id`, `name`, `age`, `gender`, `blood_pressure`, `blood_sugar`, `heart_rate`) VALUES
	('P001', 'Alice Johnson', 32, 'Female', '110/70', 88, 85),
	('P002', 'Michael Lee', 58, 'Male', '130/85', 102, 98),
	('P003', 'Sarah Brown', 27, 'Female', '115/75', 90, 70),
	('P004', 'David Kim', 63, 'Male', '140/90', 110, 105),
	('P005', 'Emily Chen', 39, 'Female', '125/80', 95, 78),
	('P006', 'James Wilson', 51, 'Male', '135/85', 100, 92),
	('P007', 'Linda Davis', 44, 'Female', '120/78', 92, 74),
	('P008', 'Robert Taylor', 36, 'Male', '118/76', 89, 80),
	('P009', 'Nancy White', 29, 'Female', '112/72', 87, 68),
	('P010', 'Thomas Green', 47, 'Male', '145/95', 108, 110);
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;

-- 傾印  表格 segmentation.symptoms 結構
CREATE TABLE IF NOT EXISTS `symptoms` (
  `symptom_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `main_symptom` text COLLATE utf8mb4_unicode_ci,
  `duration` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `severity` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `associated_symptoms` text COLLATE utf8mb4_unicode_ci,
  `recorded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`symptom_id`),
  KEY `patient_id` (`patient_id`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 正在傾印表格  segmentation.symptoms 的資料：30 rows
/*!40000 ALTER TABLE `symptoms` DISABLE KEYS */;
INSERT INTO `symptoms` (`symptom_id`, `patient_id`, `main_symptom`, `duration`, `severity`, `associated_symptoms`, `recorded_at`) VALUES
	(1, 'P001', 'Mild chest discomfort', '1 hour', 'Chest pain 3/10', 'No cough, no fever', '2025-04-01 07:00:00'),
	(2, 'P001', 'Slight chest tightness', '2 hours', 'Chest pain 4/10', 'Mild fatigue', '2025-04-02 08:00:00'),
	(3, 'P001', 'Improved chest sensation', '1 hour', 'Chest pain 2/10', 'No other symptoms', '2025-04-03 09:00:00'),
	(4, 'P002', 'Sudden left chest pain, shortness of breath', '3 hours', 'Difficulty breathing 7/10', 'No fever', '2025-04-01 10:00:00'),
	(5, 'P002', 'Worsening chest pain, rapid breathing', '4 hours', 'Difficulty breathing 8/10', 'Mild cough', '2025-04-02 11:00:00'),
	(6, 'P002', 'Persistent chest pain, slight improvement', '2 hours', 'Difficulty breathing 6/10', 'No fever', '2025-04-03 12:00:00'),
	(7, 'P003', 'Occasional chest tightness', '1 hour', 'Chest pain 3/10', 'No cough', '2025-04-01 13:00:00'),
	(8, 'P003', 'Mild chest discomfort', '2 hours', 'Chest pain 3/10', 'Slight fatigue', '2025-04-02 14:00:00'),
	(9, 'P003', 'No chest pain', '1 hour', 'Chest pain 1/10', 'No symptoms', '2025-04-03 15:00:00'),
	(10, 'P004', 'Sharp right chest pain, breathing difficulty', '2 hours', 'Difficulty breathing 8/10', 'No cough', '2025-04-01 16:00:00'),
	(11, 'P004', 'Increased chest pain, rapid breathing', '3 hours', 'Difficulty breathing 9/10', 'Mild dizziness', '2025-04-02 17:00:00'),
	(12, 'P004', 'Reduced pain, better breathing', '1 hour', 'Difficulty breathing 6/10', 'No other symptoms', '2025-04-03 18:00:00'),
	(13, 'P005', 'Mild chest discomfort', '1 hour', 'Chest pain 2/10', 'No fever', '2025-04-01 19:00:00'),
	(14, 'P005', 'Slight chest tightness', '2 hours', 'Chest pain 3/10', 'Mild fatigue', '2025-04-02 20:00:00'),
	(15, 'P005', 'Improved condition', '1 hour', 'Chest pain 1/10', 'No symptoms', '2025-04-03 21:00:00'),
	(16, 'P006', 'Sudden chest pain, shortness of breath', '2 hours', 'Difficulty breathing 6/10', 'No fever', '2025-04-01 22:00:00'),
	(17, 'P006', 'Worsening pain, rapid breathing', '3 hours', 'Difficulty breathing 7/10', 'Mild cough', '2025-04-02 23:00:00'),
	(18, 'P006', 'Slightly reduced pain', '1 hour', 'Difficulty breathing 5/10', 'No fever', '2025-04-03 08:00:00'),
	(19, 'P007', 'Mild chest tightness', '1 hour', 'Chest pain 3/10', 'No cough', '2025-04-01 09:00:00'),
	(20, 'P007', 'Occasional discomfort', '2 hours', 'Chest pain 2/10', 'Slight fatigue', '2025-04-02 10:00:00'),
	(21, 'P007', 'No symptoms', '1 hour', 'Chest pain 1/10', 'No symptoms', '2025-04-03 11:00:00'),
	(22, 'P008', 'Slight chest discomfort', '1 hour', 'Chest pain 2/10', 'No fever', '2025-04-01 12:00:00'),
	(23, 'P008', 'Mild chest tightness', '2 hours', 'Chest pain 3/10', 'Mild fatigue', '2025-04-02 13:00:00'),
	(24, 'P008', 'Improved condition', '1 hour', 'Chest pain 1/10', 'No symptoms', '2025-04-03 14:00:00'),
	(25, 'P009', 'Occasional chest tightness', '1 hour', 'Chest pain 2/10', 'No cough', '2025-04-01 15:00:00'),
	(26, 'P009', 'Mild discomfort', '2 hours', 'Chest pain 3/10', 'Slight fatigue', '2025-04-02 16:00:00'),
	(27, 'P009', 'No chest pain', '1 hour', 'Chest pain 1/10', 'No symptoms', '2025-04-03 17:00:00'),
	(28, 'P010', 'Severe chest pain, breathing difficulty', '3 hours', 'Difficulty breathing 9/10', 'No fever', '2025-04-01 18:00:00'),
	(29, 'P010', 'Worsening pain, rapid breathing', '4 hours', 'Difficulty breathing 10/10', 'Dizziness', '2025-04-02 19:00:00'),
	(30, 'P010', 'Slightly better breathing', '2 hours', 'Difficulty breathing 7/10', 'Mild cough', '2025-04-03 20:00:00');
/*!40000 ALTER TABLE `symptoms` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

-- phpMyAdmin SQL Dump
-- version 4.4.10
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Apr 24, 2016 at 10:37 PM
-- Server version: 5.5.42
-- PHP Version: 7.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `HealthcareClinic`
--

-- --------------------------------------------------------

--
-- Table structure for table `Access_rule`
--

CREATE TABLE `Access_rule` (
  `ID` int(11) NOT NULL,
  `Access_type` varchar(30) DEFAULT NULL,
  `Revision_user` varchar(30) DEFAULT NULL,
  `Revision_date` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Access_rule`
--

INSERT INTO `Access_rule` (`ID`, `Access_type`, `Revision_user`, `Revision_date`) VALUES
(1, 'DOCTOR', 'root@localhost', '2016-03-27 16:29:08'),
(2, 'NURSE', 'root@localhost', '2016-03-27 16:29:27'),
(3, 'RECEPTION', 'root@localhost', '2016-03-27 16:29:37'),
(4, 'PATIENT', 'root@localhost', '2016-03-27 16:29:47');

-- --------------------------------------------------------

--
-- Table structure for table `Appointment`
--

CREATE TABLE `Appointment` (
  `ID` int(11) NOT NULL,
  `Date` datetime NOT NULL,
  `Invoice_number` int(11) DEFAULT NULL,
  `Patient_id` int(11) NOT NULL,
  `Employee_id` int(11) DEFAULT NULL,
  `Doctor_id` int(11) NOT NULL,
  `Family_dr_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'N',
  `Reason` varchar(2000) NOT NULL,
  `Walkin_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Appointment`
--

INSERT INTO `Appointment` (`ID`, `Date`, `Invoice_number`, `Patient_id`, `Employee_id`, `Doctor_id`, `Family_dr_flag`, `Reason`, `Walkin_flag`, `Revision_user`, `Revision_date`) VALUES
(1, '2016-04-03 13:00:00', 48, 1, 1, 1, 'Y', 'Dying', 'N', 'root@localhost', '2016-04-18 09:37:43'),
(2, '2016-04-04 13:00:00', NULL, 1, 1, 1, 'Y', 'Dying', 'N', 'root@localhost', '2016-04-09 15:09:59'),
(3, '2016-04-05 13:00:00', NULL, 2, 3, 1, 'Y', 'Kidney pain', 'N', 'root@localhost', '2016-04-09 23:51:35'),
(4, '2016-04-06 13:00:00', 3, 2, 3, 1, 'Y', 'Vaccines', 'N', 'root@localhost', '2016-04-09 15:09:59'),
(5, '2016-04-07 13:00:00', 4, 1, 8, 1, 'Y', 'Flu', 'N', 'root@localhost', '2016-04-09 15:09:59'),
(6, '2016-04-08 13:00:00', 5, 2, 8, 1, 'N', 'Broken Arm', 'Y', 'root@localhost', '2016-04-09 15:09:59'),
(7, '2016-04-11 13:00:00', 6, 1, 8, 1, 'Y', 'Lacerated forehead', 'N', 'root@localhost', '2016-04-09 15:09:59'),
(8, '2016-04-16 12:00:00', NULL, 1, 1, 1, 'Y', 'Ear Infection', 'N', 'root@localhost', '2016-04-16 15:35:38'),
(9, '2016-04-16 13:00:00', 50, 2, 3, 1, 'Y', 'Warts', 'N', 'root@localhost', '2016-04-18 09:44:29'),
(10, '2016-04-16 14:00:00', NULL, 2, 3, 1, 'Y', 'Checkup', 'N', 'root@localhost', '2016-04-16 15:35:38'),
(11, '2016-04-17 15:00:00', NULL, 1, 8, 1, 'Y', 'Vaccines', 'N', 'root@localhost', '2016-04-16 15:35:38'),
(12, '2016-04-17 16:00:00', NULL, 2, 8, 1, 'N', 'Broken Leg', 'Y', 'root@localhost', '2016-04-16 15:35:38'),
(13, '2016-04-17 17:00:00', NULL, 1, 8, 1, 'Y', 'Foot Fungus', 'N', 'root@localhost', '2016-04-16 15:35:38'),
(14, '2016-04-23 12:00:00', 52, 5, 1, 1, 'Y', 'Lacerated Finger', 'N', 'root@localhost', '2016-04-23 19:58:31'),
(15, '2016-04-23 13:00:00', NULL, 6, 1, 1, 'Y', 'Broken Hand', 'N', 'root@localhost', '2016-04-23 19:19:16'),
(16, '2016-04-23 14:00:00', 53, 9, 1, 1, 'Y', 'Lacerated Knee', 'N', 'root@localhost', '2016-04-23 20:40:31'),
(21, '2016-04-24 14:00:00', NULL, 8, 2, 2, 'Y', 'Dead', 'N', 'root@localhost', '2016-04-24 13:04:15'),
(23, '2016-04-24 14:30:00', 55, 14, 8, 1, 'Y', 'Test', 'N', 'root@localhost', '2016-04-24 14:21:02'),
(18, '2016-04-24 15:00:00', NULL, 8, 8, 1, 'Y', 'Warts', 'N', 'root@localhost', '2016-04-24 12:40:28'),
(17, '2016-04-25 11:00:00', NULL, 9, 8, 1, 'Y', 'Broken Hands', 'N', 'root@localhost', '2016-04-24 13:38:04'),
(19, '2016-04-25 12:00:00', NULL, 8, 1, 1, 'Y', 'Lacerated Thumb', 'N', 'root@localhost', '2016-04-24 11:26:01'),
(22, '2016-04-25 13:00:00', 54, 8, 8, 1, 'Y', 'Hernia', 'N', 'root@localhost', '2016-04-24 12:43:09'),
(20, '2016-04-27 12:00:00', NULL, 8, 1, 1, 'Y', 'Broken Hand', 'N', 'root@localhost', '2016-04-24 11:26:13');

-- --------------------------------------------------------

--
-- Table structure for table `Billing`
--

CREATE TABLE `Billing` (
  `Invoice_number` int(11) NOT NULL,
  `Amount` decimal(15,2) unsigned NOT NULL,
  `Balance` decimal(15,2) unsigned NOT NULL,
  `Paid` decimal(15,2) unsigned NOT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Billing`
--

INSERT INTO `Billing` (`Invoice_number`, `Amount`, `Balance`, `Paid`, `Revision_user`, `Revision_date`) VALUES
(1, '300.00', '300.00', '0.00', '', '2016-04-09 15:55:00'),
(2, '1000.00', '800.00', '200.00', 'root@localhost', '2016-04-09 23:51:35'),
(3, '500.00', '0.00', '500.00', 'root@localhost', '2016-04-24 14:25:13'),
(4, '300.00', '0.00', '300.00', 'root@localhost', '2016-04-24 13:09:42'),
(5, '1000.00', '700.00', '300.00', 'root@localhost', '2016-04-24 14:25:34'),
(6, '300.00', '300.00', '0.00', '', '2016-04-09 16:00:00'),
(48, '100.00', '1.00', '0.00', 'root@localhost', '2016-04-18 09:37:43'),
(49, '100.00', '1.00', '0.00', 'root@localhost', '2016-04-18 09:44:03'),
(50, '100.00', '1.00', '0.00', 'root@localhost', '2016-04-18 09:44:29'),
(51, '100.00', '1.00', '0.00', 'root@localhost', '2016-04-23 19:58:15'),
(52, '100.00', '1.00', '0.00', 'root@localhost', '2016-04-23 19:58:31'),
(53, '100.00', '1.00', '0.00', 'root@localhost', '2016-04-23 20:40:31'),
(54, '100.00', '1.00', '0.00', 'root@localhost', '2016-04-24 12:43:09'),
(55, '100.00', '1.00', '0.00', 'root@localhost', '2016-04-24 14:21:02');

-- --------------------------------------------------------

--
-- Table structure for table `Clinic_user`
--

CREATE TABLE `Clinic_user` (
  `User_id` int(11) NOT NULL,
  `Username` varchar(30) NOT NULL,
  `Password` varchar(200) NOT NULL,
  `User_email` varchar(45) NOT NULL,
  `Date_registered` bigint(20) NOT NULL,
  `Patient_id` int(11) DEFAULT NULL,
  `Employee_id` int(11) DEFAULT NULL,
  `User_type` varchar(10) NOT NULL,
  `Access_rule_id` int(11) NOT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Clinic_user`
--

INSERT INTO `Clinic_user` (`User_id`, `Username`, `Password`, `User_email`, `Date_registered`, `Patient_id`, `Employee_id`, `User_type`, `Access_rule_id`, `Revision_user`, `Revision_date`) VALUES
(1, 'lrtoenje', '3137326e03c1bc88f0ca09060c61d1ede1af0d6f08eb0764139bb92ef7965005ab3e54a5a02d56f80da8cc7203f0fc4ac1508c0a5a2969746e9b2782596b41a3', 'luke@example.com', 1459132365, NULL, 1, 'DOCTOR', 1, 'root@localhost', '2016-03-27 20:33:15'),
(2, 'asdf', '7970b231c7e8de1c8de7402a063eafd2a88449e62edcd0f751355961cd369a6490906e1aaad908619589ab8df4b7fbbbfe6479a39bbe0c082620036982e91409', 'asdf', 1459190377, 2, NULL, 'PATIENT', 4, 'root@localhost', '2016-03-28 12:39:53'),
(5, 'alitoen', '8d1a4d33fe02cf5e0916f7abe06d22477aff22a796d131658380c7278e74239bea08b903ce408c7052f0130db3d568ed1645ac3f9243600a64c154817b81a545', 'alitoen@example.com', 1460217174, NULL, 6, 'NURSE', 2, 'root@localhost', '2016-04-09 09:57:40'),
(8, 'madbum', 'cc9c08831b41487a459b56b5f84b52cb2508d6a7ffffb95e26ce1422b49861fadf2248480c3b8934fb6c1fc05fd2d03231bbda51fa230d63f68d79fdb5ec55aa', 'madbum@giants.com', 1461021095, NULL, 9, 'DOCTOR', 1, 'root@localhost', '2016-04-18 17:14:45'),
(9, 'adamw', '7c750d3e6c878f78ea8ad44d6a027f8791b56718a66762a1384eaad8412a38d90b8b53da8322b263edacd026aaec050d9bb6117004a8bc55462295a7b4cec9ec', 'wainster@cardinals.com', 1461021323, NULL, 10, 'DOCTOR', 1, 'root@localhost', '2016-04-18 17:17:35'),
(10, 'matzzy', '57c042deea6dd2d777788d4a2893566949d4e08c4eca69a5c0e8623d266103048bbb1a1199f9bd7dd50b601720b42feb515d607df49d8c4122e3d62a71fac1ed', 'matz@mets.com', 1461021473, NULL, 11, 'NURSE', 2, 'root@localhost', '2016-04-18 17:19:52'),
(11, 'dantheman', 'd49be5a557ba71a3e056e0e376843569318e9b6d87e7b6d244014cbdebada6361110fc273479422fd5610ff2dae2465f373536cfdb4c2ea71839d1c88ec198f9', 'danny@indians.com', 1461021629, NULL, 12, 'RECEPTION', 3, 'root@localhost', '2016-04-18 17:22:44'),
(12, 'bakedjake', 'a4991af2b52846a4bd1fd10c7ae8c4e830b4042c351587848d8c05eae32ac10f993f6e79488d2ef88c9074b26a33e49d54d9f8bd8fb5efc07dffd8fb598657aa', 'jakester@cubs.com', 1461022533, NULL, 13, 'NURSE', 2, 'root@localhost', '2016-04-18 17:36:22'),
(13, 'chriss', '03c6c15202d1399884a28dcfbad4d965076d3d19f47440d2d9a1954d77e04547de93bd5dca178b291579f80a299cd70c41b41259069f3eebc843f70914cf9ef0', 'saleman@whitesox.com', 1461022759, NULL, 14, 'DOCTOR', 1, 'root@localhost', '2016-04-18 17:41:49'),
(14, 'hecks', '826f1f64815996706bf5f730c8a746d84623592d01aaef42b4b6d106b4f18e24d325a204eee6de7b2133aee772b72fb626fd6100de59fce1a974d3937b5520c0', 'roro@cubs.com', 1461023210, NULL, 17, 'RECEPTION', 3, 'root@localhost', '2016-04-18 17:47:55'),
(15, 'mattyw', '5502b6516827807023854eb9932ab9d5a7ed96bc719841787d579e045bddc24f4b682049bac5720aa7c585755d29fc0e576ecd122451aea600e4647130d80d04', 'waters@Orioles.com', 1461024164, 4, NULL, 'PATIENT', 4, 'root@localhost', '2016-04-18 18:04:35'),
(16, 'freewilly', '0b32a408a9f93bcda4239ac0c0386ab9f4a1fda14e2c15fe972e9e752b28dde34c89d9fb882d771173b218249a9ff876dc27b74bab81dc3291e13a6d551cf811', 'ramos@nationals.com', 1461024320, 5, NULL, 'PATIENT', 4, 'root@localhost', '2016-04-18 18:08:06'),
(17, 'pollypocket', '410600bd1ea802d044ebd3c300e21caac8347e6675a93b807871e897d2caeac00d8911e36df313b50e3ad119399dc20888d2d676e9f3e69be167af383c8d8b91', 'goldy@dbacks.com', 1461024488, 6, NULL, 'PATIENT', 4, 'root@localhost', '2016-04-18 18:11:07'),
(18, 'josea', '0edb53ca8927dad164b709355fea2330c2a856de85ce38b73334f481b6d1366fa6facb500d7f3367d5665e95ec0337f38a4e048ff32e66f026ab4f3843301859', 'abreu@whitesox.com', 1461024668, 7, NULL, 'PATIENT', 4, 'root@localhost', '2016-04-18 18:12:42'),
(19, 'bulldozer', '8820e150a6d69c383881c00bd4dc960ddb7982c0fb76e08179924a30fdb8e0147d99be3f8d232589330306f98688e20ea9698676837fcaedbdc32e4043db555e', 'brian@twins.com', 1461024764, 8, NULL, 'PATIENT', 4, 'root@localhost', '2016-04-18 18:14:55'),
(20, 'tornado', '84716b3a6209a7f4ce3890b1fe4b04ce1faa5acf23e877ede138ed3d34b0a7bc64994f2bc9f30b22e0a09162270bb2b25128db239fca3b8756422e25a1faed20', 'nolan@rockies.com', 1461024896, 9, NULL, 'PATIENT', 4, 'root@localhost', '2016-04-18 18:17:25'),
(21, 'kyles', 'd9c7152dd846cbd9302e15e0f82cd6f0be0cbca42c390a9cd6de0b09eb476d7759f358bc88286fbf1486733792e94515ed252e3828884fa6f0bfd5206f5326d1', 'seager@mariners.com', 1461025101, 10, NULL, 'PATIENT', 4, 'root@localhost', '2016-04-18 18:20:20'),
(22, 'jeans', '0e6a3e90fe2da110e246ed9989191e1fb1cef745dbf99d41be9382e58cb9705a75c70f0b5af9b88e0e859dd86f6e742600ddd47d1155b5d10f0c4194e17150fa', 'segura@dbacks.com', 1461025222, 11, NULL, 'PATIENT', 4, 'root@localhost', '2016-04-18 18:22:32'),
(23, 'harps', 'cf2e9639b1d66c3a1187cf12db93738c8f7b20808070c3fc0db6973abcd602900e40c51e22254311f1d658bd45926c492894c1390bc3382edcf46512da48015c', 'harper@nationals.com', 1461025354, 12, NULL, 'PATIENT', 4, 'root@localhost', '2016-04-18 18:25:54'),
(24, 'crustydave', '5a52f8c5cbcb1379d44416ca59bd67e73c2e0c66708152f2fa7d11515a4f3637bf63b8bebe6a632972444ff2e62a20a4f62e95fca1befe9959307fe31c06e27f', 'davis@orioles.com', 1461025636, 13, NULL, 'PATIENT', 4, 'root@localhost', '2016-04-18 18:32:05'),
(25, 'tamer', 'cf7f2120c2f21337b79102e834fdb397d419c52dbf247a5ff6d63e4ad0d1e712a2d327b020510af9c1c90588569e29b3f93f2400587049de3ee6c73f08124ae8', 'tamer@example.com', 1461528775, 14, NULL, 'PATIENT', 4, 'root@localhost', '2016-04-24 14:14:35');

-- --------------------------------------------------------

--
-- Table structure for table `Drugs_Available`
--

CREATE TABLE `Drugs_Available` (
  `Drug_id` int(11) NOT NULL,
  `DIN` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Type` varchar(30) NOT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Drugs_Available`
--

INSERT INTO `Drugs_Available` (`Drug_id`, `DIN`, `Name`, `Type`, `Revision_user`, `Revision_date`) VALUES
(1, 2269139, 'Acetylsalicylic Acid 80 MG Tablet', 'Salicylates', 'root@localhost', '2016-04-24 13:17:00'),
(2, 326577, 'Adasept Acne Gel', 'Keratolytic Agents', 'root@localhost', '2016-04-18 22:19:11'),
(3, 2444593, 'Aleve Nighttime Tablet', 'Nonsteroidal Antiimflammatory', 'root@localhost', '2016-04-18 22:19:28'),
(4, 1933531, 'Advil Ibuprofen 200 MG Tablet', 'Nonsteroidal Antiimflammatory', 'root@localhost', '2016-04-18 22:19:43'),
(5, 2244577, 'Advil Ibuprofen 400 MG Tablet', 'Nonsteroidal Antiimflammatory', 'root@localhost', '2016-04-18 22:19:57'),
(6, 2231462, 'Allegra 12 Hour 60 MG Tablet', 'Second Generation Antihistamin', 'root@localhost', '2016-04-18 22:20:17'),
(7, 363766, 'Dimenhydrinate 50 MG Tablet', 'Antihistamines', 'root@localhost', '2016-04-18 22:20:30'),
(8, 2250993, 'Benadryl Total Tablet', 'Analgesics and Antipyretics', 'root@localhost', '2016-04-18 22:20:44'),
(9, 2039397, 'Benylin Cough & Congestion Ext Str Syrup', 'Expectorants', 'root@localhost', '2016-04-18 22:21:33'),
(10, 899453, 'Benzac 5% Gel', 'Keratolytic Agents', 'root@localhost', '2016-04-18 22:21:49'),
(11, 2150867, 'Canesten 1% Topical Cream', 'Azoles', 'root@localhost', '2016-04-18 22:22:02'),
(12, 2289164, 'Buckley''s Cough Chest Congestion Syrup', 'Expectorants', 'root@localhost', '2016-04-18 22:22:14'),
(13, 782696, 'Claritin 10 MG Tablet', 'Second Generation Antihistamin', 'root@localhost', '2016-04-18 22:22:27'),
(14, 1944355, 'Combantrin 50 MG/mL Oral Suspension', 'Anthelmintics', 'root@localhost', '2016-04-18 22:22:40'),
(15, 2332248, 'Cyproheptadine 4 MG Tablet', 'Miscellaneous Derivatives', 'root@localhost', '2016-04-18 22:22:53'),
(16, 2300265, 'Decongest Nasal Spray', 'Vasoconstrictors', 'root@localhost', '2016-04-18 22:23:04'),
(17, 2100207, 'Dequadin 0.25 MG Lozenges', 'Miscellaneous Anti-infectives', 'root@localhost', '2016-04-18 22:23:17'),
(18, 2338424, 'Desloratadine 5 MG Tablet', 'Second Generation Antihistamin', 'root@localhost', '2016-04-18 22:23:31'),
(19, 2212005, 'Loperamide 2 MG Tablet', 'Antidiarrhea Agents', 'root@localhost', '2016-04-18 22:23:48'),
(20, 2243969, 'Dimetapp DM Cough and Cold Liquid', 'Propylamine Derivatives', 'root@localhost', '2016-04-18 22:23:58'),
(21, 2242893, 'Diurex Water Caplets', 'Diuretics', 'root@localhost', '2016-04-18 22:24:19'),
(22, 2279762, 'Docusate Calcium', 'Cathartics and Laxatives', 'root@localhost', '2016-04-18 22:24:33'),
(23, 2354527, 'Dr. Numb Topical Anesthetic Cream', 'Antipruritics and Local Anesth', 'root@localhost', '2016-04-18 22:24:45'),
(24, 2376997, 'Dulcocomfort Stool Softener Capsule', 'Cathartics and Laxatives', 'root@localhost', '2016-04-18 22:25:00'),
(25, 2389886, 'Dry Eye Tears Drops', 'Artificial Tears', 'root@localhost', '2016-04-18 22:25:16'),
(26, 254142, 'Dulcolax Tablet', 'Cathartics and Laxatives', 'root@localhost', '2016-04-18 22:25:26'),
(27, 10332, 'Enthropen 325 MG Tablet', 'Salicylates', 'root@localhost', '2016-04-18 22:25:44'),
(28, 2352133, 'Fluconazole 150 MG Capsule', 'Azoles', 'root@localhost', '2016-04-18 22:25:55'),
(30, 999999, 'NONE', 'None', 'root@localhost', '2016-04-24 13:17:19');

-- --------------------------------------------------------

--
-- Table structure for table `Employee`
--

CREATE TABLE `Employee` (
  `Employee_id` int(11) NOT NULL,
  `Employee_type` varchar(30) NOT NULL,
  `First_name` varchar(50) NOT NULL,
  `Last_name` varchar(50) NOT NULL,
  `Gender` varchar(1) DEFAULT NULL,
  `SIN_number` varchar(15) NOT NULL,
  `Start_date` datetime NOT NULL,
  `End_date` datetime DEFAULT NULL,
  `Active_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `Phone_number` varchar(15) NOT NULL,
  `Address` varchar(250) NOT NULL,
  `Doctor_id` int(11) DEFAULT NULL,
  `Speciality` varchar(50) DEFAULT NULL,
  `Certification` varchar(50) DEFAULT NULL,
  `Work_station_number` int(11) DEFAULT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Employee`
--

INSERT INTO `Employee` (`Employee_id`, `Employee_type`, `First_name`, `Last_name`, `Gender`, `SIN_number`, `Start_date`, `End_date`, `Active_flag`, `Phone_number`, `Address`, `Doctor_id`, `Speciality`, `Certification`, `Work_station_number`, `Revision_user`, `Revision_date`) VALUES
(1, 'DOCTOR', 'Luke', 'Toenjes', 'M', '123456789', '2016-03-23 11:23:37', NULL, 'Y', '403-710-1951', 'University of Calgary', 1, 'GP', NULL, NULL, 'root@localhost', '2016-04-08 16:24:54'),
(2, 'RECEPTIONIST', 'Spencer', 'Manzon', 'M', '312468469', '2016-03-23 11:23:37', NULL, 'Y', '403-710-1951', 'University of Calgary', 2, NULL, NULL, NULL, 'root@localhost', '2016-03-23 11:23:37'),
(3, 'NURSE', 'Justin;', 'Chu', 'M', '001800481', '2016-03-23 11:23:37', '2016-03-23 16:00:14', 'N', '000-000-0000', 'University of Calgary', 4, 'Feet', 'RN', NULL, 'root@localhost', '2016-03-23 16:00:14'),
(8, 'NURSE', 'Alicia', 'Toenjes', 'F', '4154562', '2016-04-09 00:00:00', NULL, 'Y', '403-976-5468', 'Chestermere', NULL, NULL, 'LPN', NULL, 'root@localhost', '2016-04-09 10:01:10'),
(9, 'DOCTOR', 'Madison', 'Bumgarner ', 'M', '192874327', '2016-04-18 00:00:00', NULL, 'Y', '403-817-8382', 'San Fransisco', 40, 'Hand Specialist', NULL, NULL, 'root@localhost', '2016-04-18 17:14:45'),
(10, 'DOCTOR', 'Adam', 'Wainwright', 'M', '83921838', '2016-04-18 00:00:00', NULL, 'Y', '403-828-8912', '143 Cardinals Street, Calgary AB, Canada', 50, 'GP', NULL, NULL, 'root@localhost', '2016-04-18 17:17:35'),
(11, 'NURSE', 'Steven', 'Matz', 'M', '849392843', '2016-04-18 00:00:00', NULL, 'Y', '403-836-0018', '89 Mets Ave, Calgary AB, Canada', NULL, NULL, 'RN', NULL, 'root@localhost', '2016-04-18 17:19:52'),
(12, 'RECEPTIONIST', 'Danny', 'Salazar', 'M', '992837183', '2016-04-18 00:00:00', NULL, 'Y', '403-910-8318', '45 Indian Road, Calgary AB, Canada', NULL, NULL, NULL, 3, 'root@localhost', '2016-04-18 17:22:44'),
(13, 'NURSE', 'Jake', 'Arrieta', 'M', '918471941', '2016-04-18 00:00:00', NULL, 'Y', '587-938-7294', '1 Cubs Way, Calgary AB, Canada', NULL, NULL, 'LPN', NULL, 'root@localhost', '2016-04-18 17:36:22'),
(14, 'DOCTOR', 'Chris', 'Sale', 'M', '938291837', '2016-04-18 00:00:00', NULL, 'Y', '587-937-1743', '192 Sox Drive , Calgary AB, Canada', 49, 'Emergency', NULL, NULL, 'root@localhost', '2016-04-18 17:41:49'),
(17, 'RECEPTIONIST', 'Hector', 'Rondon', 'M', '910392784', '2016-04-18 00:00:00', NULL, 'Y', '587-618-8827', '10 Cubs Drive, Calgary AB, Canada', NULL, NULL, NULL, 1, 'root@localhost', '2016-04-18 17:47:55');

-- --------------------------------------------------------

--
-- Table structure for table `Equipment`
--

CREATE TABLE `Equipment` (
  `Equipment_id` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Manufacturer` varchar(250) NOT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Equipment`
--

INSERT INTO `Equipment` (`Equipment_id`, `Name`, `Manufacturer`, `Revision_user`, `Revision_date`) VALUES
(1, 'Telephone', 'NEC', 'root@localhost', '2016-04-19 00:10:25'),
(2, 'Calculator', 'Staples', 'root@localhost', '2016-04-19 00:12:38'),
(3, 'Monitor', 'Samsung', 'root@localhost', '2016-04-19 00:13:04'),
(4, 'Compute Center', 'Dell', 'root@localhost', '2016-04-19 00:13:23'),
(5, 'Copy Machine', 'Xerox', 'root@localhost', '2016-04-19 00:13:38'),
(6, 'Printer', 'Xerox', 'root@localhost', '2016-04-19 00:13:53'),
(7, 'Chair', 'IKEA', 'root@localhost', '2016-04-19 00:14:15'),
(8, 'Autoclave', '3M', 'root@localhost', '2016-04-19 00:14:57'),
(9, 'Digital Blood Pressure', 'Welch Allyn', 'root@localhost', '2016-04-19 00:16:30'),
(10, 'Sphygmomanometer', 'Welch Allyn', 'root@localhost', '2016-04-19 00:16:46'),
(11, 'Sphygmomanometer', 'Welch Allyn', 'root@localhost', '2016-04-19 00:16:53'),
(12, 'Examination Bed', 'Clinton', 'root@localhost', '2016-04-19 00:23:14'),
(13, 'Examination Bed', 'Clinton', 'root@localhost', '2016-04-19 00:23:26'),
(14, 'Weighing Scale', 'Welch Allyn', 'root@localhost', '2016-04-19 00:23:54'),
(15, 'Tympanic Thermometer', 'Medline', 'root@localhost', '2016-04-19 00:37:38'),
(16, 'Tympanic Thermometer', 'Medline', 'root@localhost', '2016-04-19 00:38:07'),
(17, 'Tympanic Thermometer', 'Medline', 'root@localhost', '2016-04-19 00:38:22'),
(18, 'Rectal Thermometer', 'Vicks', 'root@localhost', '2016-04-19 00:39:20'),
(19, 'Stapler', 'Staples', 'root@localhost', '2016-04-19 00:50:25'),
(20, 'Biohazard Bin', 'Rubbermaid', 'root@localhost', '2016-04-19 00:54:06'),
(21, 'Biohazard Bin', 'Rubbermaid', 'root@localhost', '2016-04-19 00:54:16'),
(22, 'Scissors', 'Staples', 'root@localhost', '2016-04-19 00:54:48'),
(23, 'Scissors', 'Staples', 'root@localhost', '2016-04-19 00:54:59'),
(24, 'Tourniquet', 'MooreBrand', 'root@localhost', '2016-04-19 00:56:59'),
(25, 'Tourniquet', 'MooreBrand', 'root@localhost', '2016-04-19 00:57:08'),
(26, 'Chair Test', '471Labb', 'root@localhost', '2016-04-24 14:28:16');

-- --------------------------------------------------------

--
-- Table structure for table `Medical_History`
--

CREATE TABLE `Medical_History` (
  `ID` int(11) NOT NULL,
  `Doctor_id` int(11) NOT NULL,
  `Appointment_date` datetime NOT NULL,
  `Patient_id` int(11) NOT NULL,
  `Walkin_flag` varchar(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `Family_dr_flag` varchar(45) DEFAULT NULL,
  `Comments` varchar(250) DEFAULT NULL,
  `Reason_for_appt` varchar(2000) NOT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Medical_History`
--

INSERT INTO `Medical_History` (`ID`, `Doctor_id`, `Appointment_date`, `Patient_id`, `Walkin_flag`, `Family_dr_flag`, `Comments`, `Reason_for_appt`, `Revision_user`, `Revision_date`) VALUES
(1, 1, '2016-04-25 13:00:00', 8, 'N', 'Y', ' Successful Treatment', 'Hernia', 'root@localhost', '2016-04-24 12:43:09'),
(2, 1, '2016-04-24 14:30:00', 14, 'N', 'Y', ' Test', 'Test', 'root@localhost', '2016-04-24 14:21:02');

-- --------------------------------------------------------

--
-- Table structure for table `Medical_Hist_Drug_Xref`
--

CREATE TABLE `Medical_Hist_Drug_Xref` (
  `Medical_history_id` int(11) NOT NULL,
  `Drug_id` int(11) NOT NULL,
  `Refills` int(11) NOT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Medical_Hist_Drug_Xref`
--

INSERT INTO `Medical_Hist_Drug_Xref` (`Medical_history_id`, `Drug_id`, `Refills`, `Revision_user`, `Revision_date`) VALUES
(2, 2, 1, 'root@localhost', '2016-04-24 14:21:02');

-- --------------------------------------------------------

--
-- Table structure for table `Patient`
--

CREATE TABLE `Patient` (
  `Id` int(11) NOT NULL,
  `SIN_number` varchar(15) NOT NULL,
  `First_name` varchar(50) NOT NULL,
  `Last_name` varchar(50) NOT NULL,
  `Allergies` varchar(250) DEFAULT NULL,
  `Health_care_number` varchar(15) NOT NULL,
  `Address` varchar(250) NOT NULL,
  `Phone_number` varchar(15) NOT NULL,
  `Doctor_id` int(11) DEFAULT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Patient`
--

INSERT INTO `Patient` (`Id`, `SIN_number`, `First_name`, `Last_name`, `Allergies`, `Health_care_number`, `Address`, `Phone_number`, `Doctor_id`, `Revision_user`, `Revision_date`) VALUES
(1, '819479174', 'Luke', 'Toenjes', 'none', '193928', '3', '4', NULL, 'root@localhost', '2016-03-27 20:33:15'),
(2, '918402841', 'Matt', 'Kemp', 'Peanut', '948194', 'San Diego', '111-111-1111', NULL, 'root@localhost', '2016-04-08 09:58:39'),
(4, '184928472', 'Matt', 'Wieters', 'Penicillin', '194827', '53 Orioles Blvd, Calgary AB, Canada', '403-948-8819', NULL, 'root@localhost', '2016-04-18 18:04:35'),
(5, '990382918', 'Wilson', 'Ramos', 'Strawberries', '104828', '492 Nationals Way, Calgary AB, Canada', '587-910-4582', NULL, 'root@localhost', '2016-04-18 18:08:06'),
(6, '772849375', 'Paul', 'Goldschmidt', 'None', '105828', '999 Snake Road, Calgary AB, Canada', '403-985-8918', NULL, 'root@localhost', '2016-04-18 18:11:07'),
(7, '993827465', 'Jose', 'Abreu', 'Shellfish, Luke', '901985', '392 Sox Drive, Calgary AB, Canada', '403-892-0091', NULL, 'root@localhost', '2016-04-23 15:56:22'),
(8, '758463791', 'Brian', 'Dozier', 'None', '882741', '193 Twins Road, Calgary AB, Canada', '403-942-9582', NULL, 'root@localhost', '2016-04-18 18:14:55'),
(9, '4829857`3', 'Nolan', 'Arenado', 'None', '827581', '12 Rockies Way, Calgary AB, Canada', '587-948-8194', NULL, 'root@localhost', '2016-04-18 18:17:25'),
(10, '557393201', 'Kyle', 'Seager', 'Crab, Lobster', '439184', '391 Mariners Place, Calgary AB, Canada', '403-881-8402', NULL, 'root@localhost', '2016-04-18 18:20:20'),
(11, '557917483', 'Jean', 'Segura', 'Grass', '847189', '918 Snake Road, Calgary AB, Canada', '403-987-1293', NULL, 'root@localhost', '2016-04-18 18:22:32'),
(12, '195739284', 'Bryce', 'Harper', 'None', '443194', '71 Nationals Way, Calgary AB, Canada', '587-817-9941', NULL, 'root@localhost', '2016-04-18 18:25:54'),
(13, '339228117', 'Chris', 'Davis', 'Gluten, Lactose', '837991', '773 Orioles Place, Calgary AB, Canada', '403-883-4721', NULL, 'root@localhost', '2016-04-18 18:32:05'),
(14, '000000000', 'Ibrahim', 'Jarada', 'None', '000000', 'U of C', '403-111-1111', NULL, 'root@localhost', '2016-04-24 14:22:26');

-- --------------------------------------------------------

--
-- Table structure for table `Room`
--

CREATE TABLE `Room` (
  `Room_number` int(11) NOT NULL,
  `Type` varchar(10) NOT NULL,
  `Size` varchar(30) NOT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Room`
--

INSERT INTO `Room` (`Room_number`, `Type`, `Size`, `Revision_user`, `Revision_date`) VALUES
(1, 'Exam', '15''x10''', 'root@localhost', '2016-04-02 17:12:10'),
(2, 'Exam', '10''x10''', 'root@localhost', '2016-04-02 17:12:10'),
(3, 'Staging', '10''x10''', 'root@localhost', '2016-04-02 17:12:10'),
(4, 'Waiting', '20''x20''', 'root@localhost', '2016-04-02 17:12:10');

-- --------------------------------------------------------

--
-- Table structure for table `Room_Equipment_Xref`
--

CREATE TABLE `Room_Equipment_Xref` (
  `Room_number` int(11) NOT NULL,
  `Equipment_id` int(11) NOT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Room_Equipment_Xref`
--

INSERT INTO `Room_Equipment_Xref` (`Room_number`, `Equipment_id`, `Revision_user`, `Revision_date`) VALUES
(1, 10, 'root@localhost', '2016-04-19 00:16:46'),
(1, 12, 'root@localhost', '2016-04-19 00:23:14'),
(1, 17, 'root@localhost', '2016-04-19 00:38:22'),
(1, 20, 'root@localhost', '2016-04-19 00:54:06'),
(1, 24, 'root@localhost', '2016-04-19 00:56:59'),
(2, 11, 'root@localhost', '2016-04-19 00:16:53'),
(2, 13, 'root@localhost', '2016-04-19 00:23:26'),
(2, 16, 'root@localhost', '2016-04-19 00:38:07'),
(2, 18, 'root@localhost', '2016-04-19 00:39:20'),
(2, 21, 'root@localhost', '2016-04-19 00:54:16'),
(2, 25, 'root@localhost', '2016-04-19 00:57:08'),
(3, 8, 'root@localhost', '2016-04-19 00:14:57'),
(3, 9, 'root@localhost', '2016-04-19 00:16:30'),
(3, 14, 'root@localhost', '2016-04-19 00:23:54'),
(3, 15, 'root@localhost', '2016-04-19 00:37:38'),
(4, 1, 'root@localhost', '2016-04-19 00:10:25'),
(4, 2, 'root@localhost', '2016-04-19 00:12:38'),
(4, 3, 'root@localhost', '2016-04-19 00:13:04'),
(4, 4, 'root@localhost', '2016-04-19 00:13:23'),
(4, 5, 'root@localhost', '2016-04-19 00:13:38'),
(4, 6, 'root@localhost', '2016-04-19 00:13:53'),
(4, 7, 'root@localhost', '2016-04-19 00:14:15'),
(4, 19, 'root@localhost', '2016-04-19 00:50:25'),
(4, 22, 'root@localhost', '2016-04-19 00:54:48'),
(4, 23, 'root@localhost', '2016-04-19 00:54:59'),
(4, 26, 'root@localhost', '2016-04-24 14:28:16');

-- --------------------------------------------------------

--
-- Table structure for table `Room_Supplies_Xref`
--

CREATE TABLE `Room_Supplies_Xref` (
  `Room_number` int(11) NOT NULL,
  `Supplies_id` int(11) NOT NULL,
  `Amount` int(11) unsigned NOT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Room_Supplies_Xref`
--

INSERT INTO `Room_Supplies_Xref` (`Room_number`, `Supplies_id`, `Amount`, `Revision_user`, `Revision_date`) VALUES
(1, 1, 1000, 'root@localhost', '2016-04-19 00:24:59'),
(1, 2, 300, 'root@localhost', '2016-04-19 00:30:47'),
(1, 3, 220, 'root@localhost', '2016-04-19 00:33:59'),
(1, 4, 190, 'root@localhost', '2016-04-19 00:34:46'),
(2, 1, 800, 'root@localhost', '2016-04-19 00:27:01'),
(2, 2, 250, 'root@localhost', '2016-04-19 00:31:12'),
(2, 3, 210, 'root@localhost', '2016-04-19 00:34:26'),
(2, 4, 197, 'root@localhost', '2016-04-19 00:35:01'),
(2, 5, 10, 'root@localhost', '2016-04-19 00:40:48'),
(3, 1, 1000, 'root@localhost', '2016-04-19 00:24:22'),
(3, 2, 320, 'root@localhost', '2016-04-19 00:32:00'),
(3, 6, 100, 'root@localhost', '2016-04-19 00:42:54'),
(3, 7, 23, 'root@localhost', '2016-04-19 00:45:42'),
(3, 8, 200, 'root@localhost', '2016-04-19 00:46:31'),
(4, 9, 5000, 'root@localhost', '2016-04-19 00:46:49'),
(4, 10, 2, 'root@localhost', '2016-04-19 00:47:05'),
(4, 11, 4, 'root@localhost', '2016-04-19 00:47:20'),
(4, 12, 100, 'root@localhost', '2016-04-19 00:51:19'),
(4, 13, 2, 'root@localhost', '2016-04-19 00:51:37'),
(4, 14, 3, 'root@localhost', '2016-04-19 00:51:47'),
(4, 15, 100, 'root@localhost', '2016-04-19 00:55:41'),
(4, 16, 30, 'root@localhost', '2016-04-19 00:57:51');

-- --------------------------------------------------------

--
-- Table structure for table `Scheduled_For`
--

CREATE TABLE `Scheduled_For` (
  `Employee_id` int(11) NOT NULL,
  `Work_day_date` datetime NOT NULL,
  `Revision_user` varchar(30) DEFAULT NULL,
  `Revision_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Scheduled_For`
--

INSERT INTO `Scheduled_For` (`Employee_id`, `Work_day_date`, `Revision_user`, `Revision_date`) VALUES
(1, '2016-03-28 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-03-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-03-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-03-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-03-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-03-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-03-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-03-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-03-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-03-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-03-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-03-29 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-03-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-03-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-03-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-03-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-03-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-03-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-03-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-03-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-03-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-03-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-03-30 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-03-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-03-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-03-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-03-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-03-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-03-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-03-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-03-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-03-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-03-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-03-31 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-03-31 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-03-31 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-03-31 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-03-31 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-03-31 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-03-31 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-03-31 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-03-31 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-03-31 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-03-31 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-04-01 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-04-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-04-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-04-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-04-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-04-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-04-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-04-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-04-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-04-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-04-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-04-02 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-04-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-04-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-04-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-04-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-04-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-04-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-04-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-04-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-04-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-04-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-04-03 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-04-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-04-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-04-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-04-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-04-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-04-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-04-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-04-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-04-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-04-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-04-23 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-04-23 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-04-23 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-04-23 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-04-23 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-04-23 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-04-23 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-04-23 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-04-23 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-04-23 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-04-23 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-04-24 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-04-24 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-04-24 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-04-24 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-04-24 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-04-24 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-04-24 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-04-24 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-04-24 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-04-24 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-04-24 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-04-25 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-04-25 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-04-25 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-04-25 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-04-25 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-04-25 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-04-25 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-04-25 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-04-25 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-04-25 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-04-25 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-04-26 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-04-26 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-04-26 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-04-26 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-04-26 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-04-26 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-04-26 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-04-26 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-04-26 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-04-26 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-04-26 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-04-27 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-04-27 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-04-27 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-04-27 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-04-27 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-04-27 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-04-27 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-04-27 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-04-27 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-04-27 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-04-27 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-04-28 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-04-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-04-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-04-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-04-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-04-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-04-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-04-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-04-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-04-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-04-28 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-04-29 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-04-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-04-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-04-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-04-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-04-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-04-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-04-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-04-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-04-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-04-29 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-04-30 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-04-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-04-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-04-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-04-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-04-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-04-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-04-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-04-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-04-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-04-30 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-01 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-01 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-02 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-02 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-03 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-03 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-04 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-04 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-04 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-04 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-04 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-04 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-04 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-04 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-04 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-04 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-04 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-05 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-05 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-05 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-05 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-05 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-05 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-05 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-05 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-05 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-05 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-05 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-06 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-06 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-06 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-06 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-06 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-06 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-06 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-06 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-06 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-06 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-06 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-07 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-07 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-07 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-07 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-07 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-07 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-07 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-07 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-07 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-07 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-07 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-08 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-08 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-08 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-08 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-08 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-08 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-08 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-08 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-08 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-08 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-08 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-09 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-09 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-09 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-09 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-09 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-09 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-09 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-09 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-09 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-09 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-09 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-10 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-10 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-10 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-10 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-10 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-10 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-10 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-10 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-10 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-10 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-10 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-11 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-11 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-11 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-11 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-11 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-11 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-11 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-11 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-11 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-11 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-11 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-12 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-12 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-12 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-12 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-12 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-12 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-12 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-12 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-12 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-12 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-12 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-13 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-13 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-13 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-13 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-13 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-13 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-13 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-13 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-13 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-13 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-13 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-14 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-14 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-14 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-14 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-14 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-14 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-14 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-14 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-14 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-14 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-14 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-15 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-15 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-15 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-15 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-15 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-15 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-15 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-15 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-15 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-15 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-15 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-16 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-16 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-16 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-16 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-16 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-16 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-16 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-16 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-16 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-16 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-16 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-17 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-17 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-17 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-17 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-17 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-17 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-17 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-17 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-17 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-17 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-17 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-18 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-18 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-18 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-18 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-18 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-18 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-18 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-18 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-18 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-18 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-18 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-19 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-19 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-19 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-19 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-19 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-19 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-19 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-19 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-19 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-19 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-19 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-20 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-20 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-20 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-20 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-20 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-20 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-20 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-20 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-20 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-20 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-20 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-21 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-21 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-21 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-21 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-21 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-21 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-21 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-21 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-21 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-21 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-21 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(1, '2016-05-22 00:00:00', 'root@localhost', '2016-04-24 10:45:19'),
(2, '2016-05-22 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(3, '2016-05-22 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(8, '2016-05-22 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(9, '2016-05-22 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(10, '2016-05-22 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(11, '2016-05-22 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(12, '2016-05-22 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(13, '2016-05-22 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(14, '2016-05-22 00:00:00', 'root@localhost', '2016-04-24 10:45:39'),
(17, '2016-05-22 00:00:00', 'root@localhost', '2016-04-24 10:45:39');

-- --------------------------------------------------------

--
-- Table structure for table `Supplies`
--

CREATE TABLE `Supplies` (
  `ID` int(11) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Supplier` varchar(45) NOT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Supplies`
--

INSERT INTO `Supplies` (`ID`, `Name`, `Supplier`, `Revision_user`, `Revision_date`) VALUES
(1, 'Cotton Swabs', 'Johnson&Johnson', 'root@localhost', '2016-04-19 00:24:22'),
(2, 'Cotton Balls', 'Johnson&Johnson', 'root@localhost', '2016-04-19 00:30:47'),
(3, 'Syringe', 'Terumen', 'root@localhost', '2016-04-19 00:33:59'),
(4, 'Needle', 'Terumen', 'root@localhost', '2016-04-19 00:34:46'),
(5, 'Pregnancy Test Kit', 'Clearblue', 'root@localhost', '2016-04-19 00:40:48'),
(6, 'Povidone-iodine', 'Betadine', 'root@localhost', '2016-04-19 00:42:54'),
(7, 'Bandage', 'Nexcare', 'root@localhost', '2016-04-19 00:45:42'),
(8, 'Gloves', 'Tesco', 'root@localhost', '2016-04-19 00:46:31'),
(9, 'Paper', 'Staples', 'root@localhost', '2016-04-19 00:46:49'),
(10, 'Printer Toner', 'Xerox', 'root@localhost', '2016-04-19 00:47:05'),
(11, 'Receipt Paper', 'Staples', 'root@localhost', '2016-04-19 00:47:20'),
(12, 'Letter Envelopes', 'Staples', 'root@localhost', '2016-04-19 00:51:19'),
(13, 'Stamp Pad', 'Staples', 'root@localhost', '2016-04-19 00:51:37'),
(14, 'Stamper', 'Staples', 'root@localhost', '2016-04-19 00:51:47'),
(15, 'Paper Clip', 'Staples', 'root@localhost', '2016-04-19 00:55:41'),
(16, 'Folder', 'Staples', 'root@localhost', '2016-04-19 00:57:51');

-- --------------------------------------------------------

--
-- Table structure for table `Work_Day`
--

CREATE TABLE `Work_Day` (
  `Date` datetime NOT NULL,
  `Start_time` datetime NOT NULL,
  `End_time` datetime NOT NULL,
  `Revision_user` varchar(30) NOT NULL,
  `Revision_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Work_Day`
--

INSERT INTO `Work_Day` (`Date`, `Start_time`, `End_time`, `Revision_user`, `Revision_date`) VALUES
('2016-03-28 00:00:00', '2016-03-28 09:00:00', '2016-03-25 17:00:00', 'root@localhost', '2016-03-27 18:13:22'),
('2016-03-29 00:00:00', '2016-03-29 09:00:00', '2016-03-25 17:00:00', 'root@localhost', '2016-03-27 18:13:22'),
('2016-03-30 00:00:00', '2016-03-30 09:00:00', '2016-03-25 17:00:00', 'root@localhost', '2016-03-27 18:13:22'),
('2016-03-31 00:00:00', '2016-03-31 09:00:00', '2016-03-25 17:00:00', 'root@localhost', '2016-03-27 18:13:22'),
('2016-04-01 00:00:00', '2016-04-01 09:00:00', '2016-03-25 17:00:00', 'root@localhost', '2016-03-27 18:13:22'),
('2016-04-02 00:00:00', '2016-04-01 09:00:00', '2016-03-25 17:00:00', 'root@localhost', '2016-03-27 18:13:22'),
('2016-04-03 00:00:00', '2016-04-01 09:00:00', '2016-03-25 17:00:00', 'root@localhost', '2016-03-27 18:17:42'),
('2016-04-23 00:00:00', '2016-04-23 09:00:00', '2016-04-23 17:00:00', 'root@localhost', '2016-04-23 22:26:32'),
('2016-04-24 00:00:00', '2016-04-24 09:00:00', '2016-04-24 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-04-25 00:00:00', '2016-04-25 09:00:00', '2016-04-25 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-04-26 00:00:00', '2016-04-26 09:00:00', '2016-04-26 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-04-27 00:00:00', '2016-04-27 09:00:00', '2016-04-27 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-04-28 00:00:00', '2016-04-28 09:00:00', '2016-04-28 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-04-29 00:00:00', '2016-04-29 09:00:00', '2016-04-29 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-04-30 00:00:00', '2016-04-30 09:00:00', '2016-04-30 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-01 00:00:00', '2016-05-01 09:00:00', '2016-05-01 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-02 00:00:00', '2016-05-02 09:00:00', '2016-05-02 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-03 00:00:00', '2016-05-03 09:00:00', '2016-05-03 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-04 00:00:00', '2016-05-04 09:00:00', '2016-05-04 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-05 00:00:00', '2016-05-05 09:00:00', '2016-05-05 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-06 00:00:00', '2016-05-06 09:00:00', '2016-05-06 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-07 00:00:00', '2016-05-07 09:00:00', '2016-05-07 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-08 00:00:00', '2016-05-08 09:00:00', '2016-05-08 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-09 00:00:00', '2016-05-09 09:00:00', '2016-05-09 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-10 00:00:00', '2016-05-10 09:00:00', '2016-05-10 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-11 00:00:00', '2016-05-11 09:00:00', '2016-05-11 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-12 00:00:00', '2016-05-12 09:00:00', '2016-05-12 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-13 00:00:00', '2016-05-13 09:00:00', '2016-05-13 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-14 00:00:00', '2016-05-14 09:00:00', '2016-05-14 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-15 00:00:00', '2016-05-15 09:00:00', '2016-05-15 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-16 00:00:00', '2016-05-16 09:00:00', '2016-05-16 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-17 00:00:00', '2016-05-17 09:00:00', '2016-05-17 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-18 00:00:00', '2016-05-18 09:00:00', '2016-05-18 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-19 00:00:00', '2016-05-19 09:00:00', '2016-05-19 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-20 00:00:00', '2016-05-20 09:00:00', '2016-05-20 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-21 00:00:00', '2016-05-21 09:00:00', '2016-05-21 17:00:00', 'root@localhost', '2016-04-23 22:47:18'),
('2016-05-22 00:00:00', '2016-05-22 09:00:00', '2016-05-22 17:00:00', 'root@localhost', '2016-04-23 22:47:18');


ALTER TABLE `Access_rule`
  ADD PRIMARY KEY (`ID`);


ALTER TABLE `Appointment`
  ADD PRIMARY KEY (`Date`,`Patient_id`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`),
  ADD KEY `Invoice_number_idx` (`Invoice_number`),
  ADD KEY `Patient_id_idx` (`Patient_id`),
  ADD KEY `Doctor_id_idx` (`Doctor_id`),
  ADD KEY `Employee_id_idx` (`Employee_id`);


ALTER TABLE `Billing`
  ADD PRIMARY KEY (`Invoice_number`);


ALTER TABLE `Clinic_user`
  ADD PRIMARY KEY (`User_id`),
  ADD UNIQUE KEY `Username_UNIQUE` (`Username`),
  ADD KEY `Patient_id_idx` (`Patient_id`),
  ADD KEY `Employee_id_idx` (`Employee_id`),
  ADD KEY `Access_rule_id_idx` (`Access_rule_id`);

ALTER TABLE `Drugs_Available`
  ADD PRIMARY KEY (`Drug_id`,`DIN`);

ALTER TABLE `Employee`
  ADD PRIMARY KEY (`Employee_id`),
  ADD UNIQUE KEY `SIN_number_UNIQUE` (`SIN_number`),
  ADD UNIQUE KEY `Doctor_id_UNIQUE` (`Doctor_id`);


ALTER TABLE `Equipment`
  ADD PRIMARY KEY (`Equipment_id`);


ALTER TABLE `Medical_History`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID_UNIQUE` (`ID`),
  ADD KEY `Appointment_date_idx` (`Appointment_date`),
  ADD KEY `Patient_id_idx` (`Patient_id`),
  ADD KEY `Doctor_id_medh` (`Doctor_id`);


ALTER TABLE `Medical_Hist_Drug_Xref`
  ADD PRIMARY KEY (`Medical_history_id`,`Drug_id`),
  ADD KEY `Drug_name_idx` (`Drug_id`);


ALTER TABLE `Patient`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `SIN_number_UNIQUE` (`SIN_number`),
  ADD UNIQUE KEY `Health_care_number_UNIQUE` (`Health_care_number`),
  ADD KEY `Doctor_id_pat_idx` (`Doctor_id`);


ALTER TABLE `Room`
  ADD PRIMARY KEY (`Room_number`);


ALTER TABLE `Room_Equipment_Xref`
  ADD PRIMARY KEY (`Room_number`,`Equipment_id`),
  ADD KEY `Equipment_id` (`Equipment_id`);


ALTER TABLE `Room_Supplies_Xref`
  ADD PRIMARY KEY (`Room_number`,`Supplies_id`),
  ADD KEY `Supplies_id_idx` (`Supplies_id`);


ALTER TABLE `Scheduled_For`
  ADD PRIMARY KEY (`Work_day_date`,`Employee_id`),
  ADD KEY `Employee_id_idx` (`Employee_id`);


ALTER TABLE `Supplies`
  ADD PRIMARY KEY (`ID`);


ALTER TABLE `Work_Day`
  ADD PRIMARY KEY (`Date`);

ALTER TABLE `Access_rule`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;

ALTER TABLE `Appointment`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=24;

ALTER TABLE `Billing`
  MODIFY `Invoice_number` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=56;

ALTER TABLE `Clinic_user`
  MODIFY `User_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=26;

ALTER TABLE `Drugs_Available`
  MODIFY `Drug_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=32;

ALTER TABLE `Employee`
  MODIFY `Employee_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;

ALTER TABLE `Equipment`
  MODIFY `Equipment_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;

ALTER TABLE `Medical_History`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;

ALTER TABLE `Patient`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;

ALTER TABLE `Room`
  MODIFY `Room_number` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;

ALTER TABLE `Supplies`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;

ALTER TABLE `Appointment`
  ADD CONSTRAINT `Doctor_id_appt` FOREIGN KEY (`Doctor_id`) REFERENCES `Employee` (`Doctor_id`),
  ADD CONSTRAINT `Employee_id_appt` FOREIGN KEY (`Employee_id`) REFERENCES `Employee` (`Employee_id`),
  ADD CONSTRAINT `Invoice_number` FOREIGN KEY (`Invoice_number`) REFERENCES `Billing` (`Invoice_number`),
  ADD CONSTRAINT `Patient_id_appt` FOREIGN KEY (`Patient_id`) REFERENCES `Patient` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `Clinic_user`
  ADD CONSTRAINT `Patient_id` FOREIGN KEY (`Patient_id`) REFERENCES `Patient` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `Medical_History`
  ADD CONSTRAINT `Appointment_date` FOREIGN KEY (`Appointment_date`) REFERENCES `Appointment` (`Date`),
  ADD CONSTRAINT `Doctor_id_medh` FOREIGN KEY (`Doctor_id`) REFERENCES `Employee` (`Doctor_id`),
  ADD CONSTRAINT `Patient_id_medh` FOREIGN KEY (`Patient_id`) REFERENCES `Patient` (`Id`);


ALTER TABLE `Medical_Hist_Drug_Xref`
  ADD CONSTRAINT `Drug_id` FOREIGN KEY (`Drug_id`) REFERENCES `Drugs_Available` (`Drug_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Medical_history_id` FOREIGN KEY (`Medical_history_id`) REFERENCES `Medical_History` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `Patient`
  ADD CONSTRAINT `Doctor_id_pat` FOREIGN KEY (`Doctor_id`) REFERENCES `Employee` (`Doctor_id`) ON DELETE SET NULL ON UPDATE CASCADE;


ALTER TABLE `Room_Equipment_Xref`
  ADD CONSTRAINT `Equipment_id` FOREIGN KEY (`Equipment_id`) REFERENCES `Equipment` (`Equipment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Room_number_eqp` FOREIGN KEY (`Room_number`) REFERENCES `Room` (`Room_number`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `Room_Supplies_Xref`
  ADD CONSTRAINT `Room_number` FOREIGN KEY (`Room_number`) REFERENCES `Room` (`Room_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Supplies_id` FOREIGN KEY (`Supplies_id`) REFERENCES `Supplies` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `Scheduled_For`
  ADD CONSTRAINT `Employee_id` FOREIGN KEY (`Employee_id`) REFERENCES `Employee` (`Employee_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Work_day_date` FOREIGN KEY (`Work_day_date`) REFERENCES `Work_Day` (`Date`) ON DELETE NO ACTION ON UPDATE NO ACTION;

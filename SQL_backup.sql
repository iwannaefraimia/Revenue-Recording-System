-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: 195.251.249.131    Database: ismgroup5
-- ------------------------------------------------------
-- Server version	5.6.21-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assets` (
  `asset_ID` int(11) NOT NULL AUTO_INCREMENT,
  `asset_Name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `asset_Descr` varchar(2000) COLLATE utf8_unicode_ci DEFAULT NULL,
  `asset_TotalTimima` decimal(30,2) DEFAULT NULL,
  `asset_CatID` int(10) NOT NULL,
  PRIMARY KEY (`asset_ID`),
  KEY `assets_FK` (`asset_CatID`),
  CONSTRAINT `assets_FK` FOREIGN KEY (`asset_CatID`) REFERENCES `assetcats` (`assetcat_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
INSERT INTO `assets` VALUES (1,'Στοά ΜΟΔΙΑΝΟ ΑΕ','Επίσημη κεντρική αγορά Τροφίμων (προσθετω καμποσο κειμενο για να δω αν γινεται word wrap στην παρουσιαση των αποτελεσματων μεσω της JSP). test edit',5000000.06,1),(3,'Μαρίνα Αλίμου',NULL,4000000.00,3),(6,'Εταιρεία επένδυσης ακινήτων νέας Κέρκυρας ΑΕ',NULL,100000.00,1),(7,'Λιμένας Ελευσίνας ',NULL,20000000.00,6),(9,'Ξενία Κύθνου',NULL,7000000.00,1),(10,'ΟΛΗ - Λιμένας Ηρακλείου ΑΕ',NULL,6000000.00,6),(11,'ΟΛΡ - Λιμένας Ραφήνας ΑΕ',NULL,8000000.00,6),(12,'Έρμου & Αιόλου',NULL,1000500.00,1),(13,'Σανατόριο (ΑΒΚ 134)',NULL,2000000.00,1),(14,'ΟΛΘ - Λιμένας Θεσσαλονίκης ΑΕ',NULL,7500000.00,6),(15,'ΔΑΑ - Διεθνής Αερολιμένας Αθηνών ΑΕ',NULL,150000000.00,4),(16,'ΕΛΠΕ - Ελληνικά Πετρέλαια ΑΕ',NULL,28000.12,7),(17,'ΟΠΑΠ ΑΕ',NULL,105000000.00,7),(71,'ΟΛΠ - Λιμένας Πειραιά ΑΕ',NULL,3000000000.00,6),(72,'ΟΛΒ - Λιμένας Βόλου ΑΕ',NULL,800000000.00,6),(81,'Διόδια Ιεροπηγής','Σταθμός διοδίων Εγνατίας Οδού',60000000.00,2),(82,'Διόδια Προμαχώνα','Σταθμός διοδίων Εγνατίας Οδού',8000000.00,2),(83,'Διόδια Στρυμονικού','Σταθμός διοδίων Εγνατίας Οδού',4500000.00,2),(100,'Ραδιοσυχνότητες 5G',NULL,200000000.00,8),(152,'test_6','test descr 12',454876454.12,8),(155,'test32','test descr',454551.12,10),(156,'test 54','test descr 2',15457444.01,10),(157,'test PS','test descr 54',456456411.03,10),(158,'test asset2024','test descr3',4464654.04,10),(159,'ακινητο','ακινητο',12503650.00,1);
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incometypes`
--

DROP TABLE IF EXISTS `incometypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incometypes` (
  `incometype_ID` int(11) NOT NULL AUTO_INCREMENT,
  `incometype_Name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `incometype_ALE` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`incometype_ID`),
  KEY `incometype_FK` (`incometype_ALE`),
  CONSTRAINT `incometype_FK` FOREIGN KEY (`incometype_ALE`) REFERENCES `ale` (`ale_Num`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incometypes`
--

LOCK TABLES `incometypes` WRITE;
/*!40000 ALTER TABLE `incometypes` DISABLE KEYS */;
INSERT INTO `incometypes` VALUES (1,'Λιμένες / αεροδρόμια / μαρίνες (αντάλλαγμα παραχώρησης)','1430189001'),(2,'Ακίνητο (μίσθωση)','1430189001'),(3,'Ακίνητο (πώληση)','3110389001'),(4,'Γαιοτεμάχιο (μίσθωση)','1530289001'),(5,'Γαιοτεμάχιο (πώληση)','3150101001'),(6,'Διόδια','1310889001'),(7,'Πώληση μετοχών ΑΕ (Μη-εισηγμένες)','4520901001'),(8,'Μείωση Μ/Κ ΑΕ (Μη-εισηγμένες)','4520901002'),(9,'Πώληση μετοχών ΑΕ (Εισηγμένες)','4510901001'),(31,'Διανομή μερίσματος / αποθεματικού (Εισηγμένων)','1520101001'),(32,'Διανομή μερίσματος / αποθεματικού (Μη-εισηγμένων)','1520201001'),(33,'Επιστροφή κεφαλαίου από διαφορά έκδοσης μετοχών υπέρ το άρτιο','1520101001'),(50,'Τόκοι υπερημερίας','1560203001'),(91,'Δικαίωμα χρήσης ραδιοσυχν. (αντάλλαγμα παραχώρησης)','1530902001'),(96,'test1_incometype_test1','4520901002'),(98,'test1057','1530902001');
/*!40000 ALTER TABLE `incometypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ale`
--

DROP TABLE IF EXISTS `ale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ale` (
  `ale_Num` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `ale_Descr` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ale_OldKAE` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ale_Num`),
  UNIQUE KEY `ale_Num_UNIQUE` (`ale_Num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ale`
--

LOCK TABLES `ale` WRITE;
/*!40000 ALTER TABLE `ale` DISABLE KEYS */;
INSERT INTO `ale` VALUES ('1310889001','Λοιπές μεταβιβάσεις από νομικά πρόσωπα','3829Μ, 3111, 3113Μ, 3115, 3119'),('1430189001','Λοιπά μισθώματα κτιρίων & υποδομών','2224Μ, 6721Μ, 6729Μ'),('1520101001','Διανεμόμενο εισόδημα μετοχών εισηγμένων στο χρηματιστήριο','2543, 2544, 2546, 2551, 2552,2553, 2541Μ, 2549Μ'),('1520201001','Διανεμόμενο εισόδημα μετοχών μη-εισηγμένων στο χρηματιστήριο','2547, 2549Μ'),('1530289001','Λοιπά μισθώματα γης','2224Μ, 2446, 3426, 2445'),('1530902001','Άδειες χρήσης ραδιοσυχνοτήτων επίγειας ψηφιακής ευρυεκπομπής','2449Μ'),('1560203001','Τόκοι υπερημερίας',NULL),('3110389001','Πωλήσεις λοιπών κτιρίων','6729Μ'),('3150101001','Πωλήσεις γης',NULL),('4510901001','Πωλήσεις συμμετοχής σε ΑΜΚ / Αγορά μετοχών για λοιπές επιχειρήσεις εισηγμένες','6711'),('4520901001','Πωλήσεις μετοχών μη-εισηγμένων επιχειρήσεων εσωτερικού','6713'),('4520901002','Επιστροφές Μ/Κ μη-εισηγμένων εταιρειών','6718'),('9999999999','test ale for test is OK','test old KAEs is now OK');
/*!40000 ALTER TABLE `ale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incomes`
--

DROP TABLE IF EXISTS `incomes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incomes` (
  `income_ID` int(11) NOT NULL AUTO_INCREMENT,
  `income_DateKatath` date NOT NULL COMMENT 'Ημερομηνία κατάθεσης σε Λογ. του Δημοσίου',
  `income_DateTaiped` date DEFAULT NULL COMMENT 'Ημερομηνία κατάθεσης σε Λογ. του ΤΑΙΠΕΔ (πριν από το Λογ. του Δημοσίου)',
  `income_AmountDeposit` decimal(20,2) NOT NULL,
  `income_Dosi_Etos` char(200) COLLATE utf8_unicode_ci NOT NULL,
  `income_Descr` varchar(2000) COLLATE utf8_unicode_ci NOT NULL,
  `income_SAP` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `income_AccID` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `income_AssetID` int(11) NOT NULL,
  `income_IncomeType` int(11) NOT NULL,
  PRIMARY KEY (`income_ID`),
  KEY `fk_Asset` (`income_AssetID`),
  KEY `fk_IncomeType` (`income_IncomeType`),
  KEY `records_FK` (`income_AccID`),
  CONSTRAINT `fk_Asset` FOREIGN KEY (`income_AssetID`) REFERENCES `assets` (`asset_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_IncomeType` FOREIGN KEY (`income_IncomeType`) REFERENCES `incometypes` (`incometype_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `records_FK` FOREIGN KEY (`income_AccID`) REFERENCES `accounts` (`acc_Num`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incomes`
--

LOCK TABLES `incomes` WRITE;
/*!40000 ALTER TABLE `incomes` DISABLE KEYS */;
INSERT INTO `incomes` VALUES (10,'2021-02-09',NULL,10000.00,'2021-01','Έσοδα διοδίων Ιανουαρίου 2021','6601260336','2009141111',81,6),(11,'2021-02-09',NULL,320000.00,'2021-01','Έσοδα διοδίων Ιανουαρίου 2021','6601260336','2009141111',82,6),(12,'2021-02-09',NULL,240000.00,'2021-01','Έσοδα διοδίων Ιανουαρίου 2021','6601260336','2009141111',83,6),(13,'2021-03-11',NULL,8500.00,'2021-02','Έσοδα διοδίων Φεβρουαρίου 2021','6601277179','2009141111',81,6),(14,'2021-03-11',NULL,386000.00,'2021-02','Έσοδα διοδίων Φεβρουαρίου 2021','6601277179','2009141111',82,6),(15,'2021-03-11',NULL,295000.00,'2021-02','Έσοδα διοδίων Φεβρουαρίου 2021','6601277179','2009141111',83,6),(16,'2021-03-22',NULL,4800000.00,'2020','Αντάλλαγμα παραχώρησης 2020',NULL,'200548',71,1),(17,'2021-02-08',NULL,200000000.00,'2021','Άδειες χρήσης ραδιοσυχνοτήτων επίγειας ψηφιακής ευρυεκπομπής - Aντάλλαγμα παραχώρησης δικαιώματος χρήσης ραδιοσυχνοτήτων στις ζώνες 700 MHz, 2 GHz, 3400-3800 MHz και 26 GHz (5G)','6601260336','2009141111',100,91),(18,'2021-02-26',NULL,280000.00,'3','Μερική καταβολή 3ης δόσης - Πώληση μετοχών','6601260339','2009141111',1,3),(19,'2021-03-05',NULL,500.00,'4','Τόκοι υπερημερίας 3ης δόσης','6601260339','2009141111',1,50),(20,'2021-05-12',NULL,2600000.00,'2020','Αντάλλαγμα παραχώρησης 2020. Κατατέθηκε αρχικά στο λογαριασμό 2427037 (12/05/2021)','6601303182','200548',14,1),(21,'2022-04-04','2022-03-16',5000.00,'4','Καταβολή 4ης δόσης - Πώληση μετοχών της εταιρείας Στοά Μοδιάνο ΑΕ','6601444827','2009141111',1,3),(22,'2022-05-12',NULL,7600000.00,'2021','Μέρισμα 2021. Εγινε εγγραφο για μεταφορα στο Λογ Μερισματαποδ. (μεταφορα 6601476400 & 6601476494)','6601461335','2009141111',16,9),(23,'2022-10-07',NULL,3000000.00,'2022','Πώληση μετοχών',NULL,'2009141111',17,9);
/*!40000 ALTER TABLE `incomes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `acc_Num` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `acc_Name` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `acc_IBAN` varchar(27) COLLATE utf8_unicode_ci NOT NULL,
  `acc_Descr` varchar(1000) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`acc_Num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES ('200540','200540 μερισμ','GR4895084058048547358642575','Τεστok2'),('200548','200548','GR4895084058048547358642575','548 βαζουν ολοι!'),('2009141111','Διακριτος','GR4895084058048547358642575','Test account4_test'),('2427037','Μερισματαποδειξεων','GR4895084058048547358642575','Test account1_testOOK'),('4534657657','testaccount','GR9999999999999999999999999','test account new ok changed?');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assetcats`
--

DROP TABLE IF EXISTS `assetcats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assetcats` (
  `assetcat_ID` int(10) NOT NULL AUTO_INCREMENT,
  `assetcat_Name` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`assetcat_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetcats`
--

LOCK TABLES `assetcats` WRITE;
/*!40000 ALTER TABLE `assetcats` DISABLE KEYS */;
INSERT INTO `assetcats` VALUES (1,'Ακίνητα'),(2,'Διόδια'),(3,'Μαρίνες'),(4,'Αεροδρόμια'),(6,'Λιμένες'),(7,'Συμμετοχές σε επιχειρήσεις'),(8,'Ραδιοσυχνότητες'),(10,'TestAC edited OK now');
/*!40000 ALTER TABLE `assetcats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(21) COLLATE utf8_unicode_ci NOT NULL,
  `fullname` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `activate` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Activation of user (1 = activated & able to login, 0 = not activated not able to login)',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('geotsak','9999','Τσακαλος Γεωργιος','t8200259@aueb.gr',NULL,1),('iokar','9999','Καρυτσιωτη Ιωαννα','t8210054@aueb.gr',NULL,1),('kpram','9999','Πραματαρη Κατερινα','kpramatari1@aueb.gr','2109999999',1),('sofos','9999','Στουραίτης Σοφοκλης','sofos@aueb.gr',NULL,0),('stefan','123123123','stefanos','stef@example.com','6912312312',0),('stefkour','9999','Κουρουπακης Στεφανος','t8210067@aueb.gr',NULL,1),('teoiak','9999','Ιακωβακη Θεοδωρα','t8210047@aueb.gr',NULL,1),('usernametest','usernametest','Νικολαου Γεωργιος','email@email.gr','6969454545',0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-15 10:38:26

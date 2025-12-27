-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: dn198.cti.ugal.ro    Database: dn198
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Angajat`
--

DROP TABLE IF EXISTS `Angajat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Angajat` (
  `IDAngajat` int NOT NULL AUTO_INCREMENT,
  `IDA` int DEFAULT NULL,
  `nume` varchar(100) NOT NULL,
  `prenume` varchar(100) NOT NULL,
  `functie` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`IDAngajat`),
  KEY `IDA` (`IDA`),
  CONSTRAINT `Angajat_ibfk_1` FOREIGN KEY (`IDA`) REFERENCES `Atelier` (`IDA`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Angajat`
--

LOCK TABLES `Angajat` WRITE;
/*!40000 ALTER TABLE `Angajat` DISABLE KEYS */;
INSERT INTO `Angajat` VALUES (1,1,'Popa','Ionel','Mecanic'),(2,1,'Ionescu','George','Mecanic'),(3,2,'Barbu','Elena','Electrician'),(4,3,'Dumitrescu','Mihai','Recepționer'),(5,4,'Voiculescu','Ana','Mecanic'),(6,5,'Nistor','Cristina','Consultant service'),(7,6,'Marcu','Radu','Diagnoză'),(8,7,'Iliescu','Raluca','Coordonator atelier'),(9,8,'Cojocaru','Paul','Mecanic'),(10,9,'Pavel','Irina','Asistent service'),(11,5,'Vasilica','Popescu','Ucenic'),(12,1,'Popescu','Andrei','Mecanic'),(13,2,'Ionescu','Mihai','Electrician'),(14,3,'Tudor','Daniela','Consultant service'),(15,4,'Stan','Paul','Mecanic'),(16,5,'Enache','Alexandru','Receptioner'),(17,6,'Cristea','Ioana','Consilier'),(18,7,'Balan','Ovidiu','Coordonator atelier'),(19,8,'Pop','Marius','Mecanic'),(20,9,'Dragan','Silvia','Receptioner'),(21,5,'Ion','Vasile','Ucenic'),(22,9,'Marian','Vasiliu','Mecanic'),(23,3,'Alibec','Doru','Receptioner'),(24,5,'Mircea','Brasov','Mecanic');
/*!40000 ALTER TABLE `Angajat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Atelier`
--

DROP TABLE IF EXISTS `Atelier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Atelier` (
  `IDA` int NOT NULL AUTO_INCREMENT,
  `nume` varchar(100) NOT NULL,
  `adresa` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`IDA`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Atelier`
--

LOCK TABLES `Atelier` WRITE;
/*!40000 ALTER TABLE `Atelier` DISABLE KEYS */;
INSERT INTO `Atelier` VALUES (1,'Atelier Central','Str. Independentei 10'),(2,'Atelier Nord','Str. Victoriei 22'),(3,'Atelier Sud','Str. Libertății 33'),(4,'Atelier Est','Bd. Unirii 44'),(5,'Atelier Vest','Str. Traian 55'),(6,'Service Motor','Str. Motorului 66'),(7,'Service Electric','Str. Electricienilor 77'),(8,'Diagnoză Rapidă','Str. Diagnozei 88'),(9,'Atelier Mecanică','Str. Mecanicului 99'),(10,'Atelier Frâne','Str. Frânei 101'),(11,'Atelier Dyno','Str. Masinii 24'),(12,'Atelier Detailing','Str. Parfumului'),(13,'Atelier Galati','Str Crizantemelor'),(15,'Atelier Braila','Str Dunarii');
/*!40000 ALTER TABLE `Atelier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Client`
--

DROP TABLE IF EXISTS `Client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Client` (
  `IDC` int NOT NULL AUTO_INCREMENT,
  `nume` varchar(100) NOT NULL,
  `prenume` varchar(100) NOT NULL,
  `telefon` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `username` varchar(25) NOT NULL,
  `password` varchar(255) NOT NULL,
  `tipUtilizator` enum('Admin','Client') NOT NULL DEFAULT 'Client',
  PRIMARY KEY (`IDC`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Client`
--

LOCK TABLES `Client` WRITE;
/*!40000 ALTER TABLE `Client` DISABLE KEYS */;
INSERT INTO `Client` VALUES (1,'Nastac','Dorian','1025648944','dn@yahoo.com','dori','7110eda4d09e062aa5e4a390b0a572ac0d2c0220','Client'),(3,'Georgescu','Vladut','0789421678','','vladg','b8c3fa2a4530920cbfb8ed59288ed07b6eda70d4','Client'),(4,'Radu','Elena','','','elena_r','f583df6d7956296486ee69f8ae24224e33af7e64','Client'),(5,'Dumitru','Andrei',NULL,NULL,'andrei_d','3a0f36f928d9e935121dfa42c6a7c84347a30882','Client'),(7,'Neagu','Cristian',NULL,NULL,'cristian_n','7fa3a67b0aee89ce85f8014ffc434e88fc4ce430','Client'),(8,'Marin','Silviaa','0475986244','silvia@yahoo.com','silviam','d261ad1804ca62bc1c7ecbf3d608da59ca850f92','Client'),(9,'Petrescu','Florinel','','','florin_p','c17da768c1175d53ab91bd48e4a8ef783892ba98','Client'),(11,'Chioru','Ionel','0765489256','ionTheBlind@yahoo.com','ion','7110eda4d09e062aa5e4a390b0a572ac0d2c0220','Client'),(13,'Dorian','Nastac','0764785124','dn@gmail.com','admin','83592796bc17705662dc9a750c8b6d0a4fd93396','Admin'),(14,'Andrei','Popescu','0758963451','AP@yahoo.com','popan','12990398d8f96d38265b6b2c8dd92f566978b8c1','Client'),(17,'Vasile','Ionica','0754215986','vasi@yahoo.com','vasi','bbb286479461a1d59861a3df616b887fda20735e','Client'),(18,'Nicu','Grigore','','ng@gmail.com','nicu','b3676b91df007720edbe69850d8fb6a4d2716ff4','Client'),(19,'Enescu','Laura','0712345678','laura@gmail.com','laurae','4b9f9c7ef36d0c6f7d919e0a8c9e33f7a62dd3c5','Client'),(20,'Rusu','Cristian','0722345678','cristi@yahoo.com','rusuc','bf0b452a9a56e90e5a64f0d654b6a9cc7b6f3c20','Client'),(21,'Valentin','Victorescu','0752489521','vvv@gmail.com','vali','7110eda4d09e062aa5e4a390b0a572ac0d2c0220','Client'),(30,'Tavi','Popescu','0754258965','tavipop@yahoo.com','taviii','2e0ecdbe839a9682cc92dc8e521b774c44978328','Client'),(31,'Gheorghe','Hagi','0752489621','gicahagi@gmailcom','hagi','e6a4c418984e688e5cf0f90d88918f99b4af4a3b','Client'),(32,'Gheorghe','Popescu','0478652358','gp@gmail.com','gpopescu','62d841bc64df7803f83dc99fa1a4339fff255837','Client'),(33,'Ilie','Dumitrescu','0763589654','axulCentral@yahoo.com','axul','233ec5bda5fa468329234788b4ee61711ea3041e','Client'),(34,'Mustaine','Dave','0745685234','mustaine@yahoo.com','megadeth','7b71748522d4dc181a341437faf316b5ca395965','Client'),(36,'Ilie','Moromete','0764458965','moro@yahoo.com','moro','9d9930aaf47566f5279c1bbc51bce2d9399ec5ff','Client'),(39,'Hetfield','James','075544552','papahet@yahoo.com','metallica','7e85183c21f800c0290d27f5c832b77e70a59045','Client'),(51,'Pascu','Ion','0452789544','pascu@yahoo.com','admin2','7110eda4d09e062aa5e4a390b0a572ac0d2c0220','Admin'),(53,'Chipciu','Andrei','0752364589','chipicao@yahoo.com','chip','05b1f356646c24bf1765f6f1b65aea3bde7247e1','Client'),(54,'Prodan','Darian','075426589','prd@gmail.com','prodan','7110eda4d09e062aa5e4a390b0a572ac0d2c0220','Client'),(55,'Mircea','Luis','0755226485','lmircea@yahoo.com','luis','5dccc96bcc182bf62b25793d7f395c9cc580a5d3','Client'),(56,'Birligea','Daniel','0789426538','dutu@yahoo.com','dani','d1d9e01506a3dc8087fa486e437e919c7328ffaf','Client');
/*!40000 ALTER TABLE `Client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IstoricAdmin`
--

DROP TABLE IF EXISTS `IstoricAdmin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IstoricAdmin` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IDAdmin` int DEFAULT NULL,
  `numeAdmin` varchar(100) DEFAULT NULL,
  `actiune` text,
  `dataOra` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IstoricAdmin`
--

LOCK TABLES `IstoricAdmin` WRITE;
/*!40000 ALTER TABLE `IstoricAdmin` DISABLE KEYS */;
INSERT INTO `IstoricAdmin` VALUES (7,13,'Dorian Nastac','Autentificare','2025-05-31 11:00:19'),(8,13,'Dorian Nastac','Delogare','2025-05-31 11:04:19'),(9,13,'Dorian Nastac','Autentificare','2025-05-31 11:08:00'),(10,13,'Dorian Nastac','Modificare client ID 1','2025-05-31 11:08:18'),(11,13,'Dorian Nastac','Adăugare client: Pascu Ion','2025-05-31 11:09:59'),(12,13,'Dorian Nastac','Autentificare','2025-05-31 11:42:52'),(13,13,'Dorian Nastac','Delogare','2025-05-31 11:42:54'),(14,51,'Pascu Ion','Autentificare','2025-05-31 11:43:05'),(15,51,'Pascu Ion','Adăugare client: af wefw','2025-05-31 11:45:46'),(16,51,'Pascu Ion','Modificare client ID 52','2025-05-31 11:46:08'),(17,51,'Pascu Ion','Ștergere client ID 52','2025-05-31 11:46:11'),(18,51,'Pascu Ion','Autentificare','2025-05-31 12:37:27'),(19,NULL,'Pascu','Import clienți XLSX (4 înregistrări)','2025-05-31 12:40:13'),(20,NULL,'Pascu','Import clienți XLSX (4 înregistrări)','2025-05-31 13:17:08'),(21,51,'Pascu Ion','Import clienți XLSX (5 înregistrări)','2025-05-31 13:38:44'),(22,51,'Pascu Ion','Export clienți XLSX (23 înregistrări)','2025-05-31 13:41:39'),(23,51,'Pascu Ion','Import clienți XLSX (5 înregistrări)','2025-05-31 13:41:44'),(24,51,'Pascu Ion','Delogare','2025-05-31 13:51:32'),(25,51,'Pascu Ion','Autentificare','2025-05-31 13:51:34'),(26,51,'Pascu Ion','Delogare','2025-05-31 13:52:15'),(27,51,'Pascu Ion','Autentificare','2025-05-31 13:52:16'),(28,NULL,'Pascu','Export vehicule XLSX','2025-05-31 14:29:43'),(29,NULL,'Pascu','Import vehicule XLSX (2 înregistrări)','2025-05-31 14:30:17'),(30,51,'Pascu Ion','Autentificare','2025-05-31 15:23:29'),(31,NULL,'Pascu','Export vehicule XLSX','2025-05-31 15:24:22'),(32,NULL,'Pascu','Import vehicule XLSX (2 înregistrări)','2025-05-31 15:24:30'),(33,51,'Pascu Ion','Import clienți XLSX (5 înregistrări)','2025-05-31 15:30:48'),(34,NULL,'Pascu','Import vehicule XLSX (2 înregistrări)','2025-05-31 15:31:38'),(35,51,'Pascu Ion','Import vehiculei XLSX (2 înregistrări)','2025-05-31 15:33:42'),(36,51,'Pascu Ion','Import vehiculei XLSX (2 înregistrări)','2025-05-31 15:34:46'),(37,51,'Pascu Ion','Export clienți XLSX (23 înregistrări)','2025-05-31 15:34:54'),(38,51,'Pascu Ion','Export vehicule XLSX ( înregistrări)','2025-05-31 15:37:38'),(39,51,'Pascu Ion','Adăugare programare: 207','2025-05-31 15:45:47'),(40,51,'Pascu Ion','Modificare programare ID 207','2025-05-31 15:46:22'),(41,51,'Pascu Ion','Ștergere programare ID 207','2025-05-31 15:46:31'),(42,51,'Pascu Ion','Export clienți XLSX ( înregistrări)','2025-05-31 15:51:55'),(43,51,'Pascu Ion','Export clienți XLSX ( înregistrări)','2025-05-31 15:52:20'),(44,51,'Pascu Ion','Export clienți XLSX ( înregistrări)','2025-05-31 15:54:22'),(45,NULL,'Pascu Ion','Export programări XLSX (51 înregistrări)','2025-05-31 16:01:55'),(46,51,'Pascu Ion','Export vehicule XLSX (51 înregistrări)','2025-05-31 16:02:43'),(47,51,'Pascu Ion','Export programari XLSX (51 înregistrări)','2025-05-31 16:03:04'),(50,51,'Pascu Ion','Import programari XLSX ( înregistrări)','2025-05-31 16:05:27'),(51,51,'Pascu Ion','Import programari XLSX ( înregistrări)','2025-05-31 16:06:27'),(52,51,'Pascu Ion','Import programari XLSX ( înregistrări)','2025-05-31 16:06:38'),(53,51,'Pascu Ion','Import programari XLSX (4 înregistrări)','2025-05-31 16:07:40'),(54,51,'Pascu Ion','Export clienți XLSX (23 înregistrări)','2025-05-31 16:08:02'),(55,51,'Pascu Ion','Export vehicule XLSX ( înregistrări)','2025-05-31 16:09:01'),(56,51,'Pascu Ion','Import vehiculei XLSX (2 înregistrări)','2025-05-31 16:09:06'),(57,51,'Pascu Ion','Export vehicule XLSX (0 înregistrări)','2025-05-31 16:11:38'),(58,51,'Pascu Ion','Export vehicule XLSX (28 înregistrări)','2025-05-31 16:12:07'),(59,51,'Pascu Ion','Export clienți XLSX (23 înregistrări)','2025-05-31 16:12:29'),(60,51,'Pascu Ion','Import clienți XLSX (5 înregistrări)','2025-05-31 16:12:34'),(61,51,'Pascu Ion','Export vehicule XLSX (28 înregistrări)','2025-05-31 16:12:49'),(62,51,'Pascu Ion','Import vehiculei XLSX (2 înregistrări)','2025-05-31 16:12:53'),(63,51,'Pascu Ion','Export programari XLSX (51 înregistrări)','2025-05-31 16:13:05'),(64,51,'Pascu Ion','Import programari XLSX (4 înregistrări)','2025-05-31 16:13:08'),(65,51,'Pascu Ion','Creare lucrare pentru programarea: 24','2025-05-31 16:20:41'),(66,51,'Pascu Ion','Modificare lucrare: 12','2025-05-31 16:21:42'),(67,51,'Pascu Ion','Stergere lucrare: 218','2025-05-31 16:22:28'),(68,51,'Pascu Ion','Stergere lucrare: 14','2025-05-31 16:22:47'),(69,NULL,'','Export lucrări XLSX (12 înregistrări)','2025-05-31 16:25:13'),(70,NULL,'','Export lucrări XLSX (12 înregistrări)','2025-05-31 16:25:15'),(71,51,'Pascu Ion','Export lucrări XLSX (12 înregistrări)','2025-05-31 16:28:50'),(72,51,'Pascu Ion','Export lucrări XLSX (12 înregistrări)','2025-05-31 16:29:08'),(73,51,'Pascu Ion','Adăugare programare: 208','2025-05-31 16:31:51'),(74,51,'Pascu Ion','Adăugare programare: 209','2025-05-31 16:34:51'),(75,51,'Pascu Ion','Delogare','2025-05-31 16:34:58'),(76,13,'Dorian Nastac','Autentificare','2025-05-31 16:36:07'),(77,13,'Dorian Nastac','Export vehicule XLSX (28 înregistrări)','2025-05-31 16:36:11'),(78,13,'Dorian Nastac','Delogare','2025-05-31 16:36:53'),(79,13,'Dorian Nastac','Autentificare','2025-05-31 16:41:28'),(80,13,'Dorian Nastac','Adăugare atelier: 1241','2025-05-31 16:43:34'),(81,13,'Dorian Nastac','Adăugare atelier: 1241 la adresa: rgaseg','2025-05-31 16:48:30'),(82,13,'Dorian Nastac','Modificare atelier: 1241de cu id: 33','2025-05-31 16:48:35'),(83,13,'Dorian Nastac','Ștergere atelier:  cu id: 33','2025-05-31 16:48:39'),(84,13,'Dorian Nastac','Ștergere atelier:  cu id: 32','2025-05-31 16:48:42'),(85,13,'Dorian Nastac','Export ateliere XLSX (14 înregistrări)','2025-05-31 16:51:13'),(86,13,'Dorian Nastac','Import clienți XLSX (2 înregistrări)','2025-05-31 16:52:58'),(87,13,'Dorian Nastac','Adăugare angajat: Dumbravă Valeriu','2025-05-31 16:57:19'),(88,13,'Dorian Nastac','Modificare angajat: Dumbravă Valerică cu id: 25','2025-05-31 16:57:34'),(89,13,'Dorian Nastac','Ștergere angajat:   cu id: 25','2025-05-31 16:57:48'),(90,13,'Dorian Nastac','Export clienți XLSX (24 înregistrări)','2025-05-31 16:59:06'),(91,13,'Dorian Nastac','Export angajați XLSX (24 înregistrări)','2025-05-31 16:59:33'),(92,13,'Dorian Nastac','Import angajați XLSX (2 înregistrări)','2025-05-31 17:01:00'),(93,13,'Dorian Nastac','Delogare','2025-05-31 17:05:40'),(94,51,'Pascu Ion','Autentificare','2025-05-31 17:08:49'),(95,51,'Pascu Ion','Adăugare materiale/piese: bujie ngk','2025-05-31 17:17:42'),(96,51,'Pascu Ion','Modificare materiale/piese: bujie ngk cu id: 32','2025-05-31 17:17:54'),(97,51,'Pascu Ion','Ștergere materiale/piese cu id: 32','2025-05-31 17:17:58'),(98,51,'Pascu Ion','Export materiale/piese XLSX (17 înregistrări)','2025-05-31 17:20:26'),(99,51,'Pascu Ion','Import materiale XLSX (1 înregistrări)','2025-05-31 17:21:32'),(100,51,'Pascu Ion','Delogare','2025-05-31 17:24:00'),(101,51,'Pascu Ion','Autentificare','2025-05-31 17:31:42'),(102,51,'Pascu Ion','Export servicii XLSX (15 înregistrări)','2025-05-31 17:31:56'),(103,51,'Pascu Ion','Import servicii XLSX (1 înregistrări)','2025-05-31 17:32:01'),(104,51,'Pascu Ion','Autentificare','2025-06-01 09:40:27'),(105,51,'Pascu Ion','Export servicii XLSX (15 înregistrări)','2025-06-01 09:41:04'),(106,51,'Pascu Ion','Import servicii XLSX (1 înregistrări)','2025-06-01 09:41:14'),(107,51,'Pascu Ion','Adăugare materiale/piese: Furtun intercooler','2025-06-01 09:43:04'),(108,51,'Pascu Ion','Export materiale/piese XLSX (18 înregistrări)','2025-06-01 09:43:11'),(109,51,'Pascu Ion','Import materiale XLSX (1 înregistrări)','2025-06-01 09:43:16'),(110,51,'Pascu Ion','Export clienți XLSX (25 înregistrări)','2025-06-01 09:45:30'),(111,51,'Pascu Ion','Export vehicule XLSX (29 înregistrări)','2025-06-01 09:45:39'),(112,51,'Pascu Ion','Export programari XLSX (55 înregistrări)','2025-06-01 09:45:50'),(113,51,'Pascu Ion','Export lucrări XLSX (12 înregistrări)','2025-06-01 09:45:58'),(114,51,'Pascu Ion','Export ateliere XLSX (14 înregistrări)','2025-06-01 09:46:14'),(115,51,'Pascu Ion','Export angajați XLSX (24 înregistrări)','2025-06-01 09:46:23'),(116,51,'Pascu Ion','Export servicii XLSX (15 înregistrări)','2025-06-01 09:46:27'),(117,51,'Pascu Ion','Export materiale/piese XLSX (18 înregistrări)','2025-06-01 09:46:30'),(118,51,'Pascu Ion','Delogare','2025-06-01 09:47:52'),(119,51,'Pascu Ion','Autentificare','2025-06-01 09:48:02'),(120,NULL,'Pascu','Export grafice activitate PDF','2025-06-01 10:12:00'),(121,NULL,'Pascu','Export grafice activitate PDF','2025-06-01 10:22:39'),(122,NULL,'Pascu','Export grafice activitate PDF','2025-06-01 10:23:26'),(123,51,'Pascu Ion','Creare lucrare pentru programarea: 164','2025-06-01 10:28:03'),(124,51,'Pascu Ion','Creare lucrare pentru programarea: 167','2025-06-01 10:28:28'),(125,51,'Pascu Ion','Adăugare programare: 212','2025-06-01 10:29:06'),(126,51,'Pascu Ion','Creare lucrare pentru programarea: 210','2025-06-01 10:30:30'),(127,51,'Pascu Ion','Creare lucrare pentru programarea: 19','2025-06-01 10:30:43'),(128,51,'Pascu Ion','Creare lucrare pentru programarea: 191','2025-06-01 10:31:05'),(129,51,'Pascu Ion','Creare lucrare pentru programarea: 29','2025-06-01 10:31:20'),(130,51,'Pascu Ion','Creare lucrare pentru programarea: 163','2025-06-01 10:31:48'),(131,51,'Pascu Ion','Creare lucrare pentru programarea: 20','2025-06-01 10:32:00'),(132,51,'Pascu Ion','Creare lucrare pentru programarea: 162','2025-06-01 10:32:16'),(133,51,'Pascu Ion','Creare lucrare pentru programarea: 28','2025-06-01 10:32:27'),(134,51,'Pascu Ion','Creare lucrare pentru programarea: 206','2025-06-01 10:32:52'),(135,51,'Pascu Ion','Creare lucrare pentru programarea: 190','2025-06-01 10:33:06'),(136,NULL,'Pascu','Export grafice activitate PDF','2025-06-01 10:35:21'),(137,51,'Pascu Ion','Delogare','2025-06-01 11:07:41'),(138,13,'Dorian Nastac','Autentificare','2025-06-04 10:27:31'),(139,13,'Dorian Nastac','Delogare','2025-06-04 11:12:55'),(140,13,'Dorian Nastac','Autentificare','2025-06-04 11:38:40'),(141,13,'Dorian Nastac','Autentificare','2025-06-04 21:16:08'),(142,13,'Dorian Nastac','Creare lucrare pentru programarea: 192','2025-06-04 21:17:13'),(143,13,'Dorian Nastac','Creare lucrare pentru programarea: 171','2025-06-04 21:17:25'),(144,13,'Dorian Nastac','Adăugare programare: 214','2025-06-04 21:17:55'),(145,13,'Dorian Nastac','Adăugare programare: 215','2025-06-04 21:18:14'),(146,13,'Dorian Nastac','Adăugare programare: 216','2025-06-04 21:18:28'),(147,13,'Dorian Nastac','Delogare','2025-06-04 21:19:17'),(148,13,'Dorian Nastac','Autentificare','2025-06-05 08:32:23'),(149,13,'Dorian Nastac','Export clienți XLSX (27 înregistrări)','2025-06-05 08:33:27'),(150,13,'Dorian Nastac','Import clienți XLSX (5 înregistrări)','2025-06-05 08:33:48'),(151,NULL,'Dorian','Export grafice activitate PDF','2025-06-05 08:35:07');
/*!40000 ALTER TABLE `IstoricAdmin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IstoricClient`
--

DROP TABLE IF EXISTS `IstoricClient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `IstoricClient` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `IDC` int NOT NULL,
  `numeClient` varchar(100) DEFAULT NULL,
  `actiune` text,
  `dataOra` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `IDC` (`IDC`),
  CONSTRAINT `IstoricClient_ibfk_1` FOREIGN KEY (`IDC`) REFERENCES `Client` (`IDC`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IstoricClient`
--

LOCK TABLES `IstoricClient` WRITE;
/*!40000 ALTER TABLE `IstoricClient` DISABLE KEYS */;
INSERT INTO `IstoricClient` VALUES (1,1,'Nastac Dorian','Autentificare','2025-05-30 18:01:30'),(2,1,'Nastac Dorian','Creare programare la 2025-05-30 11:00:00 pentru vehicul IDV 32 și serviciu IDS 16','2025-05-30 18:02:31'),(6,1,'Nastac Dorian','Autentificare','2025-05-30 22:36:30'),(7,1,'Nastac Dorian','Autentificare','2025-05-30 22:42:18'),(8,1,'Nastac Dorian','Delogare','2025-05-30 22:42:20'),(9,1,'Nastac Dorian','Autentificare','2025-05-31 09:48:45'),(10,1,'Nastac Dorian','Delogare','2025-05-31 09:48:48'),(11,34,'Mustaine Dave','Autentificare','2025-05-31 11:04:37'),(12,34,'Mustaine Dave','Creare programare la 2025-05-22 11:00:00 pentru vehicul IDV 33 și serviciu IDS 12','2025-05-31 11:05:54'),(13,34,'Mustaine Dave','Delogare','2025-05-31 11:05:58'),(14,34,'Mustaine Dave','Autentificare','2025-05-31 16:35:06'),(15,34,'Mustaine Dave','Creare programare la 2025-05-14 15:00:00 pentru vehicul IDV 33 și serviciu IDS 15','2025-05-31 16:35:22'),(16,34,'Mustaine Dave','Delogare','2025-05-31 16:36:04'),(17,53,'Chipciu Andrei','Autentificare','2025-05-31 17:07:34'),(18,53,'Chipciu Andrei','Creare programare la 2025-07-01 12:00:00 pentru vehicul IDV 34 și serviciu IDS 20','2025-05-31 17:08:36'),(19,53,'Chipciu Andrei','Delogare','2025-05-31 17:08:45'),(20,54,'Prodan Darian','Înregistrare cont nou','2025-05-31 17:26:17'),(21,1,'Nastac Dorian','Autentificare','2025-06-04 10:26:29'),(22,1,'Nastac Dorian','Delogare','2025-06-04 10:27:23'),(23,1,'Nastac Dorian','Autentificare','2025-06-04 11:16:25'),(24,1,'Nastac Dorian','Creare programare la 2025-06-04 13:30:00 pentru vehicul IDV 17 și serviciu IDS 25','2025-06-04 11:21:14'),(25,1,'Nastac Dorian','Delogare','2025-06-04 11:38:26'),(26,1,'Nastac Dorian','Autentificare','2025-06-04 20:35:51'),(27,1,'Nastac Dorian','Autentificare','2025-06-04 21:19:20'),(28,1,'Nastac Dorian','Delogare','2025-06-04 21:19:38'),(29,55,'Mircea Luis','Înregistrare cont nou','2025-06-04 21:21:12'),(30,56,'Birligea Daniel','Înregistrare cont nou','2025-06-04 21:22:14'),(31,56,'Birligea Daniel','Autentificare','2025-06-04 21:22:27'),(32,56,'Birligea Daniel','Creare programare la 2025-06-04 09:30:00 pentru vehicul IDV 35 și serviciu IDS 17','2025-06-04 21:24:11'),(33,56,'Birligea Daniel','Creare programare la 2025-05-05 16:00:00 pentru vehicul IDV 35 și serviciu IDS 19','2025-06-04 21:24:36'),(34,56,'Birligea Daniel','Delogare','2025-06-04 21:25:07'),(35,1,'Nastac Dorian','Autentificare','2025-06-05 08:31:50'),(36,1,'Nastac Dorian','Delogare','2025-06-05 08:32:16');
/*!40000 ALTER TABLE `IstoricClient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Lucrare`
--

DROP TABLE IF EXISTS `Lucrare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Lucrare` (
  `IDL` int NOT NULL AUTO_INCREMENT,
  `IDP` int NOT NULL,
  `IDA` int NOT NULL,
  `dataInitiala` datetime NOT NULL,
  `dataFinala` datetime DEFAULT NULL,
  `pret` decimal(10,2) DEFAULT NULL,
  `descriere` text,
  PRIMARY KEY (`IDL`),
  UNIQUE KEY `uc_lucrare_idp` (`IDP`),
  KEY `IDA` (`IDA`),
  CONSTRAINT `Lucrare_ibfk_1` FOREIGN KEY (`IDP`) REFERENCES `Programare` (`IDP`),
  CONSTRAINT `Lucrare_ibfk_2` FOREIGN KEY (`IDA`) REFERENCES `Atelier` (`IDA`)
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Lucrare`
--

LOCK TABLES `Lucrare` WRITE;
/*!40000 ALTER TABLE `Lucrare` DISABLE KEYS */;
INSERT INTO `Lucrare` VALUES (11,14,1,'2025-05-15 11:30:00','2025-05-15 13:30:00',1350.00,'o lucrare foarte usoara'),(12,18,2,'2025-05-15 08:30:00','2025-05-15 11:30:00',1000.00,'s-a schimbat foarte greu!!!'),(13,23,3,'2025-05-06 06:00:00','2025-05-06 06:40:00',300.00,'o lucrare realizata cu succes, fara batai de cap'),(24,25,1,'2025-05-20 11:00:00','2025-05-20 12:30:00',500.00,'Schimb bujii efectuat'),(25,26,2,'2025-05-21 12:00:00','2025-05-21 13:30:00',600.00,'Schimb lichid frână'),(212,27,1,'2025-05-21 12:00:00','2025-05-21 13:00:00',500.00,'.'),(213,15,1,'2025-05-15 11:30:00','2025-05-15 13:00:00',400.00,'Descriere'),(214,17,1,'2025-05-15 14:00:00','2025-05-15 16:00:00',440.00,'OK'),(215,161,1,'2025-05-20 10:00:00','2025-05-20 10:45:00',550.00,'...'),(216,22,1,'2025-05-06 09:30:00','2025-05-06 10:10:00',250.00,'lucrare mai veche'),(217,21,1,'2025-05-16 21:23:00','2025-05-16 22:53:00',1000.00,'efa'),(219,24,1,'2025-05-19 14:00:00','2025-05-19 15:30:00',1000.00,'lucrare grea!!'),(220,164,1,'2025-06-01 09:00:00','2025-06-01 10:00:00',150.00,'ok'),(221,167,3,'2025-06-01 12:00:00','2025-06-01 12:40:00',350.00,'ok'),(222,210,2,'2025-05-14 12:00:00','2025-05-14 14:00:00',400.00,'...'),(223,19,3,'2025-05-15 05:00:00','2025-05-15 05:40:00',330.00,'ok...'),(224,191,2,'2025-05-29 07:00:00','2025-05-29 08:40:00',450.00,'reparatie cu succes, usora'),(225,29,1,'2025-05-20 12:30:00','2025-05-20 14:00:00',1000.00,'schimbat piese necesare'),(226,163,1,'2025-05-21 09:00:00','2025-05-21 09:30:00',100.00,'diagnoza obd2\r\nerori pe egr'),(227,20,2,'2025-05-15 11:30:00','2025-05-15 13:30:00',500.00,'...'),(228,162,1,'2025-05-20 08:00:00','2025-05-20 08:45:00',700.00,'schimbat ulei si filtre'),(229,28,1,'2025-05-20 12:00:00','2025-05-20 13:30:00',1150.00,'.'),(230,206,1,'2025-05-22 08:00:00','2025-05-22 09:00:00',150.00,'bracaj realizat cu succes'),(231,190,2,'2025-05-27 19:30:00','2025-05-27 22:00:00',680.00,'.'),(232,192,2,'2025-05-29 14:30:00','2025-05-29 16:30:00',250.00,'\r\n'),(233,171,1,'2025-06-02 07:00:00','2025-06-02 07:45:00',550.00,'\r\n');
/*!40000 ALTER TABLE `Lucrare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MaterialePiese`
--

DROP TABLE IF EXISTS `MaterialePiese`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MaterialePiese` (
  `IDMat` int NOT NULL AUTO_INCREMENT,
  `denumire` varchar(100) NOT NULL,
  `pret` decimal(10,2) NOT NULL,
  `cantitate` decimal(10,2) DEFAULT '1.00',
  `IDS` int NOT NULL,
  PRIMARY KEY (`IDMat`),
  KEY `fk_materiale_serviciu` (`IDS`),
  CONSTRAINT `fk_materiale_serviciu` FOREIGN KEY (`IDS`) REFERENCES `Serviciu` (`IDS`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MaterialePiese`
--

LOCK TABLES `MaterialePiese` WRITE;
/*!40000 ALTER TABLE `MaterialePiese` DISABLE KEYS */;
INSERT INTO `MaterialePiese` VALUES (15,'Filtru ulei',40.00,1.00,11),(16,'Set reglaj roți',50.00,1.00,12),(17,'Plăcuțe frână față',180.00,1.00,13),(18,'Discuri frână',300.00,2.00,13),(19,'Scanner OBD',50.00,1.00,14),(20,'Curea alternator',120.00,1.00,15),(21,'Kit distribuție',700.00,1.00,16),(22,'Kit ambreiaj',950.00,1.00,17),(23,'Parbriz OEM',600.00,1.00,18),(24,'Freon R134a',100.00,0.50,19),(25,'Miez turbo',900.00,1.00,20),(26,'Kit garnituri turbo',100.00,1.00,20),(27,'Intinzator curea alternator',35.00,1.00,15),(28,'Set revizie',150.00,1.00,22),(29,'Bujii NGK',80.00,4.00,23),(30,'Lichid frână DOT4',50.00,1.00,24),(31,'Set reparatie injectoare',300.00,1.00,25),(33,'Furtun intercooler',350.00,1.00,20);
/*!40000 ALTER TABLE `MaterialePiese` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prog_Serv`
--

DROP TABLE IF EXISTS `Prog_Serv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Prog_Serv` (
  `IDP` int NOT NULL,
  `IDS` int NOT NULL,
  PRIMARY KEY (`IDP`,`IDS`),
  KEY `IDS` (`IDS`),
  CONSTRAINT `Prog_Serv_ibfk_1` FOREIGN KEY (`IDP`) REFERENCES `Programare` (`IDP`) ON DELETE CASCADE,
  CONSTRAINT `Prog_Serv_ibfk_2` FOREIGN KEY (`IDS`) REFERENCES `Serviciu` (`IDS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prog_Serv`
--

LOCK TABLES `Prog_Serv` WRITE;
/*!40000 ALTER TABLE `Prog_Serv` DISABLE KEYS */;
INSERT INTO `Prog_Serv` VALUES (161,11),(162,11),(169,11),(171,11),(164,12),(178,12),(181,12),(186,12),(202,12),(206,12),(209,12),(21,13),(165,13),(166,13),(191,13),(204,13),(163,14),(17,15),(20,15),(170,15),(174,15),(180,15),(192,15),(210,15),(172,16),(176,16),(182,16),(190,16),(203,16),(205,16),(18,17),(173,17),(177,17),(183,17),(201,17),(215,17),(217,17),(15,18),(216,18),(19,19),(22,19),(23,19),(167,19),(168,19),(185,19),(187,19),(218,19),(14,20),(175,20),(179,20),(184,20),(211,20),(212,21),(24,22),(28,22),(29,22),(188,22),(25,23),(208,23),(214,23),(26,24),(213,25);
/*!40000 ALTER TABLE `Prog_Serv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Programare`
--

DROP TABLE IF EXISTS `Programare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Programare` (
  `IDP` int NOT NULL AUTO_INCREMENT,
  `IDC` int NOT NULL,
  `IDV` int NOT NULL,
  `dataProg` datetime NOT NULL,
  `status` enum('Programat','In lucru','Finalizat','Anulat') DEFAULT 'Programat',
  PRIMARY KEY (`IDP`),
  KEY `IDC` (`IDC`),
  KEY `IDV` (`IDV`),
  CONSTRAINT `Programare_ibfk_1` FOREIGN KEY (`IDC`) REFERENCES `Client` (`IDC`),
  CONSTRAINT `Programare_ibfk_2` FOREIGN KEY (`IDV`) REFERENCES `Vehicul` (`IDV`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Programare`
--

LOCK TABLES `Programare` WRITE;
/*!40000 ALTER TABLE `Programare` DISABLE KEYS */;
INSERT INTO `Programare` VALUES (14,1,17,'2025-05-15 11:30:00','Finalizat'),(15,1,17,'2025-05-15 11:30:00','Finalizat'),(17,1,17,'2025-05-15 14:00:00','Finalizat'),(18,1,17,'2025-05-15 11:30:00','Finalizat'),(19,17,18,'2025-05-15 08:00:00','Finalizat'),(20,17,18,'2025-05-15 14:30:00','Finalizat'),(21,5,14,'2025-05-16 21:23:00','Finalizat'),(22,1,17,'2025-05-06 09:30:00','Finalizat'),(23,1,17,'2025-05-06 09:00:00','Finalizat'),(24,5,10,'2025-05-19 17:00:18','Finalizat'),(25,19,22,'2025-05-20 10:00:00','Finalizat'),(26,20,23,'2025-05-20 11:00:00','Finalizat'),(27,18,24,'2025-05-21 12:00:00','In lucru'),(28,21,25,'2025-05-20 15:00:00','Finalizat'),(29,21,25,'2025-05-20 15:30:00','Finalizat'),(161,19,22,'2025-05-20 10:00:00','Finalizat'),(162,20,23,'2025-05-20 11:00:00','Finalizat'),(163,18,24,'2025-05-21 12:00:00','Finalizat'),(164,5,4,'2025-06-01 12:00:00','Finalizat'),(165,7,6,'2025-06-01 13:00:00','Programat'),(166,8,7,'2025-06-01 14:00:00','Anulat'),(167,9,8,'2025-06-01 15:00:00','Finalizat'),(168,11,9,'2025-06-01 16:00:00','Programat'),(169,14,10,'2025-06-01 17:00:00','In lucru'),(170,17,11,'2025-06-02 09:00:00','Programat'),(171,18,12,'2025-06-02 10:00:00','Finalizat'),(172,19,13,'2025-06-02 11:00:00','In lucru'),(173,20,14,'2025-06-02 12:00:00','Programat'),(174,21,15,'2025-06-02 13:00:00','Programat'),(175,1,16,'2025-06-02 14:00:00','Programat'),(176,3,17,'2025-06-02 15:00:00','Programat'),(177,4,18,'2025-06-03 09:00:00','In lucru'),(178,5,19,'2025-06-03 10:00:00','Programat'),(179,7,20,'2025-06-03 11:00:00','Programat'),(180,8,21,'2025-06-03 12:00:00','Programat'),(181,9,22,'2025-06-03 13:00:00','Programat'),(182,11,23,'2025-06-03 14:00:00','Programat'),(183,14,24,'2025-06-03 15:00:00','Anulat'),(184,17,25,'2025-06-03 16:00:00','Programat'),(185,18,1,'2025-06-04 09:00:00','In lucru'),(186,19,2,'2025-06-04 10:00:00','Programat'),(187,20,3,'2025-06-04 11:00:00','Programat'),(188,21,4,'2025-06-04 12:00:00','Programat'),(190,8,20,'2025-05-27 22:30:00','Finalizat'),(191,1,16,'2025-05-29 10:00:00','Finalizat'),(192,1,17,'2025-05-29 17:30:00','Finalizat'),(201,20,14,'2025-06-19 10:00:00','Programat'),(202,14,12,'2025-06-16 14:00:00','Programat'),(203,17,15,'2025-06-17 12:00:00','Programat'),(204,19,18,'2025-06-18 14:00:00','Programat'),(205,1,32,'2025-05-30 11:00:00','Programat'),(206,34,33,'2025-05-22 11:00:00','Finalizat'),(208,36,23,'2025-07-30 16:31:00','Programat'),(209,32,31,'2025-07-08 12:00:00','Programat'),(210,34,33,'2025-05-14 15:00:00','Finalizat'),(211,53,34,'2025-07-01 12:00:00','Programat'),(212,19,15,'2025-06-30 10:00:00','Programat'),(213,1,17,'2025-06-04 13:30:00','Programat'),(214,11,10,'2025-07-05 21:17:00','Programat'),(215,8,6,'2025-07-01 21:00:00','Programat'),(216,5,10,'2025-06-25 21:17:00','Programat'),(217,56,35,'2025-06-04 09:30:00','Programat'),(218,56,35,'2025-05-05 16:00:00','Programat');
/*!40000 ALTER TABLE `Programare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Serviciu`
--

DROP TABLE IF EXISTS `Serviciu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Serviciu` (
  `IDS` int NOT NULL AUTO_INCREMENT,
  `nume` varchar(100) NOT NULL,
  `descriere` text,
  `durata_estimata` int DEFAULT NULL,
  `IDA` int NOT NULL,
  PRIMARY KEY (`IDS`),
  KEY `fk_serviciu_atelier` (`IDA`),
  CONSTRAINT `fk_serviciu_atelier` FOREIGN KEY (`IDA`) REFERENCES `Atelier` (`IDA`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Serviciu`
--

LOCK TABLES `Serviciu` WRITE;
/*!40000 ALTER TABLE `Serviciu` DISABLE KEYS */;
INSERT INTO `Serviciu` VALUES (11,'Schimb ulei','Schimbarea uleiului de motor și a filtrului',45,1),(12,'Geometrie roți','Reglarea unghiurilor roților',60,1),(13,'Reparație frâne','Înlocuire plăcuțe și discuri frână',100,2),(14,'Diagnoză computerizată','Scanare electronică a mașinii',30,1),(15,'Reparație alternator','Verificare și reparație alternator',120,2),(16,'Schimb distribuție','Înlocuire curea de distribuție și role',150,2),(17,'Schimb ambreiaj','Înlocuire kit ambreiaj complet',180,2),(18,'Înlocuire parbriz','Demontare și montare parbriz',90,3),(19,'Încărcare freon','Verificare și reumplere freon AC',40,3),(20,'Recondiționare turbo','Demontare, curățare și reparație turbo',200,3),(21,'Test Dyno','Testare a puterii (hp) si cuplului (Nm)',140,11),(22,'Revizie generală','Verificare completă a autovehiculului',90,1),(23,'Schimb bujii','Înlocuire bujii',45,2),(24,'Schimb lichid frână','Înlocuire completă lichid frână',60,3),(25,'Reconditionare Injectoare','Curatire si reparare injectoare',300,1);
/*!40000 ALTER TABLE `Serviciu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vehicul`
--

DROP TABLE IF EXISTS `Vehicul`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vehicul` (
  `IDV` int NOT NULL AUTO_INCREMENT,
  `serieSasiu` varchar(50) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `tip` varchar(50) DEFAULT NULL,
  `motor` varchar(50) DEFAULT NULL,
  `nrInmatriculare` varchar(20) NOT NULL,
  PRIMARY KEY (`IDV`),
  UNIQUE KEY `serieSasiu` (`serieSasiu`),
  UNIQUE KEY `nrInmatriculare` (`nrInmatriculare`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vehicul`
--

LOCK TABLES `Vehicul` WRITE;
/*!40000 ALTER TABLE `Vehicul` DISABLE KEYS */;
INSERT INTO `Vehicul` VALUES (1,'WVWZZZ1JZXW000001','Volkswagen','Golf','Hatchback','1.9 TDI','B-01-XYZ'),(2,'VF1BG1A0523654987','Renault','Megane','Sedan','1.5 dCi','B-02-XYZ'),(3,'WAUZZZ8K8AA000002','Audi','A4','Sedan','2.0 TDI','B-03-XYZ'),(4,'WDB2110221A000003','Mercedes','E-Class','Sedan','2.2 CDI','B-04-XYZ'),(6,'3VWFE21C04M000005','Volkswagen','Passat','Break','2.0 TDI','B-06-XYZ'),(7,'JN1AZ34D06M000006','Nissan','Juke','SUV','1.6','B-07-XYZ'),(8,'JHMEG85400S000007','Honda','Civic','Hatchback','1.8','B-08-XYZ'),(9,'VF3CRBHYBJJ000008','Peugeot','308','Break','1.6 HDi','B-09-XYZ'),(10,'W0L0XCE7574000009','Opel','Astra','Sedan','1.6','B-10-XYZ'),(11,'wdb203','Mercedes','c','amg','om646','GL16NAD'),(12,'reno1999','Renault','Laguna','w2','k9k','GL99ION'),(13,'234traqgq4222','Lexus','is','250','2500 v6','GL33LEX'),(14,'WDUNG45DHB222','Audi','A4','sedan','3.0 V6 TDI','VS11POP'),(15,'GRH34ATH','Dacia','Logan','Sedan','0.9 tce','B001LGN'),(16,'WD3335','Lincoln','Continental','Sedan','V8','GL98LIN'),(17,'WDB2345','Mercedes-Benz','E Class','Sedan','om648','GL17NAD'),(18,'GKDH000DH4F','BMW','302d','Sedan','n47','B507BMW'),(19,'A230FFHFIATDOBLOITALIA','Fiat','Doblo','Van','1.3 multijet','GL77FIA'),(20,'ert41ygq','dacia','logan','sedan','16 16valve','GL16VAL'),(21,'235','4623','346ggg','463','346','63463qa'),(22,'WVWZZZ12345678901','Volkswagen','Golf','Hatchback','1.6 TDI','B-22-XYZ'),(23,'VF1ABC12345678902','Renault','Clio','Sedan','1.5 dCi','B-23-XYZ'),(24,'WAUZZZ8K8BB000003','Audi','A6','Sedan','2.0 TDI','B-24-XYZ'),(25,'WHDY4467BB','Lancia','Delta','Hatchback','2.0 turbo','VS44VAL'),(30,'FORD445522F150Raptor','Ford','F150','Truck','5.0 coyote','GL01FRD'),(31,'DOD444GECHRG000','Dodge','Charger','Coupe','Big block HEMI','B577HMI'),(32,'A231FFHFIATDOBLOITALIA','Fiat','Doblo','Van','1.3 multijet','GL89NAD'),(33,'MERC6200V8UFJSON','Mercedes','S-class','Limuzina','6.2 V8','B356MGD'),(34,'G3GQ34Y35423ARG','Ferrari','528','speedster','v8','B664CHP'),(35,'FIAT347T384HJ500','Fiat','500','hatchback','1.2 mpi','BR34BBB');
/*!40000 ALTER TABLE `Vehicul` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-05 14:15:44

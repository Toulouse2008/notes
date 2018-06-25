-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: music
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `album` (
  `artist_id` smallint(5) NOT NULL DEFAULT '0',
  `album_id` smallint(4) NOT NULL DEFAULT '0',
  `album_name` char(128) DEFAULT NULL,
  PRIMARY KEY (`artist_id`,`album_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `album`
--

LOCK TABLES `album` WRITE;
/*!40000 ALTER TABLE `album` DISABLE KEYS */;
INSERT INTO `album` VALUES (1,1,'Retro - John McCready FAN'),(1,2,'Substance (Disc 2)'),(1,3,'Retro - Miranda Sawyer POP'),(1,4,'Retro - New Order / Bobby Gillespie LIVE'),(1,5,'Power, Corruption & Lies'),(1,6,'Substance 1987 (Disc 1)'),(1,7,'Brotherhood'),(2,1,'Let Love In'),(3,1,'Live Around The World'),(3,2,'In A Silent Way'),(4,1,'Exile On Main Street'),(5,1,'Second Coming'),(6,1,'Light Years');
/*!40000 ALTER TABLE `album` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `art4`
--

DROP TABLE IF EXISTS `art4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `art4` (
  `artist_id` smallint(5) NOT NULL DEFAULT '0',
  `album_id` smallint(4) NOT NULL DEFAULT '0',
  `track_id` smallint(3) NOT NULL DEFAULT '0',
  `sequence_id` smallint(3) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `art4`
--

LOCK TABLES `art4` WRITE;
/*!40000 ALTER TABLE `art4` DISABLE KEYS */;
/*!40000 ALTER TABLE `art4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `artist` (
  `artist_id` smallint(5) NOT NULL DEFAULT '0',
  `artist_name` char(128) DEFAULT NULL,
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'New Order'),(2,'Nick Cave & The Bad Seeds'),(3,'Miles Davis'),(4,'The Rolling Stones'),(5,'The Stone Roses'),(6,'Kylie Minogue'),(7,'Barry Adamson'),(8,'Erric error'),(9,'Bitten Bite');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engineer`
--

DROP TABLE IF EXISTS `engineer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `engineer` (
  `engineer_id` smallint(4) NOT NULL DEFAULT '0',
  `engineer_name` char(128) DEFAULT NULL,
  `years` smallint(3) DEFAULT '0',
  PRIMARY KEY (`engineer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engineer`
--

LOCK TABLES `engineer` WRITE;
/*!40000 ALTER TABLE `engineer` DISABLE KEYS */;
INSERT INTO `engineer` VALUES (1,'George Martin',40),(2,'Eddie Kramer',38),(3,'Jeff Jarratt',40),(4,'Ed Stasium',25);
/*!40000 ALTER TABLE `engineer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `played`
--

DROP TABLE IF EXISTS `played`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `played` (
  `artist_id` smallint(5) NOT NULL DEFAULT '0',
  `album_id` smallint(4) NOT NULL DEFAULT '0',
  `track_id` smallint(3) NOT NULL DEFAULT '0',
  `played` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`artist_id`,`album_id`,`track_id`,`played`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `played`
--

LOCK TABLES `played` WRITE;
/*!40000 ALTER TABLE `played` DISABLE KEYS */;
INSERT INTO `played` VALUES (1,3,0,'2006-08-14 14:21:03'),(1,3,1,'2006-08-14 14:25:22'),(1,3,2,'2006-08-14 14:30:25'),(1,3,3,'2006-08-14 14:36:54'),(1,3,4,'2006-08-14 14:41:43'),(1,3,5,'2006-08-14 14:43:37'),(1,3,6,'2006-08-14 14:47:21'),(1,3,7,'2006-08-14 14:54:02'),(3,1,0,'2006-08-15 18:00:03'),(3,1,1,'2006-08-15 18:26:12'),(3,1,2,'2006-08-15 18:33:57'),(7,1,1,'2018-02-02 18:14:26');
/*!40000 ALTER TABLE `played` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producer`
--

DROP TABLE IF EXISTS `producer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producer` (
  `producer_id` smallint(4) NOT NULL DEFAULT '0',
  `producer_name` char(128) DEFAULT NULL,
  `years` smallint(3) DEFAULT '0',
  PRIMARY KEY (`producer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producer`
--

LOCK TABLES `producer` WRITE;
/*!40000 ALTER TABLE `producer` DISABLE KEYS */;
INSERT INTO `producer` VALUES (1,'Phil Spector',36),(2,'George Martin',40),(3,'Tina Weymouth',20),(4,'Chris Frantz',20),(5,'Ed Kuepper',15);
/*!40000 ALTER TABLE `producer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shuffle`
--

DROP TABLE IF EXISTS `shuffle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shuffle` (
  `artist_id` smallint(5) NOT NULL DEFAULT '0',
  `album_id` smallint(4) NOT NULL DEFAULT '0',
  `track_id` smallint(3) NOT NULL DEFAULT '0',
  `sequence_id` smallint(3) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sequence_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shuffle`
--

LOCK TABLES `shuffle` WRITE;
/*!40000 ALTER TABLE `shuffle` DISABLE KEYS */;
/*!40000 ALTER TABLE `shuffle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `id` int(5) DEFAULT NULL,
  `name` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'asf'),(2,'wer'),(3,'iou');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `track`
--

DROP TABLE IF EXISTS `track`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `track` (
  `track_id` smallint(3) NOT NULL DEFAULT '0',
  `track_name` char(128) DEFAULT NULL,
  `artist_id` smallint(5) NOT NULL DEFAULT '0',
  `album_id` smallint(4) NOT NULL DEFAULT '0',
  `time` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`artist_id`,`album_id`,`track_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `track`
--

LOCK TABLES `track` WRITE;
/*!40000 ALTER TABLE `track` DISABLE KEYS */;
INSERT INTO `track` VALUES (0,'Elegia',1,1,4.93),(1,'In A Lonely Place',1,1,6.26),(2,'Procession',1,1,4.47),(3,'Your Silent Face',1,1,5.99),(4,'Sunrise',1,1,6.01),(5,'Let\'s Go',1,1,3.90),(6,'Broken Promise',1,1,3.76),(7,'Dreams Never End',1,1,3.20),(8,'Cries And Whispers',1,1,3.42),(9,'All Day Long',1,1,5.18),(10,'Sooner Than You Think',1,1,5.21),(11,'Leave Me Alone',1,1,4.67),(12,'Lonesome Tonight',1,1,5.19),(13,'Every Little Counts',1,1,4.47),(14,'Run Wild',1,1,3.95),(0,'In A Lonely Place',1,2,6.30),(1,'Procession',1,2,4.46),(2,'Mesh',1,2,3.44),(3,'Hurt',1,2,6.98),(4,'The Beach',1,2,7.32),(5,'Confusion',1,2,7.64),(6,'Lonesome Tonight',1,2,5.20),(7,'Murder',1,2,3.93),(8,'Thieves Like Us',1,2,6.95),(9,'Kiss Of Death',1,2,7.05),(10,'Shame Of The Nation',1,2,7.91),(11,'1963',1,2,5.63),(0,'Fine Time',1,3,4.71),(1,'Temptation',1,3,8.71),(2,'True Faith',1,3,5.88),(3,'The Perfect Kiss',1,3,4.83),(4,'Ceremony',1,3,4.41),(5,'Regret',1,3,4.14),(6,'Crystal',1,3,6.83),(7,'Bizarre Love Triangle',1,3,4.35),(8,'Confusion',1,3,8.22),(9,'Round And Round',1,3,4.52),(10,'Blue Monday',1,3,7.48),(11,'Brutal',1,3,4.83),(12,'Slow Jam',1,3,4.88),(13,'Everyone Everywhere',1,3,4.43),(0,'Ceremony [Studio 54, Barcelona 7/7/84]',1,4,4.82),(1,'Procession [Polytechnic of Central London, London 6/12/85]',1,4,3.57),(2,'Everything\'s Gone Green [Tolworth Recreation Centre, London 12/3/85]',1,4,5.25),(3,'In A Lonely Place [Glastonbury Festival 20/6/81]',1,4,5.55),(4,'Age Of Consent [Spectrum Arena, Warrington 1/3/86]',1,4,5.04),(5,'Elegia [Glastonbury Festival 19/6/87]',1,4,4.77),(6,'The Perfect Kiss [Glastonbury Festival 19/6/87]',1,4,9.73),(7,'Fine Time [Popular Creek Music Theatre, Chicago 30/6/89]',1,4,5.04),(8,'World [Starplex Amphitheatre, Dallas 21/7/93]',1,4,4.81),(9,'Regret [Reading Festival 29/8/93]',1,4,4.03),(10,'As It Is When It Was [Reading Festival 29/8/93]',1,4,3.80),(11,'Intermission By Alan Wise [Olympia, Paris 12/11/01]',1,4,1.34),(12,'Crystal [Big Day Out, Gold Coast 20/1/02]',1,4,6.86),(13,'Turn My Way [Olympia, Liverpool 18/7/01]',1,4,4.96),(14,'Temptation [Big Day Out, Gold Coast 20/1/02]',1,4,7.79),(0,'Age Of Consent',1,5,5.26),(1,'We All Stand',1,5,5.24),(2,'The Village',1,5,4.62),(3,'5 8 6',1,5,7.52),(4,'Your Silent Face',1,5,6.00),(5,'Ultraviolence',1,5,4.87),(6,'Ecstasy',1,5,4.42),(7,'Leave Me Alone',1,5,4.69),(0,'Ceremony',1,6,4.42),(1,'Everything\'s Gone Green',1,6,5.51),(2,'Temptation',1,6,6.99),(3,'Blue Monday',1,6,7.49),(4,'Confusion',1,6,4.72),(5,'Thieves Like Us',1,6,6.61),(6,'Perfect Kiss',1,6,8.04),(7,'Subculture',1,6,4.80),(8,'Shellshock',1,6,6.48),(9,'State of the Nation',1,6,6.54),(10,'Bizarre Love Triangle',1,6,6.74),(11,'True Faith',1,6,5.93),(0,'State of the Nation',1,7,6.56),(1,'Every Little Counts',1,7,4.48),(2,'Angel Dust',1,7,3.73),(3,'All Day Long',1,7,5.21),(4,'Bizarre Love Triangle',1,7,4.37),(5,'Way of Life',1,7,4.11),(6,'Broken Promise',1,7,3.80),(7,'As It Is When It Was',1,7,3.77),(8,'Weirdo',1,7,3.89),(9,'Paradise',1,7,3.86),(0,'Do You Love Me?',2,1,5.95),(1,'Nobody\'s Baby Now',2,1,3.87),(2,'Loverman',2,1,6.37),(3,'Jangling Jack',2,1,2.78),(4,'Red Right Hand',2,1,6.18),(5,'I Let Love In',2,1,4.25),(6,'Thirsty Dog',2,1,3.81),(7,'Ain\'t Gonna Rain Anymore',2,1,3.77),(8,'Lay Me Low',2,1,5.15),(9,'Do You Love Me? (Part Two)',2,1,6.23),(0,'In A Silent Way',3,1,1.81),(1,'Intruder',3,1,4.87),(2,'New Blues',3,1,5.58),(3,'Human Nature',3,1,12.80),(4,'Mr. Pastorius',3,1,3.54),(5,'Amandla',3,1,5.87),(6,'Wrinkle',3,1,7.28),(7,'Tutu',3,1,8.89),(8,'Full Nelson',3,1,2.81),(9,'Time After Time',3,1,9.98),(10,'Hannibal',3,1,7.37),(0,'Shhh/Peaceful',3,2,16.67),(1,'In A Silent Way/It\'s About That Time',3,2,16.67),(0,'Rocks Off',4,1,4.54),(1,'Rip This Joint',4,1,2.38),(2,'Shake Your Hips',4,1,3.00),(3,'Casino Boogie',4,1,3.57),(4,'Tumbling Dice',4,1,3.79),(5,'Sweet Virginia',4,1,4.44),(6,'Torn & Frayed',4,1,4.30),(7,'Sweet Black Angel',4,1,2.97),(8,'Loving Cup',4,1,4.43),(9,'Happy',4,1,3.08),(10,'Turd On The Run',4,1,2.64),(11,'Ventilator Blues',4,1,3.40),(12,'I Just Want To See His Face',4,1,2.90),(13,'Let It Loose',4,1,5.31),(14,'All Down The Line',4,1,3.84),(15,'Stop Breaking Down',4,1,4.57),(16,'Shine A Light',4,1,4.28),(17,'Soul Survivor',4,1,3.82),(0,'Breaking Into Heaven',5,1,11.37),(1,'Driving South',5,1,5.17),(2,'Ten Storey Love Song',5,1,4.50),(3,'Daybreak',5,1,6.56),(4,'Your Star Will Shine',5,1,2.99),(5,'Straight To The Man',5,1,3.26),(6,'Begging You',5,1,4.94),(7,'Tightrope',5,1,4.45),(8,'Good Times',5,1,5.67),(9,'Tears',5,1,6.84),(10,'How Do You Sleep',5,1,4.99),(11,'Love Spreads',5,1,5.79),(12,'Untitled',5,1,6.43),(0,'Spinning Around',6,1,3.46),(1,'On A Night Like This',6,1,3.55),(2,'So Now Goodbye',6,1,3.62),(3,'Disco Down',6,1,3.96),(4,'Loveboat',6,1,4.18),(5,'Koocachoo',6,1,4.00),(6,'Your Disco Needs You',6,1,3.56),(7,'Please Stay',6,1,4.14),(8,'Bittersweet Goodbye',6,1,3.72),(9,'Butterfly',6,1,4.16),(10,'Under The Influence Of Love',6,1,3.40),(11,'I\'m So High',6,1,3.55),(12,'Kids',6,1,4.34);
/*!40000 ALTER TABLE `track` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-02-04 12:00:13

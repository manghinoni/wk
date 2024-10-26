/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.5.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: wk
-- ------------------------------------------------------
-- Server version	11.5.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Current Database: `wk`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `wk` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;

USE `wk`;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cidade` varchar(30) DEFAULT NULL,
  `uf` char(2) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES
(1,'Marco','Curitiba','PR'),
(2,'Pedro','Curitiba','PR'),
(3,'Joao','Sao Paulo','SP'),
(4,'Marcelo','Sao Paulo','SP'),
(5,'Wagner','Sao Paulo','SP'),
(6,'Evary','Sao Paulo','SP'),
(7,'Dirceu','Sao Paulo','SP'),
(8,'Fernanda','Sao Paulo','SP'),
(9,'Ana','Sao Paulo','SP'),
(10,'Fabio','Sao Paulo','SP'),
(11,'Lunay','Sao Paulo','SP'),
(12,'Hassan','Sao Paulo','SP'),
(13,'Yuri','Sao Paulo','SP'),
(14,'Tania','Sao Paulo','SP'),
(15,'Scooby','Sao Paulo','SP'),
(16,'Tico','Sao Paulo','SP'),
(17,'Benji','Sao Paulo','SP'),
(18,'Freddy','Sao Paulo','SP'),
(19,'Barney','Sao Paulo','SP'),
(20,'Ze','Sao Paulo','SP');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pedido` (
  `numero` int(11) NOT NULL AUTO_INCREMENT,
  `emissao` date NOT NULL,
  `codcliente` int(11) NOT NULL,
  `total` float NOT NULL,
  PRIMARY KEY (`numero`),
  KEY `pedido_cliente_FK` (`codcliente`),
  CONSTRAINT `pedido_cliente_FK` FOREIGN KEY (`codcliente`) REFERENCES `cliente` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES
(1,'2024-10-26',2,876),
(3,'2024-10-26',3,5),
(4,'2024-10-26',5,46.4),
(6,'2024-10-26',16,256);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produto` (
  `codigo` int(11) NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `preco` float NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES
(1,'Batata',5),
(2,'Feijao',10),
(3,'Arroz',8),
(4,'Tomate',10.5),
(5,'Cebola',9.28),
(6,'Macarrao',5.6),
(7,'Queijo',49.9),
(8,'Presunto',29.56),
(9,'Pao Frances',10.98),
(10,'Detergente',3.22),
(11,'Esponja',5.7),
(12,'Sabao em Po',32.99),
(13,'Sabao Liquido',23),
(14,'Papel Higienico',11.98),
(15,'Shampoo',22),
(16,'Condicionador',33),
(17,'Sabonete',3.49),
(18,'Frango',11.09),
(19,'Picanha',59.9),
(20,'Molho Tomate',2.98);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtopedido`
--

DROP TABLE IF EXISTS `produtopedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produtopedido` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numeropedido` int(11) NOT NULL,
  `codproduto` int(11) NOT NULL,
  `quantidade` float NOT NULL,
  `valorunitario` float NOT NULL,
  `valortotal` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `produtopedido_pedido_FK` (`numeropedido`),
  KEY `produtopedido_produto_FK` (`codproduto`),
  CONSTRAINT `produtopedido_pedido_FK` FOREIGN KEY (`numeropedido`) REFERENCES `pedido` (`numero`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `produtopedido_produto_FK` FOREIGN KEY (`codproduto`) REFERENCES `produto` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtopedido`
--

LOCK TABLES `produtopedido` WRITE;
/*!40000 ALTER TABLE `produtopedido` DISABLE KEYS */;
INSERT INTO `produtopedido` VALUES
(27,1,1,4,6,24),
(28,1,2,78,10,780),
(29,1,3,9,8,72),
(30,3,1,1,5,5),
(31,4,5,5,9.28,46.4),
(33,6,16,16,16,256);
/*!40000 ALTER TABLE `produtopedido` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2024-10-26 11:38:34

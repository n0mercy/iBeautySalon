CREATE DATABASE  IF NOT EXISTS `ibeautysalon` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `ibeautysalon`;
-- MySQL dump 10.13  Distrib 5.6.24, for Win32 (x86)
--
-- Host: localhost    Database: ibeautysalon
-- ------------------------------------------------------
-- Server version	5.6.27-log

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
-- Table structure for table `bairro`
--

DROP TABLE IF EXISTS `bairro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bairro` (
  `bai_codigo` int(1) NOT NULL AUTO_INCREMENT,
  `bai_nome` varchar(80) NOT NULL,
  `bai_zona_cod` int(1) NOT NULL,
  PRIMARY KEY (`bai_codigo`),
  UNIQUE KEY `bai_nome` (`bai_nome`),
  KEY `bai_zona_cod` (`bai_zona_cod`),
  CONSTRAINT `bairro_ibfk_1` FOREIGN KEY (`bai_zona_cod`) REFERENCES `zona` (`zona_cod`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bairro`
--

LOCK TABLES `bairro` WRITE;
/*!40000 ALTER TABLE `bairro` DISABLE KEYS */;
INSERT INTO `bairro` VALUES (1,'Adrianópolis',5),(2,'Aleixo',5),(3,'Alvorada',6),(4,'Armando Mendes',3),(5,'Betânia',2),(6,'Cachoeirinha',2),(7,'Centro',2),(8,'Chapada',5),(9,'Cidade de Deus',1),(10,'Cidade Nova',1),(11,'Colônia Antônio Aleixo',3),(12,'Colônia Oliveira Machado',2),(13,'Colônia Santo Antônio',1),(14,'Colônia Terra Nova',1),(15,'Compensa',4),(16,'Coroado',3),(17,'Crespo',2),(18,'Da Paz',6),(19,'Distrito Industrial I',6),(20,'Distrito Industrial II',3),(21,'Dom Pedro I',6),(22,'Educandos',2),(23,'Flores',5),(24,'Gilberto Mestrinho',3),(25,'Glória',4),(26,'Japiim',2),(28,'Lago Azul',1),(29,'Jorge Teixeira',3),(31,'Lírio do Vale',4),(32,'Mauazinho',3),(33,'Monte das Oliveiras',1),(34,'Morro da Liberadade',2),(35,'Nossa Senhora Aparecida',2),(36,'Nossa Senhora das Graças',5),(37,'Nova Cidade',1),(38,'Nova Esperança',4),(39,'Novo Aleixo',1),(40,'Novo Israel',1),(41,'Parque 10 de Novembro',5),(42,'Petrópolis',2),(43,'Planalto',6),(44,'Ponta Negra',4),(45,'Praça 14 de Janeiro',2),(46,'Presidente Vargas',2),(47,'Puraquequara',3),(48,'Raiz',2),(49,'Redenção',6),(50,'Santa Etelvina',1),(51,'Santa Luzia',2),(52,'Santo Agostinho',4),(53,'Santo Antônio',4),(54,'São Francisco',2),(55,'São Geraldo',5),(56,'São Jorge',4),(57,'São José Operário',3),(58,'São Lázaro',2),(59,'São Raimundo',4),(60,'Tancredo Neves',3),(61,'Tarumã',4),(62,'Tarumã-Açu',4),(63,'Vila Buriti',2),(64,'Vila da Prata',4),(65,'Zumbi dos Palmares',3);
/*!40000 ALTER TABLE `bairro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cep`
--

DROP TABLE IF EXISTS `cep`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cep` (
  `cep_cep` varchar(8) NOT NULL,
  `cep_rua` varchar(100) NOT NULL,
  `cep_bai_codigo` int(1) NOT NULL,
  PRIMARY KEY (`cep_cep`),
  KEY `cep_bai_codigo` (`cep_bai_codigo`),
  CONSTRAINT `cep_ibfk_1` FOREIGN KEY (`cep_bai_codigo`) REFERENCES `bairro` (`bai_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cep`
--

LOCK TABLES `cep` WRITE;
/*!40000 ALTER TABLE `cep` DISABLE KEYS */;
INSERT INTO `cep` VALUES ('69010050',' Rua Barroso',7),('69020375','Beco Rio Branco',3),('69030050','Danilo de Matos Areosa',8),('69030051','Danilo de Matos Areosa 2',8),('69030052','Danilo de Matos Areosa 3',8),('69030260','Rua Alberto de Oliveira (Cj Ipase)',7),('69038250','Rua Pindaí',4),('69043040','Rua Professora Maria T. Monteiro',1),('69043380','Rua Raimundo Nonato (Cj Flores II)',5),('69050160','Rua Wilson Castro (Cj Eldorado)',6),('69055660','Rua Álvaro Braga',8),('69057250','Rua São Luiz',5),('69057290','Rua Tavares Teixeira (Cj Celetramazon)',5),('69060260','Rua Oscarito (Cj Jd Paulista)',9),('69060332','Beco Allium',2),('69070210',' Rua Inacio Guimaraes',22);
/*!40000 ALTER TABLE `cep` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente_usuario`
--

DROP TABLE IF EXISTS `cliente_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cliente_usuario` (
  `cli_cpf` varchar(14) NOT NULL,
  `cli_nome` varchar(80) NOT NULL,
  `cli_dtnasc` date DEFAULT NULL,
  `cli_usu_codigo` int(1) DEFAULT NULL,
  PRIMARY KEY (`cli_cpf`),
  KEY `cli_usu_codigo` (`cli_usu_codigo`),
  CONSTRAINT `cliente_usuario_ibfk_1` FOREIGN KEY (`cli_usu_codigo`) REFERENCES `usuario` (`usu_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente_usuario`
--

LOCK TABLES `cliente_usuario` WRITE;
/*!40000 ALTER TABLE `cliente_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `cliente_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cupom`
--

DROP TABLE IF EXISTS `cupom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cupom` (
  `cupom_codigo` int(1) NOT NULL AUTO_INCREMENT,
  `cupom_status` varchar(10) DEFAULT NULL,
  `cupom_data` date NOT NULL,
  `cupom_dtvalidade` date DEFAULT NULL,
  `cupom_clicpf` varchar(14) DEFAULT NULL,
  `cupom_pag_codigo` int(1) DEFAULT NULL,
  PRIMARY KEY (`cupom_codigo`),
  KEY `cupom_clicpf` (`cupom_clicpf`),
  KEY `cupom_pag_codigo` (`cupom_pag_codigo`),
  CONSTRAINT `cupom_ibfk_1` FOREIGN KEY (`cupom_clicpf`) REFERENCES `cliente_usuario` (`cli_cpf`),
  CONSTRAINT `cupom_ibfk_2` FOREIGN KEY (`cupom_pag_codigo`) REFERENCES `pagamento` (`pag_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cupom`
--

LOCK TABLES `cupom` WRITE;
/*!40000 ALTER TABLE `cupom` DISABLE KEYS */;
/*!40000 ALTER TABLE `cupom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa_usuario`
--

DROP TABLE IF EXISTS `empresa_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empresa_usuario` (
  `emp_cnpj` varchar(18) NOT NULL,
  `emp_razao` varchar(80) DEFAULT NULL,
  `emp_insc_estadual` varchar(9) DEFAULT NULL,
  `emp_usu_codigo` int(1) DEFAULT NULL,
  PRIMARY KEY (`emp_cnpj`),
  UNIQUE KEY `emp_insc_estadual` (`emp_insc_estadual`),
  KEY `emp_usu_codigo` (`emp_usu_codigo`),
  CONSTRAINT `empresa_usuario_ibfk_1` FOREIGN KEY (`emp_usu_codigo`) REFERENCES `usuario` (`usu_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa_usuario`
--

LOCK TABLES `empresa_usuario` WRITE;
/*!40000 ALTER TABLE `empresa_usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `empresa_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `endereco`
--

DROP TABLE IF EXISTS `endereco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `endereco` (
  `end_codigo` int(1) NOT NULL AUTO_INCREMENT,
  `end_ref` varchar(80) DEFAULT NULL,
  `end_num` varchar(6) DEFAULT NULL,
  `end_cep` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`end_codigo`),
  KEY `end_cep` (`end_cep`),
  CONSTRAINT `endereco_ibfk_1` FOREIGN KEY (`end_cep`) REFERENCES `cep` (`cep_cep`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `endereco`
--

LOCK TABLES `endereco` WRITE;
/*!40000 ALTER TABLE `endereco` DISABLE KEYS */;
INSERT INTO `endereco` VALUES (1,'proximo ao posto de saúde','423','69057250'),(2,'proximo casa doberman','932','69057290'),(3,'proximo ao supermercado db','321','69043040'),(4,'Ao lado da casa de saude','45','69060260'),(5,'Proximo ao DB Ponta Negra 2','777','69055660'),(6,'proximo ao campo futebol','576','69038250'),(8,'em frente ao corpo de bombeiros','1010','69055660'),(9,'Loja da Rai','65','69055660'),(10,'Proximo ao DB','777','69057290'),(11,'Dota Always','777','69030052'),(12,'PrÃ³ximo ao Shopping do Alchmist','777','69057290'),(13,'Loja da Rai','777','69057290'),(14,'Loja da Rai','777','69055660'),(15,'gf','234','69057290'),(16,'23456','12345','69057290'),(17,'dfghj','234','69055660'),(18,'asdasd','21313','69057290'),(19,'Loja da Rai','777','69038250'),(20,'DB Ponta Negra','777','69055660');
/*!40000 ALTER TABLE `endereco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fones`
--

DROP TABLE IF EXISTS `fones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fones` (
  `fone_usu_codigo` int(1) NOT NULL DEFAULT '0',
  `fon_fones` varchar(20) NOT NULL,
  PRIMARY KEY (`fone_usu_codigo`,`fon_fones`),
  CONSTRAINT `fones_ibfk_1` FOREIGN KEY (`fone_usu_codigo`) REFERENCES `usuario` (`usu_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fones`
--

LOCK TABLES `fones` WRITE;
/*!40000 ALTER TABLE `fones` DISABLE KEYS */;
/*!40000 ALTER TABLE `fones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcionario`
--

DROP TABLE IF EXISTS `funcionario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `funcionario` (
  `fun_matricula` int(1) NOT NULL AUTO_INCREMENT,
  `fun_nome` varchar(80) NOT NULL,
  `fun_emp_cnpj` varchar(18) DEFAULT NULL,
  `fun_status` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`fun_matricula`),
  KEY `fun_emp_cnpj` (`fun_emp_cnpj`),
  CONSTRAINT `funcionario_ibfk_1` FOREIGN KEY (`fun_emp_cnpj`) REFERENCES `empresa_usuario` (`emp_cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcionario`
--

LOCK TABLES `funcionario` WRITE;
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itemservico`
--

DROP TABLE IF EXISTS `itemservico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemservico` (
  `itemserv_codigo` int(1) NOT NULL AUTO_INCREMENT,
  `itemserv_data` date DEFAULT NULL,
  `itemserv_ofe_codigo` int(1) DEFAULT NULL,
  `itemserv_cupom_codigo` int(1) DEFAULT NULL,
  `itemserv_func_codigo` int(1) DEFAULT NULL,
  PRIMARY KEY (`itemserv_codigo`),
  KEY `itemserv_ofe_cod` (`itemserv_ofe_codigo`),
  KEY `itemserv_cupom_cod` (`itemserv_cupom_codigo`),
  KEY `itemserv_func_cod` (`itemserv_func_codigo`),
  CONSTRAINT `itemservico_ibfk_1` FOREIGN KEY (`itemserv_ofe_codigo`) REFERENCES `oferece` (`ofe_codigo`),
  CONSTRAINT `itemservico_ibfk_2` FOREIGN KEY (`itemserv_cupom_codigo`) REFERENCES `cupom` (`cupom_codigo`),
  CONSTRAINT `itemservico_ibfk_3` FOREIGN KEY (`itemserv_func_codigo`) REFERENCES `funcionario` (`fun_matricula`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itemservico`
--

LOCK TABLES `itemservico` WRITE;
/*!40000 ALTER TABLE `itemservico` DISABLE KEYS */;
/*!40000 ALTER TABLE `itemservico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oferece`
--

DROP TABLE IF EXISTS `oferece`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oferece` (
  `ofe_codigo` int(1) NOT NULL AUTO_INCREMENT,
  `ofe_status` varchar(10) DEFAULT NULL,
  `ofe_valor` decimal(10,2) NOT NULL,
  `ofe_emp_cnpj` varchar(18) DEFAULT NULL,
  `ofe_serv_codigo` int(1) DEFAULT NULL,
  PRIMARY KEY (`ofe_codigo`),
  KEY `ofe_emp_cnpj` (`ofe_emp_cnpj`),
  KEY `ofe_serv_codigo` (`ofe_serv_codigo`),
  CONSTRAINT `oferece_ibfk_1` FOREIGN KEY (`ofe_emp_cnpj`) REFERENCES `empresa_usuario` (`emp_cnpj`),
  CONSTRAINT `oferece_ibfk_2` FOREIGN KEY (`ofe_serv_codigo`) REFERENCES `servico` (`serv_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oferece`
--

LOCK TABLES `oferece` WRITE;
/*!40000 ALTER TABLE `oferece` DISABLE KEYS */;
/*!40000 ALTER TABLE `oferece` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pagamento` (
  `pag_codigo` int(1) NOT NULL AUTO_INCREMENT,
  `pag_desc` varchar(15) NOT NULL,
  PRIMARY KEY (`pag_codigo`),
  UNIQUE KEY `pag_desc` (`pag_desc`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagamento`
--

LOCK TABLES `pagamento` WRITE;
/*!40000 ALTER TABLE `pagamento` DISABLE KEYS */;
INSERT INTO `pagamento` VALUES (2,'Crédito'),(1,'Débito');
/*!40000 ALTER TABLE `pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `realiza`
--

DROP TABLE IF EXISTS `realiza`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `realiza` (
  `real_codigo` int(1) NOT NULL AUTO_INCREMENT,
  `real_datapag` date DEFAULT NULL,
  `real_valor` decimal(10,2) NOT NULL,
  `real_dtVenc` date DEFAULT NULL,
  `real_status` varchar(10) NOT NULL,
  `real_pag_codigo` int(1) DEFAULT NULL,
  `real_emp_cnpj` varchar(18) DEFAULT NULL,
  PRIMARY KEY (`real_codigo`),
  KEY `real_pag_codigo` (`real_pag_codigo`),
  KEY `real_emp_cnpj` (`real_emp_cnpj`),
  CONSTRAINT `realiza_ibfk_1` FOREIGN KEY (`real_pag_codigo`) REFERENCES `pagamento` (`pag_codigo`),
  CONSTRAINT `realiza_ibfk_2` FOREIGN KEY (`real_emp_cnpj`) REFERENCES `empresa_usuario` (`emp_cnpj`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `realiza`
--

LOCK TABLES `realiza` WRITE;
/*!40000 ALTER TABLE `realiza` DISABLE KEYS */;
/*!40000 ALTER TABLE `realiza` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servico`
--

DROP TABLE IF EXISTS `servico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servico` (
  `serv_codigo` int(1) NOT NULL AUTO_INCREMENT,
  `serv_desc` varchar(60) NOT NULL,
  `serv_status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`serv_codigo`),
  UNIQUE KEY `serv_desc` (`serv_desc`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico`
--

LOCK TABLES `servico` WRITE;
/*!40000 ALTER TABLE `servico` DISABLE KEYS */;
INSERT INTO `servico` VALUES (4,'Pedicure','Ativo'),(5,'Manicure','Ativo'),(6,'Chapinha','Ativo'),(7,'Escova','Ativo'),(8,'Escova+Chapinha','Ativo'),(9,'Manicure+Pedicure','Ativo'),(10,'Limpeza de Pele','Ativo'),(11,'Maquiagem','Ativo'),(12,'Escova Marroquina','Ativo'),(13,'Loção Arranca Tudo','Ativo'),(14,'Pedicure Premium','ativo');
/*!40000 ALTER TABLE `servico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_usuario`
--

DROP TABLE IF EXISTS `tipo_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_usuario` (
  `tipo_codigo` int(1) NOT NULL AUTO_INCREMENT,
  `tipo_desc` varchar(25) NOT NULL,
  PRIMARY KEY (`tipo_codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_usuario`
--

LOCK TABLES `tipo_usuario` WRITE;
/*!40000 ALTER TABLE `tipo_usuario` DISABLE KEYS */;
INSERT INTO `tipo_usuario` VALUES (1,'Administrador'),(2,'PessoaFisica'),(3,'PessoaJuridica');
/*!40000 ALTER TABLE `tipo_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `usu_codigo` int(1) NOT NULL AUTO_INCREMENT,
  `usu_status` varchar(10) DEFAULT NULL,
  `usu_senha` varchar(20) NOT NULL,
  `usu_email` varchar(60) NOT NULL,
  `usu_end_codigo` int(1) DEFAULT NULL,
  `usu_tipo_codigo` int(1) NOT NULL,
  PRIMARY KEY (`usu_codigo`),
  KEY `usu_end_cep` (`usu_end_codigo`),
  KEY `usu_tipo_codigo` (`usu_tipo_codigo`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`usu_end_codigo`) REFERENCES `endereco` (`end_codigo`),
  CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`usu_tipo_codigo`) REFERENCES `tipo_usuario` (`tipo_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zona`
--

DROP TABLE IF EXISTS `zona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zona` (
  `zona_cod` int(1) NOT NULL AUTO_INCREMENT,
  `zona_nome` varchar(12) NOT NULL,
  PRIMARY KEY (`zona_cod`),
  UNIQUE KEY `zona_nome` (`zona_nome`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zona`
--

LOCK TABLES `zona` WRITE;
/*!40000 ALTER TABLE `zona` DISABLE KEYS */;
INSERT INTO `zona` VALUES (6,'Centro-Oeste'),(5,'Centro-Sul'),(3,'Leste'),(1,'Norte'),(4,'Oeste'),(2,'Sul');
/*!40000 ALTER TABLE `zona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ibeautysalon'
--

--
-- Dumping routines for database 'ibeautysalon'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-06 12:07:13

-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: adventure
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `destinos`
--

DROP TABLE IF EXISTS `destinos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `destinos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `emoji` varchar(10) NOT NULL,
  `imagen` varchar(500) NOT NULL,
  `descripcion` text NOT NULL,
  `paisajes` text NOT NULL,
  `comida` text NOT NULL,
  `tips` text NOT NULL,
  `orden` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destinos`
--

LOCK TABLES `destinos` WRITE;
/*!40000 ALTER TABLE `destinos` DISABLE KEYS */;
INSERT INTO `destinos` VALUES (1,'Bariloche, Argentina','🏔️','https://picsum.photos/seed/bariloche/800/400','San Carlos de Bariloche es la joya de la Patagonia argentina. Rodeada de montañas, lagos y bosques de arrayanes, es el destino perfecto para quienes buscan naturaleza imponente.','El lago Nahuel Huapi, el Cerro Catedral y el Parque Nacional Nahuel Huapi son imperdibles. En invierno la nieve transforma todo en un paisaje de postal.','La gastronomía local incluye truchas y salmones frescos, fondues de queso, chocolates artesanales y cervezas artesanales únicas en el mundo.','Visitá el Cerro Campanario para la mejor vista.|El chocolate Mamuschka es obligatorio.|En verano hacé trekking y kayak en el lago.|Reservá con anticipación en temporada de ski.',4,'2026-09-02 21:15:57'),(2,'Mendoza, Argentina','🍷','https://picsum.photos/seed/mendoza/800/400','Mendoza es la capital mundial del Malbec. Sus viñedos infinitos, la imponente cordillera de los Andes y su gastronomía de primer nivel la convierten en un destino único.','Los viñedos de Luján de Cuyo y Maipú, el Aconcagua y el Parque General San Martín son postales obligadas.','Las bodegas ofrecen degustaciones de Malbec, Cabernet y Torrontés. Los asados mendocinos con cortes premium son legendarios.','Alquilá una bici para recorrer las bodegas de Maipú.|El mejor momento es la Vendimia (marzo).|Reservá cena maridaje en una bodega boutique.|Llevá ropa abrigada para la cordillera.',2,'2026-09-02 21:15:57'),(3,'Ushuaia, Argentina','🌊','https://picsum.photos/seed/ushuaia/800/400','La ciudad más austral del mundo. Ushuaia te ofrece paisajes que parecen de otro planeta: el Canal Beagle, glaciares milenarios y el Parque Nacional Tierra del Fuego.','El Canal Beagle con lobos marinos y pingüinos, el Glaciar Martial y el Parque Nacional Tierra del Fuego son experiencias únicas.','El centolla es el plato estrella — un cangrejo gigante de sabor incomparable. También destacan los mejillones y el cordero patagónico.','Tomá el Tren del Fin del Mundo en el Parque Nacional.|Navegá el Canal Beagle al atardecer.|En invierno esquiá en el Cerro Castor.|Llevá ropa para todas las estaciones.',3,'2026-09-02 21:15:57');
/*!40000 ALTER TABLE `destinos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entretenimiento`
--

DROP TABLE IF EXISTS `entretenimiento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entretenimiento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `ubicacion` varchar(150) NOT NULL,
  `fecha` date NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `descripcion` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entretenimiento`
--

LOCK TABLES `entretenimiento` WRITE;
/*!40000 ALTER TABLE `entretenimiento` DISABLE KEYS */;
INSERT INTO `entretenimiento` VALUES (1,'Festival de Jazz','Bariloche, Argentina','2026-06-15','Música','https://loremflickr.com/400/300/concert,music?lock=1','Festival de jazz en el centro de Bariloche.','2026-05-03 00:48:33'),(2,'Festival de Jazz de Buenos Aires','Buenos Aires, Argentina','2026-06-10','Música','https://loremflickr.com/400/300/concert,music?lock=2','El festival de jazz más importante del país.','2026-05-03 01:22:35'),(3,'Vendimia 2026','Mendoza, Argentina','2026-06-15','Festival','https://loremflickr.com/400/300/festival,crowd?lock=3','La fiesta nacional de la vendimia.','2026-05-03 01:22:35'),(4,'Tango en La Boca','Buenos Aires, Argentina','2026-06-20','Espectáculo','https://loremflickr.com/400/300/show,stage?lock=4','Show de tango en vivo en La Boca.','2026-05-03 01:22:35'),(5,'Fiesta del Chocolate','Bariloche, Argentina','2026-06-25','Festival','https://loremflickr.com/400/300/festival,crowd?lock=5','El festival del chocolate más grande de la Patagonia.','2026-05-03 01:22:35'),(6,'Rock en el Parque','Córdoba, Argentina','2026-07-01','Música','https://loremflickr.com/400/300/concert,music?lock=6','Festival de rock con las mejores bandas del país.','2026-05-03 01:22:35'),(7,'Carnaval de Gualeguaychú','Gualeguaychú, Argentina','2026-07-05','Carnaval','https://loremflickr.com/400/300/carnival,parade?lock=7','El carnaval más espectacular de Argentina.','2026-05-03 01:22:35'),(8,'Muestra de Cine Independiente','Buenos Aires, Argentina','2026-07-10','Cine','https://loremflickr.com/400/300/cinema,film?lock=8','Festival de cine independiente internacional.','2026-05-03 01:22:35'),(9,'Noche de las Estrellas','San Juan, Argentina','2026-07-15','Ciencia','https://loremflickr.com/400/300/science,laboratory?lock=9','Observación astronómica en el observatorio.','2026-05-03 01:22:35'),(10,'Festival de Folclore','Cosquín, Argentina','2026-07-20','Música','https://loremflickr.com/400/300/concert,music?lock=10','El festival de folclore más importante del país.','2026-05-03 01:22:35'),(11,'Feria del Libro','Buenos Aires, Argentina','2026-07-25','Cultural','https://loremflickr.com/400/300/culture,tradition?lock=11','La feria del libro más grande de América Latina.','2026-05-03 01:22:35'),(12,'Festival de Tango','Buenos Aires, Argentina','2026-08-01','Danza','https://loremflickr.com/400/300/dance,performance?lock=12','El festival de tango más grande del mundo.','2026-05-03 01:22:35'),(13,'Expo Vinos Mendoza','Mendoza, Argentina','2026-08-05','Gastronomía','https://loremflickr.com/400/300/food,gastronomy?lock=13','Exposición de los mejores vinos argentinos.','2026-05-03 01:22:35'),(14,'Festival de la Cerveza','Villa General Belgrano, Argentina','2026-08-10','Festival','https://loremflickr.com/400/300/festival,crowd?lock=14','Oktoberfest a la argentina en la ciudad alemana.','2026-05-03 01:22:35'),(15,'Noche de los Museos','Buenos Aires, Argentina','2026-08-15','Cultural','https://loremflickr.com/400/300/culture,tradition?lock=15','Una noche especial con museos abiertos y gratuitos.','2026-05-03 01:22:35'),(16,'Festival de Cine de Mar del Plata','Mar del Plata, Argentina','2026-08-20','Cine','https://loremflickr.com/400/300/cinema,film?lock=16','El festival de cine más importante de Argentina.','2026-05-03 01:22:35'),(17,'Maratón de Buenos Aires','Buenos Aires, Argentina','2026-08-25','Deporte','https://loremflickr.com/400/300/sports,race?lock=17','La maratón más grande de Argentina.','2026-05-03 01:22:35'),(18,'Festival de Danzas Folklóricas','Salta, Argentina','2026-09-01','Danza','https://loremflickr.com/400/300/dance,performance?lock=18','Festival de danzas folklóricas del norte argentino.','2026-05-03 01:22:35'),(19,'Expo Tecnología','Buenos Aires, Argentina','2026-09-05','Tecnología','https://loremflickr.com/400/300/technology,expo?lock=19','La mayor exposición de tecnología del país.','2026-05-03 01:22:35'),(20,'Festival de Teatro','Córdoba, Argentina','2026-09-10','Teatro','https://loremflickr.com/400/300/theater,stage?lock=20','Festival internacional de teatro en Córdoba.','2026-05-03 01:22:35'),(21,'Fiesta Nacional del Poncho','Catamarca, Argentina','2026-09-15','Cultural','https://loremflickr.com/400/300/culture,tradition?lock=21','La fiesta del poncho más grande del país.','2026-05-03 01:22:35'),(22,'Festival de Surf','Mar del Plata, Argentina','2026-09-20','Deporte','https://loremflickr.com/400/300/sports,race?lock=22','Campeonato nacional de surf en la costa atlántica.','2026-05-03 01:22:35'),(23,'Feria Artesanal Patagónica','Bariloche, Argentina','2026-09-25','Cultural','https://loremflickr.com/400/300/culture,tradition?lock=23','Feria de artesanías y productos regionales.','2026-05-03 01:22:35'),(24,'Festival de Música Clásica','Buenos Aires, Argentina','2026-10-01','Música','https://loremflickr.com/400/300/concert,music?lock=24','Festival internacional de música clásica.','2026-05-03 01:22:35'),(25,'Exposición de Arte Contemporáneo','Buenos Aires, Argentina','2026-10-05','Arte','https://loremflickr.com/400/300/art,exhibition?lock=25','La mayor exposición de arte contemporáneo del país.','2026-05-03 01:22:35'),(26,'Festival Gastronómico','Rosario, Argentina','2026-10-10','Gastronomía','https://loremflickr.com/400/300/food,gastronomy?lock=26','Festival de gastronomía con chefs de todo el mundo.','2026-05-03 01:22:35'),(27,'Carnaval de Corrientes','Corrientes, Argentina','2026-10-15','Carnaval','https://loremflickr.com/400/300/carnival,parade?lock=27','El carnaval más colorido del norte argentino.','2026-05-03 01:22:35'),(28,'Festival de Hip Hop','Buenos Aires, Argentina','2026-10-20','Música','https://loremflickr.com/400/300/concert,music?lock=28','El festival de hip hop más grande de Argentina.','2026-05-03 01:22:35'),(29,'Expo Agro','Palermo, Argentina','2026-10-25','Agricultura','https://loremflickr.com/400/300/agriculture,farm?lock=29','La exposición agropecuaria más importante del país.','2026-05-03 01:22:35'),(30,'Festival de Flamenco','Buenos Aires, Argentina','2026-11-01','Danza','https://loremflickr.com/400/300/dance,performance?lock=30','Festival internacional de flamenco.','2026-05-03 01:22:35'),(31,'Maratón de Mendoza','Mendoza, Argentina','2026-11-05','Deporte','https://loremflickr.com/400/300/sports,race?lock=31','Maratón entre viñedos y montañas.','2026-05-03 01:22:35'),(32,'Festival de Cumbia','Córdoba, Argentina','2026-11-10','Música','https://loremflickr.com/400/300/concert,music?lock=32','El festival de cumbia más grande del interior.','2026-05-03 01:22:35'),(33,'Feria de Artesanos','San Telmo, Argentina','2026-11-15','Cultural','https://loremflickr.com/400/300/culture,tradition?lock=33','Feria de artesanos en el histórico barrio de San Telmo.','2026-05-03 01:22:35'),(34,'Festival de Ciencia','Buenos Aires, Argentina','2026-11-20','Ciencia','https://loremflickr.com/400/300/science,laboratory?lock=34','Festival de ciencia y tecnología para toda la familia.','2026-05-03 01:22:35'),(35,'Show de Magia','Buenos Aires, Argentina','2026-11-25','Espectáculo','https://loremflickr.com/400/300/show,stage?lock=35','El show de magia más impresionante del año.','2026-05-03 01:22:35'),(36,'Festival de Reggae','Mar del Plata, Argentina','2026-12-01','Música','https://loremflickr.com/400/300/concert,music?lock=36','Festival de reggae en la costa atlántica.','2026-05-03 01:22:35'),(37,'Feria de Navidad','Buenos Aires, Argentina','2026-12-05','Festival','https://loremflickr.com/400/300/festival,crowd?lock=37','La feria navideña más grande de Argentina.','2026-05-03 01:22:35'),(38,'Festival de Fuegos Artificiales','Bariloche, Argentina','2026-12-10','Espectáculo','https://loremflickr.com/400/300/show,stage?lock=38','Espectáculo de fuegos artificiales sobre el lago.','2026-05-03 01:22:35'),(39,'Noche Buena Musical','Córdoba, Argentina','2026-12-15','Música','https://loremflickr.com/400/300/concert,music?lock=39','Concierto especial de navidad en el centro.','2026-05-03 01:22:35'),(40,'Festival de Verano','Pinamar, Argentina','2026-12-20','Festival','https://loremflickr.com/400/300/festival,crowd?lock=40','El festival de verano más esperado de la costa.','2026-05-03 01:22:35'),(41,'Año Nuevo en Buenos Aires','Buenos Aires, Argentina','2026-12-25','Espectáculo','https://loremflickr.com/400/300/show,stage?lock=41','La celebración de año nuevo más grande del país.','2026-05-03 01:22:35'),(42,'Festival de Electrónica','Buenos Aires, Argentina','2026-12-28','Música','https://loremflickr.com/400/300/concert,music?lock=42','Festival de música electrónica a fin de año.','2026-05-03 01:22:35'),(43,'Expo Motos','Buenos Aires, Argentina','2026-12-30','Tecnología','https://loremflickr.com/400/300/technology,expo?lock=43','Exposición de motos y accesorios.','2026-05-03 01:22:35'),(44,'Festival de Opera','Buenos Aires, Argentina','2027-01-05','Música','https://loremflickr.com/400/300/concert,music?lock=44','Festival de ópera en el Teatro Colón.','2026-05-03 01:22:35'),(45,'Torneo de Polo','Palermo, Argentina','2027-01-10','Deporte','https://loremflickr.com/400/300/sports,race?lock=45','El torneo de polo más importante del mundo.','2026-05-03 01:22:35'),(46,'Festival de Fotografía','Rosario, Argentina','2027-01-15','Arte','https://loremflickr.com/400/300/art,exhibition?lock=46','Festival internacional de fotografía.','2026-05-03 01:22:35'),(47,'Expo Comic','Buenos Aires, Argentina','2027-01-20','Cultural','https://loremflickr.com/400/300/culture,tradition?lock=47','La exposición de comics y anime más grande del país.','2026-05-03 01:22:35'),(48,'Festival de Blues','Buenos Aires, Argentina','2027-01-25','Música','https://loremflickr.com/400/300/concert,music?lock=48','Festival de blues con artistas internacionales.','2026-05-03 01:22:35'),(49,'Carrera de Autos','San Juan, Argentina','2027-02-01','Deporte','https://loremflickr.com/400/300/sports,race?lock=49','Carrera de autos en el circuito de San Juan.','2026-05-03 01:22:35'),(50,'Festival de Murga','Montevideo, Uruguay','2027-02-05','Carnaval','https://loremflickr.com/400/300/carnival,parade?lock=50','El festival de murga más grande del Río de la Plata.','2026-05-03 01:22:35'),(51,'Expo Gastronomía Patagónica','Bariloche, Argentina','2027-02-10','Gastronomía','https://loremflickr.com/400/300/food,gastronomy?lock=51','Exposición de gastronomía patagónica.','2026-05-03 01:22:35');
/*!40000 ALTER TABLE `entretenimiento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favoritos`
--

DROP TABLE IF EXISTS `favoritos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `tipo` enum('hotel','vuelo','restaurante','entretenimiento','destino') NOT NULL,
  `referencia_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritos`
--

LOCK TABLES `favoritos` WRITE;
/*!40000 ALTER TABLE `favoritos` DISABLE KEYS */;
INSERT INTO `favoritos` VALUES (2,2,'hotel',1,'2026-05-03 01:45:30'),(3,2,'entretenimiento',3,'2026-05-03 01:45:41'),(6,2,'hotel',4,'2026-05-27 01:59:21'),(7,2,'restaurante',2,'2026-05-27 02:02:06');
/*!40000 ALTER TABLE `favoritos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hoteles`
--

DROP TABLE IF EXISTS `hoteles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hoteles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `ubicacion` varchar(150) NOT NULL,
  `descripcion` text,
  `precio` decimal(10,2) NOT NULL,
  `rating` decimal(3,1) DEFAULT '0.0',
  `tipo` enum('hotel','hostel','departamento','resort') NOT NULL,
  `imagen` varchar(255) DEFAULT NULL,
  `propietario_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `propietario_id` (`propietario_id`),
  CONSTRAINT `hoteles_ibfk_1` FOREIGN KEY (`propietario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoteles`
--

LOCK TABLES `hoteles` WRITE;
/*!40000 ALTER TABLE `hoteles` DISABLE KEYS */;
INSERT INTO `hoteles` VALUES (1,'Hotel Patagonia','Bariloche, Argentina','Hotel con vista al lago',150.00,4.5,'hotel','https://loremflickr.com/400/300/hotel,building?lock=1',NULL,'2026-05-03 00:19:03'),(2,'Hotel Llao Llao','Bariloche, Argentina','Hotel de lujo con vista al lago Nahuel Huapi.',350.00,4.9,'resort','https://loremflickr.com/400/300/resort,pool?lock=2',NULL,'2026-05-03 01:24:21'),(3,'Hostel El Mochilero','Buenos Aires, Argentina','Hostel céntrico ideal para viajeros.',25.00,4.2,'hostel','https://loremflickr.com/400/300/hostel,backpacker?lock=3',NULL,'2026-05-03 01:24:21'),(4,'Departamento Palermo','Buenos Aires, Argentina','Moderno departamento en Palermo.',80.00,4.5,'departamento','https://loremflickr.com/400/300/apartment,interior?lock=4',NULL,'2026-05-03 01:24:21'),(5,'Hotel Panamericano','Buenos Aires, Argentina','Hotel 5 estrellas en el centro porteño.',200.00,4.7,'hotel','https://loremflickr.com/400/300/hotel,building?lock=5',NULL,'2026-05-03 01:24:21'),(6,'Cabaña Los Andes','Mendoza, Argentina','Cabaña rústica con vista a la cordillera.',120.00,4.6,'hotel','https://loremflickr.com/400/300/hotel,building?lock=6',NULL,'2026-05-03 01:24:21'),(7,'Hotel Ushuaia','Ushuaia, Argentina','Hotel en el fin del mundo.',180.00,4.8,'hotel','https://loremflickr.com/400/300/hotel,building?lock=7',NULL,'2026-05-03 01:24:21'),(8,'Hostel Córdoba Centro','Córdoba, Argentina','Hostel moderno en el centro.',20.00,4.1,'hostel','https://loremflickr.com/400/300/hostel,backpacker?lock=8',NULL,'2026-05-03 01:24:21'),(9,'Resort Iguazú','Puerto Iguazú, Argentina','Resort de lujo a minutos de las cataratas.',280.00,4.9,'resort','https://loremflickr.com/400/300/resort,pool?lock=9',NULL,'2026-05-03 01:24:21'),(10,'Hotel Salta Colonial','Salta, Argentina','Hotel colonial en el centro histórico.',95.00,4.4,'hotel','https://loremflickr.com/400/300/hotel,building?lock=10',NULL,'2026-05-03 01:24:21'),(11,'Apart Hotel Rosario','Rosario, Argentina','Apart hotel moderno frente al río Paraná.',70.00,4.3,'departamento','https://loremflickr.com/400/300/apartment,interior?lock=11',NULL,'2026-05-03 01:24:21'),(12,'Hotel Mar del Plata','Mar del Plata, Argentina','Hotel frente al mar con vista espectacular.',150.00,4.5,'hotel','https://loremflickr.com/400/300/hotel,building?lock=12',NULL,'2026-05-03 01:24:21'),(13,'Hostel Patagonia','El Calafate, Argentina','Hostel acogedor cerca del Perito Moreno.',30.00,4.3,'hostel','https://loremflickr.com/400/300/hostel,backpacker?lock=13',NULL,'2026-05-03 01:24:21'),(14,'Resort Las Leñas','Malargüe, Argentina','Resort de ski en la montaña.',320.00,4.8,'resort','https://loremflickr.com/400/300/resort,pool?lock=14',NULL,'2026-05-03 01:24:21'),(15,'Hotel Tucumán Plaza','Tucumán, Argentina','Hotel en el centro de la ciudad jardín.',85.00,4.2,'hotel','https://loremflickr.com/400/300/hotel,building?lock=15',NULL,'2026-05-03 01:24:21'),(16,'Departamento Puerto Madero','Buenos Aires, Argentina','Lujoso departamento en Puerto Madero.',250.00,4.8,'departamento','https://loremflickr.com/400/300/apartment,interior?lock=16',NULL,'2026-05-03 01:24:21'),(17,'Hostel Mendoza Wine','Mendoza, Argentina','Hostel temático del vino.',22.00,4.4,'hostel','https://loremflickr.com/400/300/hostel,backpacker?lock=17',NULL,'2026-05-03 01:24:21'),(18,'Hotel Glaciar','El Calafate, Argentina','Hotel con vista al lago Argentino.',220.00,4.7,'hotel','https://loremflickr.com/400/300/hotel,building?lock=18',NULL,'2026-05-03 01:24:21'),(19,'Apart Neuquén','Neuquén, Argentina','Cómodo apart hotel en la capital neuquina.',65.00,4.0,'departamento','https://loremflickr.com/400/300/apartment,interior?lock=19',NULL,'2026-05-03 01:24:21'),(20,'Resort Termas de Río Hondo','Santiago del Estero, Argentina','Resort termal de lujo.',180.00,4.6,'resort','https://loremflickr.com/400/300/resort,pool?lock=20',NULL,'2026-05-03 01:24:21'),(21,'Hotel Jujuy Colonial','Jujuy, Argentina','Hotel colonial cerca de la Quebrada de Humahuaca.',90.00,4.5,'hotel','https://loremflickr.com/400/300/hotel,building?lock=21',NULL,'2026-05-03 01:24:21'),(22,'Hostel Iguazú Jungle','Puerto Iguazú, Argentina','Hostel en medio de la selva.',28.00,4.3,'hostel','https://loremflickr.com/400/300/hostel,backpacker?lock=22',NULL,'2026-05-03 01:24:21'),(23,'Hotel Recoleta','Buenos Aires, Argentina','Elegante hotel en el barrio de Recoleta.',230.00,4.8,'hotel','https://loremflickr.com/400/300/hotel,building?lock=23',NULL,'2026-05-03 01:24:21'),(24,'Departamento Microcentro','Buenos Aires, Argentina','Departamento ejecutivo en el microcentro.',75.00,4.1,'departamento','https://loremflickr.com/400/300/apartment,interior?lock=24',NULL,'2026-05-03 01:24:21'),(25,'Resort Chapelco','San Martín de los Andes, Argentina','Resort de ski con vista a los Andes.',300.00,4.7,'resort','https://loremflickr.com/400/300/resort,pool?lock=25',NULL,'2026-05-03 01:24:21'),(26,'Hotel Villa La Angostura','Villa La Angostura, Argentina','Hotel boutique en la Patagonia.',160.00,4.6,'hotel','https://loremflickr.com/400/300/hotel,building?lock=26',NULL,'2026-05-03 01:24:21'),(27,'Hostel San Telmo','Buenos Aires, Argentina','Hostel en el barrio histórico de San Telmo.',18.00,4.2,'hostel','https://loremflickr.com/400/300/hostel,backpacker?lock=27',NULL,'2026-05-03 01:24:21'),(28,'Hotel Posadas','Posadas, Argentina','Hotel moderno en la capital misionera.',80.00,4.1,'hotel','https://loremflickr.com/400/300/hotel,building?lock=28',NULL,'2026-05-03 01:24:21'),(29,'Apart Hotel Palermo Soho','Buenos Aires, Argentina','Apart hotel en Palermo Soho.',110.00,4.5,'departamento','https://loremflickr.com/400/300/apartment,interior?lock=29',NULL,'2026-05-03 01:24:21'),(30,'Resort Costa Galana','Mar del Plata, Argentina','Resort frente al mar.',260.00,4.8,'resort','https://loremflickr.com/400/300/resort,pool?lock=30',NULL,'2026-05-03 01:24:21'),(31,'Hotel Bariloche Centro','Bariloche, Argentina','Hotel céntrico a pasos del lago.',140.00,4.4,'hotel','https://loremflickr.com/400/300/hotel,building?lock=31',NULL,'2026-05-03 01:24:21'),(32,'Hostel Salta Vieja','Salta, Argentina','Hostel en el casco histórico de Salta.',22.00,4.3,'hostel','https://loremflickr.com/400/300/hostel,backpacker?lock=32',NULL,'2026-05-03 01:24:21'),(33,'Hotel Corrientes','Corrientes, Argentina','Hotel con vista al río Paraná.',75.00,4.0,'hotel','https://loremflickr.com/400/300/hotel,building?lock=33',NULL,'2026-05-03 01:24:21'),(34,'Departamento Belgrano','Buenos Aires, Argentina','Departamento amplio en Belgrano.',90.00,4.3,'departamento','https://loremflickr.com/400/300/apartment,interior?lock=34',NULL,'2026-05-03 01:24:21'),(35,'Resort Villa Carlos Paz','Villa Carlos Paz, Argentina','Resort a orillas del lago San Roque.',190.00,4.5,'resort','https://loremflickr.com/400/300/resort,pool?lock=35',NULL,'2026-05-03 01:24:21'),(36,'Hotel Tandil','Tandil, Argentina','Hotel boutique en las sierras.',100.00,4.4,'hotel','https://loremflickr.com/400/300/hotel,building?lock=36',NULL,'2026-05-03 01:24:21'),(37,'Hostel Rosario Centro','Rosario, Argentina','Hostel moderno en el centro de Rosario.',20.00,4.1,'hostel','https://loremflickr.com/400/300/hostel,backpacker?lock=37',NULL,'2026-05-03 01:24:21'),(38,'Hotel Comodoro Rivadavia','Comodoro Rivadavia, Argentina','Hotel moderno en la Patagonia.',110.00,4.2,'hotel','https://loremflickr.com/400/300/hotel,building?lock=38',NULL,'2026-05-03 01:24:21'),(39,'Apart Hotel Córdoba','Córdoba, Argentina','Apart hotel moderno en Nueva Córdoba.',70.00,4.2,'departamento','https://loremflickr.com/400/300/apartment,interior?lock=39',NULL,'2026-05-03 01:24:21'),(40,'Resort Termas de Cacheuta','Mendoza, Argentina','Resort termal en las montañas.',210.00,4.7,'resort','https://loremflickr.com/400/300/resort,pool?lock=40',NULL,'2026-05-03 01:24:21'),(41,'Hotel San Juan','San Juan, Argentina','Hotel moderno en la ciudad del sol.',85.00,4.1,'hotel','https://loremflickr.com/400/300/hotel,building?lock=41',NULL,'2026-05-03 01:24:21'),(42,'Hostel Trelew','Trelew, Argentina','Hostel galés en la Patagonia.',20.00,4.0,'hostel','https://loremflickr.com/400/300/hostel,backpacker?lock=42',NULL,'2026-05-03 01:24:21'),(43,'Hotel La Rioja','La Rioja, Argentina','Hotel en el corazón de La Rioja.',75.00,4.0,'hotel','https://loremflickr.com/400/300/hotel,building?lock=43',NULL,'2026-05-03 01:24:21'),(44,'Departamento San Isidro','San Isidro, Argentina','Departamento en el exclusivo San Isidro.',130.00,4.4,'departamento','https://loremflickr.com/400/300/apartment,interior?lock=44',NULL,'2026-05-03 01:24:21'),(45,'Resort Pinamar','Pinamar, Argentina','Resort frente al mar en Pinamar.',240.00,4.6,'resort','https://loremflickr.com/400/300/resort,pool?lock=45',NULL,'2026-05-03 01:24:21'),(46,'Hotel Resistencia','Resistencia, Argentina','Hotel moderno en el Chaco.',70.00,3.9,'hotel','https://loremflickr.com/400/300/hotel,building?lock=46',NULL,'2026-05-03 01:24:21'),(47,'Hostel Mendoza Central','Mendoza, Argentina','Hostel en el centro de Mendoza.',18.00,4.2,'hostel','https://loremflickr.com/400/300/hostel,backpacker?lock=47',NULL,'2026-05-03 01:24:21'),(48,'Hotel Puerto Madryn','Puerto Madryn, Argentina','Hotel frente al mar con avistaje de ballenas.',130.00,4.5,'hotel','https://loremflickr.com/400/300/hotel,building?lock=48',NULL,'2026-05-03 01:24:21'),(49,'Apart Hotel Tigre','Tigre, Argentina','Apart hotel en el delta del Paraná.',95.00,4.3,'departamento','https://loremflickr.com/400/300/apartment,interior?lock=49',NULL,'2026-05-03 01:24:21'),(50,'Resort Miramar','Miramar, Argentina','Resort familiar frente al mar.',170.00,4.4,'resort','https://loremflickr.com/400/300/resort,pool?lock=50',NULL,'2026-05-03 01:24:21'),(51,'Hotel Formosa','Formosa, Argentina','Hotel en el norte del país.',65.00,3.8,'hotel','https://loremflickr.com/400/300/hotel,building?lock=51',NULL,'2026-05-03 01:24:21');
/*!40000 ALTER TABLE `hoteles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hoteles_imagenes`
--

DROP TABLE IF EXISTS `hoteles_imagenes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hoteles_imagenes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hotel_id` int NOT NULL,
  `url` varchar(500) NOT NULL,
  `orden` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `hotel_id` (`hotel_id`),
  CONSTRAINT `hoteles_imagenes_ibfk_1` FOREIGN KEY (`hotel_id`) REFERENCES `hoteles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoteles_imagenes`
--

LOCK TABLES `hoteles_imagenes` WRITE;
/*!40000 ALTER TABLE `hoteles_imagenes` DISABLE KEYS */;
INSERT INTO `hoteles_imagenes` VALUES (1,1,'https://loremflickr.com/400/300/hotel,building?lock=1',0),(2,2,'https://loremflickr.com/400/300/resort,pool?lock=2',0),(3,3,'https://loremflickr.com/400/300/hostel,backpacker?lock=3',0),(4,4,'https://loremflickr.com/400/300/apartment,interior?lock=4',0),(5,5,'https://loremflickr.com/400/300/hotel,building?lock=5',0),(6,6,'https://loremflickr.com/400/300/hotel,building?lock=6',0),(7,7,'https://loremflickr.com/400/300/hotel,building?lock=7',0),(8,8,'https://loremflickr.com/400/300/hostel,backpacker?lock=8',0),(9,9,'https://loremflickr.com/400/300/resort,pool?lock=9',0),(10,10,'https://loremflickr.com/400/300/hotel,building?lock=10',0),(11,11,'https://loremflickr.com/400/300/apartment,interior?lock=11',0),(12,12,'https://loremflickr.com/400/300/hotel,building?lock=12',0),(13,13,'https://loremflickr.com/400/300/hostel,backpacker?lock=13',0),(14,14,'https://loremflickr.com/400/300/resort,pool?lock=14',0),(15,15,'https://loremflickr.com/400/300/hotel,building?lock=15',0),(16,16,'https://loremflickr.com/400/300/apartment,interior?lock=16',0),(17,17,'https://loremflickr.com/400/300/hostel,backpacker?lock=17',0),(18,18,'https://loremflickr.com/400/300/hotel,building?lock=18',0),(19,19,'https://loremflickr.com/400/300/apartment,interior?lock=19',0),(20,20,'https://loremflickr.com/400/300/resort,pool?lock=20',0),(21,21,'https://loremflickr.com/400/300/hotel,building?lock=21',0),(22,22,'https://loremflickr.com/400/300/hostel,backpacker?lock=22',0),(23,23,'https://loremflickr.com/400/300/hotel,building?lock=23',0),(24,24,'https://loremflickr.com/400/300/apartment,interior?lock=24',0),(25,25,'https://loremflickr.com/400/300/resort,pool?lock=25',0),(26,26,'https://loremflickr.com/400/300/hotel,building?lock=26',0),(27,27,'https://loremflickr.com/400/300/hostel,backpacker?lock=27',0),(28,28,'https://loremflickr.com/400/300/hotel,building?lock=28',0),(29,29,'https://loremflickr.com/400/300/apartment,interior?lock=29',0),(30,30,'https://loremflickr.com/400/300/resort,pool?lock=30',0),(31,31,'https://loremflickr.com/400/300/hotel,building?lock=31',0),(32,32,'https://loremflickr.com/400/300/hostel,backpacker?lock=32',0),(33,33,'https://loremflickr.com/400/300/hotel,building?lock=33',0),(34,34,'https://loremflickr.com/400/300/apartment,interior?lock=34',0),(35,35,'https://loremflickr.com/400/300/resort,pool?lock=35',0),(36,36,'https://loremflickr.com/400/300/hotel,building?lock=36',0),(37,37,'https://loremflickr.com/400/300/hostel,backpacker?lock=37',0),(38,38,'https://loremflickr.com/400/300/hotel,building?lock=38',0),(39,39,'https://loremflickr.com/400/300/apartment,interior?lock=39',0),(40,40,'https://loremflickr.com/400/300/resort,pool?lock=40',0),(41,41,'https://loremflickr.com/400/300/hotel,building?lock=41',0),(42,42,'https://loremflickr.com/400/300/hostel,backpacker?lock=42',0),(43,43,'https://loremflickr.com/400/300/hotel,building?lock=43',0),(44,44,'https://loremflickr.com/400/300/apartment,interior?lock=44',0),(45,45,'https://loremflickr.com/400/300/resort,pool?lock=45',0),(46,46,'https://loremflickr.com/400/300/hotel,building?lock=46',0),(47,47,'https://loremflickr.com/400/300/hostel,backpacker?lock=47',0),(48,48,'https://loremflickr.com/400/300/hotel,building?lock=48',0),(49,49,'https://loremflickr.com/400/300/apartment,interior?lock=49',0),(50,50,'https://loremflickr.com/400/300/resort,pool?lock=50',0),(51,51,'https://loremflickr.com/400/300/hotel,building?lock=51',0),(64,1,'https://loremflickr.com/400/300/hotel?lock=1001',1),(65,2,'https://loremflickr.com/400/300/resort?lock=1002',1),(66,3,'https://loremflickr.com/400/300/hostel?lock=1003',1),(67,4,'https://loremflickr.com/400/300/departamento?lock=1004',1),(68,5,'https://loremflickr.com/400/300/hotel?lock=1005',1),(69,6,'https://loremflickr.com/400/300/hotel?lock=1006',1),(70,7,'https://loremflickr.com/400/300/hotel?lock=1007',1),(71,8,'https://loremflickr.com/400/300/hostel?lock=1008',1),(72,9,'https://loremflickr.com/400/300/resort?lock=1009',1),(73,10,'https://loremflickr.com/400/300/hotel?lock=1010',1),(74,11,'https://loremflickr.com/400/300/departamento?lock=1011',1),(75,12,'https://loremflickr.com/400/300/hotel?lock=1012',1),(76,13,'https://loremflickr.com/400/300/hostel?lock=1013',1),(77,14,'https://loremflickr.com/400/300/resort?lock=1014',1),(78,15,'https://loremflickr.com/400/300/hotel?lock=1015',1),(79,16,'https://loremflickr.com/400/300/departamento?lock=1016',1),(80,17,'https://loremflickr.com/400/300/hostel?lock=1017',1),(81,18,'https://loremflickr.com/400/300/hotel?lock=1018',1),(82,19,'https://loremflickr.com/400/300/departamento?lock=1019',1),(83,20,'https://loremflickr.com/400/300/resort?lock=1020',1),(84,21,'https://loremflickr.com/400/300/hotel?lock=1021',1),(85,22,'https://loremflickr.com/400/300/hostel?lock=1022',1),(86,23,'https://loremflickr.com/400/300/hotel?lock=1023',1),(87,24,'https://loremflickr.com/400/300/departamento?lock=1024',1),(88,25,'https://loremflickr.com/400/300/resort?lock=1025',1),(89,26,'https://loremflickr.com/400/300/hotel?lock=1026',1),(90,27,'https://loremflickr.com/400/300/hostel?lock=1027',1),(91,28,'https://loremflickr.com/400/300/hotel?lock=1028',1),(92,29,'https://loremflickr.com/400/300/departamento?lock=1029',1),(93,30,'https://loremflickr.com/400/300/resort?lock=1030',1),(94,31,'https://loremflickr.com/400/300/hotel?lock=1031',1),(95,32,'https://loremflickr.com/400/300/hostel?lock=1032',1),(96,33,'https://loremflickr.com/400/300/hotel?lock=1033',1),(97,34,'https://loremflickr.com/400/300/departamento?lock=1034',1),(98,35,'https://loremflickr.com/400/300/resort?lock=1035',1),(99,36,'https://loremflickr.com/400/300/hotel?lock=1036',1),(100,37,'https://loremflickr.com/400/300/hostel?lock=1037',1),(101,38,'https://loremflickr.com/400/300/hotel?lock=1038',1),(102,39,'https://loremflickr.com/400/300/departamento?lock=1039',1),(103,40,'https://loremflickr.com/400/300/resort?lock=1040',1),(104,41,'https://loremflickr.com/400/300/hotel?lock=1041',1),(105,42,'https://loremflickr.com/400/300/hostel?lock=1042',1),(106,43,'https://loremflickr.com/400/300/hotel?lock=1043',1),(107,44,'https://loremflickr.com/400/300/departamento?lock=1044',1),(108,45,'https://loremflickr.com/400/300/resort?lock=1045',1),(109,46,'https://loremflickr.com/400/300/hotel?lock=1046',1),(110,47,'https://loremflickr.com/400/300/hostel?lock=1047',1),(111,48,'https://loremflickr.com/400/300/hotel?lock=1048',1),(112,49,'https://loremflickr.com/400/300/departamento?lock=1049',1),(113,50,'https://loremflickr.com/400/300/resort?lock=1050',1),(114,51,'https://loremflickr.com/400/300/hotel?lock=1051',1),(127,1,'https://loremflickr.com/400/300/hotel?lock=2001',2),(128,2,'https://loremflickr.com/400/300/resort?lock=2002',2),(129,3,'https://loremflickr.com/400/300/hostel?lock=2003',2),(130,4,'https://loremflickr.com/400/300/departamento?lock=2004',2),(131,5,'https://loremflickr.com/400/300/hotel?lock=2005',2),(132,6,'https://loremflickr.com/400/300/hotel?lock=2006',2),(133,7,'https://loremflickr.com/400/300/hotel?lock=2007',2),(134,8,'https://loremflickr.com/400/300/hostel?lock=2008',2),(135,9,'https://loremflickr.com/400/300/resort?lock=2009',2),(136,10,'https://loremflickr.com/400/300/hotel?lock=2010',2),(137,11,'https://loremflickr.com/400/300/departamento?lock=2011',2),(138,12,'https://loremflickr.com/400/300/hotel?lock=2012',2),(139,13,'https://loremflickr.com/400/300/hostel?lock=2013',2),(140,14,'https://loremflickr.com/400/300/resort?lock=2014',2),(141,15,'https://loremflickr.com/400/300/hotel?lock=2015',2),(142,16,'https://loremflickr.com/400/300/departamento?lock=2016',2),(143,17,'https://loremflickr.com/400/300/hostel?lock=2017',2),(144,18,'https://loremflickr.com/400/300/hotel?lock=2018',2),(145,19,'https://loremflickr.com/400/300/departamento?lock=2019',2),(146,20,'https://loremflickr.com/400/300/resort?lock=2020',2),(147,21,'https://loremflickr.com/400/300/hotel?lock=2021',2),(148,22,'https://loremflickr.com/400/300/hostel?lock=2022',2),(149,23,'https://loremflickr.com/400/300/hotel?lock=2023',2),(150,24,'https://loremflickr.com/400/300/departamento?lock=2024',2),(151,25,'https://loremflickr.com/400/300/resort?lock=2025',2),(152,26,'https://loremflickr.com/400/300/hotel?lock=2026',2),(153,27,'https://loremflickr.com/400/300/hostel?lock=2027',2),(154,28,'https://loremflickr.com/400/300/hotel?lock=2028',2),(155,29,'https://loremflickr.com/400/300/departamento?lock=2029',2),(156,30,'https://loremflickr.com/400/300/resort?lock=2030',2),(157,31,'https://loremflickr.com/400/300/hotel?lock=2031',2),(158,32,'https://loremflickr.com/400/300/hostel?lock=2032',2),(159,33,'https://loremflickr.com/400/300/hotel?lock=2033',2),(160,34,'https://loremflickr.com/400/300/departamento?lock=2034',2),(161,35,'https://loremflickr.com/400/300/resort?lock=2035',2),(162,36,'https://loremflickr.com/400/300/hotel?lock=2036',2),(163,37,'https://loremflickr.com/400/300/hostel?lock=2037',2),(164,38,'https://loremflickr.com/400/300/hotel?lock=2038',2),(165,39,'https://loremflickr.com/400/300/departamento?lock=2039',2),(166,40,'https://loremflickr.com/400/300/resort?lock=2040',2),(167,41,'https://loremflickr.com/400/300/hotel?lock=2041',2),(168,42,'https://loremflickr.com/400/300/hostel?lock=2042',2),(169,43,'https://loremflickr.com/400/300/hotel?lock=2043',2),(170,44,'https://loremflickr.com/400/300/departamento?lock=2044',2),(171,45,'https://loremflickr.com/400/300/resort?lock=2045',2),(172,46,'https://loremflickr.com/400/300/hotel?lock=2046',2),(173,47,'https://loremflickr.com/400/300/hostel?lock=2047',2),(174,48,'https://loremflickr.com/400/300/hotel?lock=2048',2),(175,49,'https://loremflickr.com/400/300/departamento?lock=2049',2),(176,50,'https://loremflickr.com/400/300/resort?lock=2050',2),(177,51,'https://loremflickr.com/400/300/hotel?lock=2051',2),(190,1,'https://loremflickr.com/400/300/hotel?lock=3001',3),(191,2,'https://loremflickr.com/400/300/resort?lock=3002',3),(192,3,'https://loremflickr.com/400/300/hostel?lock=3003',3),(193,4,'https://loremflickr.com/400/300/departamento?lock=3004',3),(194,5,'https://loremflickr.com/400/300/hotel?lock=3005',3),(195,6,'https://loremflickr.com/400/300/hotel?lock=3006',3),(196,7,'https://loremflickr.com/400/300/hotel?lock=3007',3),(197,8,'https://loremflickr.com/400/300/hostel?lock=3008',3),(198,9,'https://loremflickr.com/400/300/resort?lock=3009',3),(199,10,'https://loremflickr.com/400/300/hotel?lock=3010',3),(200,11,'https://loremflickr.com/400/300/departamento?lock=3011',3),(201,12,'https://loremflickr.com/400/300/hotel?lock=3012',3),(202,13,'https://loremflickr.com/400/300/hostel?lock=3013',3),(203,14,'https://loremflickr.com/400/300/resort?lock=3014',3),(204,15,'https://loremflickr.com/400/300/hotel?lock=3015',3),(205,16,'https://loremflickr.com/400/300/departamento?lock=3016',3),(206,17,'https://loremflickr.com/400/300/hostel?lock=3017',3),(207,18,'https://loremflickr.com/400/300/hotel?lock=3018',3),(208,19,'https://loremflickr.com/400/300/departamento?lock=3019',3),(209,20,'https://loremflickr.com/400/300/resort?lock=3020',3),(210,21,'https://loremflickr.com/400/300/hotel?lock=3021',3),(211,22,'https://loremflickr.com/400/300/hostel?lock=3022',3),(212,23,'https://loremflickr.com/400/300/hotel?lock=3023',3),(213,24,'https://loremflickr.com/400/300/departamento?lock=3024',3),(214,25,'https://loremflickr.com/400/300/resort?lock=3025',3),(215,26,'https://loremflickr.com/400/300/hotel?lock=3026',3),(216,27,'https://loremflickr.com/400/300/hostel?lock=3027',3),(217,28,'https://loremflickr.com/400/300/hotel?lock=3028',3),(218,29,'https://loremflickr.com/400/300/departamento?lock=3029',3),(219,30,'https://loremflickr.com/400/300/resort?lock=3030',3),(220,31,'https://loremflickr.com/400/300/hotel?lock=3031',3),(221,32,'https://loremflickr.com/400/300/hostel?lock=3032',3),(222,33,'https://loremflickr.com/400/300/hotel?lock=3033',3),(223,34,'https://loremflickr.com/400/300/departamento?lock=3034',3),(224,35,'https://loremflickr.com/400/300/resort?lock=3035',3),(225,36,'https://loremflickr.com/400/300/hotel?lock=3036',3),(226,37,'https://loremflickr.com/400/300/hostel?lock=3037',3),(227,38,'https://loremflickr.com/400/300/hotel?lock=3038',3),(228,39,'https://loremflickr.com/400/300/departamento?lock=3039',3),(229,40,'https://loremflickr.com/400/300/resort?lock=3040',3),(230,41,'https://loremflickr.com/400/300/hotel?lock=3041',3),(231,42,'https://loremflickr.com/400/300/hostel?lock=3042',3),(232,43,'https://loremflickr.com/400/300/hotel?lock=3043',3),(233,44,'https://loremflickr.com/400/300/departamento?lock=3044',3),(234,45,'https://loremflickr.com/400/300/resort?lock=3045',3),(235,46,'https://loremflickr.com/400/300/hotel?lock=3046',3),(236,47,'https://loremflickr.com/400/300/hostel?lock=3047',3),(237,48,'https://loremflickr.com/400/300/hotel?lock=3048',3),(238,49,'https://loremflickr.com/400/300/departamento?lock=3049',3),(239,50,'https://loremflickr.com/400/300/resort?lock=3050',3),(240,51,'https://loremflickr.com/400/300/hotel?lock=3051',3);
/*!40000 ALTER TABLE `hoteles_imagenes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notificaciones`
--

DROP TABLE IF EXISTS `notificaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notificaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `tipo` enum('publicacion_aprobada','publicacion_rechazada','nueva_reserva','nueva_resena') NOT NULL,
  `mensaje` text NOT NULL,
  `leida` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notificaciones`
--

LOCK TABLES `notificaciones` WRITE;
/*!40000 ALTER TABLE `notificaciones` DISABLE KEYS */;
INSERT INTO `notificaciones` VALUES (1,1,'publicacion_aprobada','Tu publicación \"Cabaña del Lago\" fue aprobada.',0,'2026-09-03 22:53:53');
/*!40000 ALTER TABLE `notificaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publicaciones`
--

DROP TABLE IF EXISTS `publicaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publicaciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `tipo` enum('hotel','hostel','departamento','resort') NOT NULL,
  `ubicacion` varchar(150) NOT NULL,
  `destino` varchar(100) DEFAULT NULL,
  `precio_noche` decimal(10,2) NOT NULL,
  `descripcion` text,
  `estado` enum('borrador','pendiente','publicado','rechazado') DEFAULT 'pendiente',
  `motivo_rechazo` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `publicaciones_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publicaciones`
--

LOCK TABLES `publicaciones` WRITE;
/*!40000 ALTER TABLE `publicaciones` DISABLE KEYS */;
INSERT INTO `publicaciones` VALUES (1,1,'Cabaña del Lago','hotel','Bariloche, Argentina','Bariloche',120.00,'Hermosa cabaña con vista al lago Nahuel Huapi.','publicado',NULL,'2026-05-03 00:54:26');
/*!40000 ALTER TABLE `publicaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservas`
--

DROP TABLE IF EXISTS `reservas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `hotel_id` int DEFAULT NULL,
  `vuelo_id` int DEFAULT NULL,
  `fecha_entrada` date DEFAULT NULL,
  `fecha_salida` date DEFAULT NULL,
  `estado` enum('pendiente','confirmada','cancelada') DEFAULT 'pendiente',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `hotel_id` (`hotel_id`),
  KEY `vuelo_id` (`vuelo_id`),
  CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `reservas_ibfk_2` FOREIGN KEY (`hotel_id`) REFERENCES `hoteles` (`id`),
  CONSTRAINT `reservas_ibfk_3` FOREIGN KEY (`vuelo_id`) REFERENCES `vuelos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservas`
--

LOCK TABLES `reservas` WRITE;
/*!40000 ALTER TABLE `reservas` DISABLE KEYS */;
INSERT INTO `reservas` VALUES (1,1,1,NULL,'2026-06-01','2026-06-05','pendiente','2026-05-03 00:27:24');
/*!40000 ALTER TABLE `reservas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurantes`
--

DROP TABLE IF EXISTS `restaurantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurantes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `ubicacion` varchar(150) NOT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `rating` decimal(3,1) DEFAULT '0.0',
  `imagen` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurantes`
--

LOCK TABLES `restaurantes` WRITE;
/*!40000 ALTER TABLE `restaurantes` DISABLE KEYS */;
INSERT INTO `restaurantes` VALUES (2,'La Patagonia','Bariloche, Argentina','Parrilla',2500.00,4.8,'https://loremflickr.com/400/300/steakhouse,grill?lock=2','2026-05-03 01:37:58'),(3,'El Portal','Buenos Aires, Argentina','Italiano',1800.00,4.5,'https://loremflickr.com/400/300/italian,pasta?lock=3','2026-05-03 01:37:58'),(4,'La Cabrera','Buenos Aires, Argentina','Parrilla',3200.00,4.9,'https://loremflickr.com/400/300/steakhouse,grill?lock=4','2026-05-03 01:37:58'),(5,'Sushi Club','Buenos Aires, Argentina','Japonés',2800.00,4.6,'https://loremflickr.com/400/300/sushi,japanese?lock=5','2026-05-03 01:37:58'),(6,'El Bodegón','Mendoza, Argentina','Español',2000.00,4.4,'https://loremflickr.com/400/300/spanish,tapas?lock=6','2026-05-03 01:37:58'),(7,'La Trattoria','Córdoba, Argentina','Italiano',1900.00,4.3,'https://loremflickr.com/400/300/italian,pasta?lock=7','2026-05-03 01:37:58'),(8,'Don Julio','Buenos Aires, Argentina','Parrilla',3500.00,4.9,'https://loremflickr.com/400/300/steakhouse,grill?lock=8','2026-05-03 01:37:58'),(9,'El Viejo Almacén','Buenos Aires, Argentina','Tango y Cena',4000.00,4.7,'https://loremflickr.com/400/300/tango,dinner?lock=9','2026-05-03 01:37:58'),(10,'La Mar','Buenos Aires, Argentina','Mariscos',2600.00,4.5,'https://loremflickr.com/400/300/seafood,shrimp?lock=10','2026-05-03 01:37:58'),(11,'Tegui','Buenos Aires, Argentina','Alta Cocina',5000.00,4.8,'https://loremflickr.com/400/300/finedining,restaurant?lock=11','2026-05-03 01:37:58'),(12,'El Papagayo','Bariloche, Argentina','Patagónico',2800.00,4.6,'https://loremflickr.com/400/300/patagonia,food?lock=12','2026-05-03 01:37:58'),(13,'La Fonduta','Mendoza, Argentina','Italiano',2200.00,4.4,'https://loremflickr.com/400/300/italian,pasta?lock=13','2026-05-03 01:37:58'),(14,'El Quincho','Rosario, Argentina','Parrilla',2100.00,4.5,'https://loremflickr.com/400/300/steakhouse,grill?lock=14','2026-05-03 01:37:58'),(15,'Osaka','Buenos Aires, Argentina','Nikkei',3800.00,4.7,'https://loremflickr.com/400/300/nikkei,fusion?lock=15','2026-05-03 01:37:58'),(16,'La Zarina','Buenos Aires, Argentina','Ruso',2400.00,4.3,'https://loremflickr.com/400/300/russian,food?lock=16','2026-05-03 01:37:58'),(17,'El Preferido','Buenos Aires, Argentina','Porteño',1800.00,4.6,'https://loremflickr.com/400/300/bistro,cafe?lock=17','2026-05-03 01:37:58'),(18,'Chila','Buenos Aires, Argentina','Alta Cocina',5500.00,4.9,'https://loremflickr.com/400/300/finedining,restaurant?lock=18','2026-05-03 01:37:58'),(19,'La Pescadería','Mar del Plata, Argentina','Mariscos',2300.00,4.5,'https://loremflickr.com/400/300/seafood,shrimp?lock=19','2026-05-03 01:37:58'),(20,'El Gaucho','Salta, Argentina','Parrilla',1900.00,4.4,'https://loremflickr.com/400/300/steakhouse,grill?lock=20','2026-05-03 01:37:58'),(21,'Filo','Buenos Aires, Argentina','Italiano',2000.00,4.5,'https://loremflickr.com/400/300/italian,pasta?lock=21','2026-05-03 01:37:58'),(22,'La Malbequería','Mendoza, Argentina','Parrilla',2700.00,4.7,'https://loremflickr.com/400/300/steakhouse,grill?lock=22','2026-05-03 01:37:58'),(23,'El Rincón Norteño','Jujuy, Argentina','Regional',1500.00,4.3,'https://loremflickr.com/400/300/regional,food?lock=23','2026-05-03 01:37:58'),(24,'Siga la Vaca','Buenos Aires, Argentina','Parrilla',2500.00,4.4,'https://loremflickr.com/400/300/steakhouse,grill?lock=24','2026-05-03 01:37:58'),(25,'La Bourgogne','Buenos Aires, Argentina','Francés',6000.00,4.9,'https://loremflickr.com/400/300/french,cuisine?lock=25','2026-05-03 01:37:58'),(26,'El Mirador','Ushuaia, Argentina','Patagónico',3200.00,4.6,'https://loremflickr.com/400/300/patagonia,food?lock=26','2026-05-03 01:37:58'),(27,'Gran Bar Danzon','Buenos Aires, Argentina','Fusión',3000.00,4.5,'https://loremflickr.com/400/300/fusion,cuisine?lock=27','2026-05-03 01:37:58'),(28,'La Causa','Buenos Aires, Argentina','Peruano',2800.00,4.6,'https://loremflickr.com/400/300/peruvian,food?lock=28','2026-05-03 01:37:58'),(29,'El Estadio','Córdoba, Argentina','Parrilla',2000.00,4.3,'https://loremflickr.com/400/300/steakhouse,grill?lock=29','2026-05-03 01:37:58'),(30,'Tomo 1','Buenos Aires, Argentina','Alta Cocina',5200.00,4.8,'https://loremflickr.com/400/300/finedining,restaurant?lock=30','2026-05-03 01:37:58'),(31,'La Guitarrita','Buenos Aires, Argentina','Porteño',1700.00,4.4,'https://loremflickr.com/400/300/bistro,cafe?lock=31','2026-05-03 01:37:58'),(32,'El Almacén del Sur','Rosario, Argentina','Regional',1800.00,4.2,'https://loremflickr.com/400/300/regional,food?lock=32','2026-05-03 01:37:58'),(33,'Kalma Resto','Bariloche, Argentina','Patagónico',2900.00,4.7,'https://loremflickr.com/400/300/patagonia,food?lock=33','2026-05-03 01:37:58'),(34,'La Dama Juana','Mendoza, Argentina','Alta Cocina',4500.00,4.8,'https://loremflickr.com/400/300/finedining,restaurant?lock=34','2026-05-03 01:37:58'),(35,'El Puerto','Puerto Madryn, Argentina','Mariscos',2400.00,4.5,'https://loremflickr.com/400/300/seafood,shrimp?lock=35','2026-05-03 01:37:58'),(36,'Sirop Folie','Buenos Aires, Argentina','Francés',3800.00,4.7,'https://loremflickr.com/400/300/french,cuisine?lock=36','2026-05-03 01:37:58'),(37,'El Brote','Tucumán, Argentina','Regional',1600.00,4.2,'https://loremflickr.com/400/300/regional,food?lock=37','2026-05-03 01:37:58'),(38,'La Alquería','Buenos Aires, Argentina','Español',2600.00,4.4,'https://loremflickr.com/400/300/spanish,tapas?lock=38','2026-05-03 01:37:58'),(39,'Happening','Buenos Aires, Argentina','Parrilla',3400.00,4.6,'https://loremflickr.com/400/300/steakhouse,grill?lock=39','2026-05-03 01:37:58'),(40,'El Asador Patagónico','El Calafate, Argentina','Patagónico',3100.00,4.7,'https://loremflickr.com/400/300/patagonia,food?lock=40','2026-05-03 01:37:58'),(41,'Mostrador Santa Teresita','Buenos Aires, Argentina','Café',1200.00,4.5,'https://loremflickr.com/400/300/cafe,coffee?lock=41','2026-05-03 01:37:58'),(42,'El Ternero','Corrientes, Argentina','Parrilla',1800.00,4.3,'https://loremflickr.com/400/300/steakhouse,grill?lock=42','2026-05-03 01:37:58'),(43,'La Vinería','Mendoza, Argentina','Fusión',3200.00,4.6,'https://loremflickr.com/400/300/fusion,cuisine?lock=43','2026-05-03 01:37:58'),(44,'Cucina Paradiso','Buenos Aires, Argentina','Italiano',2500.00,4.5,'https://loremflickr.com/400/300/italian,pasta?lock=44','2026-05-03 01:37:58'),(45,'El Mesón','Salta, Argentina','Regional',1700.00,4.3,'https://loremflickr.com/400/300/regional,food?lock=45','2026-05-03 01:37:58'),(46,'Pura Tierra','Buenos Aires, Argentina','Orgánico',2900.00,4.6,'https://loremflickr.com/400/300/organic,vegetables?lock=46','2026-05-03 01:37:58'),(47,'La Cantina del Puerto','Rosario, Argentina','Mariscos',2200.00,4.4,'https://loremflickr.com/400/300/seafood,shrimp?lock=47','2026-05-03 01:37:58'),(48,'El Refugio','San Martín de los Andes, Argentina','Patagónico',2700.00,4.6,'https://loremflickr.com/400/300/patagonia,food?lock=48','2026-05-03 01:37:58'),(49,'Aramburu','Buenos Aires, Argentina','Alta Cocina',6500.00,4.9,'https://loremflickr.com/400/300/finedining,restaurant?lock=49','2026-05-03 01:37:58'),(50,'La Posta del Ángel','Córdoba, Argentina','Regional',1900.00,4.3,'https://loremflickr.com/400/300/regional,food?lock=50','2026-05-03 01:37:58'),(51,'El Faro','Mar del Plata, Argentina','Mariscos',2600.00,4.5,'https://loremflickr.com/400/300/seafood,shrimp?lock=51','2026-05-03 01:37:58');
/*!40000 ALTER TABLE `restaurantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `rol` enum('viajero','anfitrion','admin') DEFAULT 'viajero',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Test Usuario','test@test.com','scrypt:32768:8:1$Pa7tZbBWBc5C5qEl$cb0aa943385ad63ab1224c2e670ef6099b97546281fe962ad6e7f4395018bdcf5950262eb1a4a4b78bf5fd9794e394a9320225647580ecacc0ec754e3a2c9f7b',NULL,'admin','2026-04-30 00:27:45'),(2,'Emmanuel Hidalgo','emaildeprueba@hotmail.com','scrypt:32768:8:1$A3E8cGPky9LfNRRS$3b94984beb139c5ff0b2e83f5c207f3d13407b7dc4a62d4ab7a2295d02a3fbbcca8309d83695a4cdca9223fc493a45ae53ab2dad79aebbc697d09a704e57f265',NULL,'anfitrion','2026-05-03 01:15:53');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vuelos`
--

DROP TABLE IF EXISTS `vuelos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vuelos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `aerolinea` varchar(100) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `origen` varchar(100) NOT NULL,
  `destino` varchar(100) NOT NULL,
  `hora_salida` datetime NOT NULL,
  `hora_llegada` datetime NOT NULL,
  `duracion` varchar(20) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `escalas` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vuelos`
--

LOCK TABLES `vuelos` WRITE;
/*!40000 ALTER TABLE `vuelos` DISABLE KEYS */;
INSERT INTO `vuelos` VALUES (2,'Aerolíneas Argentinas',NULL,'Buenos Aires','Bariloche','2026-06-01 08:00:00','2026-06-01 10:30:00','2h 30m',85000.00,0,'2026-05-03 01:25:16'),(3,'Aerolíneas Argentinas',NULL,'Buenos Aires','Ushuaia','2026-06-02 06:00:00','2026-06-02 09:30:00','3h 30m',120000.00,0,'2026-05-03 01:25:16'),(4,'LATAM',NULL,'Buenos Aires','Mendoza','2026-06-03 12:00:00','2026-06-03 13:45:00','1h 45m',65000.00,0,'2026-05-03 01:25:16'),(5,'LATAM',NULL,'Buenos Aires','Córdoba','2026-06-04 07:00:00','2026-06-04 08:15:00','1h 15m',45000.00,0,'2026-05-03 01:25:16'),(6,'Flybondi',NULL,'Buenos Aires','Puerto Iguazú','2026-06-05 09:00:00','2026-06-05 11:00:00','2h 00m',55000.00,0,'2026-05-03 01:25:16'),(7,'Flybondi',NULL,'Córdoba','Bariloche','2026-06-06 14:00:00','2026-06-06 17:30:00','3h 30m',75000.00,1,'2026-05-03 01:25:16'),(8,'Aerolíneas Argentinas',NULL,'Mendoza','Buenos Aires','2026-06-07 18:00:00','2026-06-07 19:45:00','1h 45m',68000.00,0,'2026-05-03 01:25:16'),(9,'LATAM',NULL,'Buenos Aires','Bariloche','2026-06-08 10:00:00','2026-06-08 12:30:00','2h 30m',90000.00,0,'2026-05-03 01:25:16'),(10,'Aerolíneas Argentinas',NULL,'Buenos Aires','Salta','2026-06-09 07:30:00','2026-06-09 09:30:00','2h 00m',72000.00,0,'2026-05-03 01:25:16'),(11,'Flybondi',NULL,'Buenos Aires','Mar del Plata','2026-06-10 10:00:00','2026-06-10 11:00:00','1h 00m',35000.00,0,'2026-05-03 01:25:16'),(12,'LATAM',NULL,'Córdoba','Buenos Aires','2026-06-11 08:00:00','2026-06-11 09:15:00','1h 15m',48000.00,0,'2026-05-03 01:25:16'),(13,'Aerolíneas Argentinas',NULL,'Buenos Aires','Tucumán','2026-06-12 06:00:00','2026-06-12 08:00:00','2h 00m',70000.00,0,'2026-05-03 01:25:16'),(14,'Flybondi',NULL,'Buenos Aires','Neuquén','2026-06-13 09:00:00','2026-06-13 11:00:00','2h 00m',60000.00,0,'2026-05-03 01:25:16'),(15,'LATAM',NULL,'Buenos Aires','Rosario','2026-06-14 07:00:00','2026-06-14 07:45:00','0h 45m',30000.00,0,'2026-05-03 01:25:16'),(16,'Aerolíneas Argentinas',NULL,'Bariloche','Buenos Aires','2026-06-15 16:00:00','2026-06-15 18:30:00','2h 30m',88000.00,0,'2026-05-03 01:25:16'),(17,'Flybondi',NULL,'Buenos Aires','Jujuy','2026-06-16 08:00:00','2026-06-16 10:30:00','2h 30m',78000.00,0,'2026-05-03 01:25:16'),(18,'LATAM',NULL,'Mendoza','Córdoba','2026-06-17 12:00:00','2026-06-17 13:30:00','1h 30m',52000.00,0,'2026-05-03 01:25:16'),(19,'Aerolíneas Argentinas',NULL,'Buenos Aires','El Calafate','2026-06-18 07:00:00','2026-06-18 10:30:00','3h 30m',130000.00,0,'2026-05-03 01:25:16'),(20,'Flybondi',NULL,'Córdoba','Mendoza','2026-06-19 11:00:00','2026-06-19 12:30:00','1h 30m',55000.00,0,'2026-05-03 01:25:16'),(21,'LATAM',NULL,'Buenos Aires','Posadas','2026-06-20 09:00:00','2026-06-20 11:00:00','2h 00m',68000.00,0,'2026-05-03 01:25:16'),(22,'Aerolíneas Argentinas',NULL,'Salta','Buenos Aires','2026-06-21 15:00:00','2026-06-21 17:00:00','2h 00m',75000.00,0,'2026-05-03 01:25:16'),(23,'Flybondi',NULL,'Buenos Aires','Comodoro Rivadavia','2026-06-22 08:00:00','2026-06-22 10:30:00','2h 30m',82000.00,0,'2026-05-03 01:25:16'),(24,'LATAM',NULL,'Buenos Aires','San Juan','2026-06-23 10:00:00','2026-06-23 11:45:00','1h 45m',62000.00,0,'2026-05-03 01:25:16'),(25,'Aerolíneas Argentinas',NULL,'Tucumán','Buenos Aires','2026-06-24 14:00:00','2026-06-24 16:00:00','2h 00m',73000.00,0,'2026-05-03 01:25:16'),(26,'Flybondi',NULL,'Buenos Aires','Resistencia','2026-06-25 07:00:00','2026-06-25 09:00:00','2h 00m',65000.00,0,'2026-05-03 01:25:16'),(27,'LATAM',NULL,'Bariloche','Mendoza','2026-06-26 11:00:00','2026-06-26 13:30:00','2h 30m',78000.00,1,'2026-05-03 01:25:16'),(28,'Aerolíneas Argentinas',NULL,'Buenos Aires','Puerto Madryn','2026-06-27 09:00:00','2026-06-27 11:00:00','2h 00m',80000.00,0,'2026-05-03 01:25:16'),(29,'Flybondi',NULL,'Córdoba','Salta','2026-06-28 08:00:00','2026-06-28 10:00:00','2h 00m',70000.00,0,'2026-05-03 01:25:16'),(30,'LATAM',NULL,'Buenos Aires','Trelew','2026-06-29 10:00:00','2026-06-29 12:00:00','2h 00m',75000.00,0,'2026-05-03 01:25:16'),(31,'Aerolíneas Argentinas',NULL,'El Calafate','Buenos Aires','2026-06-30 15:00:00','2026-06-30 18:30:00','3h 30m',135000.00,0,'2026-05-03 01:25:16'),(32,'Flybondi',NULL,'Buenos Aires','La Rioja','2026-07-01 08:00:00','2026-07-01 10:00:00','2h 00m',68000.00,0,'2026-05-03 01:25:16'),(33,'LATAM',NULL,'Mendoza','Buenos Aires','2026-07-02 16:00:00','2026-07-02 17:45:00','1h 45m',66000.00,0,'2026-05-03 01:25:16'),(34,'Aerolíneas Argentinas',NULL,'Buenos Aires','Formosa','2026-07-03 07:00:00','2026-07-03 09:30:00','2h 30m',72000.00,0,'2026-05-03 01:25:16'),(35,'Flybondi',NULL,'Córdoba','Puerto Iguazú','2026-07-04 09:00:00','2026-07-04 11:30:00','2h 30m',80000.00,1,'2026-05-03 01:25:16'),(36,'LATAM',NULL,'Buenos Aires','Santa Rosa','2026-07-05 10:00:00','2026-07-05 11:15:00','1h 15m',42000.00,0,'2026-05-03 01:25:16'),(37,'Aerolíneas Argentinas',NULL,'Ushuaia','Buenos Aires','2026-07-06 14:00:00','2026-07-06 17:30:00','3h 30m',125000.00,0,'2026-05-03 01:25:16'),(38,'Flybondi',NULL,'Buenos Aires','Viedma','2026-07-07 08:00:00','2026-07-07 09:30:00','1h 30m',55000.00,0,'2026-05-03 01:25:16'),(39,'LATAM',NULL,'Salta','Córdoba','2026-07-08 11:00:00','2026-07-08 13:00:00','2h 00m',68000.00,0,'2026-05-03 01:25:16'),(40,'Aerolíneas Argentinas',NULL,'Buenos Aires','San Luis','2026-07-09 09:00:00','2026-07-09 10:30:00','1h 30m',58000.00,0,'2026-05-03 01:25:16'),(41,'Flybondi',NULL,'Mendoza','Bariloche','2026-07-10 10:00:00','2026-07-10 12:30:00','2h 30m',82000.00,1,'2026-05-03 01:25:16'),(42,'LATAM',NULL,'Buenos Aires','Corrientes','2026-07-11 08:00:00','2026-07-11 10:00:00','2h 00m',70000.00,0,'2026-05-03 01:25:16'),(43,'Aerolíneas Argentinas',NULL,'Córdoba','Ushuaia','2026-07-12 06:00:00','2026-07-12 10:30:00','4h 30m',145000.00,1,'2026-05-03 01:25:16'),(44,'Flybondi',NULL,'Buenos Aires','Catamarca','2026-07-13 09:00:00','2026-07-13 11:00:00','2h 00m',72000.00,0,'2026-05-03 01:25:16'),(45,'LATAM',NULL,'Bariloche','Buenos Aires','2026-07-14 17:00:00','2026-07-14 19:30:00','2h 30m',92000.00,0,'2026-05-03 01:25:16'),(46,'Aerolíneas Argentinas',NULL,'Buenos Aires','Río Gallegos','2026-07-15 07:00:00','2026-07-15 10:00:00','3h 00m',110000.00,0,'2026-05-03 01:25:16'),(47,'Flybondi',NULL,'Córdoba','Tucumán','2026-07-16 08:00:00','2026-07-16 09:30:00','1h 30m',52000.00,0,'2026-05-03 01:25:16'),(48,'LATAM',NULL,'Buenos Aires','Neuquén','2026-07-17 10:00:00','2026-07-17 12:00:00','2h 00m',65000.00,0,'2026-05-03 01:25:16'),(49,'Aerolíneas Argentinas',NULL,'Mendoza','Salta','2026-07-18 11:00:00','2026-07-18 13:30:00','2h 30m',78000.00,1,'2026-05-03 01:25:16'),(50,'Flybondi',NULL,'Buenos Aires','Reconquista','2026-07-19 09:00:00','2026-07-19 10:30:00','1h 30m',58000.00,0,'2026-05-03 01:25:16'),(51,'LATAM',NULL,'El Calafate','Bariloche','2026-07-20 12:00:00','2026-07-20 14:00:00','2h 00m',95000.00,0,'2026-05-03 01:25:16');
/*!40000 ALTER TABLE `vuelos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'adventure'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-08 17:45:29

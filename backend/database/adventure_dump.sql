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
INSERT INTO `entretenimiento` VALUES (1,'Festival de Jazz','Bariloche, Argentina','2026-06-15','Música','https://picsum.photos/seed/evento1/400/300','Festival de jazz en el centro de Bariloche.','2026-05-03 00:48:33'),(2,'Festival de Jazz de Buenos Aires','Buenos Aires, Argentina','2026-06-10','Música','https://picsum.photos/seed/evento2/400/300','El festival de jazz más importante del país.','2026-05-03 01:22:35'),(3,'Vendimia 2026','Mendoza, Argentina','2026-06-15','Festival','https://picsum.photos/seed/evento3/400/300','La fiesta nacional de la vendimia.','2026-05-03 01:22:35'),(4,'Tango en La Boca','Buenos Aires, Argentina','2026-06-20','Espectáculo','https://picsum.photos/seed/evento4/400/300','Show de tango en vivo en La Boca.','2026-05-03 01:22:35'),(5,'Fiesta del Chocolate','Bariloche, Argentina','2026-06-25','Festival','https://picsum.photos/seed/evento5/400/300','El festival del chocolate más grande de la Patagonia.','2026-05-03 01:22:35'),(6,'Rock en el Parque','Córdoba, Argentina','2026-07-01','Música','https://picsum.photos/seed/evento6/400/300','Festival de rock con las mejores bandas del país.','2026-05-03 01:22:35'),(7,'Carnaval de Gualeguaychú','Gualeguaychú, Argentina','2026-07-05','Carnaval','https://picsum.photos/seed/evento7/400/300','El carnaval más espectacular de Argentina.','2026-05-03 01:22:35'),(8,'Muestra de Cine Independiente','Buenos Aires, Argentina','2026-07-10','Cine','https://picsum.photos/seed/evento8/400/300','Festival de cine independiente internacional.','2026-05-03 01:22:35'),(9,'Noche de las Estrellas','San Juan, Argentina','2026-07-15','Ciencia','https://picsum.photos/seed/evento9/400/300','Observación astronómica en el observatorio.','2026-05-03 01:22:35'),(10,'Festival de Folclore','Cosquín, Argentina','2026-07-20','Música','https://picsum.photos/seed/evento10/400/300','El festival de folclore más importante del país.','2026-05-03 01:22:35'),(11,'Feria del Libro','Buenos Aires, Argentina','2026-07-25','Cultural','https://picsum.photos/seed/evento11/400/300','La feria del libro más grande de América Latina.','2026-05-03 01:22:35'),(12,'Festival de Tango','Buenos Aires, Argentina','2026-08-01','Danza','https://picsum.photos/seed/evento12/400/300','El festival de tango más grande del mundo.','2026-05-03 01:22:35'),(13,'Expo Vinos Mendoza','Mendoza, Argentina','2026-08-05','Gastronomía','https://picsum.photos/seed/evento13/400/300','Exposición de los mejores vinos argentinos.','2026-05-03 01:22:35'),(14,'Festival de la Cerveza','Villa General Belgrano, Argentina','2026-08-10','Festival','https://picsum.photos/seed/evento14/400/300','Oktoberfest a la argentina en la ciudad alemana.','2026-05-03 01:22:35'),(15,'Noche de los Museos','Buenos Aires, Argentina','2026-08-15','Cultural','https://picsum.photos/seed/evento15/400/300','Una noche especial con museos abiertos y gratuitos.','2026-05-03 01:22:35'),(16,'Festival de Cine de Mar del Plata','Mar del Plata, Argentina','2026-08-20','Cine','https://picsum.photos/seed/evento16/400/300','El festival de cine más importante de Argentina.','2026-05-03 01:22:35'),(17,'Maratón de Buenos Aires','Buenos Aires, Argentina','2026-08-25','Deporte','https://picsum.photos/seed/evento17/400/300','La maratón más grande de Argentina.','2026-05-03 01:22:35'),(18,'Festival de Danzas Folklóricas','Salta, Argentina','2026-09-01','Danza','https://picsum.photos/seed/evento18/400/300','Festival de danzas folklóricas del norte argentino.','2026-05-03 01:22:35'),(19,'Expo Tecnología','Buenos Aires, Argentina','2026-09-05','Tecnología','https://picsum.photos/seed/evento19/400/300','La mayor exposición de tecnología del país.','2026-05-03 01:22:35'),(20,'Festival de Teatro','Córdoba, Argentina','2026-09-10','Teatro','https://picsum.photos/seed/evento20/400/300','Festival internacional de teatro en Córdoba.','2026-05-03 01:22:35'),(21,'Fiesta Nacional del Poncho','Catamarca, Argentina','2026-09-15','Cultural','https://picsum.photos/seed/evento21/400/300','La fiesta del poncho más grande del país.','2026-05-03 01:22:35'),(22,'Festival de Surf','Mar del Plata, Argentina','2026-09-20','Deporte','https://picsum.photos/seed/evento22/400/300','Campeonato nacional de surf en la costa atlántica.','2026-05-03 01:22:35'),(23,'Feria Artesanal Patagónica','Bariloche, Argentina','2026-09-25','Cultural','https://picsum.photos/seed/evento23/400/300','Feria de artesanías y productos regionales.','2026-05-03 01:22:35'),(24,'Festival de Música Clásica','Buenos Aires, Argentina','2026-10-01','Música','https://picsum.photos/seed/evento24/400/300','Festival internacional de música clásica.','2026-05-03 01:22:35'),(25,'Exposición de Arte Contemporáneo','Buenos Aires, Argentina','2026-10-05','Arte','https://picsum.photos/seed/evento25/400/300','La mayor exposición de arte contemporáneo del país.','2026-05-03 01:22:35'),(26,'Festival Gastronómico','Rosario, Argentina','2026-10-10','Gastronomía','https://picsum.photos/seed/evento26/400/300','Festival de gastronomía con chefs de todo el mundo.','2026-05-03 01:22:35'),(27,'Carnaval de Corrientes','Corrientes, Argentina','2026-10-15','Carnaval','https://picsum.photos/seed/evento27/400/300','El carnaval más colorido del norte argentino.','2026-05-03 01:22:35'),(28,'Festival de Hip Hop','Buenos Aires, Argentina','2026-10-20','Música','https://picsum.photos/seed/evento28/400/300','El festival de hip hop más grande de Argentina.','2026-05-03 01:22:35'),(29,'Expo Agro','Palermo, Argentina','2026-10-25','Agricultura','https://picsum.photos/seed/evento29/400/300','La exposición agropecuaria más importante del país.','2026-05-03 01:22:35'),(30,'Festival de Flamenco','Buenos Aires, Argentina','2026-11-01','Danza','https://picsum.photos/seed/evento30/400/300','Festival internacional de flamenco.','2026-05-03 01:22:35'),(31,'Maratón de Mendoza','Mendoza, Argentina','2026-11-05','Deporte','https://picsum.photos/seed/evento31/400/300','Maratón entre viñedos y montañas.','2026-05-03 01:22:35'),(32,'Festival de Cumbia','Córdoba, Argentina','2026-11-10','Música','https://picsum.photos/seed/evento32/400/300','El festival de cumbia más grande del interior.','2026-05-03 01:22:35'),(33,'Feria de Artesanos','San Telmo, Argentina','2026-11-15','Cultural','https://picsum.photos/seed/evento33/400/300','Feria de artesanos en el histórico barrio de San Telmo.','2026-05-03 01:22:35'),(34,'Festival de Ciencia','Buenos Aires, Argentina','2026-11-20','Ciencia','https://picsum.photos/seed/evento34/400/300','Festival de ciencia y tecnología para toda la familia.','2026-05-03 01:22:35'),(35,'Show de Magia','Buenos Aires, Argentina','2026-11-25','Espectáculo','https://picsum.photos/seed/evento35/400/300','El show de magia más impresionante del año.','2026-05-03 01:22:35'),(36,'Festival de Reggae','Mar del Plata, Argentina','2026-12-01','Música','https://picsum.photos/seed/evento36/400/300','Festival de reggae en la costa atlántica.','2026-05-03 01:22:35'),(37,'Feria de Navidad','Buenos Aires, Argentina','2026-12-05','Festival','https://picsum.photos/seed/evento37/400/300','La feria navideña más grande de Argentina.','2026-05-03 01:22:35'),(38,'Festival de Fuegos Artificiales','Bariloche, Argentina','2026-12-10','Espectáculo','https://picsum.photos/seed/evento38/400/300','Espectáculo de fuegos artificiales sobre el lago.','2026-05-03 01:22:35'),(39,'Noche Buena Musical','Córdoba, Argentina','2026-12-15','Música','https://picsum.photos/seed/evento39/400/300','Concierto especial de navidad en el centro.','2026-05-03 01:22:35'),(40,'Festival de Verano','Pinamar, Argentina','2026-12-20','Festival','https://picsum.photos/seed/evento40/400/300','El festival de verano más esperado de la costa.','2026-05-03 01:22:35'),(41,'Año Nuevo en Buenos Aires','Buenos Aires, Argentina','2026-12-25','Espectáculo','https://picsum.photos/seed/evento41/400/300','La celebración de año nuevo más grande del país.','2026-05-03 01:22:35'),(42,'Festival de Electrónica','Buenos Aires, Argentina','2026-12-28','Música','https://picsum.photos/seed/evento42/400/300','Festival de música electrónica a fin de año.','2026-05-03 01:22:35'),(43,'Expo Motos','Buenos Aires, Argentina','2026-12-30','Tecnología','https://picsum.photos/seed/evento43/400/300','Exposición de motos y accesorios.','2026-05-03 01:22:35'),(44,'Festival de Opera','Buenos Aires, Argentina','2027-01-05','Música','https://picsum.photos/seed/evento44/400/300','Festival de ópera en el Teatro Colón.','2026-05-03 01:22:35'),(45,'Torneo de Polo','Palermo, Argentina','2027-01-10','Deporte','https://picsum.photos/seed/evento45/400/300','El torneo de polo más importante del mundo.','2026-05-03 01:22:35'),(46,'Festival de Fotografía','Rosario, Argentina','2027-01-15','Arte','https://picsum.photos/seed/evento46/400/300','Festival internacional de fotografía.','2026-05-03 01:22:35'),(47,'Expo Comic','Buenos Aires, Argentina','2027-01-20','Cultural','https://picsum.photos/seed/evento47/400/300','La exposición de comics y anime más grande del país.','2026-05-03 01:22:35'),(48,'Festival de Blues','Buenos Aires, Argentina','2027-01-25','Música','https://picsum.photos/seed/evento48/400/300','Festival de blues con artistas internacionales.','2026-05-03 01:22:35'),(49,'Carrera de Autos','San Juan, Argentina','2027-02-01','Deporte','https://picsum.photos/seed/evento49/400/300','Carrera de autos en el circuito de San Juan.','2026-05-03 01:22:35'),(50,'Festival de Murga','Montevideo, Uruguay','2027-02-05','Carnaval','https://picsum.photos/seed/evento50/400/300','El festival de murga más grande del Río de la Plata.','2026-05-03 01:22:35'),(51,'Expo Gastronomía Patagónica','Bariloche, Argentina','2027-02-10','Gastronomía','https://picsum.photos/seed/evento51/400/300','Exposición de gastronomía patagónica.','2026-05-03 01:22:35');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritos`
--

LOCK TABLES `favoritos` WRITE;
/*!40000 ALTER TABLE `favoritos` DISABLE KEYS */;
INSERT INTO `favoritos` VALUES (2,2,'hotel',1,'2026-05-03 01:45:30'),(3,2,'entretenimiento',3,'2026-05-03 01:45:41'),(6,2,'hotel',4,'2026-05-27 01:59:21'),(7,2,'restaurante',2,'2026-05-27 02:02:06'),(8,1,'hotel',1,'2026-10-19 22:14:42');
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
INSERT INTO `hoteles` VALUES (1,'Hotel Patagonia','Bariloche, Argentina','Hotel con vista al lago',150.00,4.5,'hotel','https://picsum.photos/seed/hotel1/400/300',NULL,'2026-05-03 00:19:03'),(2,'Hotel Llao Llao','Bariloche, Argentina','Hotel de lujo con vista al lago Nahuel Huapi.',350.00,4.9,'resort','https://picsum.photos/seed/hotel2/400/300',NULL,'2026-05-03 01:24:21'),(3,'Hostel El Mochilero','Buenos Aires, Argentina','Hostel céntrico ideal para viajeros.',25.00,4.2,'hostel','https://picsum.photos/seed/hotel3/400/300',NULL,'2026-05-03 01:24:21'),(4,'Departamento Palermo','Buenos Aires, Argentina','Moderno departamento en Palermo.',80.00,4.5,'departamento','https://picsum.photos/seed/hotel4/400/300',NULL,'2026-05-03 01:24:21'),(5,'Hotel Panamericano','Buenos Aires, Argentina','Hotel 5 estrellas en el centro porteño.',200.00,4.7,'hotel','https://picsum.photos/seed/hotel5/400/300',NULL,'2026-05-03 01:24:21'),(6,'Cabaña Los Andes','Mendoza, Argentina','Cabaña rústica con vista a la cordillera.',120.00,4.6,'hotel','https://picsum.photos/seed/hotel6/400/300',NULL,'2026-05-03 01:24:21'),(7,'Hotel Ushuaia','Ushuaia, Argentina','Hotel en el fin del mundo.',180.00,4.8,'hotel','https://picsum.photos/seed/hotel7/400/300',NULL,'2026-05-03 01:24:21'),(8,'Hostel Córdoba Centro','Córdoba, Argentina','Hostel moderno en el centro.',20.00,4.1,'hostel','https://picsum.photos/seed/hotel8/400/300',NULL,'2026-05-03 01:24:21'),(9,'Resort Iguazú','Puerto Iguazú, Argentina','Resort de lujo a minutos de las cataratas.',280.00,4.9,'resort','https://picsum.photos/seed/hotel9/400/300',NULL,'2026-05-03 01:24:21'),(10,'Hotel Salta Colonial','Salta, Argentina','Hotel colonial en el centro histórico.',95.00,4.4,'hotel','https://picsum.photos/seed/hotel10/400/300',NULL,'2026-05-03 01:24:21'),(11,'Apart Hotel Rosario','Rosario, Argentina','Apart hotel moderno frente al río Paraná.',70.00,4.3,'departamento','https://picsum.photos/seed/hotel11/400/300',NULL,'2026-05-03 01:24:21'),(12,'Hotel Mar del Plata','Mar del Plata, Argentina','Hotel frente al mar con vista espectacular.',150.00,4.5,'hotel','https://picsum.photos/seed/hotel12/400/300',NULL,'2026-05-03 01:24:21'),(13,'Hostel Patagonia','El Calafate, Argentina','Hostel acogedor cerca del Perito Moreno.',30.00,4.3,'hostel','https://picsum.photos/seed/hotel13/400/300',NULL,'2026-05-03 01:24:21'),(14,'Resort Las Leñas','Malargüe, Argentina','Resort de ski en la montaña.',320.00,4.8,'resort','https://picsum.photos/seed/hotel14/400/300',NULL,'2026-05-03 01:24:21'),(15,'Hotel Tucumán Plaza','Tucumán, Argentina','Hotel en el centro de la ciudad jardín.',85.00,4.2,'hotel','https://picsum.photos/seed/hotel15/400/300',NULL,'2026-05-03 01:24:21'),(16,'Departamento Puerto Madero','Buenos Aires, Argentina','Lujoso departamento en Puerto Madero.',250.00,4.8,'departamento','https://picsum.photos/seed/hotel16/400/300',NULL,'2026-05-03 01:24:21'),(17,'Hostel Mendoza Wine','Mendoza, Argentina','Hostel temático del vino.',22.00,4.4,'hostel','https://picsum.photos/seed/hotel17/400/300',NULL,'2026-05-03 01:24:21'),(18,'Hotel Glaciar','El Calafate, Argentina','Hotel con vista al lago Argentino.',220.00,4.7,'hotel','https://picsum.photos/seed/hotel18/400/300',NULL,'2026-05-03 01:24:21'),(19,'Apart Neuquén','Neuquén, Argentina','Cómodo apart hotel en la capital neuquina.',65.00,4.0,'departamento','https://picsum.photos/seed/hotel19/400/300',NULL,'2026-05-03 01:24:21'),(20,'Resort Termas de Río Hondo','Santiago del Estero, Argentina','Resort termal de lujo.',180.00,4.6,'resort','https://picsum.photos/seed/hotel20/400/300',NULL,'2026-05-03 01:24:21'),(21,'Hotel Jujuy Colonial','Jujuy, Argentina','Hotel colonial cerca de la Quebrada de Humahuaca.',90.00,4.5,'hotel','https://picsum.photos/seed/hotel21/400/300',NULL,'2026-05-03 01:24:21'),(22,'Hostel Iguazú Jungle','Puerto Iguazú, Argentina','Hostel en medio de la selva.',28.00,4.3,'hostel','https://picsum.photos/seed/hotel22/400/300',NULL,'2026-05-03 01:24:21'),(23,'Hotel Recoleta','Buenos Aires, Argentina','Elegante hotel en el barrio de Recoleta.',230.00,4.8,'hotel','https://picsum.photos/seed/hotel23/400/300',NULL,'2026-05-03 01:24:21'),(24,'Departamento Microcentro','Buenos Aires, Argentina','Departamento ejecutivo en el microcentro.',75.00,4.1,'departamento','https://picsum.photos/seed/hotel24/400/300',NULL,'2026-05-03 01:24:21'),(25,'Resort Chapelco','San Martín de los Andes, Argentina','Resort de ski con vista a los Andes.',300.00,4.7,'resort','https://picsum.photos/seed/hotel25/400/300',NULL,'2026-05-03 01:24:21'),(26,'Hotel Villa La Angostura','Villa La Angostura, Argentina','Hotel boutique en la Patagonia.',160.00,4.6,'hotel','https://picsum.photos/seed/hotel26/400/300',NULL,'2026-05-03 01:24:21'),(27,'Hostel San Telmo','Buenos Aires, Argentina','Hostel en el barrio histórico de San Telmo.',18.00,4.2,'hostel','https://picsum.photos/seed/hotel27/400/300',NULL,'2026-05-03 01:24:21'),(28,'Hotel Posadas','Posadas, Argentina','Hotel moderno en la capital misionera.',80.00,4.1,'hotel','https://picsum.photos/seed/hotel28/400/300',NULL,'2026-05-03 01:24:21'),(29,'Apart Hotel Palermo Soho','Buenos Aires, Argentina','Apart hotel en Palermo Soho.',110.00,4.5,'departamento','https://picsum.photos/seed/hotel29/400/300',NULL,'2026-05-03 01:24:21'),(30,'Resort Costa Galana','Mar del Plata, Argentina','Resort frente al mar.',260.00,4.8,'resort','https://picsum.photos/seed/hotel30/400/300',NULL,'2026-05-03 01:24:21'),(31,'Hotel Bariloche Centro','Bariloche, Argentina','Hotel céntrico a pasos del lago.',140.00,4.4,'hotel','https://picsum.photos/seed/hotel31/400/300',NULL,'2026-05-03 01:24:21'),(32,'Hostel Salta Vieja','Salta, Argentina','Hostel en el casco histórico de Salta.',22.00,4.3,'hostel','https://picsum.photos/seed/hotel32/400/300',NULL,'2026-05-03 01:24:21'),(33,'Hotel Corrientes','Corrientes, Argentina','Hotel con vista al río Paraná.',75.00,4.0,'hotel','https://picsum.photos/seed/hotel33/400/300',NULL,'2026-05-03 01:24:21'),(34,'Departamento Belgrano','Buenos Aires, Argentina','Departamento amplio en Belgrano.',90.00,4.3,'departamento','https://picsum.photos/seed/hotel34/400/300',NULL,'2026-05-03 01:24:21'),(35,'Resort Villa Carlos Paz','Villa Carlos Paz, Argentina','Resort a orillas del lago San Roque.',190.00,4.5,'resort','https://picsum.photos/seed/hotel35/400/300',NULL,'2026-05-03 01:24:21'),(36,'Hotel Tandil','Tandil, Argentina','Hotel boutique en las sierras.',100.00,4.4,'hotel','https://picsum.photos/seed/hotel36/400/300',NULL,'2026-05-03 01:24:21'),(37,'Hostel Rosario Centro','Rosario, Argentina','Hostel moderno en el centro de Rosario.',20.00,4.1,'hostel','https://picsum.photos/seed/hotel37/400/300',NULL,'2026-05-03 01:24:21'),(38,'Hotel Comodoro Rivadavia','Comodoro Rivadavia, Argentina','Hotel moderno en la Patagonia.',110.00,4.2,'hotel','https://picsum.photos/seed/hotel38/400/300',NULL,'2026-05-03 01:24:21'),(39,'Apart Hotel Córdoba','Córdoba, Argentina','Apart hotel moderno en Nueva Córdoba.',70.00,4.2,'departamento','https://picsum.photos/seed/hotel39/400/300',NULL,'2026-05-03 01:24:21'),(40,'Resort Termas de Cacheuta','Mendoza, Argentina','Resort termal en las montañas.',210.00,4.7,'resort','https://picsum.photos/seed/hotel40/400/300',NULL,'2026-05-03 01:24:21'),(41,'Hotel San Juan','San Juan, Argentina','Hotel moderno en la ciudad del sol.',85.00,4.1,'hotel','https://picsum.photos/seed/hotel41/400/300',NULL,'2026-05-03 01:24:21'),(42,'Hostel Trelew','Trelew, Argentina','Hostel galés en la Patagonia.',20.00,4.0,'hostel','https://picsum.photos/seed/hotel42/400/300',NULL,'2026-05-03 01:24:21'),(43,'Hotel La Rioja','La Rioja, Argentina','Hotel en el corazón de La Rioja.',75.00,4.0,'hotel','https://picsum.photos/seed/hotel43/400/300',NULL,'2026-05-03 01:24:21'),(44,'Departamento San Isidro','San Isidro, Argentina','Departamento en el exclusivo San Isidro.',130.00,4.4,'departamento','https://picsum.photos/seed/hotel44/400/300',NULL,'2026-05-03 01:24:21'),(45,'Resort Pinamar','Pinamar, Argentina','Resort frente al mar en Pinamar.',240.00,4.6,'resort','https://picsum.photos/seed/hotel45/400/300',NULL,'2026-05-03 01:24:21'),(46,'Hotel Resistencia','Resistencia, Argentina','Hotel moderno en el Chaco.',70.00,3.9,'hotel','https://picsum.photos/seed/hotel46/400/300',NULL,'2026-05-03 01:24:21'),(47,'Hostel Mendoza Central','Mendoza, Argentina','Hostel en el centro de Mendoza.',18.00,4.2,'hostel','https://picsum.photos/seed/hotel47/400/300',NULL,'2026-05-03 01:24:21'),(48,'Hotel Puerto Madryn','Puerto Madryn, Argentina','Hotel frente al mar con avistaje de ballenas.',130.00,4.5,'hotel','https://picsum.photos/seed/hotel48/400/300',NULL,'2026-05-03 01:24:21'),(49,'Apart Hotel Tigre','Tigre, Argentina','Apart hotel en el delta del Paraná.',95.00,4.3,'departamento','https://picsum.photos/seed/hotel49/400/300',NULL,'2026-05-03 01:24:21'),(50,'Resort Miramar','Miramar, Argentina','Resort familiar frente al mar.',170.00,4.4,'resort','https://picsum.photos/seed/hotel50/400/300',NULL,'2026-05-03 01:24:21'),(51,'Hotel Formosa','Formosa, Argentina','Hotel en el norte del país.',65.00,3.8,'hotel','https://picsum.photos/seed/hotel51/400/300',NULL,'2026-05-03 01:24:21');
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
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoteles_imagenes`
--

LOCK TABLES `hoteles_imagenes` WRITE;
/*!40000 ALTER TABLE `hoteles_imagenes` DISABLE KEYS */;
INSERT INTO `hoteles_imagenes` VALUES (1,1,'https://picsum.photos/seed/hotelimg1/800/500',0),(2,2,'https://picsum.photos/seed/hotelimg2/800/500',0),(3,3,'https://picsum.photos/seed/hotelimg3/800/500',0),(4,4,'https://picsum.photos/seed/hotelimg4/800/500',0),(5,5,'https://picsum.photos/seed/hotelimg5/800/500',0),(6,6,'https://picsum.photos/seed/hotelimg6/800/500',0),(7,7,'https://picsum.photos/seed/hotelimg7/800/500',0),(8,8,'https://picsum.photos/seed/hotelimg8/800/500',0),(9,9,'https://picsum.photos/seed/hotelimg9/800/500',0),(10,10,'https://picsum.photos/seed/hotelimg10/800/500',0),(11,11,'https://picsum.photos/seed/hotelimg11/800/500',0),(12,12,'https://picsum.photos/seed/hotelimg12/800/500',0),(13,13,'https://picsum.photos/seed/hotelimg13/800/500',0),(14,14,'https://picsum.photos/seed/hotelimg14/800/500',0),(15,15,'https://picsum.photos/seed/hotelimg15/800/500',0),(16,16,'https://picsum.photos/seed/hotelimg16/800/500',0),(17,17,'https://picsum.photos/seed/hotelimg17/800/500',0),(18,18,'https://picsum.photos/seed/hotelimg18/800/500',0),(19,19,'https://picsum.photos/seed/hotelimg19/800/500',0),(20,20,'https://picsum.photos/seed/hotelimg20/800/500',0),(21,21,'https://picsum.photos/seed/hotelimg21/800/500',0),(22,22,'https://picsum.photos/seed/hotelimg22/800/500',0),(23,23,'https://picsum.photos/seed/hotelimg23/800/500',0),(24,24,'https://picsum.photos/seed/hotelimg24/800/500',0),(25,25,'https://picsum.photos/seed/hotelimg25/800/500',0),(26,26,'https://picsum.photos/seed/hotelimg26/800/500',0),(27,27,'https://picsum.photos/seed/hotelimg27/800/500',0),(28,28,'https://picsum.photos/seed/hotelimg28/800/500',0),(29,29,'https://picsum.photos/seed/hotelimg29/800/500',0),(30,30,'https://picsum.photos/seed/hotelimg30/800/500',0),(31,31,'https://picsum.photos/seed/hotelimg31/800/500',0),(32,32,'https://picsum.photos/seed/hotelimg32/800/500',0),(33,33,'https://picsum.photos/seed/hotelimg33/800/500',0),(34,34,'https://picsum.photos/seed/hotelimg34/800/500',0),(35,35,'https://picsum.photos/seed/hotelimg35/800/500',0),(36,36,'https://picsum.photos/seed/hotelimg36/800/500',0),(37,37,'https://picsum.photos/seed/hotelimg37/800/500',0),(38,38,'https://picsum.photos/seed/hotelimg38/800/500',0),(39,39,'https://picsum.photos/seed/hotelimg39/800/500',0),(40,40,'https://picsum.photos/seed/hotelimg40/800/500',0),(41,41,'https://picsum.photos/seed/hotelimg41/800/500',0),(42,42,'https://picsum.photos/seed/hotelimg42/800/500',0),(43,43,'https://picsum.photos/seed/hotelimg43/800/500',0),(44,44,'https://picsum.photos/seed/hotelimg44/800/500',0),(45,45,'https://picsum.photos/seed/hotelimg45/800/500',0),(46,46,'https://picsum.photos/seed/hotelimg46/800/500',0),(47,47,'https://picsum.photos/seed/hotelimg47/800/500',0),(48,48,'https://picsum.photos/seed/hotelimg48/800/500',0),(49,49,'https://picsum.photos/seed/hotelimg49/800/500',0),(50,50,'https://picsum.photos/seed/hotelimg50/800/500',0),(51,51,'https://picsum.photos/seed/hotelimg51/800/500',0),(64,1,'https://picsum.photos/seed/hotelimg64/800/500',1),(65,2,'https://picsum.photos/seed/hotelimg65/800/500',1),(66,3,'https://picsum.photos/seed/hotelimg66/800/500',1),(67,4,'https://picsum.photos/seed/hotelimg67/800/500',1),(68,5,'https://picsum.photos/seed/hotelimg68/800/500',1),(69,6,'https://picsum.photos/seed/hotelimg69/800/500',1),(70,7,'https://picsum.photos/seed/hotelimg70/800/500',1),(71,8,'https://picsum.photos/seed/hotelimg71/800/500',1),(72,9,'https://picsum.photos/seed/hotelimg72/800/500',1),(73,10,'https://picsum.photos/seed/hotelimg73/800/500',1),(74,11,'https://picsum.photos/seed/hotelimg74/800/500',1),(75,12,'https://picsum.photos/seed/hotelimg75/800/500',1),(76,13,'https://picsum.photos/seed/hotelimg76/800/500',1),(77,14,'https://picsum.photos/seed/hotelimg77/800/500',1),(78,15,'https://picsum.photos/seed/hotelimg78/800/500',1),(79,16,'https://picsum.photos/seed/hotelimg79/800/500',1),(80,17,'https://picsum.photos/seed/hotelimg80/800/500',1),(81,18,'https://picsum.photos/seed/hotelimg81/800/500',1),(82,19,'https://picsum.photos/seed/hotelimg82/800/500',1),(83,20,'https://picsum.photos/seed/hotelimg83/800/500',1),(84,21,'https://picsum.photos/seed/hotelimg84/800/500',1),(85,22,'https://picsum.photos/seed/hotelimg85/800/500',1),(86,23,'https://picsum.photos/seed/hotelimg86/800/500',1),(87,24,'https://picsum.photos/seed/hotelimg87/800/500',1),(88,25,'https://picsum.photos/seed/hotelimg88/800/500',1),(89,26,'https://picsum.photos/seed/hotelimg89/800/500',1),(90,27,'https://picsum.photos/seed/hotelimg90/800/500',1),(91,28,'https://picsum.photos/seed/hotelimg91/800/500',1),(92,29,'https://picsum.photos/seed/hotelimg92/800/500',1),(93,30,'https://picsum.photos/seed/hotelimg93/800/500',1),(94,31,'https://picsum.photos/seed/hotelimg94/800/500',1),(95,32,'https://picsum.photos/seed/hotelimg95/800/500',1),(96,33,'https://picsum.photos/seed/hotelimg96/800/500',1),(97,34,'https://picsum.photos/seed/hotelimg97/800/500',1),(98,35,'https://picsum.photos/seed/hotelimg98/800/500',1),(99,36,'https://picsum.photos/seed/hotelimg99/800/500',1),(100,37,'https://picsum.photos/seed/hotelimg100/800/500',1),(101,38,'https://picsum.photos/seed/hotelimg101/800/500',1),(102,39,'https://picsum.photos/seed/hotelimg102/800/500',1),(103,40,'https://picsum.photos/seed/hotelimg103/800/500',1),(104,41,'https://picsum.photos/seed/hotelimg104/800/500',1),(105,42,'https://picsum.photos/seed/hotelimg105/800/500',1),(106,43,'https://picsum.photos/seed/hotelimg106/800/500',1),(107,44,'https://picsum.photos/seed/hotelimg107/800/500',1),(108,45,'https://picsum.photos/seed/hotelimg108/800/500',1),(109,46,'https://picsum.photos/seed/hotelimg109/800/500',1),(110,47,'https://picsum.photos/seed/hotelimg110/800/500',1),(111,48,'https://picsum.photos/seed/hotelimg111/800/500',1),(112,49,'https://picsum.photos/seed/hotelimg112/800/500',1),(113,50,'https://picsum.photos/seed/hotelimg113/800/500',1),(114,51,'https://picsum.photos/seed/hotelimg114/800/500',1),(127,1,'https://picsum.photos/seed/hotelimg127/800/500',2),(128,2,'https://picsum.photos/seed/hotelimg128/800/500',2),(129,3,'https://picsum.photos/seed/hotelimg129/800/500',2),(130,4,'https://picsum.photos/seed/hotelimg130/800/500',2),(131,5,'https://picsum.photos/seed/hotelimg131/800/500',2),(132,6,'https://picsum.photos/seed/hotelimg132/800/500',2),(133,7,'https://picsum.photos/seed/hotelimg133/800/500',2),(134,8,'https://picsum.photos/seed/hotelimg134/800/500',2),(135,9,'https://picsum.photos/seed/hotelimg135/800/500',2),(136,10,'https://picsum.photos/seed/hotelimg136/800/500',2),(137,11,'https://picsum.photos/seed/hotelimg137/800/500',2),(138,12,'https://picsum.photos/seed/hotelimg138/800/500',2),(139,13,'https://picsum.photos/seed/hotelimg139/800/500',2),(140,14,'https://picsum.photos/seed/hotelimg140/800/500',2),(141,15,'https://picsum.photos/seed/hotelimg141/800/500',2),(142,16,'https://picsum.photos/seed/hotelimg142/800/500',2),(143,17,'https://picsum.photos/seed/hotelimg143/800/500',2),(144,18,'https://picsum.photos/seed/hotelimg144/800/500',2),(145,19,'https://picsum.photos/seed/hotelimg145/800/500',2),(146,20,'https://picsum.photos/seed/hotelimg146/800/500',2),(147,21,'https://picsum.photos/seed/hotelimg147/800/500',2),(148,22,'https://picsum.photos/seed/hotelimg148/800/500',2),(149,23,'https://picsum.photos/seed/hotelimg149/800/500',2),(150,24,'https://picsum.photos/seed/hotelimg150/800/500',2),(151,25,'https://picsum.photos/seed/hotelimg151/800/500',2),(152,26,'https://picsum.photos/seed/hotelimg152/800/500',2),(153,27,'https://picsum.photos/seed/hotelimg153/800/500',2),(154,28,'https://picsum.photos/seed/hotelimg154/800/500',2),(155,29,'https://picsum.photos/seed/hotelimg155/800/500',2),(156,30,'https://picsum.photos/seed/hotelimg156/800/500',2),(157,31,'https://picsum.photos/seed/hotelimg157/800/500',2),(158,32,'https://picsum.photos/seed/hotelimg158/800/500',2),(159,33,'https://picsum.photos/seed/hotelimg159/800/500',2),(160,34,'https://picsum.photos/seed/hotelimg160/800/500',2),(161,35,'https://picsum.photos/seed/hotelimg161/800/500',2),(162,36,'https://picsum.photos/seed/hotelimg162/800/500',2),(163,37,'https://picsum.photos/seed/hotelimg163/800/500',2),(164,38,'https://picsum.photos/seed/hotelimg164/800/500',2),(165,39,'https://picsum.photos/seed/hotelimg165/800/500',2),(166,40,'https://picsum.photos/seed/hotelimg166/800/500',2),(167,41,'https://picsum.photos/seed/hotelimg167/800/500',2),(168,42,'https://picsum.photos/seed/hotelimg168/800/500',2),(169,43,'https://picsum.photos/seed/hotelimg169/800/500',2),(170,44,'https://picsum.photos/seed/hotelimg170/800/500',2),(171,45,'https://picsum.photos/seed/hotelimg171/800/500',2),(172,46,'https://picsum.photos/seed/hotelimg172/800/500',2),(173,47,'https://picsum.photos/seed/hotelimg173/800/500',2),(174,48,'https://picsum.photos/seed/hotelimg174/800/500',2),(175,49,'https://picsum.photos/seed/hotelimg175/800/500',2),(176,50,'https://picsum.photos/seed/hotelimg176/800/500',2),(177,51,'https://picsum.photos/seed/hotelimg177/800/500',2),(190,1,'https://picsum.photos/seed/hotelimg190/800/500',3),(191,2,'https://picsum.photos/seed/hotelimg191/800/500',3),(192,3,'https://picsum.photos/seed/hotelimg192/800/500',3),(193,4,'https://picsum.photos/seed/hotelimg193/800/500',3),(194,5,'https://picsum.photos/seed/hotelimg194/800/500',3),(195,6,'https://picsum.photos/seed/hotelimg195/800/500',3),(196,7,'https://picsum.photos/seed/hotelimg196/800/500',3),(197,8,'https://picsum.photos/seed/hotelimg197/800/500',3),(198,9,'https://picsum.photos/seed/hotelimg198/800/500',3),(199,10,'https://picsum.photos/seed/hotelimg199/800/500',3),(200,11,'https://picsum.photos/seed/hotelimg200/800/500',3),(201,12,'https://picsum.photos/seed/hotelimg201/800/500',3),(202,13,'https://picsum.photos/seed/hotelimg202/800/500',3),(203,14,'https://picsum.photos/seed/hotelimg203/800/500',3),(204,15,'https://picsum.photos/seed/hotelimg204/800/500',3),(205,16,'https://picsum.photos/seed/hotelimg205/800/500',3),(206,17,'https://picsum.photos/seed/hotelimg206/800/500',3),(207,18,'https://picsum.photos/seed/hotelimg207/800/500',3),(208,19,'https://picsum.photos/seed/hotelimg208/800/500',3),(209,20,'https://picsum.photos/seed/hotelimg209/800/500',3),(210,21,'https://picsum.photos/seed/hotelimg210/800/500',3),(211,22,'https://picsum.photos/seed/hotelimg211/800/500',3),(212,23,'https://picsum.photos/seed/hotelimg212/800/500',3),(213,24,'https://picsum.photos/seed/hotelimg213/800/500',3),(214,25,'https://picsum.photos/seed/hotelimg214/800/500',3),(215,26,'https://picsum.photos/seed/hotelimg215/800/500',3),(216,27,'https://picsum.photos/seed/hotelimg216/800/500',3),(217,28,'https://picsum.photos/seed/hotelimg217/800/500',3),(218,29,'https://picsum.photos/seed/hotelimg218/800/500',3),(219,30,'https://picsum.photos/seed/hotelimg219/800/500',3),(220,31,'https://picsum.photos/seed/hotelimg220/800/500',3),(221,32,'https://picsum.photos/seed/hotelimg221/800/500',3),(222,33,'https://picsum.photos/seed/hotelimg222/800/500',3),(223,34,'https://picsum.photos/seed/hotelimg223/800/500',3),(224,35,'https://picsum.photos/seed/hotelimg224/800/500',3),(225,36,'https://picsum.photos/seed/hotelimg225/800/500',3),(226,37,'https://picsum.photos/seed/hotelimg226/800/500',3),(227,38,'https://picsum.photos/seed/hotelimg227/800/500',3),(228,39,'https://picsum.photos/seed/hotelimg228/800/500',3),(229,40,'https://picsum.photos/seed/hotelimg229/800/500',3),(230,41,'https://picsum.photos/seed/hotelimg230/800/500',3),(231,42,'https://picsum.photos/seed/hotelimg231/800/500',3),(232,43,'https://picsum.photos/seed/hotelimg232/800/500',3),(233,44,'https://picsum.photos/seed/hotelimg233/800/500',3),(234,45,'https://picsum.photos/seed/hotelimg234/800/500',3),(235,46,'https://picsum.photos/seed/hotelimg235/800/500',3),(236,47,'https://picsum.photos/seed/hotelimg236/800/500',3),(237,48,'https://picsum.photos/seed/hotelimg237/800/500',3),(238,49,'https://picsum.photos/seed/hotelimg238/800/500',3),(239,50,'https://picsum.photos/seed/hotelimg239/800/500',3),(240,51,'https://picsum.photos/seed/hotelimg240/800/500',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservas`
--

LOCK TABLES `reservas` WRITE;
/*!40000 ALTER TABLE `reservas` DISABLE KEYS */;
INSERT INTO `reservas` VALUES (1,1,1,NULL,'2026-06-01','2026-06-05','cancelada','2026-05-03 00:27:24'),(2,1,2,NULL,'2026-12-22','2027-01-01','pendiente','2026-10-19 22:15:00'),(3,1,NULL,2,NULL,NULL,'pendiente','2026-10-22 00:50:03');
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
INSERT INTO `restaurantes` VALUES (2,'La Patagonia','Bariloche, Argentina','Parrilla',2500.00,4.8,'https://picsum.photos/seed/resto2/400/300','2026-05-03 01:37:58'),(3,'El Portal','Buenos Aires, Argentina','Italiano',1800.00,4.5,'https://picsum.photos/seed/resto3/400/300','2026-05-03 01:37:58'),(4,'La Cabrera','Buenos Aires, Argentina','Parrilla',3200.00,4.9,'https://picsum.photos/seed/resto4/400/300','2026-05-03 01:37:58'),(5,'Sushi Club','Buenos Aires, Argentina','Japonés',2800.00,4.6,'https://picsum.photos/seed/resto5/400/300','2026-05-03 01:37:58'),(6,'El Bodegón','Mendoza, Argentina','Español',2000.00,4.4,'https://picsum.photos/seed/resto6/400/300','2026-05-03 01:37:58'),(7,'La Trattoria','Córdoba, Argentina','Italiano',1900.00,4.3,'https://picsum.photos/seed/resto7/400/300','2026-05-03 01:37:58'),(8,'Don Julio','Buenos Aires, Argentina','Parrilla',3500.00,4.9,'https://picsum.photos/seed/resto8/400/300','2026-05-03 01:37:58'),(9,'El Viejo Almacén','Buenos Aires, Argentina','Tango y Cena',4000.00,4.7,'https://picsum.photos/seed/resto9/400/300','2026-05-03 01:37:58'),(10,'La Mar','Buenos Aires, Argentina','Mariscos',2600.00,4.5,'https://picsum.photos/seed/resto10/400/300','2026-05-03 01:37:58'),(11,'Tegui','Buenos Aires, Argentina','Alta Cocina',5000.00,4.8,'https://picsum.photos/seed/resto11/400/300','2026-05-03 01:37:58'),(12,'El Papagayo','Bariloche, Argentina','Patagónico',2800.00,4.6,'https://picsum.photos/seed/resto12/400/300','2026-05-03 01:37:58'),(13,'La Fonduta','Mendoza, Argentina','Italiano',2200.00,4.4,'https://picsum.photos/seed/resto13/400/300','2026-05-03 01:37:58'),(14,'El Quincho','Rosario, Argentina','Parrilla',2100.00,4.5,'https://picsum.photos/seed/resto14/400/300','2026-05-03 01:37:58'),(15,'Osaka','Buenos Aires, Argentina','Nikkei',3800.00,4.7,'https://picsum.photos/seed/resto15/400/300','2026-05-03 01:37:58'),(16,'La Zarina','Buenos Aires, Argentina','Ruso',2400.00,4.3,'https://picsum.photos/seed/resto16/400/300','2026-05-03 01:37:58'),(17,'El Preferido','Buenos Aires, Argentina','Porteño',1800.00,4.6,'https://picsum.photos/seed/resto17/400/300','2026-05-03 01:37:58'),(18,'Chila','Buenos Aires, Argentina','Alta Cocina',5500.00,4.9,'https://picsum.photos/seed/resto18/400/300','2026-05-03 01:37:58'),(19,'La Pescadería','Mar del Plata, Argentina','Mariscos',2300.00,4.5,'https://picsum.photos/seed/resto19/400/300','2026-05-03 01:37:58'),(20,'El Gaucho','Salta, Argentina','Parrilla',1900.00,4.4,'https://picsum.photos/seed/resto20/400/300','2026-05-03 01:37:58'),(21,'Filo','Buenos Aires, Argentina','Italiano',2000.00,4.5,'https://picsum.photos/seed/resto21/400/300','2026-05-03 01:37:58'),(22,'La Malbequería','Mendoza, Argentina','Parrilla',2700.00,4.7,'https://picsum.photos/seed/resto22/400/300','2026-05-03 01:37:58'),(23,'El Rincón Norteño','Jujuy, Argentina','Regional',1500.00,4.3,'https://picsum.photos/seed/resto23/400/300','2026-05-03 01:37:58'),(24,'Siga la Vaca','Buenos Aires, Argentina','Parrilla',2500.00,4.4,'https://picsum.photos/seed/resto24/400/300','2026-05-03 01:37:58'),(25,'La Bourgogne','Buenos Aires, Argentina','Francés',6000.00,4.9,'https://picsum.photos/seed/resto25/400/300','2026-05-03 01:37:58'),(26,'El Mirador','Ushuaia, Argentina','Patagónico',3200.00,4.6,'https://picsum.photos/seed/resto26/400/300','2026-05-03 01:37:58'),(27,'Gran Bar Danzon','Buenos Aires, Argentina','Fusión',3000.00,4.5,'https://picsum.photos/seed/resto27/400/300','2026-05-03 01:37:58'),(28,'La Causa','Buenos Aires, Argentina','Peruano',2800.00,4.6,'https://picsum.photos/seed/resto28/400/300','2026-05-03 01:37:58'),(29,'El Estadio','Córdoba, Argentina','Parrilla',2000.00,4.3,'https://picsum.photos/seed/resto29/400/300','2026-05-03 01:37:58'),(30,'Tomo 1','Buenos Aires, Argentina','Alta Cocina',5200.00,4.8,'https://picsum.photos/seed/resto30/400/300','2026-05-03 01:37:58'),(31,'La Guitarrita','Buenos Aires, Argentina','Porteño',1700.00,4.4,'https://picsum.photos/seed/resto31/400/300','2026-05-03 01:37:58'),(32,'El Almacén del Sur','Rosario, Argentina','Regional',1800.00,4.2,'https://picsum.photos/seed/resto32/400/300','2026-05-03 01:37:58'),(33,'Kalma Resto','Bariloche, Argentina','Patagónico',2900.00,4.7,'https://picsum.photos/seed/resto33/400/300','2026-05-03 01:37:58'),(34,'La Dama Juana','Mendoza, Argentina','Alta Cocina',4500.00,4.8,'https://picsum.photos/seed/resto34/400/300','2026-05-03 01:37:58'),(35,'El Puerto','Puerto Madryn, Argentina','Mariscos',2400.00,4.5,'https://picsum.photos/seed/resto35/400/300','2026-05-03 01:37:58'),(36,'Sirop Folie','Buenos Aires, Argentina','Francés',3800.00,4.7,'https://picsum.photos/seed/resto36/400/300','2026-05-03 01:37:58'),(37,'El Brote','Tucumán, Argentina','Regional',1600.00,4.2,'https://picsum.photos/seed/resto37/400/300','2026-05-03 01:37:58'),(38,'La Alquería','Buenos Aires, Argentina','Español',2600.00,4.4,'https://picsum.photos/seed/resto38/400/300','2026-05-03 01:37:58'),(39,'Happening','Buenos Aires, Argentina','Parrilla',3400.00,4.6,'https://picsum.photos/seed/resto39/400/300','2026-05-03 01:37:58'),(40,'El Asador Patagónico','El Calafate, Argentina','Patagónico',3100.00,4.7,'https://picsum.photos/seed/resto40/400/300','2026-05-03 01:37:58'),(41,'Mostrador Santa Teresita','Buenos Aires, Argentina','Café',1200.00,4.5,'https://picsum.photos/seed/resto41/400/300','2026-05-03 01:37:58'),(42,'El Ternero','Corrientes, Argentina','Parrilla',1800.00,4.3,'https://picsum.photos/seed/resto42/400/300','2026-05-03 01:37:58'),(43,'La Vinería','Mendoza, Argentina','Fusión',3200.00,4.6,'https://picsum.photos/seed/resto43/400/300','2026-05-03 01:37:58'),(44,'Cucina Paradiso','Buenos Aires, Argentina','Italiano',2500.00,4.5,'https://picsum.photos/seed/resto44/400/300','2026-05-03 01:37:58'),(45,'El Mesón','Salta, Argentina','Regional',1700.00,4.3,'https://picsum.photos/seed/resto45/400/300','2026-05-03 01:37:58'),(46,'Pura Tierra','Buenos Aires, Argentina','Orgánico',2900.00,4.6,'https://picsum.photos/seed/resto46/400/300','2026-05-03 01:37:58'),(47,'La Cantina del Puerto','Rosario, Argentina','Mariscos',2200.00,4.4,'https://picsum.photos/seed/resto47/400/300','2026-05-03 01:37:58'),(48,'El Refugio','San Martín de los Andes, Argentina','Patagónico',2700.00,4.6,'https://picsum.photos/seed/resto48/400/300','2026-05-03 01:37:58'),(49,'Aramburu','Buenos Aires, Argentina','Alta Cocina',6500.00,4.9,'https://picsum.photos/seed/resto49/400/300','2026-05-03 01:37:58'),(50,'La Posta del Ángel','Córdoba, Argentina','Regional',1900.00,4.3,'https://picsum.photos/seed/resto50/400/300','2026-05-03 01:37:58'),(51,'El Faro','Mar del Plata, Argentina','Mariscos',2600.00,4.5,'https://picsum.photos/seed/resto51/400/300','2026-05-03 01:37:58');
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

-- Dump completed on 2026-10-21 22:11:31

CREATE Database Darkness 
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: retail_insights
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `category_detail_subdim`
--

DROP TABLE IF EXISTS `category_detail_subdim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_detail_subdim` (
  `category_id` int NOT NULL,
  `category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_detail_subdim`
--

LOCK TABLES `category_detail_subdim` WRITE;
/*!40000 ALTER TABLE `category_detail_subdim` DISABLE KEYS */;
INSERT INTO `category_detail_subdim` VALUES (1,'Electronics'),(2,'Furniture'),(3,'Fashion'),(4,'Sports'),(5,'Grocery');
/*!40000 ALTER TABLE `category_detail_subdim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon_detail_subdim`
--

DROP TABLE IF EXISTS `coupon_detail_subdim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon_detail_subdim` (
  `coupon_code` varchar(10) NOT NULL,
  `coupon_amount` int NOT NULL,
  `end_validity` date NOT NULL,
  PRIMARY KEY (`coupon_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon_detail_subdim`
--

LOCK TABLES `coupon_detail_subdim` WRITE;
/*!40000 ALTER TABLE `coupon_detail_subdim` DISABLE KEYS */;
INSERT INTO `coupon_detail_subdim` VALUES ('ABCD1234',50,'2025-08-15'),('ABCD1235',45,'2025-06-30'),('ABCD1236',40,'2025-07-15'),('EFGH6789',100,'2025-08-11'),('EFGH6790',90,'2025-06-08'),('EFGH6791',70,'2025-07-15'),('IJKL2345',60,'2025-05-15'),('IJKL2346',50,'2025-09-13'),('IJKL2347',30,'2025-06-28'),('KLMN9876',120,'2025-07-09'),('KLMN9877',110,'2025-08-05'),('LMNO3456',30,'2025-06-15'),('LMNO3457',25,'2025-08-19'),('LMNO3458',20,'2025-07-28'),('MNOP7890',30,'2025-07-11'),('MNOP7891',25,'2025-08-25'),('MNOP7892',15,'2025-06-03'),('PQRS9876',20,'2025-09-18'),('PQRS9877',15,'2025-07-15'),('PQRS9878',10,'2025-08-15'),('QRST3456',40,'2025-07-25'),('QRST3457',35,'2025-06-29'),('UVWX1234',25,'2025-07-15'),('UVWX1235',20,'2025-06-25'),('WXYZ5678',200,'2025-06-28'),('WXYZ5679',180,'2025-08-15'),('WXYZ5680',160,'2025-07-11'),('YXWV5678',80,'2025-08-17'),('YXWV5679',75,'2025-07-13');
/*!40000 ALTER TABLE `coupon_detail_subdim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_detail_dim`
--

DROP TABLE IF EXISTS `customer_detail_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_detail_dim` (
  `customer_id` int NOT NULL,
  `customer_name` varchar(40) NOT NULL,
  `country` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `pincode` int NOT NULL,
  `customer_address` varchar(200) NOT NULL,
  `gender` varchar(9) DEFAULT NULL,
  `customer_contact` varchar(75) NOT NULL,
  `membership_status` varchar(5) NOT NULL,
  PRIMARY KEY (`customer_id`),
  CONSTRAINT `customer_detail_dim_chk_1` CHECK ((`membership_status` in (_utf8mb4'TRUE',_utf8mb4'FALSE')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_detail_dim`
--

LOCK TABLES `customer_detail_dim` WRITE;
/*!40000 ALTER TABLE `customer_detail_dim` DISABLE KEYS */;
INSERT INTO `customer_detail_dim` VALUES (6001,'Alan','India','Bihar','Patna',80001,'52, B-block, New Horizon Apartment, Patna, Bihar','Male','alan@gmail.com','TRUE'),(6002,'Rubin','India','Uttar Pradesh','Lucknow',226001,'#41, Jehta Rd, Dubagga, Maura, Lucknow, Uttar Pradesh','Female','rubin@gmail.com','FALSE'),(6003,'Issac','India','Kerala','Kottayam',682001,'#24, 9th main road, previthanam, pala, kottayam, kerala','Others','issac@gmail.com','FALSE'),(6004,'Bhavika','India','Karnataka','Bangalore',530068,'L-134, 4th main, HSR Layout, Bangalore, Karnataka','Female','bhavika@gmail.com','TRUE'),(6005,'Michele','India','Punjab','Ludhiana',141001,'42 - Happy Enclave, Ludhiana, Punjab','Female','michele@gmail.com','TRUE'),(6006,'Rajesh','India','Maharashtra','Mumbai',400001,'A-301, Ocean View, Colaba, Mumbai, Maharashtra','Male','rajesh@gmail.com','FALSE'),(6007,'Aishwarya','India','Tamil Nadu','Chennai',600001,'27, Anna Nagar, Chennai, Tamil Nadu','Female','aishwarya@gmail.com','TRUE'),(6008,'Vikram','India','Gujarat','Ahmedabad',380001,'15, Satellite Road, Ahmedabad, Gujarat','Male','vikram@gmail.com','TRUE'),(6009,'Neha','India','Rajasthan','Jaipur',302001,'B-102, Pink City Residency, Jaipur, Rajasthan','Female','neha@gmail.com','FALSE'),(6010,'Siddharth','India','Uttarakhand','Dehradun',248001,'29, Rajpur Road, Dehradun, Uttarakhand','Male','siddharth@gmail.com','TRUE'),(6011,'Kavita','India','Madhya Pradesh','Bhopal',462001,'C-45, Arera Colony, Bhopal, Madhya Pradesh','Female','kavita@gmail.com','FALSE'),(6012,'Rahul','India','Puducherry','Puducherry',605001,'8, White Town, Puducherry','Male','rahul@gmail.com','TRUE'),(6013,'Preeti','India','Telangana','Hyderabad',500001,'12, Banjara Hills, Hyderabad, Telangana','Female','preeti@gmail.com','TRUE'),(6014,'Ankit','India','Haryana','Gurgaon',122001,'F-201, DLF Phase 1, Gurgaon, Haryana','Male','ankit@gmail.com','FALSE'),(6015,'Swati','India','Uttar Pradesh','Kanpur',208001,'A-56, Civil Lines, Kanpur, Uttar Pradesh','Female','swati@gmail.com','TRUE'),(6016,'Alok','India','Karnataka','Mangalore',575001,'6, Hampankatta, Mangalore, Karnataka','Male','alok@gmail.com','FALSE'),(6017,'Ritu','India','Jharkhand','Ranchi',834001,'14, Kanke Road, Ranchi, Jharkhand','Female','ritu@gmail.com','TRUE'),(6018,'Arjun','India','Assam','Guwahati',781001,'D-102, Dispur, Guwahati, Assam','Male','arjun@gmail.com','FALSE'),(6019,'Shikha','India','West Bengal','Kolkata',700001,'23, Park Street, Kolkata, West Bengal','Female','shikha@gmail.com','TRUE'),(6020,'Rajat','India','Odisha','Bhubaneswar',751001,'G-301, Saheed Nagar, Bhubaneswar, Odisha','Male','rajat@gmail.com','TRUE'),(6021,'Deepa','India','Chhattisgarh','Raipur',492001,'C-201, Civil Lines, Raipur, Chhattisgarh','Female','deepa@gmail.com','FALSE'),(6022,'Ravi','India','Bihar','Gaya',823001,'10, Surya Nagar, Gaya, Bihar','Male','ravi@gmail.com','TRUE'),(6023,'Shruti','India','Punjab','Amritsar',143001,'15, Lawrence Road, Amritsar, Punjab','Female','shruti@gmail.com','TRUE'),(6024,'Sumit','India','Maharashtra','Nagpur',440001,'B-401, Civil Lines, Nagpur, Maharashtra','Male','sumit@gmail.com','FALSE'),(6025,'Pooja','India','Tamil Nadu','Coimbatore',641001,'7, Gandhipuram, Coimbatore, Tamil Nadu','Female','pooja@gmail.com','TRUE'),(6026,'Amit','India','Gujarat','Surat',395001,'E-102, Adajan, Surat, Gujarat','Male','amit@gmail.com','FALSE'),(6027,'Priya','India','Rajasthan','Udaipur',313001,'F-202, Hiran Magri, Udaipur, Rajasthan','Female','priya@gmail.com','TRUE'),(6028,'Sameer','India','Uttarakhand','Haridwar',249401,'9, Shivalik Nagar, Haridwar, Uttarakhand','Male','sameer@gmail.com','TRUE'),(6029,'Anjali','India','Madhya Pradesh','Indore',452001,'12, Vijay Nagar, Indore, Madhya Pradesh','Female','anjali@gmail.com','FALSE'),(6030,'Rajeshwari','India','Puducherry','Karaikal',609602,'C-56, Beach Road, Karaikal, Puducherry','Female','rajeshwari@gmail.com','TRUE');
/*!40000 ALTER TABLE `customer_detail_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holder_detail_dim`
--

DROP TABLE IF EXISTS `holder_detail_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `holder_detail_dim` (
  `holder_id` int NOT NULL,
  `holder_type` varchar(50) NOT NULL,
  PRIMARY KEY (`holder_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holder_detail_dim`
--

LOCK TABLES `holder_detail_dim` WRITE;
/*!40000 ALTER TABLE `holder_detail_dim` DISABLE KEYS */;
INSERT INTO `holder_detail_dim` VALUES (0,'Amazon Fulfilled'),(1,'Seller Fulfilled');
/*!40000 ALTER TABLE `holder_detail_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_detail_fact`
--

DROP TABLE IF EXISTS `inventory_detail_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_detail_fact` (
  `seller_id` int NOT NULL,
  `sku_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `holder_id` int NOT NULL,
  `unit_of_measurement_id` int NOT NULL,
  `inventory_quantity` int NOT NULL,
  `last_update_timestamp` timestamp NOT NULL,
  PRIMARY KEY (`seller_id`,`sku_id`,`warehouse_id`),
  KEY `unit_of_measurement_id` (`unit_of_measurement_id`),
  CONSTRAINT `inventory_detail_fact_ibfk_1` FOREIGN KEY (`unit_of_measurement_id`) REFERENCES `unit_of_measurement_dim` (`unit_of_measurement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_detail_fact`
--

LOCK TABLES `inventory_detail_fact` WRITE;
/*!40000 ALTER TABLE `inventory_detail_fact` DISABLE KEYS */;
INSERT INTO `inventory_detail_fact` VALUES (103,1003,203,503,3,100,'2025-04-25 08:50:00'),(104,1004,204,504,4,75,'2025-04-30 10:40:00'),(105,1005,205,505,5,30,'2025-05-01 06:25:00'),(106,1006,206,506,6,15,'2025-05-08 04:10:00'),(107,1007,207,507,7,40,'2025-05-10 06:55:00'),(108,1008,208,508,8,20,'2025-05-12 08:45:00'),(109,1009,209,509,9,90,'2025-05-12 12:00:00'),(110,1010,210,510,10,10,'2025-05-14 03:15:00'),(111,1011,211,511,11,55,'2025-05-15 04:25:00'),(112,1012,212,512,12,80,'2025-05-15 07:40:00'),(113,1013,213,513,13,35,'2025-05-20 10:15:00'),(114,1014,214,514,14,60,'2025-05-22 12:50:00'),(115,1015,215,515,15,50,'2025-05-22 05:00:00'),(116,1016,216,516,16,25,'2025-05-22 05:10:00'),(117,1017,217,517,17,70,'2025-05-25 09:20:00'),(118,1018,218,518,18,45,'2025-05-25 11:45:00'),(119,1019,219,519,19,120,'2025-05-25 02:50:00'),(120,1020,220,520,20,5,'2025-05-30 05:05:00'),(121,1021,221,521,21,30,'2025-05-30 07:30:00'),(122,1022,222,522,22,15,'2025-05-30 09:55:00'),(123,1023,223,523,23,100,'2025-05-30 12:20:00'),(124,1024,224,524,24,55,'2025-06-01 03:30:00'),(125,1025,225,525,25,75,'2025-06-01 05:45:00'),(126,1026,226,526,26,40,'2025-06-05 08:10:00'),(127,1027,227,527,27,20,'2025-06-05 10:25:00'),(128,1028,228,528,28,65,'2025-06-10 02:40:00'),(129,1029,229,529,29,85,'2025-06-10 04:55:00'),(130,1030,230,530,30,10,'2025-06-10 07:20:00');
/*!40000 ALTER TABLE `inventory_detail_fact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail_fact`
--

DROP TABLE IF EXISTS `order_detail_fact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail_fact` (
  `order_id` int NOT NULL,
  `sku_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `review_id` int NOT NULL,
  `transaction_id` int NOT NULL,
  `tracking_id` int NOT NULL,
  `return_id` int DEFAULT NULL,
  `seller_id` int NOT NULL,
  `order_quantity` int DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `sku_id` (`sku_id`),
  KEY `customer_id` (`customer_id`),
  KEY `review_id` (`review_id`),
  KEY `transaction_id` (`transaction_id`),
  KEY `tracking_id` (`tracking_id`),
  KEY `return_id` (`return_id`),
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `order_detail_fact_ibfk_1` FOREIGN KEY (`sku_id`) REFERENCES `sku_detail_dim` (`sku_id`),
  CONSTRAINT `order_detail_fact_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customer_detail_dim` (`customer_id`),
  CONSTRAINT `order_detail_fact_ibfk_3` FOREIGN KEY (`review_id`) REFERENCES `review_detail_dim` (`review_id`),
  CONSTRAINT `order_detail_fact_ibfk_4` FOREIGN KEY (`transaction_id`) REFERENCES `transaction_detail_dim` (`transaction_id`),
  CONSTRAINT `order_detail_fact_ibfk_5` FOREIGN KEY (`tracking_id`) REFERENCES `shipping_detail_dim` (`tracking_id`),
  CONSTRAINT `order_detail_fact_ibfk_6` FOREIGN KEY (`return_id`) REFERENCES `return_detail_dim` (`return_id`),
  CONSTRAINT `order_detail_fact_ibfk_7` FOREIGN KEY (`seller_id`) REFERENCES `seller_detail_dim` (`seller_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail_fact`
--

LOCK TABLES `order_detail_fact` WRITE;
/*!40000 ALTER TABLE `order_detail_fact` DISABLE KEYS */;
INSERT INTO `order_detail_fact` VALUES (2001,1001,6001,7001,8001,3001,10001,101,2),(2002,1002,6002,7002,8002,3002,NULL,102,1),(2003,1003,6003,7003,8003,3003,10002,103,3),(2004,1004,6004,7004,8004,3004,NULL,104,1),(2005,1003,6005,7005,8005,3005,10003,105,2),(2006,1006,6005,7006,8006,3006,NULL,106,1),(2007,1007,6004,7007,8007,3007,10004,107,2),(2008,1003,6008,7008,8008,3008,NULL,108,1),(2009,1009,6004,7009,8009,3009,10005,109,3),(2010,1003,6005,7010,8010,3010,NULL,110,1),(2011,1011,6011,7011,8011,3011,NULL,111,2),(2012,1012,6004,7012,8012,3012,10006,112,1),(2013,1003,6005,7013,8013,3013,NULL,113,3),(2014,1014,6014,7014,8014,3014,10007,114,1),(2015,1015,6004,7015,8015,3015,NULL,115,2),(2016,1016,6005,7016,8016,3016,10008,116,1),(2017,1015,6004,7017,8017,3017,NULL,117,3),(2018,1018,6018,7018,8018,3018,10009,118,1),(2019,1015,6019,7019,8019,3019,NULL,119,2),(2020,1015,6003,7020,8020,3020,10010,120,1),(2021,1021,6021,7021,8021,3021,NULL,121,3),(2022,1014,6022,7022,8022,3022,NULL,122,1),(2023,1015,6008,7023,8023,3023,NULL,123,2),(2024,1014,6004,7024,8024,3024,NULL,124,1),(2025,1025,6002,7025,8025,3025,NULL,125,3),(2026,1014,6001,7026,8026,3026,NULL,126,1),(2027,1027,6004,7027,8027,3027,NULL,127,2),(2028,1014,6008,7028,8028,3028,NULL,128,1),(2029,1002,6014,7029,8029,3029,NULL,110,3),(2030,1014,6005,7030,8030,3030,NULL,130,1);
/*!40000 ALTER TABLE `order_detail_fact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_detail_subdim`
--

DROP TABLE IF EXISTS `product_detail_subdim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_detail_subdim` (
  `product_id` int NOT NULL,
  `category_id` int NOT NULL,
  `product_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `product_detail_subdim_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category_detail_subdim` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_detail_subdim`
--

LOCK TABLES `product_detail_subdim` WRITE;
/*!40000 ALTER TABLE `product_detail_subdim` DISABLE KEYS */;
INSERT INTO `product_detail_subdim` VALUES (1,1,'Smartphone XYZ'),(2,2,'Wooden Dining Table'),(3,3,'Summer Dress'),(4,4,'Basketball'),(5,5,'Rice 5kg'),(6,1,'Laptop ABC'),(7,2,'Leather Sofa Set'),(8,3,'Running Shoes'),(9,4,'Cricket Bat'),(10,5,'Cooking Oil 1L'),(11,1,'Smartwatch'),(12,2,'Office Desk'),(13,3,'T-shirt'),(14,4,'Yoga Mat'),(15,5,'Cereal Box'),(16,1,'Gaming Laptop'),(17,2,'Coffee Table'),(18,3,'Sunglasses'),(19,4,'Football'),(20,5,'Pasta Pack'),(21,1,'Bluetooth Headphones'),(22,2,'Bed Frame'),(23,3,'Denim Jeans'),(24,4,'Tennis Racket'),(25,5,'Milk 1L'),(26,1,'Desktop PC'),(27,2,'Bookshelf'),(28,3,'Wrist Watch'),(29,4,'Basketball Shoes'),(30,5,'Toothpaste');
/*!40000 ALTER TABLE `product_detail_subdim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `return_detail_dim`
--

DROP TABLE IF EXISTS `return_detail_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `return_detail_dim` (
  `return_id` int NOT NULL,
  `return_status` varchar(12) NOT NULL,
  PRIMARY KEY (`return_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `return_detail_dim`
--

LOCK TABLES `return_detail_dim` WRITE;
/*!40000 ALTER TABLE `return_detail_dim` DISABLE KEYS */;
INSERT INTO `return_detail_dim` VALUES (10001,'Processing'),(10002,'Completed'),(10003,'Pending'),(10004,'Rejected'),(10005,'Approved'),(10006,'Processing'),(10007,'Completed'),(10008,'Pending'),(10009,'Rejected'),(10010,'Approved');
/*!40000 ALTER TABLE `return_detail_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_detail_dim`
--

DROP TABLE IF EXISTS `review_detail_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_detail_dim` (
  `review_id` int NOT NULL,
  `review_heading` varchar(100) NOT NULL,
  `review_description` varchar(700) DEFAULT NULL,
  `rating` int NOT NULL,
  PRIMARY KEY (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_detail_dim`
--

LOCK TABLES `review_detail_dim` WRITE;
/*!40000 ALTER TABLE `review_detail_dim` DISABLE KEYS */;
INSERT INTO `review_detail_dim` VALUES (7001,'Great Product!','I am very satisfied with my purchase. The product exceeded my expectations.',5),(7002,'Poor Quality','The item I received was of poor quality and not as described. Very disappointed.',1),(7003,'Fast Delivery','The delivery was incredibly fast. Received the product within 24 hours.',4),(7004,'Not Recommended','I do not recommend this product. It broke within a week of use.',2),(7005,'Excellent Service','The customer service provided was excellent. They were very helpful and resolved my issue quickly.',5),(7006,'Average Product','The product is okay, nothing special. It works as expected but not outstanding.',3),(7007,'Defective Item','Received a defective item. The company needs to improve its quality control.',1),(7008,'Highly Recommended','I highly recommend this product. It has met all my expectations and more.',5),(7009,'Delayed Delivery','The delivery was delayed, and the communication from the seller was poor.',2),(7010,'Good Value for Money','The product offers good value for money. I got it at a great price.',4),(7011,'Disappointing Purchase','Very disappointed with the purchase. The product does not match the description.',1),(7012,'Prompt Customer Support','Had an issue with the order, but the customer support team was prompt in resolving it.',4),(7013,'Satisfied Customer','I am a satisfied customer. The product quality and service were up to the mark.',5),(7014,'Not Worth It','The product is not worth the price. I expected better quality.',2),(7015,'Great Deal','I got a great deal on this product. The discount was substantial.',5),(7016,'Unreliable','The product is unreliable and stopped working after a few days of use.',1),(7017,'Smooth Transaction','The buying process was smooth, and I received exactly what I ordered.',4),(7018,'Mediocre Product','The product is mediocre. It works, but I expected better performance.',3),(7019,'Horrible Experience','Had a horrible experience with this purchase. Will not buy from this seller again.',1),(7020,'Impressive Quality','Impressed with the quality of the product. It has a durable build and functions well.',5),(7021,'Late Shipment','The shipment was late, and there was no communication from the seller about the delay.',2),(7022,'Decent Product','The product is decent. It serves its purpose but lacks some features.',3),(7023,'Excellent Packaging','The product was packed securely, and it arrived without any damage.',5),(7024,'Not User-Friendly','The product is not user-friendly. It is difficult to use and set up.',2),(7025,'Responsive Seller','The seller was responsive to my queries and provided helpful information.',4),(7026,'Average Performance','The product has average performance. It meets basic requirements but nothing exceptional.',3),(7027,'Worst Purchase','This has been the worst purchase experience. The product did not work from the start.',1),(7028,'Excellent Product','I am extremely happy with the product. It works perfectly and meets all my needs.',5),(7029,'Misleading Description','The product description was misleading. The actual item does not match the details provided.',2),(7030,'Good Bargain','Got a good bargain on this product. Quality is decent for the price.',4);
/*!40000 ALTER TABLE `review_detail_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller_detail_dim`
--

DROP TABLE IF EXISTS `seller_detail_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller_detail_dim` (
  `seller_id` int NOT NULL,
  `seller_name` varchar(40) NOT NULL,
  `seller_address` varchar(200) NOT NULL,
  `seller_contact` varchar(75) NOT NULL,
  `amazon_verified` varchar(5) NOT NULL,
  PRIMARY KEY (`seller_id`),
  CONSTRAINT `seller_detail_dim_chk_1` CHECK ((`amazon_verified` in (_utf8mb4'TRUE',_utf8mb4'FALSE')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller_detail_dim`
--

LOCK TABLES `seller_detail_dim` WRITE;
/*!40000 ALTER TABLE `seller_detail_dim` DISABLE KEYS */;
INSERT INTO `seller_detail_dim` VALUES (101,'ElectroDeals','Delhi, India','1234567890','TRUE'),(102,'FurnitureHub','Mumbai, India','9876543210','FALSE'),(103,'FashionBazaar','Kolkata, India','8765432109','TRUE'),(104,'SportsWorld','Chennai, India','7654321098','FALSE'),(105,'GroceryMart','Bangalore, India','6543210987','TRUE'),(106,'TechGalore','Hyderabad, India','5432109876','FALSE'),(107,'HomeStyle','Ahmedabad, India','4321098765','TRUE'),(108,'StyleTrend','Pune, India','3210987654','FALSE'),(109,'ActiveGear','Jaipur, India','2109876543','TRUE'),(110,'FreshBasket','Lucknow, India','1098765432','FALSE'),(111,'SmartElectronics','Kochi, India','9876543210','TRUE'),(112,'UrbanLiving','Indore, India','8765432109','FALSE'),(113,'TrendyStyles','Coimbatore, India','7654321098','TRUE'),(114,'OutdoorSports','Vadodara, India','6543210987','FALSE'),(115,'GreenGrocers','Bhopal, India','5432109876','TRUE'),(116,'GizmoGalaxy','Nagpur, India','4321098765','FALSE'),(117,'ElegantHomes','Visakhapatnam, India','3210987654','TRUE'),(118,'ChicCouture','Surat, India','2109876543','FALSE'),(119,'FitZone','Kanpur, India','1098765432','TRUE'),(120,'NatureNook','Thane, India','9876543210','FALSE'),(121,'DigitalDeals','Patna, India','8765432109','TRUE'),(122,'CozyHomes','Ludhiana, India','7654321098','FALSE'),(123,'ModaMania','Agra, India','6543210987','TRUE'),(124,'ActiveLife','Varanasi, India','5432109876','FALSE'),(125,'OrganicHarvest','Ranchi, India','4321098765','TRUE'),(126,'InnovateTech','Mysuru, India','3210987654','FALSE'),(127,'LuxuryLiving','Jodhpur, India','2109876543','TRUE'),(128,'GlamGoddess','Amritsar, India','1098765432','FALSE'),(129,'FitAndFine','Guwahati, India','9876543210','TRUE'),(130,'GreenGroove','Srinagar, India','8765432109','FALSE');
/*!40000 ALTER TABLE `seller_detail_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipper_detail_subdim`
--

DROP TABLE IF EXISTS `shipper_detail_subdim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipper_detail_subdim` (
  `shipper_id` int NOT NULL,
  `shipper_name` varchar(40) NOT NULL,
  `shipper_contact` varchar(75) NOT NULL,
  PRIMARY KEY (`shipper_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipper_detail_subdim`
--

LOCK TABLES `shipper_detail_subdim` WRITE;
/*!40000 ALTER TABLE `shipper_detail_subdim` DISABLE KEYS */;
INSERT INTO `shipper_detail_subdim` VALUES (1,'ABC Logistics','+91 9876543210'),(2,'Quick Ship','+91 8765432109'),(3,'Express Movers','+91 7654321098'),(4,'Speedy Couriers','+91 6543210987'),(5,'Swift Shipping','+91 5432109876'),(6,'Reliable Deliveries','+91 4321098765'),(7,'Fast Freight','+91 3210987654'),(8,'Rapid Logistics','+91 2109876543'),(9,'Secure Shippers','+91 1098765432'),(10,'Prime Couriers','+91 0987654321');
/*!40000 ALTER TABLE `shipper_detail_subdim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_detail_dim`
--

DROP TABLE IF EXISTS `shipping_detail_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_detail_dim` (
  `tracking_id` int NOT NULL,
  `shipper_id` int NOT NULL,
  `shipping_address` varchar(200) NOT NULL,
  `shipping_method` varchar(7) DEFAULT NULL,
  `shipping_priority` varchar(17) NOT NULL,
  `shipping_cost` int NOT NULL,
  `shipping_date` date NOT NULL,
  `estimated_delivery_date` date NOT NULL,
  `actual_delivery_date` date DEFAULT NULL,
  PRIMARY KEY (`tracking_id`),
  KEY `shipper_id` (`shipper_id`),
  CONSTRAINT `shipping_detail_dim_ibfk_1` FOREIGN KEY (`shipper_id`) REFERENCES `shipper_detail_subdim` (`shipper_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_detail_dim`
--

LOCK TABLES `shipping_detail_dim` WRITE;
/*!40000 ALTER TABLE `shipping_detail_dim` DISABLE KEYS */;
INSERT INTO `shipping_detail_dim` VALUES (3001,1,'52, B-block, New Horizon Apartment, Patna, Bihar','Air','Same Day',100,'2025-07-10','2025-07-12','2025-07-11'),(3002,2,'#41, Jehta Rd, Dubagga, Maura, Lucknow, Uttar Pradesh','Ground','2 Days',150,'2025-07-12','2025-07-14','2025-07-13'),(3003,3,'#24, 9th main road, previthanam, pala, kottayam, kerala','Express','Standard',80,'2025-07-15','2025-07-18','2025-07-17'),(3004,4,'L-134, 4th main, HSR Layout, Bangalore, Karnataka','Ground','Same Day',120,'2025-07-18','2025-07-20','2025-07-19'),(3005,3,'42 - Happy Enclave, Ludhiana, Punjab','Air','2 Days',200,'2025-07-20','2025-07-22','2025-07-21'),(3006,6,'The Address, Pune, Maharashtra','Ground','Standard',90,'2025-07-22','2025-07-25','2025-07-24'),(3007,7,'Hyderabad House, Hyderabad, Telangana','Express','Same Day',130,'2025-08-25','2025-08-28','2025-08-27'),(3008,3,'Vijay Towers, Chennai, Tamil Nadu','Ground','2 Days',180,'2025-08-28','2025-08-30','2025-08-29'),(3009,9,'Vidhan Bhavan, Mumbai, Maharashtra','Air','Standard',100,'2025-07-30','2025-07-02','2025-07-01'),(3010,10,'Raj Bhavan, Bhopal, Madhya Pradesh','Ground','Same Day',150,'2025-07-02','2025-07-04','2025-07-03'),(3011,3,'The White House, Delhi, India','Express','2 Days',120,'2025-07-05','2025-07-08','2025-07-07'),(3012,1,'Gateway of India, Mumbai, Maharashtra','Ground','Standard',80,'2025-07-08','2025-07-10','2025-07-09'),(3013,3,'Lotus Temple, Delhi, India','Air','Same Day',110,'2025-08-10','2025-08-12','2025-08-11'),(3014,4,'Qutub Minar, Delhi, India','Ground','2 Days',170,'2025-07-13','2025-07-16','2025-07-15'),(3015,2,'Hawa Mahal, Jaipur, Rajasthan','Express','Standard',95,'2025-08-16','2025-08-18','2025-08-17'),(3016,2,'Charminar, Hyderabad, Telangana','Ground','Same Day',130,'2025-08-19','2025-08-22','2025-08-21'),(3017,1,'Marine Drive, Mumbai, Maharashtra','Air','2 Days',150,'2025-08-22','2025-08-24','2025-08-23'),(3018,1,'Golden Temple, Amritsar, Punjab','Express','Standard',85,'2025-08-25','2025-08-28','2025-08-27'),(3019,1,'Mysuru Palace, Mysuru, Karnataka','Ground','Same Day',120,'2025-07-28','2025-07-30','2025-07-29'),(3020,5,'Taj Mahal, Agra, Uttar Pradesh','Air','2 Days',160,'2025-07-01','2025-07-04','2025-07-03'),(3021,6,'Nalanda University, Bihar, India','Ground','Standard',90,'2025-08-04','2025-08-06','2025-08-05'),(3022,6,'Red Fort, Delhi, India','Express','Same Day',110,'2025-07-07','2025-07-10','2025-07-09'),(3023,8,'Gateway Arch, Mumbai, Maharashtra','Ground','2 Days',140,'2025-07-10','2025-07-12','2025-07-11'),(3024,8,'India Gate, Delhi, India','Air','Standard',95,'2025-07-13','2025-07-16','2025-07-15'),(3025,6,'Howrah Bridge, Kolkata, West Bengal','Express','Same Day',120,'2025-08-16','2025-08-18','2025-08-17'),(3026,8,'Golconda Fort, Hyderabad, Telangana','Ground','2 Days',180,'2025-08-19','2025-08-22','2025-08-21'),(3027,3,'Vivekananda Rock Memorial, Kanyakumari, Tamil Nadu','Air','Standard',100,'2025-08-22','2025-08-24','2025-08-23'),(3028,2,'Lotus Temple, Delhi, India','Express','Same Day',130,'2025-07-25','2025-07-28','2025-07-27'),(3029,1,'Chittorgarh Fort, Rajasthan, India','Ground','2 Days',160,'2025-07-28','2025-07-30','2025-07-29'),(3030,4,'Victoria Memorial, Kolkata, West Bengal','Air','Standard',90,'2025-07-31','2025-07-03','2025-07-02');
/*!40000 ALTER TABLE `shipping_detail_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sku_detail_dim`
--

DROP TABLE IF EXISTS `sku_detail_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sku_detail_dim` (
  `sku_id` int NOT NULL,
  `product_id` int NOT NULL,
  `description` varchar(200) NOT NULL,
  `listing_price` int NOT NULL,
  `selling_price` int NOT NULL,
  `discount_percentage` int DEFAULT NULL,
  `discount_amount` int DEFAULT NULL,
  PRIMARY KEY (`sku_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `sku_detail_dim_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product_detail_subdim` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sku_detail_dim`
--

LOCK TABLES `sku_detail_dim` WRITE;
/*!40000 ALTER TABLE `sku_detail_dim` DISABLE KEYS */;
INSERT INTO `sku_detail_dim` VALUES (1001,1,'Smartphone XYZ - Brand: ABC, Color: Black, RAM: 8GB, Storage: 128GB',500,450,10,50),(1002,2,'Wooden Dining Table - Type: Oak, Color: Walnut, Seats: 6',1000,800,20,200),(1003,3,'Summer Dress - Brand: Fashionista, Color: Floral, Size: M',50,40,20,10),(1004,4,'Basketball - Brand: Nike, Size: Standard',30,25,10,5),(1005,5,'Rice 5kg - Type: Basmati, Brand: Royal',20,18,10,2),(1006,6,'Laptop ABC - Brand: XYZ, Model: ProBook, RAM: 16GB, Storage: 512GB SSD',800,700,15,100),(1007,7,'Leather Sofa Set - Color: Brown, Material: Genuine Leather, Seats: 3+2',1200,1000,20,200),(1008,8,'Running Shoes - Brand: Adidas, Size: 9, Color: Blue',60,50,15,10),(1009,9,'Cricket Bat - Brand: SG, Type: Kashmir Willow, Size: Short Handle',40,35,10,5),(1010,10,'Cooking Oil 1L - Type: Olive Oil, Brand: Healthy Harvest',15,12,20,3),(1011,11,'Smartwatch - Brand: TechGear, Model: SmartFit 500',300,250,20,50),(1012,12,'Office Desk - Type: Executive, Color: Mahogany',500,400,20,100),(1013,13,'T-shirt - Brand: Casual Comfort, Color: Gray, Size: L',20,15,25,5),(1014,14,'Yoga Mat - Type: Non-slip, Color: Purple',15,12,20,3),(1015,15,'Cereal Box - Type: Whole Grain, Brand: NutriFlakes',10,8,20,2),(1016,16,'Gaming Laptop - Brand: GamerTech, Model: TitanX',1200,1000,20,200),(1017,17,'Coffee Table - Type: Glass Top, Color: Espresso',300,250,20,50),(1018,18,'Sunglasses - Brand: SunShade, Style: Aviator, Color: Black',25,20,20,5),(1019,19,'Football - Brand: Nike, Size: Standard',35,30,15,5),(1020,20,'Pasta Pack - Type: Penne, Brand: Italian Delight',12,10,17,2),(1021,21,'Bluetooth Headphones - Brand: SoundWave, Model: NoiseBuster',50,40,20,10),(1022,22,'Bed Frame - Type: King Size, Material: Oak, Color: Walnut',800,700,15,100),(1023,23,'Denim Jeans - Brand: DenimCraft, Style: Slim Fit, Color: Indigo',30,25,10,5),(1024,24,'Tennis Racket - Brand: Wilson, Type: Professional',25,20,20,5),(1025,25,'Milk 1L - Type: Cows Milk, Brand: FreshLife',8,7,13,1),(1026,26,'Desktop PC - Brand: TechMaster, Model: PowerPro',700,600,15,100),(1027,27,'Bookshelf - Type: Wall-mounted, Color: White',200,150,25,50),(1028,28,'Wrist Watch - Brand: TimeStyle, Style: Classic, Color: Silver',40,35,13,5),(1029,29,'Basketball Shoes - Brand: Puma, Size: 10, Color: Red',70,60,15,10),(1030,30,'Toothpaste - Brand: FreshSmile, Type: Whitening',5,4,20,1);
/*!40000 ALTER TABLE `sku_detail_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_detail_dim`
--

DROP TABLE IF EXISTS `transaction_detail_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_detail_dim` (
  `transaction_id` int NOT NULL,
  `coupon_code` varchar(10) NOT NULL,
  `transaction_type` varchar(4) NOT NULL,
  `total_amount` int NOT NULL,
  `transaction_status` varchar(9) DEFAULT NULL,
  `total_discount_amount` int NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `coupon_code` (`coupon_code`),
  CONSTRAINT `transaction_detail_dim_ibfk_1` FOREIGN KEY (`coupon_code`) REFERENCES `coupon_detail_subdim` (`coupon_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_detail_dim`
--

LOCK TABLES `transaction_detail_dim` WRITE;
/*!40000 ALTER TABLE `transaction_detail_dim` DISABLE KEYS */;
INSERT INTO `transaction_detail_dim` VALUES (8001,'ABCD1234','COD',1028,'completed',50),(8002,'ABCD1235','card',55000,'failed',200),(8003,'ABCD1236','UPI',567,'pending',20),(8004,'EFGH6789','UPI',789,'completed',30),(8005,'EFGH6790','COD',5999,'pending',100),(8006,'EFGH6791','card',1200,'completed',60),(8007,'IJKL2345','COD',899,'failed',30),(8008,'IJKL2346','UPI',450,'pending',15),(8009,'IJKL2347','card',700,'completed',40),(8010,'KLMN9876','UPI',345,'failed',25),(8011,'KLMN9877','COD',2500,'completed',120),(8012,'LMNO3456','card',890,'failed',45),(8013,'LMNO3457','UPI',1234,'pending',50),(8014,'LMNO3458','COD',789,'completed',30),(8015,'LMNO3457','UPI',432,'failed',20),(8016,'MNOP7891','card',1500,'completed',70),(8017,'MNOP7892','COD',2999,'pending',90),(8018,'PQRS9877','UPI',567,'completed',40),(8019,'MNOP7892','card',4500,'failed',200),(8020,'QRST3456','UPI',765,'completed',30),(8021,'PQRS9877','COD',890,'pending',45),(8022,'WXYZ5679','card',120,'completed',5),(8023,'WXYZ5680','UPI',987,'failed',40),(8024,'UVWX1235','COD',1299,'completed',60),(8025,'UVWX1234','card',500,'failed',25),(8026,'QRST3457','UPI',678,'pending',30),(8027,'QRST3456','COD',349,'completed',15),(8028,'YXWV5679','card',999,'failed',50),(8029,'UVWX1235','UPI',890,'completed',40),(8030,'WXYZ5680','COD',1200,'pending',60);
/*!40000 ALTER TABLE `transaction_detail_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_of_measurement_dim`
--

DROP TABLE IF EXISTS `unit_of_measurement_dim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unit_of_measurement_dim` (
  `unit_of_measurement_id` int NOT NULL,
  `unit_name` varchar(30) NOT NULL,
  `abbreviation` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`unit_of_measurement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_of_measurement_dim`
--

LOCK TABLES `unit_of_measurement_dim` WRITE;
/*!40000 ALTER TABLE `unit_of_measurement_dim` DISABLE KEYS */;
INSERT INTO `unit_of_measurement_dim` VALUES (1,'Each','EA'),(2,'Kilogram','KG'),(3,'Meter','M'),(4,'Piece','PC'),(5,'Liter','L'),(6,'Set','SET'),(7,'Box','BOX'),(8,'Centimeter','CM'),(9,'Gallon','GAL'),(10,'Dozen','DZ'),(11,'Pound','LB'),(12,'Packet','PKT'),(13,'Roll','ROLL'),(14,'Square Meter','SQM'),(15,'Pallet','PAL'),(16,'Bundle','BDL'),(17,'Case','CASE'),(18,'Ounce','OZ'),(19,'Bag','BAG'),(20,'Pair','PAIR'),(21,'Sheet','SHEET'),(22,'Carton','CTN'),(23,'Jar','JAR'),(24,'Barrel','BAR'),(25,'Tray','TRAY'),(26,'Cup','CUP'),(27,'Bucket','BUCKET'),(28,'Roll','ROLL'),(29,'Sack','SACK'),(30,'Tube','TUBE');
/*!40000 ALTER TABLE `unit_of_measurement_dim` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse_detail`
--

DROP TABLE IF EXISTS `warehouse_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouse_detail` (
  `warehouse_id` int NOT NULL,
  `warehouse_name` varchar(50) DEFAULT NULL,
  `warehouse_location` varchar(100) NOT NULL,
  `warehouse_capacity` int DEFAULT NULL,
  `warehouse_manager` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`warehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse_detail`
--

LOCK TABLES `warehouse_detail` WRITE;
/*!40000 ALTER TABLE `warehouse_detail` DISABLE KEYS */;
INSERT INTO `warehouse_detail` VALUES (201,'Mumbai Warehouse','Mumbai, India',5000,'Raj Sharma'),(202,'Delhi Warehouse','Delhi, India',7000,'Priya Singh'),(203,'Chennai Warehouse','Chennai, India',6000,'Arun Kumar'),(204,'Kolkata Warehouse','Kolkata, India',4500,'Sneha Das'),(205,'Bangalore Warehouse','Bangalore, India',8000,'Nikhil Reddy'),(206,'Hyderabad Warehouse','Hyderabad, India',5500,'Anjali Gupta'),(207,'Ahmedabad Warehouse','Ahmedabad, India',4000,'Vijay Patel'),(208,'Pune Warehouse','Pune, India',6500,'Meera Deshmukh'),(209,'Jaipur Warehouse','Jaipur, India',4800,'Rajat Jain'),(210,'Lucknow Warehouse','Lucknow, India',5200,'Sanya Verma'),(211,'Kochi Warehouse','Kochi, India',3500,'Suresh Nair'),(212,'Indore Warehouse','Indore, India',3000,'Mansi Singh'),(213,'Coimbatore Warehouse','Coimbatore, India',4500,'Aakash Rajput'),(214,'Vadodara Warehouse','Vadodara, India',3800,'Kavita Sharma'),(215,'Bhopal Warehouse','Bhopal, India',4200,'Rohit Gupta'),(216,'Nagpur Warehouse','Nagpur, India',7000,'Shreya Joshi'),(217,'Visakhapatnam Warehouse','Visakhapatnam, India',5500,'Arjun Reddy'),(218,'Surat Warehouse','Surat, India',4800,'Divya Patel'),(219,'Kanpur Warehouse','Kanpur, India',6000,'Amit Kapoor'),(220,'Thane Warehouse','Thane, India',5200,'Kriti Sharma'),(221,'Patna Warehouse','Patna, India',3500,'Aryan Singh'),(222,'Ludhiana Warehouse','Ludhiana, India',3000,'Anika Khanna'),(223,'Agra Warehouse','Agra, India',4500,'Rajat Verma'),(224,'Varanasi Warehouse','Varanasi, India',3800,'Nisha Yadav'),(225,'Ranchi Warehouse','Ranchi, India',4200,'Vikas Tiwari'),(226,'Mysuru Warehouse','Mysuru, India',7000,'Ananya Kumar'),(227,'Jodhpur Warehouse','Jodhpur, India',5500,'Vishal Singh'),(228,'Amritsar Warehouse','Amritsar, India',4800,'Preet Kaur'),(229,'Guwahati Warehouse','Guwahati, India',6000,'Rohini Das'),(230,'Srinagar Warehouse','Srinagar, India',5200,'Sarthak Raina');
/*!40000 ALTER TABLE `warehouse_detail` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-04 14:11:02

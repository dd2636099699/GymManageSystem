/*
SQLyog Professional v13.1.1 (64 bit)
MySQL - 8.0.26 : Database - gym
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`gym` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `gym`;

/*Table structure for table `adminuser` */

DROP TABLE IF EXISTS `adminuser`;

CREATE TABLE `adminuser` (
  `adminId` int NOT NULL AUTO_INCREMENT,
  `adminName` varchar(20) DEFAULT NULL,
  `adminPassword` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`adminId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

/*Data for the table `adminuser` */

insert  into `adminuser`(`adminId`,`adminName`,`adminPassword`) values 
(1,'admin','0192023a7bbd73250516f069df18b500'),
(7,'liujian','0192023a7bbd73250516f069df18b500');

/*Table structure for table `chongzhi` */

DROP TABLE IF EXISTS `chongzhi`;

CREATE TABLE `chongzhi` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Memberid` int DEFAULT NULL,
  `newMoney` float DEFAULT NULL,
  `OriginalMoney` float DEFAULT NULL,
  `Date` datetime DEFAULT NULL,
  `czjine` float DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8mb3;

/*Data for the table `chongzhi` */

insert  into `chongzhi`(`Id`,`Memberid`,`newMoney`,`OriginalMoney`,`Date`,`czjine`) values 
(67,25,500,1,'2023-04-11 16:55:47',500),
(91,35,11,0,'2024-02-29 15:49:07',11),
(92,35,11,0,'2024-02-29 15:50:17',11),
(93,35,1,0,'2024-02-29 15:55:38',1),
(94,35,1655,16,'2024-02-29 16:32:51',1639),
(95,35,12,11,'2024-02-29 16:36:20',1),
(96,35,24,23,'2024-02-29 16:45:59',1),
(99,42,1,0,'2024-03-04 18:14:13',1),
(100,42,61,1,'2024-03-04 18:14:34',60),
(101,42,71,11,'2024-03-04 18:23:57',60),
(102,42,81,21,'2024-03-04 18:24:30',60),
(103,42,91,31,'2024-03-04 18:34:41',60),
(104,42,81,41,'2024-03-05 21:57:20',40),
(105,26,101,1,'2024-03-05 23:07:30',100),
(107,26,51,31,'2024-03-09 23:08:29',20),
(108,26,51,1,'2024-03-09 23:09:21',50),
(109,26,209,21,'2024-03-10 00:02:35',188),
(111,61,350,250,'2024-05-20 13:29:48',100),
(112,60,200,0,'2024-05-21 09:07:15',200),
(113,61,305,300,'2024-05-21 09:32:52',5),
(114,61,355,255,'2024-05-21 09:35:18',100);

/*Table structure for table `classroom` */

DROP TABLE IF EXISTS `classroom`;

CREATE TABLE `classroom` (
  `classroomId` int NOT NULL AUTO_INCREMENT,
  `classroomName` varchar(50) DEFAULT NULL,
  `capacity` int DEFAULT NULL,
  `equipment` varchar(100) DEFAULT NULL,
  `location` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`classroomId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3;

/*Data for the table `classroom` */

insert  into `classroom`(`classroomId`,`classroomName`,`capacity`,`equipment`,`location`) values 
(1,'101',1,NULL,'101'),
(2,'102',45,NULL,'102'),
(3,'103',45,NULL,'103'),
(4,'104',45,NULL,'104'),
(5,'105',45,NULL,'105'),
(7,'106',2,NULL,'2'),
(10,'107',1,NULL,'1');

/*Table structure for table `coach` */

DROP TABLE IF EXISTS `coach`;

CREATE TABLE `coach` (
  `coachId` int NOT NULL AUTO_INCREMENT,
  `coachName` varchar(20) DEFAULT NULL,
  `coachPhone` varchar(50) DEFAULT NULL,
  `coachSex` int DEFAULT NULL,
  `CoachAge` int DEFAULT NULL,
  `CoachData` date DEFAULT NULL,
  `Teach` int DEFAULT NULL,
  `CoachWages` double DEFAULT NULL,
  `CoachAddress` varchar(100) DEFAULT NULL,
  `CoachStatic` int DEFAULT '0',
  `coachPassword` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`coachId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;

/*Data for the table `coach` */

insert  into `coach`(`coachId`,`coachName`,`coachPhone`,`coachSex`,`CoachAge`,`CoachData`,`Teach`,`CoachWages`,`CoachAddress`,`CoachStatic`,`coachPassword`) values 
(2,'å¼ èµ·çµ','13243253432',0,221,'2019-08-02',2,1,'å¼ å®¶å¤æ¥¼',0,'0192023a7bbd73250516f069df18b500'),
(3,'è“å¿˜æœº','13324332344',0,20,'2019-08-02',2,2,'äº‘æ·±ä¸çŸ¥å¤„',0,'0192023a7bbd73250516f069df18b500'),
(4,'ccc','13324245453',1,25,'2023-04-10',3,3,'ä»™ä¹å›½',0,'0192023a7bbd73250516f069df18b500'),
(11,'æˆ˜å£«','13342244112',0,182,'2023-05-01',2,4,'é•¿ç•™1234111',1,'0192023a7bbd73250516f069df18b500'),
(12,'ç™½å‡¤ä¹','13433324335',1,20,'2019-10-04',1,5,'é’ä¸˜',2,'0192023a7bbd73250516f069df18b500'),
(14,'å¼ å«','15299985622',1,35,'2023-04-02',5,6,'åŒ—äº¬ä¸°å°',1,'0192023a7bbd73250516f069df18b500'),
(16,'å‘¨å‘½1','15785456231',1,22,'2023-05-06',2,7,'é™•è¥¿è¥¿å®‰',0,'0192023a7bbd73250516f069df18b500');

/*Table structure for table `course_schedule` */

DROP TABLE IF EXISTS `course_schedule`;

CREATE TABLE `course_schedule` (
  `scheduleId` int NOT NULL AUTO_INCREMENT,
  `coachId` int NOT NULL,
  `subId` int NOT NULL,
  `classTime` datetime DEFAULT NULL,
  `courseStatus` int DEFAULT '1',
  `classroomId` int DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `purchaseCount` int DEFAULT NULL,
  PRIMARY KEY (`scheduleId`),
  KEY `coach_id_fk` (`coachId`),
  KEY `sub_id_fk` (`subId`),
  KEY `classroom_id_fk` (`classroomId`),
  CONSTRAINT `classroom_id_fk` FOREIGN KEY (`classroomId`) REFERENCES `classroom` (`classroomId`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `coach_id_fk` FOREIGN KEY (`coachId`) REFERENCES `coach` (`coachId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sub_id_fk` FOREIGN KEY (`subId`) REFERENCES `subject` (`subId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3;

/*Data for the table `course_schedule` */

insert  into `course_schedule`(`scheduleId`,`coachId`,`subId`,`classTime`,`courseStatus`,`classroomId`,`startTime`,`endTime`,`purchaseCount`) values 
(9,4,1,NULL,3,1,'2023-04-01 02:00:00','2023-04-01 10:30:00',0),
(11,4,4,NULL,3,2,'2024-04-02 09:00:00','2024-04-02 10:30:00',2),
(13,3,1,NULL,3,4,'2024-03-03 13:35:00','2024-03-04 13:36:00',0),
(15,3,1,NULL,3,7,'2024-04-01 14:23:00','2024-04-01 15:23:00',2),
(16,3,2,NULL,3,2,'2024-04-01 03:25:00','2024-04-01 06:30:00',2),
(17,2,2,NULL,3,1,'2024-04-01 04:43:00','2024-04-01 04:50:00',1),
(18,4,6,NULL,3,1,'2024-03-09 21:43:00','2024-03-09 23:44:00',0),
(19,3,2,NULL,3,3,'2024-03-29 21:47:00','2024-03-29 23:47:00',3),
(20,11,2,NULL,3,7,'2024-03-09 19:36:00','2024-03-09 22:36:00',0),
(22,11,1,NULL,3,2,'2024-03-10 01:01:00','2024-03-10 08:01:00',1),
(23,11,6,NULL,3,2,'2024-03-10 00:05:00','2024-03-10 00:07:00',1),
(24,2,1,NULL,3,1,'2024-04-06 20:47:00','2024-04-06 22:47:00',0),
(25,3,4,NULL,3,3,'2024-04-06 20:51:00','2024-04-06 22:51:00',0),
(26,2,2,NULL,3,1,'2024-04-07 20:51:00','2024-04-20 22:51:00',1),
(29,3,2,NULL,3,2,'2024-05-22 09:16:00','2024-05-22 11:16:00',1);

/*Table structure for table `coursesale` */

DROP TABLE IF EXISTS `coursesale`;

CREATE TABLE `coursesale` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `scheduleId` int NOT NULL,
  `memberId` int NOT NULL,
  `purchaseDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `scheduleId` (`scheduleId`),
  KEY `memberId` (`memberId`),
  CONSTRAINT `coursesale_ibfk_1` FOREIGN KEY (`scheduleId`) REFERENCES `course_schedule` (`scheduleId`),
  CONSTRAINT `coursesale_ibfk_2` FOREIGN KEY (`memberId`) REFERENCES `member` (`MemberId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `coursesale` */

insert  into `coursesale`(`id`,`scheduleId`,`memberId`,`purchaseDate`) values 
(2,19,42,'2024-03-05 00:19:55'),
(4,17,25,'2024-03-05 00:23:09'),
(5,16,42,'2024-03-05 21:58:04'),
(6,11,42,'2024-03-05 22:16:01'),
(7,15,42,'2024-03-05 22:58:39'),
(8,19,26,'2024-03-05 23:19:28'),
(9,16,26,'2024-03-05 23:30:47'),
(10,15,26,'2024-03-09 23:09:38'),
(11,22,26,'2024-03-10 00:04:28'),
(12,23,26,'2024-03-10 00:04:56'),
(13,11,26,'2024-03-10 00:12:28'),
(15,26,25,'2024-04-05 23:06:20'),
(16,29,61,'2024-05-21 09:36:41');

/*Table structure for table `device` */

DROP TABLE IF EXISTS `device`;

CREATE TABLE `device` (
  `device_id` int NOT NULL AUTO_INCREMENT,
  `custom_name` varchar(255) DEFAULT NULL,
  `ip` varchar(45) NOT NULL,
  PRIMARY KEY (`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `device` */

/*Table structure for table `equipment` */

DROP TABLE IF EXISTS `equipment`;

CREATE TABLE `equipment` (
  `eqId` int NOT NULL AUTO_INCREMENT,
  `eqName` varchar(20) DEFAULT NULL,
  `count` int DEFAULT NULL,
  PRIMARY KEY (`eqId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;

/*Data for the table `equipment` */

insert  into `equipment`(`eqId`,`eqName`,`count`) values 
(1,'è·‘æ­¥æœº',1),
(6,'åŠ¨æ„Ÿå•è½¦',2),
(7,'å‘¼å•¦åœˆ',100),
(8,'ttt',1),
(11,'æµ‹è¯•2',4);

/*Table structure for table `goodinfo` */

DROP TABLE IF EXISTS `goodinfo`;

CREATE TABLE `goodinfo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `goodsid` int DEFAULT NULL,
  `memberid` int DEFAULT NULL,
  `count` int DEFAULT NULL,
  `price` double DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3;

/*Data for the table `goodinfo` */

insert  into `goodinfo`(`id`,`goodsid`,`memberid`,`count`,`price`,`remark`) values 
(9,3,25,2,10,''),
(12,4,26,5,5,''),
(14,5,34,6,30,''),
(15,2,37,2,10,'');

/*Table structure for table `goods` */

DROP TABLE IF EXISTS `goods`;

CREATE TABLE `goods` (
  `goodsId` int NOT NULL AUTO_INCREMENT,
  `goodsName` varchar(50) DEFAULT NULL,
  `unit` varchar(20) DEFAULT NULL,
  `unitPrice` double DEFAULT NULL,
  `sellPrice` double DEFAULT NULL,
  `inventory` int DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`goodsId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

/*Data for the table `goods` */

insert  into `goods`(`goodsId`,`goodsName`,`unit`,`unitPrice`,`sellPrice`,`inventory`,`remark`) values 
(2,'å¯å£å¯ä¹','ç“¶',2,5,48,'1'),
(3,'ç™¾äº‹å¯ä¹','ç“¶',2,5,3,''),
(4,'å°å¸ƒä¸é›ªç³•','æ ¹',0.5,1,13,''),
(5,'åŽ‹ç¼©é¥¼å¹²','å—',2,5,24,''),
(7,'è„‰åŠ¨','ç“¶',3,6,0,''),
(8,'æ¯›å·¾','ä¸ª',10,20,0,'');

/*Table structure for table `loos` */

DROP TABLE IF EXISTS `loos`;

CREATE TABLE `loos` (
  `loosId` int NOT NULL AUTO_INCREMENT,
  `loosName` varchar(20) DEFAULT NULL,
  `loosImages` varchar(50) DEFAULT NULL,
  `loosAddress` varchar(50) DEFAULT NULL,
  `loosjdate` datetime DEFAULT NULL,
  `loosStatus` int DEFAULT NULL,
  `scavenger` varchar(50) DEFAULT NULL,
  `scavengerPhone` varchar(50) DEFAULT NULL,
  `ReceiveName` varchar(20) DEFAULT NULL,
  `ReceivePhone` varchar(20) DEFAULT NULL,
  `loosldate` datetime DEFAULT NULL,
  `admin` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`loosId`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;

/*Data for the table `loos` */

insert  into `loos`(`loosId`,`loosName`,`loosImages`,`loosAddress`,`loosjdate`,`loosStatus`,`scavenger`,`scavengerPhone`,`ReceiveName`,`ReceivePhone`,`loosldate`,`admin`) values 
(1,'è½¦é’¥åŒ™','1','åŽ•æ‰€é—¨å£','2023-04-10 00:00:00',1,'å¼ ä¸‰','13355660000','22','25525','2023-04-12 00:00:00','admin'),
(6,'æ‰‹æœº','1','å‰å°','2023-05-01 00:00:00',1,'çŽ‹èƒ½','15299952320','å¼ å®','15899965478','2023-05-02 00:00:00','admin'),
(7,'é’±åŒ…','1','åŠ¨æ„Ÿå•è½¦æ—','2023-05-01 00:00:00',0,'æŽé•‡','15966325478',NULL,NULL,NULL,'admin'),
(8,'åŒ…','1','é—¨å£','2023-05-02 00:00:00',0,'åˆ˜ä¼Ÿ','15326587548',NULL,NULL,NULL,'admin'),
(9,'1','1','1','2024-03-02 00:00:00',0,'1','15266668585',NULL,NULL,NULL,'admin'),
(10,'1','1','1','2024-03-16 00:00:00',1,'1','13243253432','1','13243253432','2024-03-10 00:00:00','admin'),
(11,'12','1','2','2024-03-15 00:00:00',1,'2','15266528548','1','13243253432','2024-02-28 00:00:00','admin'),
(12,'æµ‹è¯•','1','æµ‹è¯•','2024-05-21 00:00:00',1,'æ¢è¡Œ','13536967225','å–å›žæµ‹è¯•','13536967226','2024-05-21 00:00:00','admin');

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `MemberId` int NOT NULL AUTO_INCREMENT,
  `MemberName` varchar(63) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `MemberPhone` varchar(20) DEFAULT NULL,
  `MemberSex` int DEFAULT NULL,
  `MemberAge` int DEFAULT NULL,
  `MemberTypes` int DEFAULT NULL,
  `NenberDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Birthday` varchar(20) DEFAULT NULL,
  `memberStatic` int DEFAULT NULL,
  `Memberbalance` float DEFAULT '0',
  `Memberxufei` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `groud_id` int DEFAULT NULL,
  `face_id` varchar(31) DEFAULT NULL,
  `face_feature` blob,
  `update_time` date DEFAULT NULL,
  `memberPassword` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`MemberId`),
  KEY `fk-member-membertype` (`MemberTypes`),
  CONSTRAINT `fk-member-membertype` FOREIGN KEY (`MemberTypes`) REFERENCES `membertype` (`TypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8mb3;

/*Data for the table `member` */

insert  into `member`(`MemberId`,`MemberName`,`MemberPhone`,`MemberSex`,`MemberAge`,`MemberTypes`,`NenberDate`,`Birthday`,`memberStatic`,`Memberbalance`,`Memberxufei`,`groud_id`,`face_id`,`face_feature`,`update_time`,`memberPassword`) values 
(25,'æµæ±—','13456789087',1,22,2,'2023-04-07 00:00:00','04-07',2,355,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(26,'Tom1','15266668585',0,24,5,'2023-04-07 00:00:00','04-07',1,79,'2024-06-06 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(34,'çŽ‹æ³½æ˜Ž','17858966255',1,19,5,'2023-04-07 00:00:00','04-07',2,820,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(35,'å¼ çº¢','18799256874',0,23,1,'2023-04-07 00:00:00','04-07',2,24,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(37,'çŽ‹èŠ³','15299950487',0,22,3,'2023-04-07 00:00:00','04-07',2,990,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(42,'jerry','15266528549',1,20,5,'2023-04-07 00:00:00','04-07',2,16,'2024-05-01 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(43,'æ–¹è“','13456789876',0,22,5,'2023-04-07 00:00:00','04-07',2,0,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(44,'èµµé™','15288888888',0,25,3,'2023-04-07 00:00:00','04-07',2,0,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(45,'å­™æˆ','18566584785',1,35,3,'2023-04-07 00:00:00','04-07',2,0,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(53,'çŽ‹èŠ³','15299950487',0,22,3,'2023-04-07 00:00:00','04-07',2,990,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(54,'æŽåŽé›„','15266668585',1,1,2,'2024-02-29 00:00:00','02-29',2,0,'2024-02-29 00:00:00',101,'pduhiehp80','\0€úD\0\0 Aˆ>™~%=<Aæ¥=8ò¼Ð>;=Šd<¼˜’>]–½ZÆ¼ß½(LY=\'ã>ÙX==[ªºwŠ\'<¨@=€£=Pš¼xdG:d\n=\\.ƒ=8ö›½I­Š¼Vê=U~<™]¥=Ï…ð<^À½þË½¼F²è=3×=›}ô½ßšˆ=?¼(¾©ö½g—Ì¼ðìÝ½ V=²ƒÿ<¡Ú½;ß¼óVF½Ï÷“<·Â1½3s½²À½‚ß»©é­½¿ÃÈ½±¾X=×¼„=Aõ™<©J]¼939½×œ½uæÃ½UEe¼¢ž.=ï/¼m·:rå>G:Š<“%¼j´Ê;kÔ<Ñnò½x—’½œ\"½\'ü1=ÎËj=ãmC»Ñ!™=sp=«Tä¼ÊŽ=Bê²½y+3»Õ¾ž¼¯ÚŒ»õŠÑ¼³\Z¼ðÛ»:¹¤½\Z“€½·]°=PRÈ¼òÁ=þ¦½Ÿ2=Ä=\":=¨Ãh½õ;™<¿æW=5ÄÞ»õ)é<‡%G=îM=ö^½›	Ž½¥ÎÉ=’_<Hýƒ<-d2½[™=>a8;‘Á=Çã¾™tª;ïHÕ¼NŸ‡»?‘]=ö!ù<Á¨½PÒ}½Â7*;é¨<¨k>ßÆe<î¿b;èÁ|½%í‚;œ»‰aœ=Ù?¶<gz½>|¶<EÁò<k(l<2))½Œ€=Üè<c{=ÿ>È=¹áW<Æ=Øg6»UÛ	>Çœ¼Yñ½=¾wX=‚Â=g³;]†‹=²I<ûîº”½L2=iD7=C˜<A<ÍŒD½çÁÐ½Wñ<‰Z½/ç½)õL=îtv½Ûíõ¼ž™»;Ç¾Ð!ì<18Š=ÂCm¼šš¿½ ©í¼ð÷ß¼Úc¯=J/½=Ý‚†½Í²ƒ½ó)y=ûP½Hÿ’½† ­½3ù>¶ˆ=L‹=y¢,=Ý©;–…_½mÅ»9\0‹½/áÉ½êç=Û¿v¼ÇÉ=àš‹»%\Z=Ï¥=ØÞ‘¼ïo½òÔ±=-Ni=aÙ×½é€’½Q(²; ¾=Úr!½(‘Ê½«,=ûL¾;#à¾ò ª¼Ý¦=!\'}½MjÎ¼ðŽ<ùc½=ÎÝ\"=O²&½NÖ3½fÁ<ÀÀç¼N9€=©*˜=ñ\nQ½‰t=½Í#Ž=\0[3¼¡<Úî±¼åþª½ÊeT¼jú,½f=ƒ½ru:=ºÃ³=1©‹<éÒ½¢:&½`o9=ãœ½‹%>k.•½˜d-½;ÉŒ=y¨=^*>ï5¡¼³œN=*\\†½hµ>Oáˆ=ßóÿ½Ú¢ ½[—==7ì–<…4=ÑÒ^»H§½aÄá=>÷½×¡¾','2024-02-29','c81e728d9d4c2f636f067f89cc14862c'),
(56,'å¼ ä¸½å¨Ÿ','15266668585',1,2,2,'2024-02-29 00:00:00','02-29',2,0,'2024-02-29 00:00:00',101,'zyphb2v2dg','\0€úD\0\0 AY¿Ž=ä*Â=n†œ¼H¢=uè<½}\r=Òôº_nà=Ä_I¼-<½\Z¥¾Ïî¼Æ7\0>\\ô\\= úC¼•Û<Ú€U=kP‘=µr¹¦„K½ô0¸¼­%Å¼N:3½0Äø<³mP=\\-ì<Ý½=FõÒ=“W½÷à=«÷-»zŠ,=\\Y¾|W=³öQ¾@ž\"¾l¶½áS´½z‰e;³p½CW)½c6¼#ÉÎ¼Zm¼Ü·1½\Z¶¼œÿ¨½*©_½SpÖ¼¡Ù¾¿¿=’~<ŒF;gÒm½%†R½ÕÄ@½[·\0¾]ˆ—½,:è=s`½~Öe=ð¶\"=6#= ›®½¡šÝ<öJ¼¥0Ø½.€€½Ä:`:ã²%=`\Z†¼ð¡;âŠ>`ß§½Š†Û¼Ûl>:ka½£ž=ê/æ½ãS=¼Ö#½òi½Íê<3ƒ	½“y½æ¤=åùz¼ü™¼.r$½à²•½—$š¼ÂÇÓ=^®˜½F©<½:!J=ç‚=Œb\n=ª&<Æå¼Š´†;¤M½-0•=î…G=(ë½J §<^Æ=Pè­;ò™¼ÙÄ¾„äý<½ƒn<&Ï;\n\r‚¼äg=ÙW×»0½AH½îaÒ=#š,=\Z«›<°ìL½î(˜½‹I½ô=e³ø=—»;¼ÓØ—<ê·.<£•Ü¹WRŠ=Ï¥¼³½K<Šý;Q7q=\ná=äˆÌ=ÃM½S#”½Å)N=®¿À;bÉY=ò/b=ïŽï<š¾(=¹Åk<DX;»‹~Ý<‚‘´:z‚˜=Cn)=œŠ<ì»=!Ãz½Bö¦½„á´=šcX¼aí®¼n&½Œ\\½¡÷¼Ûä¼ú õ¼z\'#=€\'½ðPú¼wôÉ½à¡™½2Ð=ÿ@=£ü<qX;¨$…<\\>»=<×½H ½ÛÂÇ½óÑ=óA‚=s!Y=,Ða=ùÙr½ðE¾½í“½•¹R½1ä‘½ËE<\nJ™¼áoâ=ìQ=¹K=zˆ†<gŠê¼ã§\"½?·<‘ðQ=—>š½ß°x½Å$g¼Þ€3=¡\n½ôøÒ½©˜¿<\rúr<Ý˜Q½ó<ÊÛŠ¼$½U·™;bãõ<;çG=:¹<’’8½6jr¼õ}=P`¶¼vU$=äÜç=’£˜=P¡ø»ãu½Ã½½ä\'¼ò:!½Ó^¥½Iw=YÐÑ½*¾®\0»<uRÁ<â¦=ï\Z½±Û¼Ew=ê½s½eSï= 5-<ùZ×¼’3é<i2Œ=~Šç<½†\0>\0½š7¼½¦½Ct>\0Û<ˆ¶½GY<L«p=úº=&‡§<­P½Å#½r.>€2Ž¼§‘¾','2024-02-29','eccbc87e4b5ce2fe28308fd9f2a7baf3'),
(60,'åˆ˜å®‡èˆª','15266668585',1,6,2,'2024-03-01 00:00:00','03-01',1,50,'2024-06-20 00:00:00',101,'897y6c3dpf','\0€úD\0\0 A|î<\"È=•˜=½•=UmÞ¼Â¼š=•G=¼x>Ñl¼	¹X=Ü‹ó½îØ¡¼›ÿ>ŽJ\n>›ü=ð=;¼û\'9Ór>«áV=b°Y½[Y¼ ½µ¼×Ú¼\nD¼ù\"€=òé½Ó€=¡†§=ëÍ¼ÕšG=º5º?k1<.x-¾C²o=÷ýù½¯©¾Y\'Ë½\"%¢½%Ó9=†b¼p«Ô¼Vç=¼äàø¼R¶L¼æ$Î;OÝ»ÛÉ½{o¾eµ½¹ž\0¾Nu#; ‘°¼.ó<z®½‚^/½Äkô¼å‹½˜­½ô=³¼¹Å\\=ŸÄ =rÃ%½g^£½Åg=^×´<Âµ¾b¾„N½Ý=J¶¯¼†m½KÃ=>ŽW½¹<p<\0…Á=ì(º½ ”õ¼ãáÀ½Û!8½IÁ½0Ò9½ö=5©¼2tÕ½÷“=ÜÌ¼4Y½:Ð½hè;›¹é=Ît…=J‡9½$ÀÆ:Ä‘=eû×<_V¡»€==V±å¼=$2<f<Ÿ½ïŸ=Mµ¥=<æ”¼³m½Uv¤<–¾+<\rœÚ<õØ+¾ V-½¢Eõ<]o=ñ‹Ë:….€=–µ¼¤x½ÌSX½m’®=axH=„˜	=*\"Ý½‹ë‘½Âõ½Uù<š\nù=cÀ¼È~…¼ç=ã3¢;s»#=IÅY½íO<â«Ò<?X=¤FÀ<2Î¬=*‰½®V{½ògÆ=E6ü<\"E=r±;=Ìù¸<gý–=J]=Ìüˆ=ª®P½U¾f¾Š=\0Vq»¥ñf=‡,¹=fiï½²eù½\rè÷<¶å£¼b!‰½æÁ-=Î˜;œ÷¼b>¼õ}<—%¢=q\'½¬\"½þ™Œ½•Ò½³®Ì<\'ß_=ú\'<rSV¼ÒO¼ó%C=ê¾$»òœ½ƒ@Â=`”ß=Õ#ä<J=|7p½+å¯½äÑì¼ÃÍž½¦ó­½9 E¼ÌýQ=¦¶¢=î“½¥¼‚¼W“b½P›«½zïo=º^Œ¼âÙ¹½C°½Õ=|5=Ð½»»¢¥½ø,»ÙBF=R½ï¹`½s£ó;©»ÀaÂ<Ãg¿=\01\n=$œ¼\r„½û»’¼á¤¬=¥¨Ê»µÙè=Ñ¡ï=½Ç.¼Ý¼^¡½pƒ½îLe=\Z½‚\nY½yjX¼£Á½¬K¾&Àg=Nº=NN=¢”½wb–¼…%Š=›½½`Uõ=K¨ ¼#$¼¼å<Mø¯=…8K=¬Pý=Eé¹¼&#ò¼ÏÖE½ÂÝ=ŽðT=í´ ½jy½<bi=G <ìj\'=^ÊF¼ü8«½Ë%8>ág;=C ½','2024-03-01','1679091c5a880faf6fb5e6087eb1b2dc'),
(61,'å¢å›ºæ™º','15266528549',1,19,5,'2024-03-09 00:00:00','04-01',1,270,'2024-06-10 00:00:00',101,'ym8a5u1u6c','\0€úD\0\0 AüS¼‡9½àa\n½þ#¼LÎ´½š5M¼¶ð½6å=°m»,{f=Rš£½¬ºÈ¼’w‰=³Ú=‰\nÉ<¨¾Ø;žÅ¬=RUu=ú\0Î¼§¾¤<8<½TxU<Ÿ¥½Yæ½õ£†=ž”}<¸Ë;ˆÑ=Èè£¼&ûô<ù\'Ó;Äü=ÜåÜ½ìC=Ïþù½ŠU¾i&\0½y£­½Ü|=½Çl›½­®)½ñM_<M=fÉ½þ—=œã™½__¼Þ¤W¼ˆ,¾+~=ã†½ë5ý<&³¼§y<S–/;w¦Ì½@ë\Z;•×=r:/½‚º5=Rå–=à,Ž=¨¥¨½ÑM=²9½Ç¢µ½‚Q”½ÓMß<õ.¶¼ü1	¼¿ªÏ¼=väŽ½¹q<ëƒo=»Ð‡½\Z+½XüÅ;%Æ;&ZŸ½™©½l\'}:É`¼<˜ê»æ£Ø<Mçû¼î3½oPi½±•l½q½§¥›=ŽF½úVÏ¼ÐÕ?=AI<Ã§£º\0¦…=Æ›Á<cy;¯™¼îÓÇ=k{p=Ø–2;ÁI½ì¡N=g-¼?«\n¼ì¾hþ><7‹$=II`½å­ú<µ;C˜+¼´×Œ½EL»¼èJ=G=`6k=Â½å9È½œU˜<Ÿ-×=Ã|+½œn„<v‘=È/Â=ù\n<Ò°N½:Õ¼Ã½.4<VÔµ<Ñþ­=ÓAÝ=\\¶<œU§½æ¯=ã?==ÅòJ=Õ=Æ´˜¼™ìÇ=B`=©&=o÷»•çx¼ëˆ=Ž…=Ø8<w>¬„½Œ¾aË= x¼lá‘¼}T*½÷:«»Žgñ<|•Ê¼%BN=[}Œ=¥Ên½]Ú²½öÚ5½€—¾ÒeÁ¼:¢Ê=í‚µ¼]@¼½ Ú=.<þ=²˜½Ì{½Â\"•½·ï¢=}I	>¦\nT»¨2´=…ý¹½ñ€.¾\'nÎ¼½šP:YU×;{\n=cˆ•½…®=‡þ=Ÿˆ0=‹eÌ»¬I¯<ƒ½Gr@=c³©=w°µ½™°A=/r=<Óò:=%3½ºO„½—7“=£\\…=;AÅ½½-\r½	”<œ	ûº`Ê¯;®$D=Ž«k<Äž=Ð{¾½ëz¼\'\\=·|½|—´<\"f>yZz<%ÞY;o5j;ìü¾{ü<þð‡½w&Ù½‘Ø‘=>*Ô½áJ½¢r¯ºËŒ=É¯½=9\0½%É`<ä7ý<·wÕ½Üó=Ú€Ò¼ÊA%¼]Ñ< Kc=¶|Ü;X>Iú‘½¦¥•:Ù‚<½­@>‚,<Õ©á½c(s=RÕÙ=æ±ç¼ÿÔy=ðsä¼®ƒ1½\n\r>kw®¼²(»½','2024-03-09','0192023a7bbd73250516f069df18b500'),
(74,'q','13536967226',1,1,2,'2024-05-24 12:56:01','05-27',2,0,'2024-05-24 12:56:01',101,'dn25akfllo','\0€úD\0\0 AV§á½“d÷=c½&Å©¼¹‰·<Oç½W1¾{þ\"=YÇÛ¼Ý)£½jZ%>4Lþ=Û{ö»_”ë¼›ÍÔ½Ö‚¦¼%Ä-½²Óf<ðp½ÿ2â<¿J>:ºéK;-ÅÅ<‹Z½zeÖ¼·ça=þdk½mhï:¼/ž<%)š<ê‡«=‚3±½·\"½—4x½€Mž=pÆ½¿ÅÅ;?%Ÿ=;&½õ=V;=+\\­<}E2>)¤à=`ñŸ=ì¤.=ï=ÁÈ<ú7¼6E¶½[[ß;dJÑ=š¼¾¶3q½gR¯<ì×=åë/½ž.=1ÇŽ=	b¼qË<D4½\r“<É6@=õ½‰!=]OM½{˜)½nåÁ½ß¨u=e¥°½Ã5=Ý…½{øN=D€²=i˜½¼”\n>u½ê­½=Û¾¢0•½pqÔ<B_5=§1“½Á¹[= 5>½â:=z*•¼ê+½)»>ƒúÑ<jWÙ¼»â;O…€¼C=5>ç>è½‚Ûg½\'Am»W¤¾¼‘ê§<7j·=OÀ¼Ú\\Ã¼i®9½{|=q¾Ó:ã#»kó=<w\"=zœU<¡èe=Å¸:{Yª½bí¾—^2<~ùÐ=ª(<ðA~<R0*=	˜Ð½Ì¼Ôb=R~=7½ò¼óu>ºÿ<Ò>gH½N`¼‚’(½ÓØ¾Ë{<aæ3½¿šF;Ivc¾Ë˜=CJ¼y–½ZÂ ¼An½zý»¼Wó¸<ŒÕ‘ºÏf‹¼Z\"½?>ó½À¦½>Ôº €F½%~<½ÛÄ=¼ãü<ËQ]½¶™<ŸŸI<Á¶	¾ý¼½™.5=âo=°–<¢@°¼óÅ=Œú3:†j;À+T½¢6I½9Ó8½šIÌ=mé\Z½\"ð<ã½aUE<&r§=R<¼|êK½ž @=„ž=“NN¼wìH=%“Š=—C{<×¸´½N5q<‰¼´Î¼m{=yå½7$f½×ú¹:Bá\r=»‹\Z¾QñV½GA½¯À<Ïp=…<Š=2¨<Œ¸>ï&\r<‹4»tö¡½cæ=5l=ùo;•°’½1ª)=Ïð=d­2¼`’½»ˆ\"»Çt’;yž;åþ¼Š^<eSºòÝ2=„1K=œ)o<.I¬<u=÷=ïçS½°Ëî½¢¢¾âJö=ÁÊ‚=KS•<ZXÐ½9«§=»ÿS¼±ñ½?E½Çð<ÖÏ×<\'L[½Á}½P\Zª=áèg=_„#=N\Z@=úÔº6|ƒ½j›&=,í{½¶Éð½Ó<Å£¼æáe¼h(¼!ñÒ=~Ê=\0 !=âR=~<','2024-05-24','0192023a7bbd73250516f069df18b500');

/*Table structure for table `membertype` */

DROP TABLE IF EXISTS `membertype`;

CREATE TABLE `membertype` (
  `TypeId` int NOT NULL AUTO_INCREMENT,
  `TypeName` varchar(20) DEFAULT NULL,
  `TypeciShu` int DEFAULT NULL,
  `TypeDay` int DEFAULT NULL,
  `Typemoney` float DEFAULT NULL,
  PRIMARY KEY (`TypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3;

/*Data for the table `membertype` */

insert  into `membertype`(`TypeId`,`TypeName`,`TypeciShu`,`TypeDay`,`Typemoney`) values 
(1,'å­£å¡',0,90,500),
(2,'æœˆå¡',0,30,150),
(3,'å¹´å¡',0,365,1000),
(5,'å‘¨å¡',0,7,50);

/*Table structure for table `person` */

DROP TABLE IF EXISTS `person`;

CREATE TABLE `person` (
  `person_id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(45) DEFAULT NULL,
  `person_name` varchar(45) NOT NULL,
  `power` int DEFAULT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `person` */

/*Table structure for table `privatecoachinfo` */

DROP TABLE IF EXISTS `privatecoachinfo`;

CREATE TABLE `privatecoachinfo` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `memberid` int DEFAULT NULL,
  `coachid` int DEFAULT NULL,
  `subjectid` int DEFAULT NULL,
  `count` int DEFAULT NULL,
  `countprice` double DEFAULT NULL,
  `realprice` double DEFAULT NULL,
  `date` date DEFAULT NULL,
  `state` int DEFAULT NULL,
  `remark` varchar(20) DEFAULT NULL,
  `admin` varchar(20) DEFAULT 'asdf',
  PRIMARY KEY (`pid`),
  KEY `fk_pri_subject` (`subjectid`),
  KEY `fk_pri_coach` (`coachid`),
  KEY `fk_pri_member` (`memberid`),
  CONSTRAINT `fk_pri_coach` FOREIGN KEY (`coachid`) REFERENCES `coach` (`coachId`),
  CONSTRAINT `fk_pri_member` FOREIGN KEY (`memberid`) REFERENCES `member` (`MemberId`),
  CONSTRAINT `fk_pri_subject` FOREIGN KEY (`subjectid`) REFERENCES `subject` (`subId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3;

/*Data for the table `privatecoachinfo` */

insert  into `privatecoachinfo`(`pid`,`memberid`,`coachid`,`subjectid`,`count`,`countprice`,`realprice`,`date`,`state`,`remark`,`admin`) values 
(3,25,16,1,1,200,30,'2023-04-07',1,'fg','aa'),
(13,26,14,2,22,660,500.5,'2023-04-15',1,'','asdf'),
(16,34,11,1,5,150,200,'2023-05-02',1,'','asdf'),
(17,25,4,5,5,100,100,'2023-05-01',1,'','asdf');

/*Table structure for table `record` */

DROP TABLE IF EXISTS `record`;

CREATE TABLE `record` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `device_id` int NOT NULL,
  `image_url` varchar(45) NOT NULL,
  `person_id` int NOT NULL,
  `result` bit(1) NOT NULL,
  `time` varchar(45) NOT NULL,
  PRIMARY KEY (`record_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `record` */

/*Table structure for table `renewalrecords` */

DROP TABLE IF EXISTS `renewalrecords`;

CREATE TABLE `renewalrecords` (
  `RecordId` int NOT NULL AUTO_INCREMENT,
  `TypeId` int NOT NULL,
  `MemberId` int NOT NULL,
  `OriginalBalance` float NOT NULL,
  `NewBalance` float NOT NULL,
  `RenewalTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`RecordId`),
  KEY `TypeId` (`TypeId`),
  KEY `MemberId` (`MemberId`),
  CONSTRAINT `renewalrecords_ibfk_1` FOREIGN KEY (`TypeId`) REFERENCES `membertype` (`TypeId`),
  CONSTRAINT `renewalrecords_ibfk_2` FOREIGN KEY (`MemberId`) REFERENCES `member` (`MemberId`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `renewalrecords` */

insert  into `renewalrecords`(`RecordId`,`TypeId`,`MemberId`,`OriginalBalance`,`NewBalance`,`RenewalTime`) values 
(14,5,25,390,340,'2024-02-29 13:40:23'),
(15,2,25,390,240,'2024-02-29 13:45:04'),
(16,5,25,390,340,'2024-02-29 13:47:52'),
(17,2,25,390,240,'2024-02-29 13:48:48'),
(19,2,25,390,240,'2024-03-04 18:15:04'),
(20,5,42,61,11,'2024-03-04 18:22:36'),
(21,5,42,71,21,'2024-03-04 18:24:06'),
(22,5,42,81,31,'2024-03-04 18:25:25'),
(23,5,42,91,41,'2024-03-04 18:34:53'),
(24,5,61,300,250,'2024-03-09 21:50:40'),
(25,5,26,51,1,'2024-03-09 23:08:42'),
(26,5,61,350,300,'2024-05-20 13:30:28'),
(27,2,60,200,50,'2024-05-21 09:07:53'),
(28,5,61,305,255,'2024-05-21 09:33:23'),
(29,5,61,355,305,'2024-05-21 09:36:01');

/*Table structure for table `reservation` */

DROP TABLE IF EXISTS `reservation`;

CREATE TABLE `reservation` (
  `reservationId` bigint NOT NULL AUTO_INCREMENT,
  `eqId` int NOT NULL,
  `date` date NOT NULL,
  `session` varchar(50) NOT NULL,
  `memberId` int NOT NULL,
  PRIMARY KEY (`reservationId`),
  KEY `eqId` (`eqId`),
  KEY `memberId` (`memberId`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`eqId`) REFERENCES `equipment` (`eqId`),
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`memberId`) REFERENCES `member` (`MemberId`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `reservation` */

insert  into `reservation`(`reservationId`,`eqId`,`date`,`session`,`memberId`) values 
(6,1,'2024-03-09','19:00-23:00',26),
(7,6,'2024-03-08','14:30-17:00',34),
(8,6,'2024-03-09','14:30-17:00',42),
(9,6,'2024-03-09','14:30-17:00',26),
(10,7,'2024-03-09','14:30-17:00',60),
(12,1,'2024-03-09','14:30-17:00',42),
(14,1,'2024-03-10','9:00-11:40',34),
(15,6,'2024-03-10','14:30-17:00',35),
(19,1,'2024-04-06','14:30-17:00',26),
(21,1,'2024-04-06','19:00-23:00',25),
(23,1,'2024-05-23','14:30-17:00',61);

/*Table structure for table `signinrecord` */

DROP TABLE IF EXISTS `signinrecord`;

CREATE TABLE `signinrecord` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `MemberName` varchar(255) NOT NULL,
  `SignInTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `signinrecord` */

insert  into `signinrecord`(`ID`,`MemberName`,`SignInTime`) values 
(1,'å¼ ä¸‰','2023-03-01 08:00:00'),
(4,'111111','2024-02-26 06:58:29'),
(5,'111111','2024-02-26 07:08:18'),
(6,'111111','2024-02-26 07:15:06'),
(7,'111111','2024-02-26 15:52:44'),
(21,'111111','2024-02-26 23:39:56'),
(25,'111111','2024-02-27 22:20:50'),
(26,'111111','2024-02-28 14:23:51'),
(27,'111111','2024-02-28 14:23:51'),
(28,'111111','2024-02-28 14:43:21'),
(29,'111111','2024-03-09 19:50:09'),
(30,'9','2024-04-03 13:44:22'),
(31,'ttt1','2024-04-03 13:44:34'),
(49,'å¢å›ºæ™º','2024-05-20 14:21:41'),
(50,'å¢å›ºæ™º','2024-05-21 09:03:49'),
(51,'å¢å›ºæ™º','2024-05-24 12:56:08'),
(52,'q','2024-05-24 12:56:16');

/*Table structure for table `subject` */

DROP TABLE IF EXISTS `subject`;

CREATE TABLE `subject` (
  `subId` int NOT NULL AUTO_INCREMENT,
  `subname` varchar(20) DEFAULT NULL,
  `sellingPrice` double DEFAULT NULL,
  PRIMARY KEY (`subId`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3;

/*Data for the table `subject` */

insert  into `subject`(`subId`,`subname`,`sellingPrice`) values 
(1,'å¥èº«çƒ',30),
(2,'è·‘æ­¥æœº',35),
(4,'åŽ‹åŠ›è½¦',50),
(5,'ä»°å§èµ·å',20),
(6,'å¥èº«æ“',50),
(7,'1',1);

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `user_password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user` */

/*Table structure for table `user_face_info` */

DROP TABLE IF EXISTS `user_face_info`;

CREATE TABLE `user_face_info` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'ä¸»é”®',
  `group_id` int DEFAULT NULL COMMENT 'åˆ†ç»„id',
  `face_id` varchar(31) DEFAULT NULL COMMENT 'äººè„¸å”¯ä¸€Id',
  `name` varchar(63) DEFAULT NULL COMMENT 'åå­—',
  `age` int DEFAULT NULL COMMENT 'å¹´çºª',
  `email` varchar(255) DEFAULT NULL COMMENT 'é‚®ç®±åœ°å€',
  `gender` smallint DEFAULT NULL COMMENT 'æ€§åˆ«ï¼Œ1=ç”·ï¼Œ2=å¥³',
  `phone_number` varchar(11) DEFAULT NULL COMMENT 'ç”µè¯å·ç ',
  `face_feature` blob COMMENT 'äººè„¸ç‰¹å¾',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'æ›´æ–°æ—¶é—´',
  `fpath` varchar(255) DEFAULT NULL COMMENT 'ç…§ç‰‡è·¯å¾„',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `GROUP_ID` (`group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `user_face_info` */

insert  into `user_face_info`(`id`,`group_id`,`face_id`,`name`,`age`,`email`,`gender`,`phone_number`,`face_feature`,`create_time`,`update_time`,`fpath`) values 
(9,101,'9wxxc9sfl3','1',NULL,NULL,NULL,NULL,'\0€úD\0\0 A—(‹={¯3;<o«¼¦£\"=ì7@½·…=æå»Ìˆ†=‘¹é»²\0=}*·½ƒî¢½Ug÷=\\>ó›r<s—=\'y=nò0=¦}½iéA=ìr=¹;iúp½Ú­A=ñÏ>ZJ=*£½3ŠË=K\'Š<³Ä¼<¼±.¼ælê=kÑŽ½<;ä=’®á½¿[Ü½ŒŸ=µ‹¾‚¡Y;*h3½9¿ò¼*.C;J7Á;1µ<€Ö¾ÉÞÏ»“Fk<»4ç¼öéÌ»¶lÖ½¯æ¼|¼½‰@=éÂ½ª¢Ÿ=í¡€½‡¾¬\ne<u¦£=ÂoÆ:æ°…¼Dí\0>Mçæ=_Á½­Û–=4Wa<ãU¶½ tr½Æt«½ýAi=Ð¶á».,Œ½7+=ø~½•J ½!à=®õ¤»7ðí<d\\Ì¼„‹<™îd¼…åÕ½÷‹¾ºp_½õëÄ½3Ü=\0è¼l\"v¼^¾=œ.œ» äå<+§¼X½Ëë)½þÑ›<Ôþµ½5\\¼ùÌ<;%=Ùú©=ûÄ½\"C>@Ç%=UäÏ½V\0=õ÷z=¾qö½ú\"=Ì¹½üÃ=VØá=…Ú•½5ºƒxÞ¼©Ø¹cé2=6÷/=»É±=êŠ¬=foí=KåN½Å“@:¼Ú¥»*zl=]×‰=	Cµ=·3=#ëË<Œ¾Ž<p$ <)È6½ž©<½Úò…½ã˜<›Ó=Ïƒå=°“‚<UO½¼ç®®=:ï=P=È<2Ö=a¸‹½yy-=Ÿ”=QË);`-=ûiÎ»Çºd=¦R<ßŽ=Î*>\'Q>½:˜½w[€=ÍŠ<öö½ë:2½\rR£½“µÕ<ƒ6F¼¦}W=¢¡Ã=|t½­G©½ÝKê½8*€½™¼$³%>3ŒN»=.5½Nè\r¼Y23>\Zöœ½2áÚ½_^¡½ÞL=?/=“\"½¶gÏ<ÄÆn½ÛÇ½a‰Õ<þ…¼P5Y½œõ¡<y—ô¼pv<Þzìº:“<Ïü\0½¡\">½At´½ÊÖ˜¼–bÔ=NCü½}Í¼©@a=¥R5=j\nÇ¼Þs$½÷/€=0=Ð`l=/:Ó¼BÛ-=G§Ã¼ÛÿE=!^=‘Ç©;‹b½}ÌÕ½Ø;6)ž=šìz=Ìˆh=ÖR=Î•«½¾ë½b¹<¼‡Ú½ÙU=/µ»Škw½ù>=Lè»½‹Nu:9Jò¼ž(u½\ná>^YZ½2¹V<“ü‰=ÿ[½š,ë=¼º>½\\Ê%<ö†V»ï¦ì=RE€=EÍ=Ï½±Â˜¼d$÷;Õê,=Æßÿ<#—¼ì<U= ¡–<šÙ°;Bíù<¥?É½jï¨½{5Q>H*=WÞì»','2024-01-28 21:42:55','2024-01-28 21:42:55',NULL),
(10,101,'lg3l5buyng','11',NULL,NULL,NULL,NULL,'\0€úD\0\0 A9ãú¼™¦½>·­¼Ž{°=ñÄ½×`Ê=kˆ¼=“>Z{<±d¼ƒ.<CÄ²»¡á—=»©ú<Í-¼¹\"\'=Å§Î=ºÀ¦<•+¤¼)“¢¼FÅ¦=FwZ=“¢²ºZèÞ¼õb=VëY=@;»Ïµ=ª½Æ¢j=+}(½by#=-ã½,ê=@Úc½\ZÉD¼æªÍ»ËH\r½*ã½×6¼«ª¼$A=‚0=ÂY<g«ñ½ûKÐ¼Â–2=¬¦X=´ÂÀ=C¾>6ð=Á9½Ÿ=‹<Õb¼½‘q°<1æ€=õ¨ù¼Ò÷«¼´VÃ½¹±4ì¼Ooe=³:Ñ=/†Ù¼±\ry»ï‹ø=Ý—½½€›E<š÷>¾e%‡=Ç<=\"!½RÌïº%F½”v”½Â\'_=–¬è½­µ<©sF½—X@;žÝ‡<`‚‚½²Ç.½ÛžÂ¼7¾½ÚÆ=>Ñ²<âW\"½ùt‚==¯ß¼‘Ð:=¦§¼Ës»°½ŠÖ=Å<í—<|¡»ü\rª<éQ5= ×½‚_>5Í\\< ¼Eñ=<¼8Á½\"}ê¼aýì¼°Ò«=ÕÇB¼Iõ»Êó–½€l=\r>6½5{¶»LÎW½]R=sÞ¼=ãjz=oO”½dü¼zö„=Ã	>ð¨B=\'Î<= C?<¡8Ü<Vh<a„¼SØ½ÃÈé¼TÕ½ÀI½ð=÷ë‹=Š¿>½‚å¨½ÿ‡Î¼³ýƒ=|½¼Ý×=ôË¥<­Þ©;ÎuÂ;	á¼—S½MÚ<ºžô<Sˆ¤<ÆA¾<£h==~ Í»5ô=ÿ>Òü½ï>j½9Ò½R¾Q½=áå<áÃ%=õx£=R”À½‰Ý½½Ü*}½åÄü¼š¶»<–=\n=mjJ=9aÊ¼L6¹<Z¬<•Ò¼{â½÷io½U¤!=Û £;‚²b<ó—\0>²«1½!ÿ¾Á{Á<vbÈ½ÅKÂ¼CA=ŠÇ¼6ÇÊ¼vâ€=ÿ½S½ûÉ¾«]»¹ƒ6¾{Ñ½=â\Z>ëØÙ<Jgˆ=½;”»õ£»<ô¨»6ZÎ½_øœ<¥&½\nÍ<æ¢Ï½“é.>?ï¼’ó=;\\%=¶j=drH=]z‚¼Ž<ÿý!=]Kð¼^eº<Ú_¯=jbP<ùÈÁ½ŸxÞ¼µ-Ö½CÏ½‡É¸<0¤?½á›\'=+‰¢½iŽ¼Ìˆ®½€¾f¯=àzl½ÔŸ	»ÛX¸=)Ú­½•‡1=z»<<³§=/=$ß=;Án@=rq†=Bþï½\'f˜½á…|=´E;lëN=!S¼]¿Û<ù{W<<Á…=žNõ¼+oM½SÂ½Šõ~=ŒŒ9=š8š»','2024-01-28 21:59:27','2024-01-28 21:59:27',NULL),
(11,101,'1zlxtyaein','111',NULL,NULL,NULL,NULL,'\0€úD\0\0 A,‹k=æv:=F\\l<Æ¿‚<¿M=9¸=‘eS=\'ß”=¼“9L m;3]	½”0½èô>Ž)Á=c9°<j<ã©=”…æ<S½q=ÓVÂ=@}=b(o½JRÖ¼~D$>eË¨»š0=óû€<r®<nð&½ÉlU=n;è<>šÈ=oÚ½ç}@=+¾†îŠ½ëØ =¤+	¾0\'¬<©ÆÎ<Âš¼ÌÐÌ8áûœ»!þÙ<.WŒ½—*É;5äÇ<›VÂ<!Ü¦½á˜½÷#-=Æ°\n½ø+¼¶*½ËlH=‡?Ù¼àLì½¾ÿ¤¼‰kŠ:Q\n<ký„;{´*>_n–=¼ÝH»îÜÂ=]ÄL½îuÍ½e’ß½½EoÅ<ÿðg½²‰”»‰ÉÐ=ôÍ\r½§¼ŒŽÍ==6½æE™¼\ZªI<jø\0=Ti:½Ió.½~ÔÀ<t+M½UÈ½³¾Ú=ùV¼÷Éƒ½û¥§=ìªó¼§k.;\0X<Oo½ƒ—º%Œ”¼Ü¿½‹¾\"½B÷=÷ì?=«úî=DÈ™½­fæ=`!=ã!Ú½§fû»\Z5ƒ< òØ½‹Û­»ly£½M^ ¼Oñ¶=ºc›½7¬½	÷¾¼&9C½ 2=¶=ô>	g=B«=%p°½W†~¼ZOI¼§9 <ðæß<ëñ%=Ÿÿ‰=ý˜Ó<lè•=\"¼w=\\\'	½^½ÙØG¼»8œ¼yôo=Ì†>¯{Þ¼âÃ¼š=-µq=°­²<ëÎ= á\\<\"ÌÕ<R<>„U=\\¤È¼²ãØ<ÉÞK=ó…Ž<¹ä=Aª>—ê;0¾È½´cÅ<Œæá:º$\'½¿ñ¶1¸³½áAÂ;o…¼ë³P<‹­ª<.z†»_¹è¼ÂåÂ½Åâ¬½¢2‘½\"”=¤a`½¶®–½EÅ¼õåA>Jp´½Óük½s†N½löÊ=ÎjØ¼ÙŠ•½W=¼Ê7½Õê½ö!-<A«G½\n1½	ö<Ihý¼zVÍ<Á‡£<ýX<¿³è¼Ásù¼’ˆ½‘jª<F¸­<.@ó½ök=KÅ¼/c=T~ø¼ßwŸ½jÕ=\\Á<²°Y»ž\\p½¹Ê˜=CfÇ»•è<`=ŠOŠ=!—»5è•½yQ¼U£=óÆ¬<ù$b=¼»Ðo¬½‡m:¼ŠHÓ<>Ú½§c/=‰y|½ÞÐ½1I•=•Ñ½‰¦é½†æm=¯½ŒPß=±Nå;uóã¼DÌ=\"-\r½\"íÆ=%§$½–@=‹y=§f	>t*:¼å>‰\ný½´-1½b+C;,–=A€=O}Á¼e†4=À¬=ži&½’Sõ<)b½%™¥½L£F>ÛN½˜+=','2024-01-29 22:56:12','2024-01-29 22:56:12',NULL),
(12,101,'44q9nixix8','55',NULL,NULL,NULL,NULL,'\0€úD\0\0 AA;xñ¼äqO½Cð=Ëò…¼r^=ððŒ¼D·Þ=Ïî;=:³M<©l½i½M½\n×©=S/æ=á¨à=ª¡½#$¸º”[=ÚO<µd==4A†=ØF=gœ»÷\'¤=+é½<F_0=\Zs¼>r‚=ï[©½¶<¸¼žd½9§8=8^â½œ=À=Ìæ½÷óÞ½7N¤=›…½†…¨¼™a¼;g;½Íu8<a´:q¶™»åþj½•J=³?£½ð—h½OÀÔ:Ñ\r¾Ó-ò<©Û¸½£ºž¼èdÇ½zr3=Dv´;J\nÛ½;ð½žÓ=RYð»~ïå<K_5>vÛ¨=½ï½w(®=\"éü<8oU½Ý½ ½\ZFÎ<_ïä¼SK½§M»ž¡¼Ñ½ô¿>Ç;‚½åJÄ;Â(ºýE™<¡ :;²}½Ä…+=M?*½órý¼?\\=è©c½\n ¼Zº§<êj‘»ÌºÔ:ã<ï«m½ýL‡=÷ž¨¼	Õ=¼·‡…¼Ÿ‘à<ðÎ=ð´Ç<|@ž½‹xŸ=´d²=$Ež½‹«<æ‡ª=Aƒ’½î\ná»Á+4½Íè°<¨¨=±#É½f*Æ9KÌZ¼ø$¼Ï,¨=«-™»Z=\r°=öO=O/	¾ÁsÍ»¶õ¼?ï`<zëX<mº=Þ‚«<Sã¸=OÔ’<»áÙ<Ñ/S½3ÞŒ½ëvm;SÂÓ;ñÝ=G£Á=³‘®;ÆB1½3‘½Äq©=ftd=o>*»XÓ¹=ðŽ…=¾õ=rEF<IÏ×»â¸=Ôà<T =´“B>äðõ¼;ÔÐ½—·<d£_<W½¥ŒU¼*ˆ~½ñâB¼‹º¨½	€b=âdˆ=¦4¾*7W¼LÎA½{K½›Ox½1ð\'>ÛÀ;=º\'¶½º<<.>¹ÔV½5cõ½žò•½=^L=D7˜<_ÿ»µõ“=m‰¹½¯¾}¸ž¼ XÅ¼_.µ<¡‘¯»ê*¼Ž,†=¥_•<µ¸D»Ë“¼W,Ÿ½Ùs]½j#&:‚›=º¶½LÍ=™¤\Z=§åÏ<G\0w¼!a½Ÿ«…=82½\rú¨½ÚúÃ½‘#=Ñ[~<cÎ”¼Ž’=Õ‹2=$Vå»>‡!¼­Ç¼?=Òg‘=vw=ù(š=pUä½#1½æCº:kì¾wm¼¶Iw¼+­»Yi`=HY½“¾Ùj½‰/½ã`×=¾˜Ã¼e\rL½PÃp=~¸{½&ëµ=y½ºª¼ç¦b=f¹=nÛ„=nî=8ßÑ½;a½V‚Æ»neò=ýYC=è›<ÇÖñ=™I<‚ººKÿ<ŸŒ•½¾ùÛ½oB3>ór<Lú½','2024-01-29 22:57:51','2024-02-16 22:18:29',NULL),
(17,101,'ufra1drnn7','00',NULL,NULL,NULL,NULL,'\0€úD\0\0 AL&>»ƒ¨=pq<žÆ\Z<Ê*_=kH¢=)‚:=L¹Ú=4Ø½Å8¥¼Õ­å½Ôû¼$•<ä¼!>\\I¼„öE==%î½‡½÷™¾Eüë=qÞ½Éù’½ì\r»Ÿè=dc¡=žFé¼Ní»=Z½»=êÅˆ=o7u=—wÜº,˜è½,„°<tðö½¡:ðõ¬½Í;‹½ý‚œ½å„=¶:Y½Ê1¿ºê´½¶™ë<5`a»Ù/»=Ð¼;½©1Ý<üá›<	`R½¹T=Õz:=Ó=ç\'b½Pº•»ÂÝJ½ºNu½\"á’½ LÖ¼¦\r<ÔÁA½ª-„=î[©<\0«¼âª†=¶ä4=ÎÖ¹½º\Z¾«7<9³‹=?!½L$=º›=j)å½4á½±o<ÑÊA½îøå;DÅG½&™½€};¼öÄÎ½RÐŸ¼ç\Z2¼¤½ûéç=Æe;©M½1ã1<¡VW<oÕ=FÜ= -;o%(½E¿P</•¤¼â³=w}.=ˆS=Ð¡½É;M½®@­¼FT¼u‡\r½Á´<½zˆÅ=¥9À=ãK=R¬(¾”Ìl¸O€˜=	Å ½¸Þ;Þ]‹=Y<C=\nÒ»¡4‡½÷Ü­=j“\r>‚I¼°îk½òeÔ½âGÞ¼Žá¦¼öF±=Úå½[Úóº‹ÝŸ¼ßŸ‰;>½\'—=ä–Ò<Ú†ë;j¡¯¼ìóÙ=êö=Šà¾!Þ¶<U‰Ÿ=\'SÐ¼T5ÿ=¾kR= }c¼÷Ûê=Îž=9\n9=±:=Ôã¾µ§Š<Ú ¢½ª =Gò»æØ ½i^÷½œÕÒ=Ây!½ªq¯½2Óø<L+c½q@ê<ØÀ¼ú@Y=Å Ò=Ž…\Z½³o„½N×½Ë\0¯½Dú&<—FÈ¼€©~½q,§=\"SÛ<D/½=¹ZD½œZ¬½æ‚j½åë½N’ý<Ù\r–½Ô;k»*Àð¼¸@¼ß©½‘<¾¡!š½iIn=‹*k½,c¸<Ú~Ê<²Õ`<àÔ½¦ý¾ëEÞ½B.å¼Ô‰½dóÃ½	Äj¼þŽE=t.>N½â›P<&Ä=Ï>ŒÍ±º{D:UX=uÁ±½ÙUú¼±¡à<’A=‰Á¹½KÅF½¡×²<YE…=â‹¼ÐWƒ;?ô> h½ÜCù½TkJ=¿!¾¡\nh=—j“=|Ù¾ª-¸»z&—¼›72<@;½UÍ$½i=Zù&½áŸ½T°½Žët<ïŽ=9è<d–<[ð3=”©ú<\'*À=Z){<ÕÖ{½Ž½=‘ž¤»©´=zH‹=>ç½¢2>û”\r¾ê_=a¹]<öXª»Æ$(½BÁ=døõ;âø¡½','2024-02-16 14:53:59','2024-02-16 14:53:59',NULL),
(18,101,'rlv7vaf9bs','77',NULL,NULL,NULL,NULL,'\0€úD\0\0 Ay=4=•°»sÞ<íe2½hí½ÀO=ï‡<é2>î´ »¶áU;`\0¾ã7•»åã=¹ë=ÅŒFºÇ\Z³¼»¦¬=]zw=<_ˆ½Wø„½EQ¼Â~!¼7è\0½í(R½!‹‹=ö+²< ‚Ö<îó¡=Eû ½Ú3=ÉE½=–sW=	à›½™»q»/ø¾Uz±½‚¸Ã¼†á¨½’ÆT½º7ª=@¾~¼~µÝ<ù	:~›0½æí<ÙÌ&½;Rõ;@|½®=ˆ½ã¥B=62b<yï]=ÍG½ëUœ½.…ä»âð½“Š–½O!=–‡U<~½y‚=¯|Ñ<\n¶Œ½\r‰›=®0é<ÿõ½š+½£Ý®¼±!=!Éó;Ê»î;-Æ<Nùm½¿ùL½ÝÁ¹=MJ ;òØ¸<[Qi¼‡\rŠ½*ûì½O¯½õIÏ»Ó\n¾H¹¸½¾™>0µ÷<~¼¶½î~Ú<—_©»éó=Ï¤¹<B`½nv ½¿áJ=žšK=ÏO==Ž=‚1½¨sv¼¹B½þï=¢‡Œ<¿¯½>\\½Þ<ÀÝ<é—a½øUd½	„=í—=1Ìi½UØn=›Ž»ÍÍ}¼¸AH½|†½ILÏ=¯“=Á0=Q/q½‰wÌ½ °Ž<\nŸ;nÐº=V\nµ;ÅØ=á=p¼H“½1¡»+¯Í¼àìê¼ñuY½ÜG=â®ˆ=¨(=uÜ» #X=‚‚=ZÉ=îÄ~=#C^½Jò¾=ŽÃ=©²®<c~½Åýº½Û?¼¡É@=Ý½¨×Ç=wš¾½~Ø\n¾0§=¡ó½ê¯Ö½\"=Š£Ø½i•ê<š¥¼%û§=j=B½¹ä{<õ,d½€ý+½—=uEŸ»R0Ù¼ñ×…»\Zý¼³ßé=}Z¾~©½ðï®½S\0=Ùž=›‰ø;Ñ{5¼„N¼Í0È½ø¢ï<Cf¡½é{Q½XQ—<²w’½w=ÿ4½ð‚=ó”©½¨ü½Î^`½s\n>=Á=;¸Ø¼¶¾W½ i<OŒ†=z\'lº=è½{\"É=.Â=ì¾bÐ•<Ðw=ø®½±ñ</«‚=x™=F½;á“8_^½N¢>=gª3¼Ò±§¼Z?Æ=í¾‹<Šlü½UèU¼½­ä½Yj‡=­_S½Ù/Ì½“ç	¼V“´½¦ÜÍ½x\'\\¼Ö\\É½K®Õ=Fó—½g6V<_N¶=7Xé½^Tµ=i‡¶»ï`ã¼Â´¹=}c=£|=ÑB\0>-jk¼sð/<:W½e&î<~½Ì<þÊŸ½ß!H=]¬–;™¿û<q(=õ{¼p¼Ž\ZÞ=«3½WˆÖ½','2024-02-22 12:56:11','2024-02-22 12:56:11',NULL),
(19,101,'y3sllbrr8v','888',NULL,NULL,NULL,NULL,'\0€úD\0\0 A~À-½ÅøZ½ú¼Cƒ=/…^½}R=  \"=’ù)>Í½ñ»Çx<Öðf½;< ½Õ;O=ï‡3>Ú^=9Á“¼#ùp=(“=Ág;\Zß?½í½Öû»+	½M9*½˜=	&D=»[4<[€Ë=âµZ½2äò;=†Ñ¼.j}=I*Ñ½§\r=iç\0¾6¡½Wí¼aSà½5½=;3vÛ½!´[¼íƒ<T;*è5¼öC=ÆtØ¼6þ¾2æ¿½_F#¾ÒO={âÎ½‰·f<ÒN‡½Qñ%½Éœƒ=Ñ}n½£Y;½ŽÐ´<\"<uE/=\n¦=VÌ\r=Âšq½m“=M\\=ÿE\0½Ú0R½<³¼|ã+<Ï½üÞ,½-w)=Äh#¼Ú&9½Ñ¯>Ï’<n¢¯»¯Ê¬¹æí¼l\rN½oqr½¿$T=ÿ„£½‰zC½‘r=¬£#¼9¾½±)Ø¼*ÍD½)GÐ<é=P\ZS½Ýb]½&^„»\'‰<!,¹<Û9”M˜<²;=`‚s½æ\r>9¸<¿‘²½¦|½~GË<[CÁ»=g¾½„Ñ«½ÞªÞ»Evg=Ã©E½m³Š=3\n’<¾Z¯;‹¼µí€½WvC=û÷U=ÇPŠ=¾”o½n£O<eú˜=—g„=¼NC=åš§=þÈø=À.=\\~c½Åˆ…¼.u¿½wÉB½#Ü¬¼ù<T>eì¼ÿœÑ¼Ê¤<ÙŽ«=æLY=Ôº=J!½[<ý=ûZ&=¬;Â<TÃI»5Çž½í’=Õ9=:%½T#>¯~6½1Ç½Ê`„=ÿ]½ÎÜs½Oõx;¢Íè½¬ð•<\"Í¼P{T=?~y=†:½ù¿ù¼¼eg½±½’ªë»«|Y<Åi»ºÄk½›C<½7“=èú½Êâ:½\Zz½ð<îXm=”j=9…l=¥?Ñ¼_±Ý½³Ð#=Ö\r½gÓÄ;+’¼Q&ï¼/83=Ê½¤Zûº*H\"½}V½Ðæà½ùWr¼	nO=Ùz°½ð<×-)=NË=òþ!=°Š•½#žõ<&M;5Šæ½$â]½ÓV\'=2ßÖ¹þ<•¼—·=µ1½$zV<Bà‚½_ãW¼Y!Z=^Ô½>Ù•»òÜè=ñ ¤;¬\rW½•É\r½P$ë½Õ«&=ÇŸ½&×‰½Ÿ¼3gÌ½6J$¾ž\'³½|ew½0LŽ=KÊš½ÃÞ–½½ðÿ<Ê×½sÌ=ñŸè:dF½*àÄ= Í=:fù<h7>\"À5½N4½ß~-½&®a=Î\Z=f&ì½|(‚=dj¼<›ky»6p‹=<s/½q‹½LÇ=KÉ{½þsÉ½','2024-02-22 15:04:10','2024-02-22 15:04:10',NULL),
(20,101,'9v27d4ogxc','1',NULL,NULL,NULL,NULL,'\0€úD\0\0 AŽ½\r¼\0°Ÿ:Çë8¼¿ÊØ=Š¶º=)×É<\"«=Grù=‰;ç<Yì©<1±½ÉËÄ<y Z=îÅ>Ñ &<Û<ª™ºÔä=qwª; =f*=WºC=Tí,½.}h½”Êƒ<õàÏ<W³=B	P=³H½ªIF»nÛ’½î„=7\0º½\0ÞI<ÆR¾ÚßÖ½µ»<þ‚ö¼’·;°qy½âæÈ8_5j=ß)N½Ò…=v19¹y=ºÌ½~´ˆ½¡“½a¼I¾/r=t(=$`)¼¾&¼½*£x½?àh<e•¾\"Õ2¼E‚<qE,=p!®=±T(>G=\Z!½D5Æ<e@ =œV+½”Ë¼ÁTŠ½†Ô¼Â?\\¼éÐ#½E»=ê¤…½Uÿ¼)a	>R©½ãG¼¯ä<`A <\nÌ~½?ve½Zuµ=€½z#Ç½f›¶=—‰=7^·½¯®\n»ÿ©ê¼[‰¬:Õ€<\"vÖ½Ò½§½ÇWÅ<ôó¼V†Ê¼/;–X&=Ûþ’½€C†=®È‹=U†¶¼¦`¨½|º˜=n½ÆA½p‚½´º±<‚=N]—½7Î’<Ô®t=¬U½WLs=ŽH†¼Ž Þ;ö¸©=Ú0=Û\r\"¾\\±=ÇIÄ¼×±,½)2=÷8=fÎ;=BÁ=,jš=â4>¥2Ì¼ëÍ9I³¼pç<nh<bó=,‹™½Å¨Š½ÊÐ‡=ð—ñ=d½Í<öè§=\Z£gº·ôÇ=0U<þl½ü“¾Ìgë¼´Y™=ÙÍú:3Eœ<È<ú?€»žè\n¾QJ„<VÚ½Û|Ù<zdT½ÑŒ½®c<=^Zu»Ê€œ»H5½ðÛ½±Š5=Dõ¼æ$=²z½¿é±=6š;‘½*öó<Yç>Y ½Ô—Ã½ßQ¼îÌ=³Û…<õÈm=þ-Ž=‹¬§½gx•½à†Ð¼?½¡=T÷]<Lú¼ùù«=ýy<%›½È¾‰¼¿:º½KAå½ád¼gr0½W^É¼¡µ»×D{¼iÄ=z0³=ñ\'Q¼tAÁ=§Ã¼À\'3½j¤•½¶9I=Kz\'<ò°¼pê=ó:R¼…<Äè:½±þ#=u#=§$ü¼æÈï=|«·=~q½/p|½ÕŠ½lÂ½@;=ª?°¼»±Z<ëm·=äŽ\r½.¥¶½ëÇc½öÊy½ö*>ê¼½>^‚½b3®=—pâ¼dÅ‚=D®¢½,‹^=rñ=\"ÎÝ=:·ð=ÖË\Z>ÕxK;ÁÄµ¼ÚŒ¼×Ó\n>âoz=ˆ<¥ŠN=QaÙ<Æé\n½ëc=ÖOƒ½&y¨¼9Y>ÿ¿½Ÿ½','2024-02-23 10:02:22','2024-02-23 10:02:22',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

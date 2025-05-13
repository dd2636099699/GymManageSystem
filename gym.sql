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
(2,'张起灵','13243253432',0,221,'2019-08-02',2,1,'张家古楼',0,'0192023a7bbd73250516f069df18b500'),
(3,'蓝忘机','13324332344',0,20,'2019-08-02',2,2,'云深不知处',0,'0192023a7bbd73250516f069df18b500'),
(4,'ccc','13324245453',1,25,'2023-04-10',3,3,'仙乐国',0,'0192023a7bbd73250516f069df18b500'),
(11,'战士','13342244112',0,182,'2023-05-01',2,4,'长留1234111',1,'0192023a7bbd73250516f069df18b500'),
(12,'白凤九','13433324335',1,20,'2019-10-04',1,5,'青丘',2,'0192023a7bbd73250516f069df18b500'),
(14,'张含','15299985622',1,35,'2023-04-02',5,6,'北京丰台',1,'0192023a7bbd73250516f069df18b500'),
(16,'周命1','15785456231',1,22,'2023-05-06',2,7,'陕西西安',0,'0192023a7bbd73250516f069df18b500');

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
(1,'跑步机',1),
(6,'动感单车',2),
(7,'呼啦圈',100),
(8,'ttt',1),
(11,'测试2',4);

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
(2,'可口可乐','瓶',2,5,48,'1'),
(3,'百事可乐','瓶',2,5,3,''),
(4,'小布丁雪糕','根',0.5,1,13,''),
(5,'压缩饼干','块',2,5,24,''),
(7,'脉动','瓶',3,6,0,''),
(8,'毛巾','个',10,20,0,'');

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
(1,'车钥匙','1','厕所门口','2023-04-10 00:00:00',1,'张三','13355660000','22','25525','2023-04-12 00:00:00','admin'),
(6,'手机','1','前台','2023-05-01 00:00:00',1,'王能','15299952320','张宏','15899965478','2023-05-02 00:00:00','admin'),
(7,'钱包','1','动感单车旁','2023-05-01 00:00:00',0,'李镇','15966325478',NULL,NULL,NULL,'admin'),
(8,'包','1','门口','2023-05-02 00:00:00',0,'刘伟','15326587548',NULL,NULL,NULL,'admin'),
(9,'1','1','1','2024-03-02 00:00:00',0,'1','15266668585',NULL,NULL,NULL,'admin'),
(10,'1','1','1','2024-03-16 00:00:00',1,'1','13243253432','1','13243253432','2024-03-10 00:00:00','admin'),
(11,'12','1','2','2024-03-15 00:00:00',1,'2','15266528548','1','13243253432','2024-02-28 00:00:00','admin'),
(12,'测试','1','测试','2024-05-21 00:00:00',1,'换行','13536967225','取回测试','13536967226','2024-05-21 00:00:00','admin');

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
(25,'流汗','13456789087',1,22,2,'2023-04-07 00:00:00','04-07',2,355,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(26,'Tom1','15266668585',0,24,5,'2023-04-07 00:00:00','04-07',1,79,'2024-06-06 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(34,'王泽明','17858966255',1,19,5,'2023-04-07 00:00:00','04-07',2,820,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(35,'张红','18799256874',0,23,1,'2023-04-07 00:00:00','04-07',2,24,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(37,'王芳','15299950487',0,22,3,'2023-04-07 00:00:00','04-07',2,990,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(42,'jerry','15266528549',1,20,5,'2023-04-07 00:00:00','04-07',2,16,'2024-05-01 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(43,'方蓝','13456789876',0,22,5,'2023-04-07 00:00:00','04-07',2,0,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(44,'赵静','15288888888',0,25,3,'2023-04-07 00:00:00','04-07',2,0,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(45,'孙戏','18566584785',1,35,3,'2023-04-07 00:00:00','04-07',2,0,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(53,'王芳','15299950487',0,22,3,'2023-04-07 00:00:00','04-07',2,990,'2023-04-07 00:00:00',NULL,NULL,NULL,NULL,'0192023a7bbd73250516f069df18b500'),
(54,'李华雄','15266668585',1,1,2,'2024-02-29 00:00:00','02-29',2,0,'2024-02-29 00:00:00',101,'pduhiehp80','\0��D\0\0�A��>�~%=�<A�=8���>;=�d<���>]��ZƼ���(LY=\'�>�X==[��w�\'<��@=��=P��xdG:d\n=\\.�=8���I���V�=U~<�]�=υ�<^���˽�F��=3�=�}��ߚ�=?�(�����g�̼��ݽ V=���<�ڽ;߼�VF����<��1�3s�����߻�魽��Ƚ��X=׼�=A��<�J]�939�ל�u�ýUEe���.=�/�m�:r�>G:�<�%�j��;k�<�n�x����\"�\'�1=��j=�mC��!�=sp=�T�ʎ=B경y+3�վ���ڌ���Ѽ�\Z��ۻ:���\Z����]�=PRȼ��=����2=�=\":=��h��;�<��W=5�޻�)�<�%G=�M=�^��	�����=�_<H��<-d2�[�=>a8;��=����t�;�HռN���?�]=�!�<����P�}��7*;騁<�k>��e<�b;��|�%�;���a�=�?�<gz�>|�<E��<k(l<2))����=��<c{=�>�=��W<�=�g6�U�	>���Y�=�wX=��=g��;]��=�I<����L2=iD7=C�<�A�<͌D���нW�<�Z�/�)�L=�tv��������;ǝ��!�<18�=�Cm����� ����߼�c�=J/�=݂��Ͳ���)y=��P�H���� ��3�>��=L�=y�,=��;��_�m��9\0��/�ɽ��=ۿv����=����%\Z=ϥ=�ޑ��o��Ա=-Ni=a�׽递�Q(�;��=�r!�(�ʽ�,=�L�;#��� ����=!\'}�Mjμ���<�c�=��\"=O�&�N�3�f�<���N9�=�*�=�\nQ��t=��#�=\0[3��<������eT�j�,�f=��ru:=�ó=1��<�ҽ�:&�`o9=�㜽�%>k.���d-�;Ɍ=y�=^*>�5����N=*\\��h�>O�=����ڢ �[�==7�<�4=��^�H��a��=>��ס�','2024-02-29','c81e728d9d4c2f636f067f89cc14862c'),
(56,'张丽娟','15266668585',1,2,2,'2024-02-29 00:00:00','02-29',2,0,'2024-02-29 00:00:00',101,'zyphb2v2dg','\0��D\0\0�AY��=�*�=n���H�=u�<�}\r=���_n�=�_I�-<�\Z������7\0>\\�\\=��C���<ڀU=kP�=�r���K��0���%żN:3�0��<�mP=\\-�<��=F��=�W���=��-�z�,=\\Y�|�W=��Q�@�\"�l���S��z�e;�p�CW)�c6�#�μZm�ܷ1�\Z������*�_�Spּ�����=�~<�F;g�m�%�R���@�[�\0�]���,:�=s`��~�e=�\"=6#= ������<�J��0ؽ.����:`:�%=`\Z���;�>`ߧ���ۼ�l>:ka���=�/��S=��#��i���<3�	��y���=��z����.r$�ಕ��$�����=^���F�<�:!J=��=�b\n=�&<�弊��;�M�-0�=�G=(��J �<^Ɲ=P�;�������<��n<&�;\n\r���g=�W׻0�AH��a�=#�,=\Z��<��L��(���I���=e��=��;��ؗ<�.<��ܹWR�=ϥ���K<���;Q7q=\n�=��=�M�S#���)N=���;b�Y=�/b=��<��(=��k<DX;��~�<���:z��=Cn)=��<��=!�z�B�����=�cX�a��n&��\\�����ہ�� ��z\'#=�\'��P��w�ɽ࡙�2�=�@=��<q�X;�$�<\\>�=<׽H����ǽ��=�A�=s!Y=,�a=��r��E������R�1䑽�E<\nJ���o�=�Q=�K=z��<g���\"�?�<��Q=�>��߰x��$g�ހ3=�\n����ҽ���<\r�r<ݘQ���<�ۊ�$�U��;b��<;�G=:�<��8�6jr��}=P`��vU$=���=���=P����u�����\'��:!��^��Iw�=Y�ѽ*��\0�<uR�<�=�\Z��ۼEw=�s�eS�= 5-<�Z׼�3�<i2�=~��<��\0>�\0��7����Ct>\0�<���GY<L�p=��=&��<�P���#�r.>�2�����','2024-02-29','eccbc87e4b5ce2fe28308fd9f2a7baf3'),
(60,'刘宇航','15266668585',1,6,2,'2024-03-01 00:00:00','03-01',1,50,'2024-06-20 00:00:00',101,'897y6c3dpf','\0��D\0\0�A|�<\"ȝ=��=��=Um޼¼�=�G=�x>�l��	�X=܋��ء���>�J\n>��=�=;��\'9�r>��V=b�Y�[Y������ڼ\nD��\"�=����Ӏ=���=�ͼ՚G=�5�?k1<.x-�C�o=�������Y\'˽\"%��%�9=�b�p�ԼV�=�����R�L��$�;Oݻ�ɽ{o�e����\0�Nu#; ����.�<z���^/��k��友�����=����\\=�Ġ=r�%�g^���g=^״<µ�b��N��=J����m�K�=>�W��<p<\0��=�(�� ��������!8�I���0�9��=5��2tս��=�̼4Y�:��h�;���=�t�=J�9�$��:đ=e��<_V���==V��=$2<f<���=M��=<攼�m�Uv�<��+<\r��<��+��V-��E�<]o=��:�.�=�����x���SX�m��=axH=��	=*\"ݽ�둽����U�<�\n�=c���~����=�3�;s�#=I�Y��O<��<?X=�F�<2ά=*���V{��g�=E6�<\"E=r�;=���<g��=J]=���=��P�U�f��=\0Vq���f=�,�=fiｲe��\r��<�壼b!����-=��;���b>���}<�%�=q\'��\"�������ҽ���<\'�_=�\'�<rSV��O��%C=��$��򜽃@�=`��=�#�<J=|7p�+寽����͞���9�E���Q=���=������W�b�P���z�o=�^���ٹ�C���=|5=н�������,��BF=R��`�s��;���a�<�g�=\01\n=$��\r������᤬=��ʻ���=ѡ�=��.���^��p����Le=�\Z��\nY�yjX�����K�&�g=N�=NN=���wb���%�=���`U�=K���#$���<M��=�8K=�P�=E鹼&#���E���=��T=��jy�<bi=G�<�j\'=^�F��8���%8>�g;=C��','2024-03-01','1679091c5a880faf6fb5e6087eb1b2dc'),
(61,'卢固智','15266528549',1,19,5,'2024-03-09 00:00:00','04-01',1,270,'2024-06-10 00:00:00',101,'ym8a5u1u6c','\0��D\0\0�A�S��9��a\n��#�Lδ��5M����6�=�m�,{f=R�����ȼ�w�=���=�\n�<���;�Ŭ=RUu=�\0μ���<8<�TxU<���Y�����=��}<���;��=�裼&��<�\'�;��=��ܽ�C=�����U�i&\0�y����|=����l����)��M_<�M=fɽ���=�㙽__�ޤW��,�+~=ㆽ�5�<&���y<S�/;w�̽@�\Z;��=r:/���5=R�=�,�=�����M=�9�Ǣ���Q���M�<�.���1	���ϼ�=v䎽�q<�o=�Ї��\Z+�X��;�%�;&Z�����l\'}:�`�<����<M����3�oPi���l�q����=�F��Vϼ��?=AI�<ç��\0��=ƛ�<cy;������=k{p=ؖ2;�I��N=g-�?�\n���h�><7�$=II`���<�;C�+��׌�EL���J�=G��=`6k=½�9Ƚ�U�<�-�=�|+��n�<v�=�/�=�\n<ҰN�:Ձ���.4<VԵ<���=�A�=\\�<�U���=�?==��J=��=ƴ�����=B`�=�&=o����x��=��=؍8<w>�����a�=�x�lᑼ}T*��:���g�<|�ʼ%BN=[}�=��n�]ڲ���5�����e��:��=킵�]@����=.<�=����{��\"����=}I	>�\nT��2�=�����.�\'nμ��P:YU�;{\n=c������=��=��0=�e̻�I�<��Gr@=c��=w�����A=/r=<��:=%3��O���7�=�\\�=;AŽ�-\r�	�<�	��`ʯ;�$D=��k<Ğ=�{���z�\'\\=�|�|��<\"f>yZz<%�Y;o5j;���{��<����w&ٽ�ؑ=>*Խ�J���r��ˌ=ɯ�=9\0�%�`<�7�<�wս��=ڀҼ�A%�]ѝ<�Kc=�|�;X>I������:ق<��@>�,<թ�c(s=R��=����y=�s伮�1�\n\r>kw���(��','2024-03-09','0192023a7bbd73250516f069df18b500'),
(74,'q','13536967226',1,1,2,'2024-05-24 12:56:01','05-27',2,0,'2024-05-24 12:56:01',101,'dn25akfllo','\0��D\0\0�AV�ὓd�=c�&ũ����<O��W1�{�\"=Y�ۼ�)��jZ%>4L�=�{��_�뼛�Խւ��%�-���f<�p��2�<�J>:��K;-��<�Z��zeּ��a=�dk�mh�:�/�<%)�<ꇫ=�3���\"��4x��M�=p�����;?%�=;&���=V;=+\\�<}E2>)��=`�=�.=�=��<�7�6E��[[�;dJ�=����3q�gR�<��=��/��.=1ǎ=	b�q�<D4�\r�<�6@=���!=]OM�{�)�n���ߨu=e����5=݅�{�N=D��=i����\n>u�ꭐ�=���0��pq�<B_5=�1����[= 5>��:=z*���+�)�>���<jWټ��;O���C�=5>�>轂�g�\'Am�W�����<7j�=O����\\üi�9�{|=q��:�#�k�=<w\"=z�U<��e=��:{Y��b���^2<~��=�(<�A~<R0*=	�н���b=R~=7���u>���<�>gH�N`���(�����{<a�3���F;Ivc�˘�=CJ�y��Z� �An�z���W�<�Ց��f��Z\"�?>����>Ժ��F�%~<���=���<�Q]���<��I<��	�����.5=�o=��<�@����=��3:��j;�+T��6I�9�8��I�=m�\Z�\"�<��aUE<&r�=R<�|�K�� @=��=�NN�w�H=%��=�C{<׸��N5q<���μm{=y�7$f����:B�\r=��\Z�Q�V�GA���<�p=�<�=�2�<��>�&\r<�4�t���c�=5l�=�o;����1�)=���=d�2�`����\"��t�;�y�;����^<eS����2=�1K=�)o<.I�<�u=�=��S������J�=�ʂ=KS�<ZXн9��=��S����?E���<���<\'L[��}�P\Z�=��g=_�#=N\Z@=�Ժ6|��j�&=,�{������<�ţ���e�h(�!��=~�=\0 !=�R=~<','2024-05-24','0192023a7bbd73250516f069df18b500');

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
(1,'季卡',0,90,500),
(2,'月卡',0,30,150),
(3,'年卡',0,365,1000),
(5,'周卡',0,7,50);

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
(1,'张三','2023-03-01 08:00:00'),
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
(49,'卢固智','2024-05-20 14:21:41'),
(50,'卢固智','2024-05-21 09:03:49'),
(51,'卢固智','2024-05-24 12:56:08'),
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
(1,'健身球',30),
(2,'跑步机',35),
(4,'压力车',50),
(5,'仰卧起坐',20),
(6,'健身操',50),
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
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_id` int DEFAULT NULL COMMENT '分组id',
  `face_id` varchar(31) DEFAULT NULL COMMENT '人脸唯一Id',
  `name` varchar(63) DEFAULT NULL COMMENT '名字',
  `age` int DEFAULT NULL COMMENT '年纪',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱地址',
  `gender` smallint DEFAULT NULL COMMENT '性别，1=男，2=女',
  `phone_number` varchar(11) DEFAULT NULL COMMENT '电话号码',
  `face_feature` blob COMMENT '人脸特征',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `fpath` varchar(255) DEFAULT NULL COMMENT '照片路径',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `GROUP_ID` (`group_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

/*Data for the table `user_face_info` */

insert  into `user_face_info`(`id`,`group_id`,`face_id`,`name`,`age`,`email`,`gender`,`phone_number`,`face_feature`,`create_time`,`update_time`,`fpath`) values 
(9,101,'9wxxc9sfl3','1',NULL,NULL,NULL,NULL,'\0��D\0\0�A�(�={�3;<o����\"=�7@����=��̈�=��黲\0=}*���Ug�=\\>�r<s�=\'y=n�0=�}�i�A=��r=���;i�p�ڭA=��>Z�J=*��3��=K\'�<�ļ<��.��l�=kю�<;�=��὿[ܽ��=�����Y;*h3�9��*.C;J7�;1�<�����ϻ�Fk<�4���̻�lֽ��|���@=������=�����\ne<u��=�o�:氅�D�\0>M��=_���ۖ=4Wa<�U�� tr��t���Ai=ж�.,��7+�=�~��J��!�=����7��<d\\̼��<��d���ս����p_���Ľ3�=\0�l\"v�^�=�.�� ��<+���X����)��ћ<����5�\\���<;%=���=�Ľ\"C>@�%=U�ϽV\0=��z=�q���\"=̹���=V��=�ڕ�5���x޼��عc�2=6�/=�ɱ=ꊬ=fo�=K�N�œ@:�ڥ�*zl=]׉=	C�=�3=#��<���<p$ <)�6���<����<��=σ�=���<UO��箮=:�=P=�<2�=a���yy-=���=Q�);`-=�iλǺd=�R�<ߎ=�*>\'Q>�:���w[�=��<����:2�\rR�����<�6F��}W=���=|t��G���K�8*�����$�%>3�N�=.5�N�\r�Y23>\Z���2�ڽ_^���L=?/=�\"��g�<��n��ǽa��<���P5Y����<y���pv<�z�:�<��\0��\">�At���֘��b�=NC��}͍��@a=�R5=j\nǼ�s$��/�=�0=�`l=/:ӼB�-=G�ü��E=!^=�ǩ;�b�}�ս�;6)�=��z=̈h=�R=Ε����뽝b�<��ڽ�U=/���kw��>=L軽�Nu:9J�(u�\n�>^YZ�2�V<���=�[��,�=��>�\\�%<��V���=RE�=E�=Ͻ��d$�;��,=���<#���<U=���<�ٰ;B��<�?ɽj悔{5Q>H*=W��','2024-01-28 21:42:55','2024-01-28 21:42:55',NULL),
(10,101,'lg3l5buyng','11',NULL,NULL,NULL,NULL,'\0��D\0\0�A9������>����{�=�Ľ�`�=k��=�>Z{<�d��.<CĲ���=���<�-��\"\'=ŧ�=���<�+��)���FŦ=FwZ=����Z�޼�b=V�Y=@;���=��Ƣj=+}(�by#=-�,�=@�c�\Z�D��ͻ�H\r�*㍽�6����$A=�0=�Y<g���Kм2=��X=���=C�>6�=�9��=�<�b���q�<1�=���������Vý��4�Ooe=�:�=/�ټ�\ry���=ݗ����E<��>�e%�=Ǎ<=\"!�R��%F��v���\'_=��轭��<�sF��X@;�݇<`�����.�۞¼7���Ɛ=>Ѳ<�W\"��t�==�߼��:=����s�����=�<��<|���\r�<�Q5=����_>5�\\< ��E�=�<�8��\"}�a�켰ҫ=��B�I���󖽀l=\r>6�5{��L�W�]R�=s޼=�jz=oO��d��z��=�	>�B=\'�<= C?<�8�<Vh<a��S؁����Tս�I���=��=��>��娽��μ���=�|����=�˥<�ީ;�u�;	��S�M�<���<S��<�A�<�h==~ ͻ5�=�>����>j�9ҽR�Q�=��<��%=�x�=R����ݽ��*}��������<�=\n=mjJ=9aʼL6�<�Z�<�Ҽ{��io�U�!=۠�;��b<�\0>��1�!���{�<vbȽ�K¼CA=�Ǽ6�ʼv�=��S�����]���6�{ѽ=�\Z>���<Jg�=�;�����<���6Zν_��<�&�\n�<�Ͻ��.>�?２�=;\\%=�j=drH=]z���<��!=]K�^e�<�_�=jbP<�����x޼�-ֽCϽ�ɸ<0�?��\'=+���i��̈����f�=�zl�ԟ	��X�=)ڭ���1=z�<<��=/=$�=;�n@=rq�=B��\'f���|=�E;l�N=!S��]��<�{W<<��=�N��+oM�S����~=��9=�8��','2024-01-28 21:59:27','2024-01-28 21:59:27',NULL),
(11,101,'1zlxtyaein','111',NULL,NULL,NULL,NULL,'\0��D\0\0�A,�k=�v:=F\\l<ƿ�<�M=9�=�eS=\'ߔ=���9L m;3]	��0���>�)�=c9�<j<�=���<S�q=�V�=@}=b(o�JRּ~D$>e˨���0=���<�r�<n�&��lU=n;�<>��=oڽ�}@=+���� =�+	�0\'�<���<������8����!��<.W���*�;5��<�V�<!ܦ��ᘽ�#-=ư\n��+���*��lH=�?ټ�L콾����k�:Q\n<k��;{�*>_n�=��H����=]�L��uͽe�߽�Eo�<��g��������=��\r������=�=6��E��\Z�I<j�\0=Ti:�I�.�~��<t+M�U�����=�V���Ƀ����=��k.;\0X�<Oo����%��������\"�B��=��?=���=Dș��f�=`!=�!ڽ�f��\Z5�<��ؽ�ۭ�ly��M^ �O�=�c��7��	���&9C� 2=�=�>	g=B�=%p��W�~�ZOI��9�<���<��%=���=���<l�=\"�w=\\\'	�^���G��8��y�o=̆>�{޼�ü�=-�q=���<�Ν= �\\<\"��<R<>�U=\\�ȼ���<��K=�<��=A�>��;0�Ƚ�c�<���:�$\'���1����A�;o����P<���<.z��_����½�⬽�2��\"�=�a`�����Eż��A>Jp����k�s�N�l��=�jؼي��W=��7����!-<A�G�\n1�	�<Ih��zV�<���<�X<����s������j�<F��<.@��k=Kż/c=T~���w��j�=\\�<��Y��\\p��ʘ=Cfǻ��<`=�O�=!��5蕽yQ��U�=�Ƭ<�$b=����o���m:��H�<>ڽ�c/=�y|��Џ�1I�=�ѽ��齆�m=���P�=�N�;u�㼁D�=\"-\r�\"��=%�$��@=�y=�f	>t*:��>�\n���-1�b+C;,�=A�=O}��e�4=��=�i&��S�<)b�%���L�F>��N��+=','2024-01-29 22:56:12','2024-01-29 22:56:12',NULL),
(12,101,'44q9nixix8','55',NULL,NULL,NULL,NULL,'\0��D\0\0�AA;x��qO�C�=��r^=����D��=��;=:�M<�l�i�M�\nש=S/�=��=���#$���[=�O<�d==4A�=�F=g���\'�=+�<F_0=�\Zs�>r�=�[���<���d�9�8=8^⽜=�=����޽7N�=��������a�;g;��u8<a�:q�����j��J=�?���h�O��:�\r��-�<�۸������dǽzr3=Dv�;J\n۽;����=RY�~��<K_5>vۨ=���w(�=\"��<8oU��� ��\ZF�<_��SK��M����ѐ���>�;���J�;�(��E�<��:;�}�ą+=M?*��r��?\\=�c�\n��Z��<�j�����:�<�m��L�=����	�=��������<��=��<|@���x�=�d�=$E����<懪=A����\n��+4���<��=�#ɽf*�9K�Z��$��,�=�-���Z=\r�=�O=O/	��sͻ���?�`<z�X<m�=ނ�<S�=OԒ<���<�/S�3ތ��vm;S��;��=G��=���;�B1�3���q�=ftd=o>*��Xӹ=���=���=rEF<I�׻��=��<T�=��B>����;�н��<d�_<W���U�*�~���B�����	�b=�d�=�4�*7W�L�A�{K��Ox�1�\'>��;=�\'���<<.>��V�5c����=^L=D7�<_�����=m������}��� Xż_.�<�����*��,�=�_�<��D����W,���s]�j#&:��=���L�=��\Z=���<G\0w�!a�����=82�\r�����ý�#=�[~<cΔ���=Ջ2=$V�>�!��Ǽ?=�g�=v�w=�(�=pU�#1��C�:k��wm��Iw�+��Yi`=HY����j��/��`�=��üe\rL�P�p=~�{�&�=y������b=f�=nۄ=n�=8�ѽ;a�V�ƻne�=�YC=蝛<���=�I<���K�<������۽oB3>�r<L��','2024-01-29 22:57:51','2024-02-16 22:18:29',NULL),
(17,101,'ufra1drnn7','00',NULL,NULL,NULL,NULL,'\0��D\0\0�AL&>���=pq<��\Z<�*_=kH�=)�:=L��=�4ؽ�8��խ����$�<�!>\\I���E==%��������E��=q�������\r���=dc�=�F�N�=Z��=�ň=o7u=�wܺ,��,��<t����:�����;������各=�:Y��1�������<5`a��/�=м;��1�<��<	`R��T=�z:=�=�\'b�P�����J��Nu�\"ᒽ�Lּ�\r<��A��-�=�[�<\0��⪆=��4=�ֹ��\Z��7<9��=?!�L$=��=j)�4���o<��A����;D�G�&����};���νRП��\Z2��������=�e�;�M�1�1<�VW<o��=F�= �-;o%(�E�P</����=w}.=�S=С��;M��@��FT�u�\r���<�z��=�9�=�K=R�(���l�O��=	� ���;�]�=Y<C=\nһ�4���ܭ=j�\r>�I���k��eԽ�G޼�ᦼ�F�=���[��ݟ�ߟ�;>��\'�=��<چ�;j������=��=���!޶<U��=\'SмT5�=�kR=�}c����=Ξ=9\n9=�:=������<� ����=G��ؠ�i^�����=�y!��q��2��<L+c�q@�<�����@Y=Š�=��\Z��o��N׽�\0��D�&<�Fȼ��~�q,�=\"S�<D/�=�ZD��Z���j���N��<�\r���;k�*��@�ߩ��<��!��iIn=�*k�,c�<�~�<��`<�������E޽B.����d�ý	�j���E=t.>N��P<&�=�>�ͱ�{D:UX=u����U�����<�A=����K�F��ײ<YE�=���W�;?�> h��C��TkJ=�!��\nh=�j�=|���-��z&���72<@;�U�$�i=Z�&����T����t<�=9�<d�<[�3=���<\'*�=Z){<��{���=������=zH�=>罢2>��\r��_=a�]<�X���$(�B�=d��;����','2024-02-16 14:53:59','2024-02-16 14:53:59',NULL),
(18,101,'rlv7vaf9bs','77',NULL,NULL,NULL,NULL,'\0��D\0\0�Ay=4=���sޏ<�e2�h퍽�O=��<�2>� ���U;`\0��7����=���=ŌF��\Z�����=]zw=<_��W���EQ��~!�7�\0��(R�!��=�+�< ��<��=E� ��3=�E�=�sW=	�����q�/��Uz����ü�ᨽ��T��7�=@�~�~��<�	:~�0���<��&�;R�;@|��=���B=62b<y�]=�G���U��.���𽓊��O!=��U<~�y�=�|�<\n���\r��=�0�<����+��ݮ��!=!��;ʻ�;-�<N�m���L����=MJ�;�ظ<[Qi��\r��*��O����Iϻ�\n�H�����>0��<~����~�<�_����=Ϥ�<B�`�nv����J=��K=�O=�=�=�1��sv��B���=���<���>\\���<��<�a��Ud�	�=헐=1�i�U�n=�����}��AH�|��IL�=��=�0�=Q/q��w̽���<\n�;nк=V\n�;��=��=�p�H��1��+�ͼ����uY��G=⮈=�(=uܻ�#X=��=Zɏ=��~=#C^�J�=��=���<c~������?���@=ݐ����=w���~�\n�0��=����ֽ�\"=��ؽi��<����%��=�j�=B���{<�,d���+���=uE��R0ټ�ׅ�\Z�����=}Z�~���﮽S\0=ٞ=���;�{5��N��0Ƚ���<Cf���{Q�XQ�<�w��w=�4���=󔩽����^`�s\n>=�=;�ؼ��W� i<O��=z\'l�=�{\"�=.�=��bЕ<�w=�����</��=x�=F�;�8_^�N�>=g�3�ұ��Z?�=�<�l��U�U����Yj�=�_S��/̽��	�V�����ͽx\'\\��\\ɽK��=F�g6V<_N�=7X�^T�=i����`�´�=}c=�|=�B\0>-jk�s�/<:W��e&�<~��<�ʟ��!H=]��;���<q(=�{�p��\Z�=�3�W�ֽ','2024-02-22 12:56:11','2024-02-22 12:56:11',NULL),
(19,101,'y3sllbrr8v','888',NULL,NULL,NULL,NULL,'\0��D\0\0�A~�-���Z����C�=/�^�}R= �\"=��)>ͽ��x<��f�;< ��;O=�3>�^=9���#�p=(�=�g;\Z�?�������+	�M9*���=	&D=�[4<[��=�Z�2��;=�Ѽ.j}=I*ѽ�\r=i�\0�6��W�aS�5�=;3v۽!�[�탐<T;*�5��C=�tؼ6��2濽_F#�ҝO={�ν��f<�N��Q�%�ɜ�=�}n��Y;��д<\"<uE/=\n�=V�\r=q��m�=M\\=�E\0��0R�<��|�+<����,�-w)=�h#��&9�ѯ>ϒ<n����ʬ���l\rN�oqr��$T=�����zC��r=��#�9���)ؼ*�D�)G�<�=P\ZS��b]�&^��\'�<!,�<��9�M�<�;=`�s��\r>9��<�����|�~G�<[C��=g���ѫ�ު޻Evg=éE�m��=3\n�<�Z�;���퀽WvC=��U=�P�=��o�n�O<e��=�g�=�NC=嚧=���=��.=\\~c�ň��.u��w�B�#ܬ��<�T>e���Ѽʤ<َ�=�LY=��=J!�[<�=�Z&=�;�<T�I�5Ǟ���=�9=:%�T#>�~6�1ǽ�`�=�]���s�O�x;��转�<\"ͼP{T=?~y=�:�������eg�����뻫|Y<�i���k��C<�7�=�����:��\Zz��<�Xm=�j=9�l=�?Ѽ_�ݽ��#=�\r�g��;+��Q&�/83=���Z��*H\"�}V�����Wr�	nO=�z����<�-)=N�=��!=����#��<&M;5��$�]��V\'=2�ֹ�<����=�1�$zV<B���_�W�Y!Z=^��>ٕ����=� �;�\rW���\r�P$�ի&=���&׉���3g̽6J$��\'��|ew�0L�=Kʚ��ޖ����<��׽s�=��:dF��*��=��=:f�<h7>\"�5�N4��~-�&�a=�\Z=f&�|(�=dj�<�ky�6p�=<s/�q���L�=K�{��sɽ','2024-02-22 15:04:10','2024-02-22 15:04:10',NULL),
(20,101,'9v27d4ogxc','1',NULL,NULL,NULL,NULL,'\0��D\0\0�A��\r�\0��:��8����=���=)��<\"�=Gr�=�;�<Y�<1�����<y Z=��>Ѡ&<�<�����=qw�;�=f*=W�C=T�,�.}h��ʃ<���<W�=B	P=��H��IF�nے��=7\0��\0�I<�R���ֽ���<������;�qy����8_5j=�)N���=v19�y=�̽~�������a�I�/r=t(=$`)��&��*�x�?�h<e��\"�2�E�<qE,=p!�=�T(>G=\Z!�D5�<e@�=�V+��˼�T���Լ�?\\���#�E�=꤅�U���)a	>R���G���<`A�<\n�~�?ve�Zu�=���z#ǽf��=��=7^����\n����[��:�Հ<\"vֽ�����W�<���V�ʼ/;�X&=�����C�=�ȋ=U����`��|��=n��A�p�����<�=N]��7Β<Ԯt=�U�WLs=�H��� �;���=ڐ0=�\r\"�\\�=�Iļױ,�)2=�8=f�;=B�=,j�=�4>�2̼��9I��p�<nh<b�=,���Ũ���Ї=��=d��<��=\Z�g����=0U�<��l�����g뼴Y�=���:3E�<�<�?����\n�QJ�<V���|�<zdT�ь��c<=^Zu�ʀ��H5��۽��5=D����$=�z���=6�;��*��<Y�>Y ��ԗý�Q��̐=�ۅ<��m=�-�=����gx����м?��=T�]<L�����=�y<%���Ⱦ���:��KA彁�d�gr0�W^ɼ����D{�i��=z0�=�\'Q�tA�=�ü�\'3�j����9I=Kz\'<�p�=�:R��<��:���#=�u#=�$�����=|��=~q�/p|�Պ�l½@;=�?����Z<�m�=�\r�.�����c���y��*>��>^��b3�=�p�dł=D���,�^=r�=\"��=:��=��\Z>�xK;�ĵ�ڌ���\n>�oz=��<��N=Qa�<��\n��c=�O��&y��9Y>�����','2024-02-23 10:02:22','2024-02-23 10:02:22',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

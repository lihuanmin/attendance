/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : attendance

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-04-01 10:04:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuCode` varchar(20) NOT NULL,
  `menuName` varchar(20) NOT NULL,
  `url` varchar(40) NOT NULL,
  `parentId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', 'userCenter', '个人中心', '#', '0');
INSERT INTO `menu` VALUES ('2', 'leaveCenter', '请假管理', '/finance/userCenter/userCenter', '0');
INSERT INTO `menu` VALUES ('3', 'updateInfo', '信息管理', '/attendance/userCenter/userCenter', '1');
INSERT INTO `menu` VALUES ('4', 'passwd', '密码', '/attendance/userCenter/passwd', '1');
INSERT INTO `menu` VALUES ('5', 'member', '员工管理', '/', '0');
INSERT INTO `menu` VALUES ('6', 'addmember', '添加员工', '/', '5');
INSERT INTO `menu` VALUES ('7', 'memManager', '员工管理', '/', '5');
INSERT INTO `menu` VALUES ('8', 'memAttendacne', '员工出勤', '/', '5');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(20) NOT NULL,
  `roleDetail` varchar(50) NOT NULL DEFAULT ' ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '普通用户', '只能操作自己相关信息');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) NOT NULL,
  `menuId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES ('1', '1', '1');
INSERT INTO `role_menu` VALUES ('2', '1', '2');
INSERT INTO `role_menu` VALUES ('3', '1', '3');
INSERT INTO `role_menu` VALUES ('4', '1', '4');
INSERT INTO `role_menu` VALUES ('5', '1', '6');
INSERT INTO `role_menu` VALUES ('6', '1', '7');
INSERT INTO `role_menu` VALUES ('7', '1', '8');
INSERT INTO `role_menu` VALUES ('8', '1', '5');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'tom');
INSERT INTO `user` VALUES ('2', 'mike');

-- ----------------------------
-- Table structure for user_attendance
-- ----------------------------
DROP TABLE IF EXISTS `user_attendance`;
CREATE TABLE `user_attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `amOn` time DEFAULT NULL,
  `amOff` time DEFAULT NULL,
  `pmOn` time DEFAULT NULL COMMENT '1签到，0请假',
  `pmOff` time DEFAULT NULL,
  `aTime` date NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1考勤，0请假',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_attendance
-- ----------------------------
INSERT INTO `user_attendance` VALUES ('1', '1', '12:36:58', '12:37:15', '00:00:01', '09:14:38', '2018-04-01', '1');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `id` int(11) NOT NULL,
  `portrait` varchar(50) NOT NULL,
  `introduce` varchar(50) NOT NULL,
  `sex` tinyint(1) NOT NULL COMMENT '1男，0女',
  `register_time` date NOT NULL,
  `email` varchar(20) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `real_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('1', '/attendance/static/img/background_a.jpg', 'semia vinct', '1', '2018-03-29', '964517471@qq.com', '18482259291', '李寰民');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '1', '1');

-- ----------------------------
-- Table structure for user_verification
-- ----------------------------
DROP TABLE IF EXISTS `user_verification`;
CREATE TABLE `user_verification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `salt` varchar(7) NOT NULL,
  `isLock` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未被锁定，1被锁定',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_verification
-- ----------------------------
INSERT INTO `user_verification` VALUES ('1', 'root', '3acadeaeff6243fbaea4c3f824d57b9e', 'ZExHMf', '0');

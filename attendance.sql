/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : attendance

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2018-05-14 17:22:23
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for attendance
-- ----------------------------
DROP TABLE IF EXISTS `attendance`;
CREATE TABLE `attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `workTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `amStatus` int(11) DEFAULT '0' COMMENT '0旷工，1上午迟到，2上午签到',
  `pmStatus` int(255) DEFAULT '0' COMMENT '0旷工，1下午早退，2下午签到',
  `reference` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of attendance
-- ----------------------------
INSERT INTO `attendance` VALUES ('1', '1', null, '2018-04-27 19:20:43', '0', '2', '2018-04-27');
INSERT INTO `attendance` VALUES ('2', '41', null, '2018-04-27 19:19:38', '0', '2', '2018-04-27');
INSERT INTO `attendance` VALUES ('4', '44', null, '2018-04-27 19:20:20', '0', '2', '2018-04-27');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `deptId` int(11) NOT NULL AUTO_INCREMENT,
  `deptName` varchar(20) NOT NULL,
  `deptCode` varchar(20) NOT NULL,
  `head` varchar(20) NOT NULL,
  `slogan` varchar(30) NOT NULL,
  PRIMARY KEY (`deptId`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '总部', 'ZB', 'root', '总部');
INSERT INTO `department` VALUES ('10', '技术部', 'JSB', '康乐乐', '技术部，负责公司的技术支持');
INSERT INTO `department` VALUES ('11', '销售部', 'XSB', '陈飞', '负责公司产品销售');

-- ----------------------------
-- Table structure for dept_file
-- ----------------------------
DROP TABLE IF EXISTS `dept_file`;
CREATE TABLE `dept_file` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deptId` int(11) NOT NULL,
  `fileUrl` varchar(50) NOT NULL,
  `userId` int(11) NOT NULL,
  `fileTime` timestamp  NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dept_file
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', 'UC', '个人中心', '#', '0');
INSERT INTO `menu` VALUES ('3', 'UI', '信息管理', '/attendance/userCenter/userCenter', '1');
INSERT INTO `menu` VALUES ('4', 'PW', '修改密码', '/attendance/userCenter/passwd', '1');
INSERT INTO `menu` VALUES ('5', 'GSYG', '公司员工', '/', '0');
INSERT INTO `menu` VALUES ('6', 'AM', '新入职员工', '/attendance/member/addMember', '5');
INSERT INTO `menu` VALUES ('7', 'MMS', '员工管理', '/attendance/member/memberListPage', '5');
INSERT INTO `menu` VALUES ('9', 'GSBM', '公司部门', '#', '0');
INSERT INTO `menu` VALUES ('10', 'AD', '新增部门', '/attendance/department/dept', '9');
INSERT INTO `menu` VALUES ('11', 'DMS', '部门管理', '/attendance/department/deptManager', '9');
INSERT INTO `menu` VALUES ('12', 'RM', '角色管理', '#', '0');
INSERT INTO `menu` VALUES ('13', 'RMS', '角色管理', '/attendance/role/role', '12');
INSERT INTO `menu` VALUES ('14', 'AR', '添加角色', '/attendance/role/addRole', '12');
INSERT INTO `menu` VALUES ('17', 'BMGL', '部门管理', '#', '0');
INSERT INTO `menu` VALUES ('18', 'YGQJ', '员工请假', '/attendance/deptMember/memberLeave', '17');
INSERT INTO `menu` VALUES ('19', 'YGKQ', '员工考勤', '/attendance/deptMember/memAttenPage', '17');
INSERT INTO `menu` VALUES ('20', 'WYQJ', '我要请假', '/attendance/leave/myleave', '28');
INSERT INTO `menu` VALUES ('21', 'CKQJ', '查看请假', '/attendance/leave/leavePage', '28');
INSERT INTO `menu` VALUES ('22', 'WDKQ', '我的考勤', '#', '0');
INSERT INTO `menu` VALUES ('24', 'BMZL', '部门资料', '#', '0');
INSERT INTO `menu` VALUES ('25', 'ZLXZ', '资料下载', '/attendance/file/listFile', '24');
INSERT INTO `menu` VALUES ('26', 'ZLSC', '资料上传', '/attendance/file/uploadPage', '24');
INSERT INTO `menu` VALUES ('27', 'WDKQ', '我的考勤', '/attendance/atten/attenPage', '22');
INSERT INTO `menu` VALUES ('28', 'QJGL', '请假管理', '#', '0');
INSERT INTO `menu` VALUES ('29', 'BMCY', '部门成员', '/attendance/file/deptMemPage', '24');
INSERT INTO `menu` VALUES ('30', 'BMXX', '部门信息', '/attendance/file/deptInfo', '24');
INSERT INTO `menu` VALUES ('31', 'QJJL', '请假记录', '/attendance/deptMember/leaveHisPage', '17');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(20) NOT NULL,
  `roleDetail` varchar(50) NOT NULL DEFAULT ' ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', '公司员工', '只能操作自己相关信息');
INSERT INTO `role` VALUES ('2', '部门经理', '可以操作整个部门员工');
INSERT INTO `role` VALUES ('3', 'CEO', '可以操作整个公司');

-- ----------------------------
-- Table structure for role_menu
-- ----------------------------
DROP TABLE IF EXISTS `role_menu`;
CREATE TABLE `role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) NOT NULL,
  `menuId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=350 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role_menu
-- ----------------------------
INSERT INTO `role_menu` VALUES ('29', '8', '1');
INSERT INTO `role_menu` VALUES ('30', '8', '3');
INSERT INTO `role_menu` VALUES ('31', '8', '4');
INSERT INTO `role_menu` VALUES ('33', '8', '15');
INSERT INTO `role_menu` VALUES ('34', '8', '16');
INSERT INTO `role_menu` VALUES ('35', '9', '1');
INSERT INTO `role_menu` VALUES ('36', '9', '3');
INSERT INTO `role_menu` VALUES ('37', '9', '4');
INSERT INTO `role_menu` VALUES ('39', '9', '5');
INSERT INTO `role_menu` VALUES ('40', '9', '6');
INSERT INTO `role_menu` VALUES ('41', '9', '7');
INSERT INTO `role_menu` VALUES ('42', '9', '9');
INSERT INTO `role_menu` VALUES ('43', '9', '10');
INSERT INTO `role_menu` VALUES ('44', '9', '11');
INSERT INTO `role_menu` VALUES ('45', '9', '12');
INSERT INTO `role_menu` VALUES ('46', '9', '13');
INSERT INTO `role_menu` VALUES ('47', '9', '14');
INSERT INTO `role_menu` VALUES ('48', '9', '15');
INSERT INTO `role_menu` VALUES ('49', '9', '16');
INSERT INTO `role_menu` VALUES ('274', '3', '1');
INSERT INTO `role_menu` VALUES ('275', '3', '3');
INSERT INTO `role_menu` VALUES ('276', '3', '4');
INSERT INTO `role_menu` VALUES ('277', '3', '5');
INSERT INTO `role_menu` VALUES ('278', '3', '6');
INSERT INTO `role_menu` VALUES ('279', '3', '7');
INSERT INTO `role_menu` VALUES ('280', '3', '9');
INSERT INTO `role_menu` VALUES ('281', '3', '10');
INSERT INTO `role_menu` VALUES ('282', '3', '11');
INSERT INTO `role_menu` VALUES ('283', '3', '12');
INSERT INTO `role_menu` VALUES ('284', '3', '13');
INSERT INTO `role_menu` VALUES ('285', '3', '14');
INSERT INTO `role_menu` VALUES ('286', '3', '17');
INSERT INTO `role_menu` VALUES ('287', '3', '18');
INSERT INTO `role_menu` VALUES ('288', '3', '19');
INSERT INTO `role_menu` VALUES ('289', '3', '31');
INSERT INTO `role_menu` VALUES ('290', '3', '22');
INSERT INTO `role_menu` VALUES ('291', '3', '27');
INSERT INTO `role_menu` VALUES ('292', '3', '24');
INSERT INTO `role_menu` VALUES ('293', '3', '25');
INSERT INTO `role_menu` VALUES ('294', '3', '26');
INSERT INTO `role_menu` VALUES ('295', '3', '29');
INSERT INTO `role_menu` VALUES ('296', '3', '30');
INSERT INTO `role_menu` VALUES ('297', '3', '28');
INSERT INTO `role_menu` VALUES ('298', '3', '20');
INSERT INTO `role_menu` VALUES ('299', '3', '21');
INSERT INTO `role_menu` VALUES ('320', '1', '1');
INSERT INTO `role_menu` VALUES ('321', '1', '3');
INSERT INTO `role_menu` VALUES ('322', '1', '4');
INSERT INTO `role_menu` VALUES ('323', '1', '22');
INSERT INTO `role_menu` VALUES ('324', '1', '27');
INSERT INTO `role_menu` VALUES ('325', '1', '24');
INSERT INTO `role_menu` VALUES ('326', '1', '25');
INSERT INTO `role_menu` VALUES ('327', '1', '26');
INSERT INTO `role_menu` VALUES ('328', '1', '29');
INSERT INTO `role_menu` VALUES ('329', '1', '30');
INSERT INTO `role_menu` VALUES ('330', '1', '28');
INSERT INTO `role_menu` VALUES ('331', '1', '20');
INSERT INTO `role_menu` VALUES ('332', '1', '21');
INSERT INTO `role_menu` VALUES ('333', '2', '1');
INSERT INTO `role_menu` VALUES ('334', '2', '3');
INSERT INTO `role_menu` VALUES ('335', '2', '4');
INSERT INTO `role_menu` VALUES ('336', '2', '17');
INSERT INTO `role_menu` VALUES ('337', '2', '18');
INSERT INTO `role_menu` VALUES ('338', '2', '19');
INSERT INTO `role_menu` VALUES ('339', '2', '31');
INSERT INTO `role_menu` VALUES ('340', '2', '22');
INSERT INTO `role_menu` VALUES ('341', '2', '27');
INSERT INTO `role_menu` VALUES ('342', '2', '24');
INSERT INTO `role_menu` VALUES ('343', '2', '25');
INSERT INTO `role_menu` VALUES ('344', '2', '26');
INSERT INTO `role_menu` VALUES ('345', '2', '29');
INSERT INTO `role_menu` VALUES ('346', '2', '30');
INSERT INTO `role_menu` VALUES ('347', '2', '28');
INSERT INTO `role_menu` VALUES ('348', '2', '20');
INSERT INTO `role_menu` VALUES ('349', '2', '21');

-- ----------------------------
-- Table structure for user_dept
-- ----------------------------
DROP TABLE IF EXISTS `user_dept`;
CREATE TABLE `user_dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `deptId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_dept
-- ----------------------------
INSERT INTO `user_dept` VALUES ('1', '1', '1');
INSERT INTO `user_dept` VALUES ('44', '41', '10');
INSERT INTO `user_dept` VALUES ('46', '43', '11');
INSERT INTO `user_dept` VALUES ('47', '44', '11');
INSERT INTO `user_dept` VALUES ('48', '45', '11');
INSERT INTO `user_dept` VALUES ('49', '46', '10');
INSERT INTO `user_dept` VALUES ('50', '47', '10');
INSERT INTO `user_dept` VALUES ('51', '48', '10');
INSERT INTO `user_dept` VALUES ('52', '49', '10');

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
INSERT INTO `user_info` VALUES ('1', '/attendance/static/img/background_a.jpg', '什么是真实的', '1', '2018-04-26', 'lihuanminlhm@163.com', '18482259291', 'root');
INSERT INTO `user_info` VALUES ('41', '/attendance/static/img/background_a.jpg', '', '0', '2018-04-27', '', '', '康乐乐');
INSERT INTO `user_info` VALUES ('44', '/attendance/static/img/background_a.jpg', '陈飞', '1', '2018-04-27', 'chenfei@qq.com', '18521564871', '陈飞');
INSERT INTO `user_info` VALUES ('48', '/attendance/static/img/background_a.jpg', '', '1', '2018-05-12', '', '', '王瑞');

-- ----------------------------
-- Table structure for user_leave
-- ----------------------------
DROP TABLE IF EXISTS `user_leave`;
CREATE TABLE `user_leave` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `startTime` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  `reason` varchar(50) NOT NULL,
  `deptId` int(11) NOT NULL,
  `examResult` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未审核，1未通过，2通过',
  `examTime` datetime DEFAULT NULL,
  `leaveTime` datetime DEFAULT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0普通，1部门经理',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_leave
-- ----------------------------
INSERT INTO `user_leave` VALUES ('2', '44', '2018-05-10 08:00:00', '2018-05-10 18:00:00', '事假', '11', '2', null, '2018-05-09 20:57:17', '0');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '3', '1');
INSERT INTO `user_role` VALUES ('32', '1', '38');
INSERT INTO `user_role` VALUES ('33', '2', '39');
INSERT INTO `user_role` VALUES ('34', '2', '40');
INSERT INTO `user_role` VALUES ('35', '2', '41');
INSERT INTO `user_role` VALUES ('36', '2', '42');
INSERT INTO `user_role` VALUES ('37', '1', '43');
INSERT INTO `user_role` VALUES ('38', '2', '44');
INSERT INTO `user_role` VALUES ('39', '1', '45');
INSERT INTO `user_role` VALUES ('40', '1', '46');
INSERT INTO `user_role` VALUES ('41', '1', '47');
INSERT INTO `user_role` VALUES ('42', '1', '48');
INSERT INTO `user_role` VALUES ('43', '1', '49');

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
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_verification
-- ----------------------------
INSERT INTO `user_verification` VALUES ('1', 'ZB-ROOT-1', '06e9ca3a2b8f14acc4b28148cad83bf5', 'O1YhIT', '0');
INSERT INTO `user_verification` VALUES ('41', 'JSB-KLL-5', 'f470c9a8a8ba1b0317ad9f6889105827', '3Qoxdg', '0');
INSERT INTO `user_verification` VALUES ('44', 'XSB-CF-8', 'e35c3ea6ae574f83f496c27d22ef3db7', 'maUxO2', '0');
INSERT INTO `user_verification` VALUES ('48', 'JSB-WR-4', 'b629c0219a224f121db44458f25003ad', 'tYl3Z4', '0');

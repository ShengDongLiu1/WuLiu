/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : wuliu

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2016-12-13 10:55:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for roleright
-- ----------------------------
DROP TABLE IF EXISTS `roleright`;
CREATE TABLE `roleright` (
  `RRID` int(11) NOT NULL AUTO_INCREMENT,
  `ROLEID` int(11) DEFAULT NULL,
  `FUNID` int(11) DEFAULT NULL,
  PRIMARY KEY (`RRID`),
  KEY `FK_Relationship_10` (`ROLEID`),
  KEY `FK_Relationship_9` (`FUNID`),
  CONSTRAINT `FK_Relationship_10` FOREIGN KEY (`ROLEID`) REFERENCES `sysrole` (`ROLEID`),
  CONSTRAINT `FK_Relationship_9` FOREIGN KEY (`FUNID`) REFERENCES `sysfunction` (`FUNID`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roleright
-- ----------------------------

-- ----------------------------
-- Table structure for sysfunction
-- ----------------------------
DROP TABLE IF EXISTS `sysfunction`;
CREATE TABLE `sysfunction` (
  `FUNID` int(11) NOT NULL AUTO_INCREMENT,
  `FUNNAME` varchar(20) DEFAULT NULL,
  `FUNURL` varchar(200) DEFAULT NULL,
  `FUNPID` int(11) DEFAULT NULL,
  `FUNSTATE` int(11) DEFAULT NULL,
  PRIMARY KEY (`FUNID`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sysfunction
-- ----------------------------
INSERT INTO `sysfunction` VALUES ('1', '系统管理', null, '-1', '1');
INSERT INTO `sysfunction` VALUES ('2', '用户管理', 'user/listuser', '1', '1');
INSERT INTO `sysfunction` VALUES ('3', '功能管理', 'function/list', '1', '1');
INSERT INTO `sysfunction` VALUES ('4', '角色管理', 'role/list', '1', '1');

-- ----------------------------
-- Table structure for sysrole
-- ----------------------------
DROP TABLE IF EXISTS `sysrole`;
CREATE TABLE `sysrole` (
  `ROLEID` int(11) NOT NULL AUTO_INCREMENT,
  `ROLENAME` varchar(20) DEFAULT NULL,
  `ROLESTATE` int(11) DEFAULT NULL,
  `ROLEDESC` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ROLEID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sysrole
-- ----------------------------
INSERT INTO `sysrole` VALUES ('-1', '超级管理员', '1', '拥有最大的权限');
INSERT INTO `sysrole` VALUES ('1', '普通管理员', '1', '普通管理员');
INSERT INTO `sysrole` VALUES ('2', '系统管理员', '1', '管理地址基本信息');

-- ----------------------------
-- Table structure for sysuser
-- ----------------------------
DROP TABLE IF EXISTS `sysuser`;
CREATE TABLE `sysuser` (
  `USERID` int(11) NOT NULL AUTO_INCREMENT,
  `ROLEID` int(11) DEFAULT NULL,
  `USERNAME` varchar(20) DEFAULT NULL,
  `USERPWD` varchar(20) DEFAULT NULL,
  `USERTRUENAME` varchar(30) DEFAULT NULL,
  `USERSTATE` int(11) DEFAULT NULL,
  PRIMARY KEY (`USERID`),
  KEY `FK_Relationship_11` (`ROLEID`),
  CONSTRAINT `FK_Relationship_11` FOREIGN KEY (`ROLEID`) REFERENCES `sysrole` (`ROLEID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sysuser
-- ----------------------------
INSERT INTO `sysuser` VALUES ('1', '-1', 'admin', 'admin', '张三', '1');
INSERT INTO `sysuser` VALUES ('2', '1', 'user', 'user', '李四', '1');
INSERT INTO `sysuser` VALUES ('3', '2', 'wang', '123456', '王五', '1');

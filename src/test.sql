/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : wuliu

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2016-12-14 19:23:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `tname` varchar(255) DEFAULT NULL,
  `tsex` varchar(255) DEFAULT NULL,
  `tmes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=915 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES ('1', '孙乐', '男', '乐古');
INSERT INTO `test` VALUES ('2', '潘永辉', '男', '一只猫');
INSERT INTO `test` VALUES ('3', '邓腾发', '男', '狗蛋');
INSERT INTO `test` VALUES ('4', '黄豪', '男', '豪傻');
INSERT INTO `test` VALUES ('5', '刘建平', '男', '建吊');
INSERT INTO `test` VALUES ('6', '123', 'ss', 'ss');
INSERT INTO `test` VALUES ('7', 'hhhh', 'ss', 'ss');
INSERT INTO `test` VALUES ('8', 'hhhh', 'ss', 'ss');
INSERT INTO `test` VALUES ('9', 'hhhh', 'ss', 'ss');
INSERT INTO `test` VALUES ('10', 'hhhh', 'ss', 'ss');
INSERT INTO `test` VALUES ('11', 'hhhh', 'ss', 'ss');
INSERT INTO `test` VALUES ('12', 'hhhh', 'ss', 'ss');
INSERT INTO `test` VALUES ('13', 'hhhh', 'ss', 'ss');
INSERT INTO `test` VALUES ('16', 'hhhh', 'ss', 'ss');
INSERT INTO `test` VALUES ('17', 'hhhh', 'ss', 'ss');
INSERT INTO `test` VALUES ('18', 'hhhh', 'ss', 'ss');
INSERT INTO `test` VALUES ('19', 'hhhh', 'ss', 'ss');
INSERT INTO `test` VALUES ('20', 'hhhh', 'ss', 'ss');
INSERT INTO `test` VALUES ('22', 'hhhh', 'ss', 'ss');
INSERT INTO `test` VALUES ('911', '1', '11', '111');
INSERT INTO `test` VALUES ('912', '11', '11', '111');

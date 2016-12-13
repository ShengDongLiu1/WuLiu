/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50712
Source Host           : localhost:3306
Source Database       : wuliu

Target Server Type    : MYSQL
Target Server Version : 50712
File Encoding         : 65001

Date: 2016-12-13 14:53:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for costtype
-- ----------------------------
DROP TABLE IF EXISTS `costtype`;
CREATE TABLE `costtype` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT '类型编号',
  `cname` varchar(50) DEFAULT NULL COMMENT '类型名称',
  `cprice` decimal(10,0) DEFAULT NULL COMMENT '类型价格',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of costtype
-- ----------------------------

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cname` varchar(50) DEFAULT NULL COMMENT '客户联系人',
  `ccompany` varchar(100) DEFAULT NULL COMMENT '客户公司',
  `cphone` varchar(100) DEFAULT NULL COMMENT '客户电话',
  `cemail` varchar(100) DEFAULT NULL COMMENT '客户邮箱',
  `ccredit` varchar(100) DEFAULT NULL COMMENT '客户信用',
  `caddress` varchar(100) DEFAULT NULL COMMENT '客户地址',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer
-- ----------------------------

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `eid` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工id',
  `ejobnumber` varchar(50) DEFAULT NULL COMMENT '员工工号',
  `ename` varchar(50) DEFAULT NULL COMMENT '员工姓名',
  `esex` varchar(50) DEFAULT NULL COMMENT '员工性别',
  `eage` int(11) DEFAULT NULL COMMENT '员工年龄',
  `eposition` varchar(50) DEFAULT NULL COMMENT '员工职位',
  `ephone` varchar(50) DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `sgoodsname` varchar(100) DEFAULT NULL COMMENT '货物名称',
  `sgoodstype` varchar(100) DEFAULT NULL COMMENT '货物类型',
  `sgoodsweight` float DEFAULT NULL COMMENT '货物重量',
  `sgoodsacreage` float DEFAULT NULL COMMENT '货物面积',
  `sgoodsstate` varchar(100) DEFAULT NULL COMMENT '货物状态',
  `sgoodsregion` varchar(100) DEFAULT NULL COMMENT '货物存放区域',
  `sgoodstime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '货物存放时间',
  `eid` int(11) DEFAULT NULL COMMENT '员工id',
  PRIMARY KEY (`sid`),
  KEY `fk_eid` (`eid`),
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`eid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of goods
-- ----------------------------

-- ----------------------------
-- Table structure for inventory
-- ----------------------------
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
  `loid` int(11) NOT NULL AUTO_INCREMENT COMMENT '库位编号',
  `logid` int(11) DEFAULT NULL COMMENT '货物编号',
  `loname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '库位名称',
  `losize` double DEFAULT NULL COMMENT '库位尺寸',
  `lovolume` double DEFAULT NULL COMMENT '库位体积',
  `loweight` double DEFAULT NULL COMMENT '承受重量',
  `lolevel` int(11) DEFAULT NULL COMMENT '库位等级',
  `lostate` int(11) DEFAULT NULL COMMENT '库位状态',
  PRIMARY KEY (`loid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of inventory
-- ----------------------------

-- ----------------------------
-- Table structure for receipt
-- ----------------------------
DROP TABLE IF EXISTS `receipt`;
CREATE TABLE `receipt` (
  `rid` int(11) NOT NULL AUTO_INCREMENT COMMENT '收货编号',
  `rcid` int(11) DEFAULT NULL COMMENT '客户编号',
  `rgid` int(11) DEFAULT NULL COMMENT '货物编号',
  `rreceivecount` int(11) DEFAULT NULL COMMENT '接收数量',
  `rdamagedcount` int(11) DEFAULT NULL COMMENT '破损数量',
  `rshelvecount` int(11) DEFAULT NULL COMMENT '搁置数量',
  `rtdgoodstime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of receipt
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roleright
-- ----------------------------
INSERT INTO `roleright` VALUES ('25', '2', '5');
INSERT INTO `roleright` VALUES ('26', '2', '6');
INSERT INTO `roleright` VALUES ('44', '1', '1');
INSERT INTO `roleright` VALUES ('45', '1', '2');
INSERT INTO `roleright` VALUES ('46', '1', '3');
INSERT INTO `roleright` VALUES ('47', '1', '5');
INSERT INTO `roleright` VALUES ('48', '1', '6');
INSERT INTO `roleright` VALUES ('49', '1', '7');
INSERT INTO `roleright` VALUES ('50', '1', '9');

-- ----------------------------
-- Table structure for storage
-- ----------------------------
DROP TABLE IF EXISTS `storage`;
CREATE TABLE `storage` (
  `sid` int(11) NOT NULL AUTO_INCREMENT,
  `srid` int(11) DEFAULT NULL COMMENT '收货编号',
  `scid` int(11) DEFAULT NULL COMMENT '客户编号',
  `sgid` int(11) DEFAULT NULL COMMENT '货物编号',
  `ssbid` int(11) DEFAULT NULL COMMENT '库位编号',
  `storagecount` int(11) DEFAULT NULL,
  `storagemode` varchar(50) DEFAULT NULL COMMENT '入库方式',
  `storagebarcode` varchar(50) DEFAULT NULL COMMENT '入库条形码',
  `sbarcadeid` varchar(50) DEFAULT NULL COMMENT '条形码编号',
  `storagetime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '入库时间',
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of storage
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
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sysfunction
-- ----------------------------
INSERT INTO `sysfunction` VALUES ('1', '系统管理', null, '-1', '1');
INSERT INTO `sysfunction` VALUES ('2', '用户管理', 'user/listuser', '1', '1');
INSERT INTO `sysfunction` VALUES ('3', '功能管理', 'function/list', '1', '1');
INSERT INTO `sysfunction` VALUES ('4', '角色管理', 'role/list', '1', '1');
INSERT INTO `sysfunction` VALUES ('5', '基本信息管理', null, '-1', '1');
INSERT INTO `sysfunction` VALUES ('6', '地域管理', 'area/list', '5', '1');
INSERT INTO `sysfunction` VALUES ('7', '公司管理', 'company/list', '5', '1');
INSERT INTO `sysfunction` VALUES ('9', '雇员管理', 'emp/list', '5', '1');
INSERT INTO `sysfunction` VALUES ('15', '汽车货物管理', null, '-1', '1');
INSERT INTO `sysfunction` VALUES ('17', '车型信息', 'cartype/list', '15', '1');
INSERT INTO `sysfunction` VALUES ('18', '货物基本信息', 'goods/list', '15', '1');
INSERT INTO `sysfunction` VALUES ('19', '汽车详情表', 'car/list', '15', '1');
INSERT INTO `sysfunction` VALUES ('20', '留言管理', null, '-1', '1');
INSERT INTO `sysfunction` VALUES ('21', '客户留言', 'message/list', '20', '1');
INSERT INTO `sysfunction` VALUES ('22', '收货管理', null, '-1', '1');
INSERT INTO `sysfunction` VALUES ('23', '入库管理', null, '-1', '1');
INSERT INTO `sysfunction` VALUES ('24', '出库管理', null, '-1', '1');
INSERT INTO `sysfunction` VALUES ('25', '受理方式', 'shouhuo/shouli.jsp', '22', '1');
INSERT INTO `sysfunction` VALUES ('26', 'ggg', null, '-1', '1');
INSERT INTO `sysfunction` VALUES ('27', 'fff', 'ggg/ddd', '26', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

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

-- ----------------------------
-- Table structure for thelibrary
-- ----------------------------
DROP TABLE IF EXISTS `thelibrary`;
CREATE TABLE `thelibrary` (
  `tid` int(11) NOT NULL AUTO_INCREMENT,
  `tsid` int(11) DEFAULT NULL COMMENT '入库编号',
  `tloid` int(11) DEFAULT NULL COMMENT '库位编号',
  `ttid` int(11) DEFAULT NULL COMMENT '承运编号',
  `tcount` int(11) DEFAULT NULL COMMENT '出库数量',
  `ttype` varchar(50) DEFAULT NULL COMMENT '出库类型',
  `ttime` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '出库时间',
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thelibrary
-- ----------------------------

-- ----------------------------
-- Table structure for transport
-- ----------------------------
DROP TABLE IF EXISTS `transport`;
CREATE TABLE `transport` (
  `tid` int(11) NOT NULL AUTO_INCREMENT COMMENT '承运编号',
  `tdrivername` varchar(50) DEFAULT NULL COMMENT '司机姓名',
  `tdriverphone` varchar(50) DEFAULT NULL COMMENT '司机电话',
  `tvehicleid` int(11) DEFAULT NULL COMMENT '车牌号',
  `tvehicletype` varchar(50) DEFAULT NULL COMMENT '车类型',
  `tvehiclecapacity` int(11) DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of transport
-- ----------------------------

-- ----------------------------
-- Table structure for unitprice
-- ----------------------------
DROP TABLE IF EXISTS `unitprice`;
CREATE TABLE `unitprice` (
  `uid` int(11) NOT NULL AUTO_INCREMENT COMMENT '单位编号',
  `uname` varchar(50) DEFAULT NULL COMMENT '单位名称',
  `uprice` decimal(10,2) DEFAULT NULL COMMENT '价格',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of unitprice
-- ----------------------------

/*
MySQL Backup
Source Server Version: 5.7.14
Source Database: precious_love
Date: 2017/11/15 星期三 06:43:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `artile`
-- ----------------------------
DROP TABLE IF EXISTS `artile`;
CREATE TABLE `artile` (
  `artile_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `title_content` text NOT NULL COMMENT '文章内容',
  `title` varchar(32) NOT NULL COMMENT '文章标题',
  PRIMARY KEY (`artile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `chat_group`
-- ----------------------------
DROP TABLE IF EXISTS `chat_group`;
CREATE TABLE `chat_group` (
  `chat_group_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '讨论组id',
  `chat_group_name` varchar(16) NOT NULL COMMENT '讨论组名称',
  PRIMARY KEY (`chat_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `chat_group_menber`
-- ----------------------------
DROP TABLE IF EXISTS `chat_group_menber`;
CREATE TABLE `chat_group_menber` (
  `chat_group_con_member_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '讨论组成员id',
  `chat_group_member` int(8) unsigned NOT NULL COMMENT '讨论组成员的用户id',
  `chat_group_id` int(8) NOT NULL COMMENT '讨论组id',
  PRIMARY KEY (`chat_group_con_member_id`),
  KEY `chat_group_member` (`chat_group_member`),
  KEY `chat_group_id` (`chat_group_id`),
  CONSTRAINT `chat_group_menber_ibfk_1` FOREIGN KEY (`chat_group_member`) REFERENCES `user_main` (`user_id`),
  CONSTRAINT `chat_group_menber_ibfk_2` FOREIGN KEY (`chat_group_id`) REFERENCES `chat_group` (`chat_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `chat_record`
-- ----------------------------
DROP TABLE IF EXISTS `chat_record`;
CREATE TABLE `chat_record` (
  `chat_record_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '聊天记录id',
  `from_user` int(10) unsigned NOT NULL COMMENT '信息发送者',
  `to_user` int(10) unsigned NOT NULL COMMENT '信息接受者',
  `type` enum('1','0') NOT NULL DEFAULT '0' COMMENT '信息类型0表示未读1表示已读',
  `content` tinytext NOT NULL COMMENT '聊天信息',
  `date` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`chat_record_id`),
  KEY `from_user` (`from_user`),
  KEY `to_user` (`to_user`),
  CONSTRAINT `chat_record_ibfk_1` FOREIGN KEY (`from_user`) REFERENCES `user_main` (`user_id`),
  CONSTRAINT `chat_record_ibfk_2` FOREIGN KEY (`to_user`) REFERENCES `user_main` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `comment`
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `comment_id` int(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '评论id',
  `user_id` int(8) unsigned NOT NULL COMMENT '发表评论者的id',
  `comment_content` tinytext NOT NULL COMMENT '评论内容',
  `article_id` int(11) NOT NULL COMMENT '评论的文章的id',
  `comment_create_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`comment_id`),
  KEY `user_id` (`user_id`),
  KEY `article_id` (`article_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_main` (`user_id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `artile` (`artile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `con_hobbies_user`
-- ----------------------------
DROP TABLE IF EXISTS `con_hobbies_user`;
CREATE TABLE `con_hobbies_user` (
  `con_hobbies_user_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '爱好与用户关联表的id',
  `hobbies_id` int(4) NOT NULL COMMENT '爱好的id',
  `user_id` int(8) unsigned NOT NULL COMMENT '用户的id',
  PRIMARY KEY (`con_hobbies_user_id`),
  KEY `hobbies_id` (`hobbies_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `con_hobbies_user_ibfk_1` FOREIGN KEY (`hobbies_id`) REFERENCES `hobbies` (`hobbies_id`),
  CONSTRAINT `con_hobbies_user_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_main` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `emp_main`
-- ----------------------------
DROP TABLE IF EXISTS `emp_main`;
CREATE TABLE `emp_main` (
  `emp_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '雇员主表id',
  `emp_name` varchar(16) NOT NULL COMMENT '雇员名称',
  `emp_head_img_id` int(8) NOT NULL COMMENT '雇员头像id',
  `emp_password` varchar(32) DEFAULT NULL COMMENT '雇员密码md5',
  PRIMARY KEY (`emp_id`),
  KEY `emp_head_img_id` (`emp_head_img_id`),
  CONSTRAINT `emp_main_ibfk_1` FOREIGN KEY (`emp_head_img_id`) REFERENCES `picture` (`picture_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `fans`
-- ----------------------------
DROP TABLE IF EXISTS `fans`;
CREATE TABLE `fans` (
  `fans_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '粉丝id',
  `fans_master` int(8) unsigned NOT NULL COMMENT '被粉的用户',
  `fans_user` int(8) unsigned NOT NULL COMMENT '粉丝用户',
  PRIMARY KEY (`fans_id`),
  KEY `fans_master` (`fans_master`),
  KEY `fans_user` (`fans_user`),
  CONSTRAINT `fans_ibfk_1` FOREIGN KEY (`fans_master`) REFERENCES `user_main` (`user_id`),
  CONSTRAINT `fans_ibfk_2` FOREIGN KEY (`fans_user`) REFERENCES `user_main` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `follow`
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow` (
  `follow_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '关注id',
  `follow_master` int(8) unsigned NOT NULL COMMENT '被关注的人',
  `follow_user` int(8) unsigned NOT NULL COMMENT '关注者',
  PRIMARY KEY (`follow_id`),
  KEY `fans_master` (`follow_master`),
  KEY `fans_user` (`follow_user`),
  CONSTRAINT `follow_ibfk_1` FOREIGN KEY (`follow_master`) REFERENCES `user_main` (`user_id`),
  CONSTRAINT `follow_ibfk_2` FOREIGN KEY (`follow_user`) REFERENCES `user_main` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `friends`
-- ----------------------------
DROP TABLE IF EXISTS `friends`;
CREATE TABLE `friends` (
  `friends_id` int(8) NOT NULL COMMENT '朋友id标识',
  `group_id` int(8) NOT NULL COMMENT '分组id',
  `user_id` int(8) unsigned NOT NULL COMMENT '朋友的用户id',
  PRIMARY KEY (`friends_id`),
  KEY `group_id` (`group_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `friends_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `group` (`group_id`),
  CONSTRAINT `friends_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user_main` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `group`
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `group_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '好友分组id',
  `group_owner` int(8) unsigned NOT NULL COMMENT '该分组拥有者',
  `group_name` varchar(16) NOT NULL DEFAULT '“我的好友”' COMMENT '分组的名字',
  `group_createdate` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '分组创建时间',
  PRIMARY KEY (`group_id`),
  KEY `group_owner` (`group_owner`),
  CONSTRAINT `group_ibfk_1` FOREIGN KEY (`group_owner`) REFERENCES `user_main` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `hobbies`
-- ----------------------------
DROP TABLE IF EXISTS `hobbies`;
CREATE TABLE `hobbies` (
  `hobbies_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '爱好id',
  `type` varchar(8) NOT NULL COMMENT '爱好类型',
  `name` varchar(16) NOT NULL COMMENT '名称',
  PRIMARY KEY (`hobbies_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `love_story`
-- ----------------------------
DROP TABLE IF EXISTS `love_story`;
CREATE TABLE `love_story` (
  `love_story_id` int(8) NOT NULL COMMENT '成功故事的id',
  `author` int(8) unsigned NOT NULL COMMENT '作者',
  `article_id` int(8) NOT NULL COMMENT '文章id号',
  `create_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`love_story_id`),
  KEY `author` (`author`),
  KEY `article_id` (`article_id`),
  CONSTRAINT `love_story_ibfk_1` FOREIGN KEY (`author`) REFERENCES `user_main` (`user_id`),
  CONSTRAINT `love_story_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `artile` (`artile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `menu`
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `menu_id` tinyint(3) NOT NULL COMMENT '菜单表id',
  `right_id` tinyint(4) NOT NULL COMMENT '权利id',
  `menu_name` varchar(16) NOT NULL COMMENT '菜单名称',
  `menu_src` varchar(32) DEFAULT NULL COMMENT '菜单路径',
  `f_id` tinyint(3) NOT NULL DEFAULT '0' COMMENT '父菜单0为基本菜单无父菜单',
  PRIMARY KEY (`menu_id`),
  KEY `right_id` (`right_id`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`right_id`) REFERENCES `rights` (`right_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `message`
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `message_id` int(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '信息id',
  `message_from` int(8) unsigned NOT NULL COMMENT '接收者',
  `message_to` int(8) unsigned NOT NULL COMMENT '发送者',
  `statue` enum('0','1') NOT NULL DEFAULT '0' COMMENT '状态0未读1已读',
  `message_content` tinytext NOT NULL COMMENT '内容',
  `created_time` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`message_id`),
  KEY `message_from` (`message_from`),
  KEY `message_to` (`message_to`),
  CONSTRAINT `message_ibfk_1` FOREIGN KEY (`message_from`) REFERENCES `user_main` (`user_id`),
  CONSTRAINT `message_ibfk_2` FOREIGN KEY (`message_to`) REFERENCES `user_main` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `photograph`
-- ----------------------------
DROP TABLE IF EXISTS `photograph`;
CREATE TABLE `photograph` (
  `photograph_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '照片id',
  `user_id` int(8) unsigned NOT NULL COMMENT '用户id',
  `src` varchar(64) NOT NULL COMMENT '图片路径',
  PRIMARY KEY (`photograph_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `photograph_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_main` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `picture`
-- ----------------------------
DROP TABLE IF EXISTS `picture`;
CREATE TABLE `picture` (
  `picture_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '图片id',
  `src` varchar(64) NOT NULL COMMENT '图片路径',
  PRIMARY KEY (`picture_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `province`
-- ----------------------------
DROP TABLE IF EXISTS `province`;
CREATE TABLE `province` (
  `province_id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '省份名称',
  `name` varchar(12) NOT NULL,
  PRIMARY KEY (`province_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rights`
-- ----------------------------
DROP TABLE IF EXISTS `rights`;
CREATE TABLE `rights` (
  `right_id` tinyint(3) NOT NULL AUTO_INCREMENT COMMENT '权限id',
  `right_name` varchar(16) NOT NULL COMMENT '权限名称',
  PRIMARY KEY (`right_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `rights_con_role`
-- ----------------------------
DROP TABLE IF EXISTS `rights_con_role`;
CREATE TABLE `rights_con_role` (
  `right_con_role_id` int(6) NOT NULL COMMENT '权限角色关联id',
  `role_id` tinyint(3) NOT NULL COMMENT '角色id',
  `right_id` tinyint(3) NOT NULL COMMENT '权限id',
  PRIMARY KEY (`right_con_role_id`),
  KEY `role_id` (`role_id`),
  KEY `right_id` (`right_id`),
  CONSTRAINT `rights_con_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `rights_con_role_ibfk_2` FOREIGN KEY (`right_id`) REFERENCES `rights` (`right_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `role`
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `role_id` tinyint(3) NOT NULL COMMENT '角色id',
  `role_name` varchar(16) NOT NULL COMMENT '角色名称',
  `role_description` varchar(128) NOT NULL COMMENT '角色描述',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `role_con_emp`
-- ----------------------------
DROP TABLE IF EXISTS `role_con_emp`;
CREATE TABLE `role_con_emp` (
  `role_con_emp_id` int(8) NOT NULL AUTO_INCREMENT COMMENT '角色雇员关联id',
  `role_id` tinyint(3) NOT NULL COMMENT '角色id',
  `emp_id` int(8) NOT NULL COMMENT '雇员id',
  PRIMARY KEY (`role_con_emp_id`),
  KEY `role_id` (`role_id`),
  KEY `emp_id` (`emp_id`),
  CONSTRAINT `role_con_emp_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `role_con_emp_ibfk_2` FOREIGN KEY (`emp_id`) REFERENCES `emp_main` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `town`
-- ----------------------------
DROP TABLE IF EXISTS `town`;
CREATE TABLE `town` (
  `town_id` int(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '市区id',
  `province_id` tinyint(3) unsigned NOT NULL COMMENT '省份id',
  `name` varchar(16) NOT NULL COMMENT '市区名称',
  PRIMARY KEY (`town_id`),
  KEY `town_id` (`town_id`),
  KEY `province_id` (`province_id`),
  CONSTRAINT `town_ibfk_1` FOREIGN KEY (`province_id`) REFERENCES `province` (`province_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `user_main`
-- ----------------------------
DROP TABLE IF EXISTS `user_main`;
CREATE TABLE `user_main` (
  `user_id` int(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id（主表）',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `telephone` varchar(11) NOT NULL COMMENT '电弧号码',
  `sex` enum('male','female') NOT NULL DEFAULT 'male' COMMENT '性别',
  `height` int(3) NOT NULL COMMENT '身高',
  `education` varchar(16) NOT NULL DEFAULT '' COMMENT '受教育程度',
  `profile_picture` int(8) DEFAULT NULL COMMENT '头像',
  `birthday` datetime NOT NULL COMMENT '生日',
  `marital_status` enum('spinsterhood','widowed','married','divorced') NOT NULL DEFAULT 'spinsterhood' COMMENT '结婚状态',
  `location_id` int(5) unsigned NOT NULL COMMENT '住址，关联到市区表的市区id',
  PRIMARY KEY (`user_id`),
  KEY `location_id` (`location_id`),
  KEY `profile_picture` (`profile_picture`),
  CONSTRAINT `user_main_ibfk_1` FOREIGN KEY (`location_id`) REFERENCES `town` (`town_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `user_slave`
-- ----------------------------
DROP TABLE IF EXISTS `user_slave`;
CREATE TABLE `user_slave` (
  `user_slave_id` int(12) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户从表id',
  `user_id` int(8) unsigned NOT NULL COMMENT '用户id',
  `key` varchar(16) NOT NULL COMMENT '用户属性',
  `value` varchar(16) NOT NULL COMMENT '用户属性值',
  PRIMARY KEY (`user_slave_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_slave_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_main` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records 
-- ----------------------------
INSERT INTO `menu` VALUES ('1','1','系统管理','#','0'), ('2','2','图片管理','#','0'), ('3','3','礼物管理','#','0'), ('4','5','礼物管理','#','0'), ('5','6','广告管理','#','0'), ('6','8','审核管理','#','0'), ('7','9','报表统计','#','0'), ('8','10','用户管理','#','0'), ('9','11','订单管理','#','0'), ('10','7','首页推送','#','0'), ('11','4','客服聊天','#','0'), ('101','101','角色管理','houTai/index/role','1'), ('102','102','员工管理','houTai/index/employe','1');
INSERT INTO `rights` VALUES ('1','系统管理'), ('2','图片管理 '), ('3','礼物管理'), ('4','客服聊天'), ('5','礼物管理'), ('6','广告管理'), ('7','首页推送'), ('8','审核管理'), ('9','报表统计'), ('10','用户管理'), ('11','订单管理'), ('101','角色管理'), ('102','员工管理');

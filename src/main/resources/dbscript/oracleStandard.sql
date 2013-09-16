----prompt "webdemo模块:创建表逻辑  start..."  
--****************************************************************************
-- 表：BASIC_DISTRICT
--****************************************************************************
drop table BASIC_DISTRICT;
create table BASIC_DISTRICT(
	id varchar2(64 char) not null,
	parentId varchar2(64 char),
	postalCode varchar2(64 char),
	remark varchar2(2000 char),
	name varchar2(64 char) not null,
	code varchar2(64 char) not null,
	fullName varchar2(64 char),
	idCardCode varchar2(64 char),
	type varchar2(64 char),
	primary key(ID)
);
create index idx_bas_district_00 on BASIC_DISTRICT(code);
create index idx_bas_district_01 on BASIC_DISTRICT(parentId);
create index idx_bas_district_02 on BASIC_DISTRICT(idCardCode);
create index idx_bas_district_03 on BASIC_DISTRICT(postalCode);

comment on table BASIC_DISTRICT is '区域信息表';
comment on column BASIC_DISTRICT.idCardCode is '区域对应身份证编码';
comment on column BASIC_DISTRICT.postalCode is '区域对应邮政编码';
----prompt "webdemo模块:创建表逻辑  end..."
----prompt "webdemo模块:创建表逻辑  start..."  
--****************************************************************************
-- 表：OPER_EMPLOYEEINFO
--****************************************************************************
DROP TABLE OPER_EMPLOYEEINFO;
CREATE TABLE OPER_EMPLOYEEINFO(
	leavingDate date,
	sex number(10,0),
	operatorid varchar2(64),
	code varchar2(64),
	officialDate date,
	entryDate date,
	trialPeriodEndDate date,
	leaving number(1,0),
	name varchar2(64),
	age number(10,0),
	official number(1,0) default 0 not null,
	lastUpdatePhoneLinkInfoDate date,
	cardNum varchar2(255),
	primary key(OPERATORID)
);
create unique index idx_oper_emp_00 on OPER_EMPLOYEEINFO(code);
--****************************************************************************
-- 表：OPER_EMPLOYEEINFO
--****************************************************************************
DROP TABLE OPER_EMPLOYEEINFO_HIS;
CREATE TABLE OPER_EMPLOYEEINFO(
	leavingDate date,
	sex number(10,0),
	operatorid varchar2(64),
	code varchar2(64),
	officialDate date,
	entryDate date,
	trialPeriodEndDate date,
	leaving number(1,0),
	name varchar2(64),
	age number(10,0),
	official number(1,0) default 0 not null,
	lastUpdatePhoneLinkInfoDate date,
	cardNum varchar2(255),
	primary key(OPERATORID)
);
--****************************************************************************
-- 表：OPER_OPERATOR
--****************************************************************************
DROP TABLE OPER_OPERATOR;
CREATE TABLE OPER_OPERATOR(
	valid number(1,0) DEFAULT 1 NOT NULL,
	pwdErrCount number(10,0),
	historyPwd varchar2(255),
	organizationId varchar2(64),
	password varchar2(255),
	invalidDate date,
	lastUpdateDate date default sysdate not null,
	id varchar2(64),
	pwdUpdateDate date default sysdate not null,
	mainPostId varchar2(64),
	userName varchar2(64),
	locked number(1,0) default 0 not null,
	createDate date default sysdate not null,
	examinePwd varchar2(255),
	loginName varchar2(64)  not null,
	primary key(ID)
);
create unique index idx_oper_oper_00 on OPER_OPERATOR(loginName);
create index idx_oper_oper_01 on OPER_OPERATOR(loginName,password);

comment on table OPER_OPERATOR is '系统使用人员信息表';
comment on column OPER_OPERATOR.valid is '是否有效 0 无效  1有效  默认有效';
--****************************************************************************
-- 表：OPER_OPERATOR
--****************************************************************************
DROP TABLE OPER_OPERATOR_HIS;
CREATE TABLE OPER_OPERATOR_HIS(
	valid number(1,0) DEFAULT 1 NOT NULL,
	pwdErrCount number(10,0),
	historyPwd varchar2(255),
	organizationId varchar2(64),
	password varchar2(255),
	invalidDate date,
	lastUpdateDate date default sysdate not null,
	id varchar2(64),
	pwdUpdateDate date default sysdate not null,
	mainPostId varchar2(64),
	userName varchar2(64),
	locked number(1,0) default 0 not null,
	createDate date default sysdate not null,
	examinePwd varchar2(255),
	loginName varchar2(64)  not null,
	primary key(ID)
);
--****************************************************************************
-- 人员引用表：负责处理人员关联角色，关联分组，等关联关系：OPER_OPERATOR
--****************************************************************************
DROP TABLE OPER_OPERATOR_REF;
CREATE TABLE OPER_OPERATOR_REF(
	OPERATORID VARCHAR2(64) NOT NULL,
	REFID VARCHAR2(64) NOT NULL,
	REFTYPE VARCHAR2(64) NOT NULL,
	CREATEDATE DATE DEFAULT SYSDATE NOT NULL,
	PRIMARY KEY(OPERATORID,REFID,REFTYPE)
);
CREATE INDEX IDX_OPER_OPERREF_00 ON OPER_OPERATOR_REF(OPERATORID,REFTYPE);
CREATE INDEX IDX_OPER_OPERREF_01 ON OPER_OPERATOR_REF(REFID,REFTYPE);
--****************************************************************************
-- 人员引用表：负责处理人员关联角色，关联分组，等关联关系：OPER_OPERATOR
--****************************************************************************
DROP TABLE OPER_OPERATOR_REF_HIS;
CREATE TABLE OPER_OPERATOR_REF_HIS(
	OPERATORID VARCHAR2(64) NOT NULL,
	REFID VARCHAR2(64) NOT NULL,
	REFTYPE VARCHAR2(64) NOT NULL,
	CREATEDATE DATE DEFAULT SYSDATE NOT NULL,
	ENDDATE DATE DEFAULT SYSDATE NOT NULL
);
--****************************************************************************
-- 表：OPER_ORGANIZATION
--****************************************************************************
DROP TABLE OPER_ORGANIZATION;
CREATE TABLE OPER_ORGANIZATION(
  valid number(1,0) default 1 not null,
  fullAddress varchar2(255),
  remark varchar2(2000),
  alias varchar2(255),
  code varchar2(64) not null,
  type varchar2(64),
  id varchar2(64) not null,
  parentId varchar2(64),
  districtId varchar2(64),
  chiefType varchar2(64),
  address varchar2(255),
  name varchar2(64) not null,
  fullName varchar2(64) not null,
  chiefId varchar2(64),
  primary key(ID)
);
create unique index idx_oper_organ_01 on OPER_ORGANIZATION(code);
create index idx_oper_organ_02 on OPER_ORGANIZATION(parentId);
create index idx_oper_organ_03 on OPER_ORGANIZATION(chiefType,chiefId);

comment on table OPER_ORGANIZATION is '组织信息表';
comment on column OPER_ORGANIZATION.VALID is '是否有效 1 有效 0 无效';
comment on column OPER_ORGANIZATION.type is '组织类型';
comment on column OPER_ORGANIZATION.chiefType is '组织主管类型：可以是人员，可以是职位，也可以是其他...';
--****************************************************************************
-- 组织信息表历史表：OPER_ORGANIZATION_HIS
--****************************************************************************
DROP TABLE OPER_ORGANIZATION_HIS;
CREATE TABLE OPER_ORGANIZATION_HIS(
  valid number(1,0) default 1 not null,
  fullAddress varchar2(255),
  remark varchar2(2000),
  alias varchar2(255),
  code varchar2(64) not null,
  type varchar2(64),
  id varchar2(64) not null,
  parentId varchar2(64),
  districtId varchar2(64),
  chiefType varchar2(64),
  address varchar2(255),
  name varchar2(64) not null,
  fullName varchar2(64) not null,
  chiefId varchar2(64),
  primary key(ID)
);
--****************************************************************************
-- 职位信息表：OPER_POST
--****************************************************************************
DROP TABLE OPER_POST;
CREATE TABLE OPER_POST(
	id varchar2(64) not null,
	parentId varchar2(64),
	remark varchar2(2000),
	name varchar2(64),
	organizationId varchar2(64),
	code varchar2(64),
	fullName varchar2(255),
	primary key(ID)
);
create index idx_oper_post_00 on OPER_POST(parentId);
create index idx_oper_post_01 on OPER_POST(code);
create index idx_oper_post_02 on OPER_POST(organizationId);

comment on table OPER_POST is '职位信息表';
comment on column OPER_POST.code is '职位编码';
--****************************************************************************
-- 职位信息表历史表：OPER_POST
--****************************************************************************
drop table OPER_POST_HIS;
create table OPER_POST_HIS(
	id varchar2(64) not null,
	parentId varchar2(64),
	remark varchar2(2000),
	name varchar2(64),
	organizationId varchar2(64),
	code varchar2(64),
	fullName varchar2(255),
	primary key(ID)
);
----prompt "webdemo模块:创建表逻辑  end..."
----prompt "webdemo模块:创建sequence  start..."  
----prompt "webdemo模块:创建sequence end..."  
----prompt "webdemo模块:创建sequence  start..."  
----prompt "webdemo模块:创建sequence end..."  
----prompt "webdemo模块:创建包   start..."  
----prompt "webdemo模块:创建包  end..."
----prompt "webdemo模块:创建包   start..."  
----prompt "webdemo模块:创建包  end..."
----prompt "webdemo模块:创建函数逻辑  start..."  
----prompt "webdemo模块:创建函数逻辑  end..." 
----prompt "webdemo模块:创建函数逻辑  start..."  
----prompt "webdemo模块:创建函数逻辑  end..." 
----prompt "webdemo模块:创建存储过程逻辑  start..." 
----prompt "webdemo模块:创建存储过程逻辑  end..."
----prompt "webdemo模块:创建存储过程逻辑  start..." 
----prompt "webdemo模块:创建存储过程逻辑  end..."
----prompt "webdemo模块:创建触发器   start..."  
----prompt "webdemo模块:创建触发器  end..." 
----prompt "webdemo模块:创建触发器   start..."  
----prompt "webdemo模块:创建触发器  end..." 
----prompt "webdemo模块:创建视图逻辑  start..."  
----prompt "webdemo模块:创建视图逻辑  start..."  
----prompt "webdemo模块:初始化基础数据  start..." 
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dd5defbf548e49068167bb4834e5ae48', '3d4bd283cbd04c1c85722c6865f1b772', null, null, '保定市', '06', '保定市', '130600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a39aa124fea245c2b0ffbfffd0a772fd', '3d4bd283cbd04c1c85722c6865f1b772', null, null, '张家口市', '07', '张家口市', '130700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7cb33ba7dcc9456caac8ec92e8640636', '3d4bd283cbd04c1c85722c6865f1b772', null, null, '承德市', '08', '承德市', '130800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c012a6672c5a4d51a2dd7c869e6e2f94', '3d4bd283cbd04c1c85722c6865f1b772', null, null, '沧州市', '09', '沧州市', '130900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e9fcaf25bb7e4954ba725288edd530b4', '3d4bd283cbd04c1c85722c6865f1b772', null, null, '廊坊市', '10', '廊坊市', '131000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('23a701cb7a9441e7b601f2b4522d90ff', '3d4bd283cbd04c1c85722c6865f1b772', null, null, '衡水市', '11', '衡水市', '131100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b7f87c79f8344d97accf425e966da23a', '5f8761dec97040dfb75f459d1657a84b', null, null, '太原市', '01', '太原市', '140100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6bdf07875675456cad494b60cf611d83', '5f8761dec97040dfb75f459d1657a84b', null, null, '大同市', '02', '大同市', '140200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('23f034f938e246278059476a291b3738', '5f8761dec97040dfb75f459d1657a84b', null, null, '阳泉市', '03', '阳泉市', '140300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('87c57bcb3f14405ab32d70bb5e6af000', '5f8761dec97040dfb75f459d1657a84b', null, null, '长治市', '04', '长治市', '140400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('39513e1f4dc34528937b429ee5ab7bd1', '5f8761dec97040dfb75f459d1657a84b', null, null, '晋城市', '05', '晋城市', '140500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3a78300165d5408f878939f11f57fb8e', '5f8761dec97040dfb75f459d1657a84b', null, null, '朔州市', '06', '朔州市', '140600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('38ee852f7125442d8c90540ecf8fbfcc', '5f8761dec97040dfb75f459d1657a84b', null, null, '晋中市', '07', '晋中市', '140700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a38ecbcdd84a434280f6a45b609558ad', '5f8761dec97040dfb75f459d1657a84b', null, null, '运城市', '08', '运城市', '140800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('264018e21b854c78866dd48622f2d326', '5f8761dec97040dfb75f459d1657a84b', null, null, '忻州市', '09', '忻州市', '140900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f01f08e264f240c78e12fea9d8d2c41a', '5f8761dec97040dfb75f459d1657a84b', null, null, '临汾市', '10', '临汾市', '141000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('246df1df62e141c68397e33cc08f5adf', '5f8761dec97040dfb75f459d1657a84b', null, null, '吕梁市', '11', '吕梁市', '141100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dc525fdeeb4d4d4a93e1a8ee410cbb15', 'd5795820975447d090bdbd135c4e4edc', null, null, '呼和浩特市', '01', '呼和浩特市', '150100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f52d20e8efa14e458b7e12d803073951', 'd5795820975447d090bdbd135c4e4edc', null, null, '包头市', '02', '包头市', '150200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('746ab0b6b0974a89b45cde14f80c15be', 'd5795820975447d090bdbd135c4e4edc', null, null, '乌海市', '03', '乌海市', '150300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d740c573976d40e880ce13ec316fdda9', 'd5795820975447d090bdbd135c4e4edc', null, null, '赤峰市', '04', '赤峰市', '150400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fb5216a01a6448768f4b174d3601242e', 'd5795820975447d090bdbd135c4e4edc', null, null, '通辽市', '05', '通辽市', '150500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('594fcd2dd10b4962a685bb3aff60a5f8', 'd5795820975447d090bdbd135c4e4edc', null, null, '鄂尔多斯市', '06', '鄂尔多斯市', '150600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ecb2eddd1a1e4129af8155c03ae0253a', 'd5795820975447d090bdbd135c4e4edc', null, null, '呼伦贝尔市', '07', '呼伦贝尔市', '150700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fab236d4b9814f9481383155c5a1cde7', 'd5795820975447d090bdbd135c4e4edc', null, null, '巴彦淖尔市', '08', '巴彦淖尔市', '150800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a0b6ea307e034ce6ba5d89c5eb5a71a8', 'd5795820975447d090bdbd135c4e4edc', null, null, '乌兰察布市', '09', '乌兰察布市', '150900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2ba645b8f3634fa8b493153e4a5ed8f6', 'd5795820975447d090bdbd135c4e4edc', null, null, '兴安盟', '22', '兴安盟', '152200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8e3b599f883a4795a8ebede218cfa3c5', 'd5795820975447d090bdbd135c4e4edc', null, null, '锡林郭勒盟', '25', '锡林郭勒盟', '152500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('750ccb3644114acbaf7cb9f3979fa14e', 'd5795820975447d090bdbd135c4e4edc', null, null, '阿拉善盟', '29', '阿拉善盟', '152900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d4dc7fd748b54bfd85730b31208b8983', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '沈阳市', '01', '沈阳市', '210100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5246279f38814f9a80d551d0c4ec88cb', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '大连市', '02', '大连市', '210200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('77697bfbce0b42e3a0ab3a35f66cc591', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '鞍山市', '03', '鞍山市', '210300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2dae9d3b1ff147988878f48b30ca29e6', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '抚顺市', '04', '抚顺市', '210400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('133d81bc3b4c48e7803bde263c887d8f', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '本溪市', '05', '本溪市', '210500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('21f243e300a74fb4abb0138b942daf00', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '丹东市', '06', '丹东市', '210600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6cd8d97a762c424985e64493c40c3dd1', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '锦州市', '07', '锦州市', '210700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2395708e898b4fb59076a40fba93436a', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '营口市', '08', '营口市', '210800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('575d6ce067aa4da9a890efc1ee49b8d7', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '阜新市', '09', '阜新市', '210900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fb07ee3fe7964963bc75133a6263f5f2', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '辽阳市', '10', '辽阳市', '211000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aa1484c1a2fa40f8ae030411fe7df533', '1884978b76d6469c871140b620617381', '314300', null, '海盐县', '24', '海盐县', '330424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('323ddd65fccd4f8e93f0320cbb6efbe9', '1884978b76d6469c871140b620617381', '314400', null, '海宁市', '81', '海宁市', '330481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8ed40842b3014cd499f3c094222b1513', '1884978b76d6469c871140b620617381', '314200', null, '平湖市', '82', '平湖市', '330482', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('838a8204d3c94ee3925de8459dc633ff', '1884978b76d6469c871140b620617381', '314500', null, '桐乡市', '83', '桐乡市', '330483', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('75b39c1f74b445319410ef34beb28c3b', '31f843473a4d4710a5d8cb462ee84cd1', null, null, '三明市', '04', '三明市', '350400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('60da25ef271a45e88a92c016ef7e469c', '31f843473a4d4710a5d8cb462ee84cd1', null, null, '泉州市', '05', '泉州市', '350500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('523109f4617c4f9394d802e616806354', '31f843473a4d4710a5d8cb462ee84cd1', null, null, '漳州市', '06', '漳州市', '350600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('66c6fb2856b6486cad0f949d7c1045e3', '31f843473a4d4710a5d8cb462ee84cd1', null, null, '南平市', '07', '南平市', '350700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('55b987a4d8ed49d99701fc0c6ad87720', '31f843473a4d4710a5d8cb462ee84cd1', null, null, '龙岩市', '08', '龙岩市', '350800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6fd17ced4f124cc4881a50ad26321855', '31f843473a4d4710a5d8cb462ee84cd1', null, null, '宁德市', '09', '宁德市', '350900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4f7002a7097045428cafa1878f18556a', '89af740e57c443e8bf70af185481d025', null, null, '南昌市', '01', '南昌市', '360100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('647fb0abceaf4c5d9ea5b24cdf2de227', '89af740e57c443e8bf70af185481d025', null, null, '景德镇市', '02', '景德镇市', '360200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('63879d4cb0b9445c86e98966d15f22d6', '89af740e57c443e8bf70af185481d025', null, null, '萍乡市', '03', '萍乡市', '360300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('160289800e4949a18ce764e082fa4bd0', '89af740e57c443e8bf70af185481d025', null, null, '九江市', '04', '九江市', '360400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e776f1045e3441a3bf1a91a222e248eb', '89af740e57c443e8bf70af185481d025', null, null, '新余市', '05', '新余市', '360500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f48fd507cbb24c9d85e8c2a2181c9115', '89af740e57c443e8bf70af185481d025', null, null, '鹰潭市', '06', '鹰潭市', '360600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0a3c848e26ed49d396eb5b00ecce7de0', '89af740e57c443e8bf70af185481d025', null, null, '赣州市', '07', '赣州市', '360700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('04639f4c045a44258ebff7fc94fec3e5', '89af740e57c443e8bf70af185481d025', null, null, '吉安市', '08', '吉安市', '360800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ba92d925173c48ebac5841355f105db5', '89af740e57c443e8bf70af185481d025', null, null, '宜春市', '09', '宜春市', '360900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bfcd8a0a0e484b12ac10a25b91a97e68', '89af740e57c443e8bf70af185481d025', null, null, '抚州市', '10', '抚州市', '361000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ae3e3d63e8b541b3a63dd96ec498e5d0', '89af740e57c443e8bf70af185481d025', null, null, '上饶市', '11', '上饶市', '361100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f1f171efba3d4ecb9a3489ae544cdd47', '43e6e48fca984902b2da31dc7babd4f5', null, null, '济南市', '01', '济南市', '370100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('adf505a23af74179b00c02a084407ca8', '43e6e48fca984902b2da31dc7babd4f5', null, null, '青岛市', '02', '青岛市', '370200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('85fb1b8433304911b85e1cd6cdb26d9e', '43e6e48fca984902b2da31dc7babd4f5', null, null, '淄博市', '03', '淄博市', '370300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7ceca56d1b8146d48e88aabf26741991', '43e6e48fca984902b2da31dc7babd4f5', null, null, '枣庄市', '04', '枣庄市', '370400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f2eb632af2014a9289fe6a736c9c12ac', '43e6e48fca984902b2da31dc7babd4f5', null, null, '东营市', '05', '东营市', '370500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5dc548802c6c40a3803e58511ec474bf', '43e6e48fca984902b2da31dc7babd4f5', null, null, '烟台市', '06', '烟台市', '370600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4ae4336f1dab45c0a465fae057c383fe', '43e6e48fca984902b2da31dc7babd4f5', null, null, '潍坊市', '07', '潍坊市', '370700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b34159526635417eac1df82dd9c7859b', '43e6e48fca984902b2da31dc7babd4f5', null, null, '济宁市', '08', '济宁市', '370800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f04b7fdbaab14550914ec25ef9299498', '43e6e48fca984902b2da31dc7babd4f5', null, null, '泰安市', '09', '泰安市', '370900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a39d0fc8049d4c8e8ac862df4bbb7ebc', '43e6e48fca984902b2da31dc7babd4f5', null, null, '威海市', '10', '威海市', '371000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3344436933104790acb9de9e63a859e9', '43e6e48fca984902b2da31dc7babd4f5', null, null, '日照市', '11', '日照市', '371100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7844d926e0c94aeca55889ee6ede41d8', '43e6e48fca984902b2da31dc7babd4f5', null, null, '莱芜市', '12', '莱芜市', '371200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ef87eb2c68254dda8ded0308e20e4dac', '43e6e48fca984902b2da31dc7babd4f5', null, null, '临沂市', '13', '临沂市', '371300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0dc3aad6447a4a92818dc72d59bb1a44', '43e6e48fca984902b2da31dc7babd4f5', null, null, '德州市', '14', '德州市', '371400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('54d95647b0ee4c219e70c84a2a74b396', '43e6e48fca984902b2da31dc7babd4f5', null, null, '聊城市', '15', '聊城市', '371500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('18d0a9122294487eb4aa8d5d6849ec93', '43e6e48fca984902b2da31dc7babd4f5', null, null, '滨州市', '16', '滨州市', '371600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d9e443c24e1403caf4ab9e0e6fd05ed', '43e6e48fca984902b2da31dc7babd4f5', null, null, '荷泽市', '17', '荷泽市', '371700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('849e41d6e28c41eea4e73753ec790c9b', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '郑州市', '01', '郑州市', '410100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4dbc4026e4944f11bae16adcae5b5e26', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '开封市', '02', '开封市', '410200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b62c1ee0eef24fee8b6941a8b36c5a40', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '洛阳市', '03', '洛阳市', '410300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('37804a77ddc4428f948d66acea1d5229', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '平顶山市', '04', '平顶山市', '410400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('521eaa766608414e800f68a916592753', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '安阳市', '05', '安阳市', '410500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1b78854ef6cb4ca9bed5b981062bc3e5', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '鹤壁市', '06', '鹤壁市', '410600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0685a404d9eb48e69f442f0fecd81238', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '新乡市', '07', '新乡市', '410700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c262f32b8254b56b1e1468a5812ad71', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '焦作市', '08', '焦作市', '410800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('620533741dd14610b937e008ac996c69', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '濮阳市', '09', '濮阳市', '410900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a1c30fcc46124323a7742e62970e5e79', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '许昌市', '10', '许昌市', '411000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('318e394e38bd4bd38a60562a064fac5d', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '漯河市', '11', '漯河市', '411100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1d21c167dbe048d7942a636ec4ce172c', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '三门峡市', '12', '三门峡市', '411200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e16c41e4d0b5480786a44c95e8fc7a5c', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '南阳市', '13', '南阳市', '411300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('815767f8485d4636acbaa4eae0b5234c', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '商丘市', '14', '商丘市', '411400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('380f7b3b49a44eae82cfa793b89dbb92', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '信阳市', '15', '信阳市', '411500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('78e3f9f0494b42a789f858385a476d44', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '周口市', '16', '周口市', '411600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7d42b8147aa24128ae7315db8d920b90', '8c9c2e275ecb461fa3bd1039d130a011', null, null, '驻马店市', '17', '驻马店市', '411700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8ebfb0cbf62d4b6597fd742963815e4d', '3cda75cb85e3483881ba373b0ef35585', null, null, '武汉市', '01', '武汉市', '420100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f0236aa5f8f246bfaa238b0f756c17d4', '3cda75cb85e3483881ba373b0ef35585', null, null, '黄石市', '02', '黄石市', '420200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3a817abfa1a4d2f80ce7ca14cb04134', '3cda75cb85e3483881ba373b0ef35585', null, null, '十堰市', '03', '十堰市', '420300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e3d5484dc1394cbb81b162633c379be5', '3cda75cb85e3483881ba373b0ef35585', null, null, '宜昌市', '05', '宜昌市', '420500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cd4e23e0d23048a3837e85d24ad2783a', '3cda75cb85e3483881ba373b0ef35585', null, null, '襄樊市', '06', '襄樊市', '420600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('41054de8248f40979f122baf019dda58', '3cda75cb85e3483881ba373b0ef35585', null, null, '鄂州市', '07', '鄂州市', '420700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3ed095ba7eea4793a022a5b3b2e21ce6', '3cda75cb85e3483881ba373b0ef35585', null, null, '荆门市', '08', '荆门市', '420800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a9623076ba7f459882a4de744213da9f', '3cda75cb85e3483881ba373b0ef35585', null, null, '孝感市', '09', '孝感市', '420900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4a6dbf97ae1346a1ae058aada593c83b', '3cda75cb85e3483881ba373b0ef35585', null, null, '荆州市', '10', '荆州市', '421000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('88495c56c828443ca445e66c6d99e988', '3cda75cb85e3483881ba373b0ef35585', null, null, '黄冈市', '11', '黄冈市', '421100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5cbfd640dd1e427e93dee73568bc7f41', '3cda75cb85e3483881ba373b0ef35585', null, null, '咸宁市', '12', '咸宁市', '421200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a2c47feb005a467e83020bce64d6a551', '3cda75cb85e3483881ba373b0ef35585', null, null, '随州市', '13', '随州市', '421300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ede3533eebc24764a993c9c8b694c26b', '3cda75cb85e3483881ba373b0ef35585', null, null, '恩施土家族苗族自治州', '28', '恩施土家族苗族自治州', '422800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('368a7e6a7a6f409e8af26a6793354867', '3cda75cb85e3483881ba373b0ef35585', null, null, '省直辖行政单位', '90', '省直辖行政单位', '429000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e44bd32e5c84c3c852e00f22f6fda95', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '长沙市', '01', '长沙市', '430100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1cb06b4200264436a52680229df355c0', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '株洲市', '02', '株洲市', '430200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1366c663bb614b20b4d433b637b286ed', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '湘潭市', '03', '湘潭市', '430300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4d775ed4147c4a29896d82e845939e8b', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '衡阳市', '04', '衡阳市', '430400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('495e8497aed747bf8741de8bd42abaf7', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '邵阳市', '05', '邵阳市', '430500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3f6620721bd74a3aade384dc03f7e7b9', 'd740c573976d40e880ce13ec316fdda9', '025500', null, '阿鲁科尔沁旗', '21', '阿鲁科尔沁旗', '150421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('37dda40329e04ffdba47d0c7064a35ac', 'd740c573976d40e880ce13ec316fdda9', '025450', null, '巴林左旗', '22', '巴林左旗', '150422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('01d033ac428d4bfca15f5931f200df8e', 'd740c573976d40e880ce13ec316fdda9', '025150', null, '巴林右旗', '23', '巴林右旗', '150423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('249e55b0df1f4d51a58905a46811b5d6', 'd740c573976d40e880ce13ec316fdda9', '025250', null, '林西县', '24', '林西县', '150424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d569337671da4fb8a85f698264ef4d61', 'd740c573976d40e880ce13ec316fdda9', '025350', null, '克什克腾旗', '25', '克什克腾旗', '150425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8ab0555e136948a3a71681ace1e2e16b', 'd740c573976d40e880ce13ec316fdda9', '024500', null, '翁牛特旗', '26', '翁牛特旗', '150426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('76406462eff84cf5939fad4d4e91c5ab', 'd740c573976d40e880ce13ec316fdda9', '024400', null, '喀喇沁旗', '28', '喀喇沁旗', '150428', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('df261d93babe4955915ac54d943c538a', 'd740c573976d40e880ce13ec316fdda9', '024200', null, '宁城县', '29', '宁城县', '150429', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('46ca4f3291ee42cf81a1815f0201a49a', 'd740c573976d40e880ce13ec316fdda9', '024300', null, '敖汉旗', '30', '敖汉旗', '150430', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2cd816572c0343d2beae701bcaf0e05a', 'fb5216a01a6448768f4b174d3601242e', '028000', null, '市辖区', '01', '市辖区', '150501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e96afb0405a6470792800c4a9835862f', 'fb5216a01a6448768f4b174d3601242e', '028000', null, '科尔沁区', '02', '科尔沁区', '150502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8276292c416e4239b37cb89844474626', 'fb5216a01a6448768f4b174d3601242e', '029300', null, '科尔沁左翼中旗', '21', '科尔沁左翼中旗', '150521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('22a22423feb94cbc885c08348ab1801b', 'fb5216a01a6448768f4b174d3601242e', '028100', null, '科尔沁左翼后旗', '22', '科尔沁左翼后旗', '150522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9fb97cb7b04244e381543dfdfddaa8e0', 'fb5216a01a6448768f4b174d3601242e', '028400', null, '开鲁县', '23', '开鲁县', '150523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1aafe84915bd47a6971382da176abdd3', 'fb5216a01a6448768f4b174d3601242e', '028200', null, '库伦旗', '24', '库伦旗', '150524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c9c992d1e3984fb8ac62e8c208860394', 'fb5216a01a6448768f4b174d3601242e', '028300', null, '奈曼旗', '25', '奈曼旗', '150525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f428dc524e04f59b24fee13286fa753', 'fb5216a01a6448768f4b174d3601242e', '029100', null, '扎鲁特旗', '26', '扎鲁特旗', '150526', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('635aded1f07547ac8d79b3e3222b8008', 'fb5216a01a6448768f4b174d3601242e', '029200', null, '霍林郭勒市', '81', '霍林郭勒市', '150581', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5219f4405243401ca5ef1dafdc9da20f', '594fcd2dd10b4962a685bb3aff60a5f8', '017000', null, '东胜区', '02', '东胜区', '150602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c9880a04d8db4894b85399f7d2e07e35', '594fcd2dd10b4962a685bb3aff60a5f8', '014300', null, '达拉特旗', '21', '达拉特旗', '150621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('13c31a7238784391a61690d856bab2ec', '594fcd2dd10b4962a685bb3aff60a5f8', '017100', null, '准格尔旗', '22', '准格尔旗', '150622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2d5d1376b8f4446cb9ed4184e81bb0f8', '594fcd2dd10b4962a685bb3aff60a5f8', '016200', null, '鄂托克前旗', '23', '鄂托克前旗', '150623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f000d607fdf6406bba184f474650c426', '594fcd2dd10b4962a685bb3aff60a5f8', '016100', null, '鄂托克旗', '24', '鄂托克旗', '150624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('23101960c7ca4d45b3f5f5a6d5af6e3e', '594fcd2dd10b4962a685bb3aff60a5f8', '017400', null, '杭锦旗', '25', '杭锦旗', '150625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('946c34f9a9ad4752a8939c5ff59ec0ea', '594fcd2dd10b4962a685bb3aff60a5f8', '017300', null, '乌审旗', '26', '乌审旗', '150626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d4b009fd03674ecba18204dedbadcaca', '594fcd2dd10b4962a685bb3aff60a5f8', '017200', null, '伊金霍洛旗', '27', '伊金霍洛旗', '150627', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8414286d343549919e59f89909ee9ef0', 'ecb2eddd1a1e4129af8155c03ae0253a', '021000', null, '市辖区', '01', '市辖区', '150701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('00483f5c69874e248afe1d8c59252ba0', 'ecb2eddd1a1e4129af8155c03ae0253a', '021000', null, '海拉尔区', '02', '海拉尔区', '150702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f090d66a3bb4677b52382c608345d39', 'ecb2eddd1a1e4129af8155c03ae0253a', '162750', null, '阿荣旗', '21', '阿荣旗', '150721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2b000b387cde4ad294598da73781dc63', 'ecb2eddd1a1e4129af8155c03ae0253a', '162850', null, '莫力达瓦达斡尔族自治旗', '22', '莫力达瓦达斡尔族自治旗', '150722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b7f3faa378c045059541626847516e4b', 'ecb2eddd1a1e4129af8155c03ae0253a', '022450', null, '鄂伦春自治旗', '23', '鄂伦春自治旗', '150723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a9d1200460bb48e49a32b15b4df78340', 'ecb2eddd1a1e4129af8155c03ae0253a', '021100', null, '鄂温克族自治旗', '24', '鄂温克族自治旗', '150724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9497e32a805e4295880520a432a73e3e', 'ecb2eddd1a1e4129af8155c03ae0253a', '021500', null, '陈巴尔虎旗', '25', '陈巴尔虎旗', '150725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e49dc865415483b97e95f96c8e42261', 'ecb2eddd1a1e4129af8155c03ae0253a', '021200', null, '新巴尔虎左旗', '26', '新巴尔虎左旗', '150726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('03cb796b97a043128a1f9bc88d7b54e2', 'ecb2eddd1a1e4129af8155c03ae0253a', '021300', null, '新巴尔虎右旗', '27', '新巴尔虎右旗', '150727', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c2c5985d7f3d4b2b8125d86a03d9876e', 'ecb2eddd1a1e4129af8155c03ae0253a', '021400', null, '满洲里市', '81', '满洲里市', '150781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fe49e564c7f24b0a9403f03097178f27', 'ecb2eddd1a1e4129af8155c03ae0253a', '022150', null, '牙克石市', '82', '牙克石市', '150782', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('949cac5ef2c44e73a33250aedcb05e66', 'ecb2eddd1a1e4129af8155c03ae0253a', '162650', null, '扎兰屯市', '83', '扎兰屯市', '150783', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fe99c2294d894601b28378d8b41e4424', 'ecb2eddd1a1e4129af8155c03ae0253a', '022250', null, '额尔古纳市', '84', '额尔古纳市', '150784', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b7b4b82254e24822915feb6bb62aa895', 'ecb2eddd1a1e4129af8155c03ae0253a', '022350', null, '根河市', '85', '根河市', '150785', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e2ff940cf41645de8412fcd19fa09295', 'fab236d4b9814f9481383155c5a1cde7', '015000', null, '市辖区', '01', '市辖区', '150801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('48e555ed46b24472b0e0b92058224d5e', 'fab236d4b9814f9481383155c5a1cde7', '015000', null, '临河区', '02', '临河区', '150802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('29ff191fe54441219d75b85d0442190c', 'fab236d4b9814f9481383155c5a1cde7', '015100', null, '五原县', '21', '五原县', '150821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('392d0be7a5b248bca8539bcecd0f7193', 'fab236d4b9814f9481383155c5a1cde7', '015200', null, '磴口县', '22', '磴口县', '150822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('531adf0c1d5344c8a1ac85d205d9739c', 'fab236d4b9814f9481383155c5a1cde7', '014400', null, '乌拉特前旗', '23', '乌拉特前旗', '150823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2f872e2b58f84e5c86040e5d34f33986', 'fab236d4b9814f9481383155c5a1cde7', '015300', null, '乌拉特中旗', '24', '乌拉特中旗', '150824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e2046a09232342b49825016907924c4d', 'fab236d4b9814f9481383155c5a1cde7', '015500', null, '乌拉特后旗', '25', '乌拉特后旗', '150825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5a1eba2dbcca47e9941580733e7b7a94', 'fab236d4b9814f9481383155c5a1cde7', '015400', null, '杭锦后旗', '26', '杭锦后旗', '150826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('56adc260dcfe462ab23a15ba20f680c2', 'a0b6ea307e034ce6ba5d89c5eb5a71a8', '012000', null, '市辖区', '01', '市辖区', '150901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2377296d1337496e8456a276d790d620', 'a0b6ea307e034ce6ba5d89c5eb5a71a8', '012000', null, '集宁区', '02', '集宁区', '150902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ec66f744a5d4424c8bb5eca6ac82d0d1', 'a0b6ea307e034ce6ba5d89c5eb5a71a8', '012300', null, '卓资县', '21', '卓资县', '150921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fbf5291250404c97b2f4404b9797d0b7', 'a0b6ea307e034ce6ba5d89c5eb5a71a8', '013350', null, '化德县', '22', '化德县', '150922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0e4bee0867354dce98af099a87c969b6', 'a0b6ea307e034ce6ba5d89c5eb5a71a8', '013400', null, '商都县', '23', '商都县', '150923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('173cb3ba6e494af1bd106d2f10af59a4', 'a0b6ea307e034ce6ba5d89c5eb5a71a8', '013650', null, '兴和县', '24', '兴和县', '150924', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('112b0099929c46429a31e10333d9aa9d', 'a0b6ea307e034ce6ba5d89c5eb5a71a8', '013750', null, '凉城县', '25', '凉城县', '150925', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b1a7197950d049b1bfd4d42f56d2afbd', 'a0b6ea307e034ce6ba5d89c5eb5a71a8', '012200', null, '察哈尔右翼前旗', '26', '察哈尔右翼前旗', '150926', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3dcd74eff4ea470e8b7db5d38f460e16', 'a0b6ea307e034ce6ba5d89c5eb5a71a8', '013500', null, '察哈尔右翼中旗', '27', '察哈尔右翼中旗', '150927', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e530a0e8718c46ed8da3877cb82335d1', 'a0b6ea307e034ce6ba5d89c5eb5a71a8', '012400', null, '察哈尔右翼后旗', '28', '察哈尔右翼后旗', '150928', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('96d5f89fc11245c6a0cdb9e9e065b688', 'a0b6ea307e034ce6ba5d89c5eb5a71a8', '011800', null, '四子王旗', '29', '四子王旗', '150929', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5d75c7e55d5d47ac988500c715db089b', 'a0b6ea307e034ce6ba5d89c5eb5a71a8', '012100', null, '丰镇市', '81', '丰镇市', '150981', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b7aaf275ffe04792adcf47668fc7f7ba', null, null, null, '北京市', '11', '北京市', '110000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d6b0f77426fb44c690e4059d93094127', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '凉山彝族自治州', '34', '凉山彝族自治州', '513400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f8bee6d70b4d4aaebf536852686432c1', 'd3b62fa78aa843649485428da6b36015', null, null, '贵阳市', '01', '贵阳市', '520100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f027f86e80f547bd898e22f4695c1146', 'd3b62fa78aa843649485428da6b36015', null, null, '六盘水市', '02', '六盘水市', '520200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('74c8764cd28d4fe797df07e2e0444dc8', 'b1661da6929548f58fc4ac41d14d2b89', '055350', null, '隆尧县', '25', '隆尧县', '130525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7e5c64d267b24dcd84d530484510a1ed', 'b1661da6929548f58fc4ac41d14d2b89', '055150', null, '任县', '26', '任县', '130526', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f33112b026d44d768bca37498f8153bb', 'b1661da6929548f58fc4ac41d14d2b89', '054400', null, '南和县', '27', '南和县', '130527', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1f30ceb3d3f04b01b0c1776030387378', 'b1661da6929548f58fc4ac41d14d2b89', '055550', null, '宁晋县', '28', '宁晋县', '130528', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ee6ba53896994d148703c571274f69da', 'b1661da6929548f58fc4ac41d14d2b89', '055250', null, '巨鹿县', '29', '巨鹿县', '130529', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('51ca2a956d574dfbab8158684bcbc233', 'b1661da6929548f58fc4ac41d14d2b89', '051730', null, '新河县', '30', '新河县', '130530', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1127c468d3114a528f92bb6719d6fb28', 'b1661da6929548f58fc4ac41d14d2b89', '054600', null, '广宗县', '31', '广宗县', '130531', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f255ada3a3724eccb41ba12a35618053', 'b1661da6929548f58fc4ac41d14d2b89', '054500', null, '平乡县', '32', '平乡县', '130532', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a8cddbfa463f4d0e85bcfe0b1d00a7b8', 'b1661da6929548f58fc4ac41d14d2b89', '054700', null, '威县', '33', '威县', '130533', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('419ab62c72e6498fbcfcf10c03c131c7', 'b1661da6929548f58fc4ac41d14d2b89', '054800', null, '清河县', '34', '清河县', '130534', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2f4b120e14a04eee8fe219667b5271e5', 'b1661da6929548f58fc4ac41d14d2b89', '054900', null, '临西县', '35', '临西县', '130535', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4162de0dcab54e33aebca065a6c81ade', 'b1661da6929548f58fc4ac41d14d2b89', '051800', null, '南宫市', '81', '南宫市', '130581', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2bd83122b2d44230893e997763c0d1fc', 'b1661da6929548f58fc4ac41d14d2b89', '054100', null, '沙河市', '82', '沙河市', '130582', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('16ffb9b0dc7f4d68a8f7b3850584c5a3', 'dd5defbf548e49068167bb4834e5ae48', '071000', null, '市辖区', '01', '市辖区', '130601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7013d03be9714d57a59b643771bd5efe', 'dd5defbf548e49068167bb4834e5ae48', '071000', null, '新市区', '02', '新市区', '130602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('47925bfc8f5c4946baa451af497581f5', 'dd5defbf548e49068167bb4834e5ae48', '071000', null, '北市区', '03', '北市区', '130603', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('07866f9d10c94cf6950b5c115e110c60', 'dd5defbf548e49068167bb4834e5ae48', '071000', null, '南市区', '04', '南市区', '130604', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('64d277aecff640dfa62a23d839df4a83', 'dd5defbf548e49068167bb4834e5ae48', '072150', null, '满城县', '21', '满城县', '130621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('59ad1eb93c6e447a87362a936d7f1032', 'dd5defbf548e49068167bb4834e5ae48', '071100', null, '清苑县', '22', '清苑县', '130622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e9a8b13e289a4f1eafb3458ec72fe3f5', 'dd5defbf548e49068167bb4834e5ae48', '074100', null, '涞水县', '23', '涞水县', '130623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('25fbf8372f434159962bfa0df084203c', 'dd5defbf548e49068167bb4834e5ae48', '073200', null, '阜平县', '24', '阜平县', '130624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cfde84f663c0464ba97574b9232804e9', 'dd5defbf548e49068167bb4834e5ae48', '072550', null, '徐水县', '25', '徐水县', '130625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2ea5b84fde544890b0998fdeeea81b68', 'dd5defbf548e49068167bb4834e5ae48', '072650', null, '定兴县', '26', '定兴县', '130626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f9612fb00884a34bb10130caf9a86cc', 'dd5defbf548e49068167bb4834e5ae48', '072350', null, '唐县', '27', '唐县', '130627', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1584c1e752544307aaaff59790dbf17e', 'dd5defbf548e49068167bb4834e5ae48', '071500', null, '高阳县', '28', '高阳县', '130628', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f287916e3e3e4ad6a8a6d750f0c75fdb', 'dd5defbf548e49068167bb4834e5ae48', '071700', null, '容城县', '29', '容城县', '130629', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1fd3f6d2808d4381b1a2e4fc5e320e0b', 'dd5defbf548e49068167bb4834e5ae48', '102900', null, '涞源县', '30', '涞源县', '130630', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('38f661ab5191467daeac49ba0a98b64d', 'dd5defbf548e49068167bb4834e5ae48', '072450', null, '望都县', '31', '望都县', '130631', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('650599f311254bf68c14e465798525c7', 'dd5defbf548e49068167bb4834e5ae48', '071600', null, '安新县', '32', '安新县', '130632', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d972ed621e0a4bec9c9881213b6bada3', 'dd5defbf548e49068167bb4834e5ae48', '074200', null, '易县', '33', '易县', '130633', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b484040da40b4706876d0640082194ef', 'dd5defbf548e49068167bb4834e5ae48', '073100', null, '曲阳县', '34', '曲阳县', '130634', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d712f7e05e104368aae3015f11431f1f', 'dd5defbf548e49068167bb4834e5ae48', '071400', null, '蠡县', '35', '蠡县', '130635', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('91fbf0ea56384d06bf3ff948371f90a4', 'dd5defbf548e49068167bb4834e5ae48', '072250', null, '顺平县', '36', '顺平县', '130636', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9de10fdf61074afa90ab3e27c6e07409', 'dd5defbf548e49068167bb4834e5ae48', '071300', null, '博野县', '37', '博野县', '130637', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('98a73c50b8e34ca2b49f122efc8d580f', 'dd5defbf548e49068167bb4834e5ae48', '071800', null, '雄县', '38', '雄县', '130638', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7abf45109ddb4b2d9dac50da4c9b595a', 'dd5defbf548e49068167bb4834e5ae48', '072750', null, '涿州市', '81', '涿州市', '130681', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dc000f3ec99e4266a85460150160da10', 'dd5defbf548e49068167bb4834e5ae48', '073000', null, '定州市', '82', '定州市', '130682', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e3e2427142b346b690676df54a3a0e18', 'dd5defbf548e49068167bb4834e5ae48', '071200', null, '安国市', '83', '安国市', '130683', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4fc61e0e39c244fbbee5537b108143a7', 'dd5defbf548e49068167bb4834e5ae48', '074000', null, '高碑店市', '84', '高碑店市', '130684', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('61084baffd014f86ac167d2d7886bbec', 'a39aa124fea245c2b0ffbfffd0a772fd', '075000', null, '市辖区', '01', '市辖区', '130701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('87d4333c126449d7817992d1dc848927', 'a39aa124fea245c2b0ffbfffd0a772fd', '075000', null, '桥东区', '02', '桥东区', '130702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1804ce18533e43d9a413ec6dba9fac63', 'a39aa124fea245c2b0ffbfffd0a772fd', '075000', null, '桥西区', '03', '桥西区', '130703', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('63bc9dc9bd8a42af80eef1220732e1c1', 'a39aa124fea245c2b0ffbfffd0a772fd', '075000', null, '宣化区', '05', '宣化区', '130705', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('945feda1a400414383ef63636f5f1cf8', 'a39aa124fea245c2b0ffbfffd0a772fd', '075000', null, '下花园区', '06', '下花园区', '130706', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3005ea611eb44657959d073407bc8d49', 'a39aa124fea245c2b0ffbfffd0a772fd', '075100', null, '宣化县', '21', '宣化县', '130721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('515fd63216b4464f8791094cfad4e23f', 'a39aa124fea245c2b0ffbfffd0a772fd', '076450', null, '张北县', '22', '张北县', '130722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6436c3486b1a4a4cacd384d5c5ffb6ed', 'a39aa124fea245c2b0ffbfffd0a772fd', '076650', null, '康保县', '23', '康保县', '130723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fbf45edbe2664fe79ea58667043ad382', 'a39aa124fea245c2b0ffbfffd0a772fd', '076550', null, '沽源县', '24', '沽源县', '130724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('422eca1df4b54ecda72f1d356584004f', 'a39aa124fea245c2b0ffbfffd0a772fd', '076750', null, '尚义县', '25', '尚义县', '130725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bdf69438790d4e73ad8e422ee1d5e21f', 'a39aa124fea245c2b0ffbfffd0a772fd', '075700', null, '蔚县', '26', '蔚县', '130726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6451f6f1b35b4cd08d94980967f50174', 'a39aa124fea245c2b0ffbfffd0a772fd', '075800', null, '阳原县', '27', '阳原县', '130727', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0a020e2ab98b43d4954c6f1325118e3f', 'a39aa124fea245c2b0ffbfffd0a772fd', '076150', null, '怀安县', '28', '怀安县', '130728', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7aff36442f3a4446be50efeb97bee7b8', 'a39aa124fea245c2b0ffbfffd0a772fd', '076250', null, '万全县', '29', '万全县', '130729', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4059bf0c7c394be69a83e745788c6d99', 'a39aa124fea245c2b0ffbfffd0a772fd', '075400', null, '怀来县', '30', '怀来县', '130730', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('569c51e2e5c94dbc95270346a75930b1', 'a39aa124fea245c2b0ffbfffd0a772fd', '075600', null, '涿鹿县', '31', '涿鹿县', '130731', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('688ed79f2ff542e1b677d1222c9eebf1', 'a39aa124fea245c2b0ffbfffd0a772fd', '075500', null, '赤城县', '32', '赤城县', '130732', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b1fa398ff17e468a832d4fd1bb24b2bd', 'a39aa124fea245c2b0ffbfffd0a772fd', '076350', null, '崇礼县', '33', '崇礼县', '130733', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ad6b9825e5034247970da2b328a901bd', '7cb33ba7dcc9456caac8ec92e8640636', '067000', null, '市辖区', '01', '市辖区', '130801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a53ca1b59ce74e0a80d63d385aa2c643', '7cb33ba7dcc9456caac8ec92e8640636', '067000', null, '双桥区', '02', '双桥区', '130802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('74393877982143feac781092b3767c14', '7cb33ba7dcc9456caac8ec92e8640636', '067000', null, '双滦区', '03', '双滦区', '130803', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fa9eac3743434ade8736cf44bd080920', '7cb33ba7dcc9456caac8ec92e8640636', '067200', null, '鹰手营子矿区', '04', '鹰手营子矿区', '130804', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('40883de60ec4400386106b3e780655aa', '7cb33ba7dcc9456caac8ec92e8640636', '067400', null, '承德县', '21', '承德县', '130821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3c25b17f174541bfb2ba7642a854a940', '7cb33ba7dcc9456caac8ec92e8640636', '067300', null, '兴隆县', '22', '兴隆县', '130822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f278bea6cb784b248e34205cfbd66fbe', '7cb33ba7dcc9456caac8ec92e8640636', '067500', null, '平泉县', '23', '平泉县', '130823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ef198bc9f1db404c87c320dfa258a5b8', '7cb33ba7dcc9456caac8ec92e8640636', '068250', null, '滦平县', '24', '滦平县', '130824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('91a1979757e044498a86b74363db63a8', '7cb33ba7dcc9456caac8ec92e8640636', '068150', null, '隆化县', '25', '隆化县', '130825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7ffe4f666c2d4862b49f75ca80f3bc37', '6bdf07875675456cad494b60cf611d83', '037300', null, '大同县', '27', '大同县', '140227', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eb5e5da70b6f4ecab159c7fc31d12714', '23f034f938e246278059476a291b3738', '045000', null, '市辖区', '01', '市辖区', '140301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('be67444325ab4647a913a15976c90b5e', '23f034f938e246278059476a291b3738', '045000', null, '城区', '02', '城区', '140302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('962b3ceb5f4a4b6ca0fc3e26c14f74cb', '23f034f938e246278059476a291b3738', '045000', null, '矿区', '03', '矿区', '140303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('034db3c8afd749a480c0b47fa98499c1', '23f034f938e246278059476a291b3738', '045000', null, '郊区', '11', '郊区', '140311', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('af17a4be1b9f4b91b5c5aa4d7f94d224', '23f034f938e246278059476a291b3738', '045200', null, '平定县', '21', '平定县', '140321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2ffbcfb1332e442aa46bfcc46d39e013', '23f034f938e246278059476a291b3738', '045100', null, '盂县', '22', '盂县', '140322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2a684ccfc6a945359bf6cdd1fa647a1f', '87c57bcb3f14405ab32d70bb5e6af000', '046000', null, '市辖区', '01', '市辖区', '140401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6701b90b83fb42c09a7b4f5d9f3608f4', '87c57bcb3f14405ab32d70bb5e6af000', '046000', null, '城区', '02', '城区', '140402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('17edf7da4d914634b952761910161589', '87c57bcb3f14405ab32d70bb5e6af000', '046000', null, '郊区', '11', '郊区', '140411', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8078b3e101d144c79f8b710edfb60ac3', '87c57bcb3f14405ab32d70bb5e6af000', '046000', null, '长治县', '21', '长治县', '140421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('511f6d9913b54c218a5b3ca32b35792d', '87c57bcb3f14405ab32d70bb5e6af000', '046200', null, '襄垣县', '23', '襄垣县', '140423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6ddbb309655743bebc819b46dc159088', '87c57bcb3f14405ab32d70bb5e6af000', '046100', null, '屯留县', '24', '屯留县', '140424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8f5b717acec34584821f641076c1ba5c', '87c57bcb3f14405ab32d70bb5e6af000', '047400', null, '平顺县', '25', '平顺县', '140425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ca41184d44c945f28fdbc282c0f7b5dc', '87c57bcb3f14405ab32d70bb5e6af000', '047600', null, '黎城县', '26', '黎城县', '140426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1430f57ccaa3451580f0faab8b4752c3', '87c57bcb3f14405ab32d70bb5e6af000', '047300', null, '壶关县', '27', '壶关县', '140427', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('32071bb121604240877cbe7e5c627021', '87c57bcb3f14405ab32d70bb5e6af000', '046600', null, '长子县', '28', '长子县', '140428', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('be9aafaf93364e6f92fb00cb3102a308', '87c57bcb3f14405ab32d70bb5e6af000', '046300', null, '武乡县', '29', '武乡县', '140429', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2a566ff2fa3843698a3a014ba14f7420', '87c57bcb3f14405ab32d70bb5e6af000', '046400', null, '沁县', '30', '沁县', '140430', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fc6acbac15ae4fdb99af95a4945f120f', '87c57bcb3f14405ab32d70bb5e6af000', '046500', null, '沁源县', '31', '沁源县', '140431', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ac94ee6edf1744178a7a7526e58a4644', '87c57bcb3f14405ab32d70bb5e6af000', '047500', null, '潞城市', '81', '潞城市', '140481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('90e18069b12d4079b9806d026813202d', '39513e1f4dc34528937b429ee5ab7bd1', '048000', null, '市辖区', '01', '市辖区', '140501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c42a61b6e5fd4745adfccb6c8c2ef85f', '39513e1f4dc34528937b429ee5ab7bd1', '048000', null, '城区', '02', '城区', '140502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('53a9500d506e453fb923a0cf301f36eb', '39513e1f4dc34528937b429ee5ab7bd1', '048200', null, '沁水县', '21', '沁水县', '140521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3e1f73bd2bb45ad930edfb306724203', '39513e1f4dc34528937b429ee5ab7bd1', '048100', null, '阳城县', '22', '阳城县', '140522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3b9ae530d9284ce1bde9df909e3c454a', '39513e1f4dc34528937b429ee5ab7bd1', '048300', null, '陵川县', '24', '陵川县', '140524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6392c7f3349c4c9183a810a92afa7191', '39513e1f4dc34528937b429ee5ab7bd1', '048000', null, '泽州县', '25', '泽州县', '140525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e609b4dcad2f42a1ae41392bb3e3a677', '39513e1f4dc34528937b429ee5ab7bd1', '046700', null, '高平市', '81', '高平市', '140581', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('de82f836f82d4f3e81cd3d27b7130ebe', '3a78300165d5408f878939f11f57fb8e', '038500', null, '市辖区', '01', '市辖区', '140601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('29ad4bf32fe94f50b0386566c161bc6f', '3a78300165d5408f878939f11f57fb8e', '038500', null, '朔城区', '02', '朔城区', '140602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('964d4dd50bef48c9b62c8981ec6d9336', '3a78300165d5408f878939f11f57fb8e', '038500', null, '平鲁区', '03', '平鲁区', '140603', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('095e5ac6a2454a829f35e53e41c6c05e', '3a78300165d5408f878939f11f57fb8e', '038400', null, '山阴县', '21', '山阴县', '140621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7fedf45a4199497e8518c58c43a2969a', '3a78300165d5408f878939f11f57fb8e', '037600', null, '应县', '22', '应县', '140622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('861787f236d94d47b2b6b3568ec6abbc', '3a78300165d5408f878939f11f57fb8e', '037200', null, '右玉县', '23', '右玉县', '140623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('29ffe65544ac4df2b6c67991d4766b74', '3a78300165d5408f878939f11f57fb8e', '038300', null, '怀仁县', '24', '怀仁县', '140624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9b4d258586794478a38e9f56124cccaf', '38ee852f7125442d8c90540ecf8fbfcc', '030600', null, '市辖区', '01', '市辖区', '140701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6e174e6bbfd644839b0b86108f223920', '38ee852f7125442d8c90540ecf8fbfcc', '030600', null, '榆次区', '02', '榆次区', '140702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5bb5cafc0d4c48dda83c229ca1650c54', '38ee852f7125442d8c90540ecf8fbfcc', '031800', null, '榆社县', '21', '榆社县', '140721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('15a4e461220b4b8c9b87f321046048c4', '38ee852f7125442d8c90540ecf8fbfcc', '032600', null, '左权县', '22', '左权县', '140722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('31c9c37439e249b38a2a83daadcb87b6', '38ee852f7125442d8c90540ecf8fbfcc', '032700', null, '和顺县', '23', '和顺县', '140723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aaa6b533af274bf6a4a2321dc02a1030', 'dc525fdeeb4d4d4a93e1a8ee410cbb15', '010000', null, '玉泉区', '04', '玉泉区', '150104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('83e171d48a9b4a81907b3d79bb64508e', 'dc525fdeeb4d4d4a93e1a8ee410cbb15', '010000', null, '赛罕区', '05', '赛罕区', '150105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('947d71e5a72f4f7e8e826fc80d1be96a', 'dc525fdeeb4d4d4a93e1a8ee410cbb15', '010100', null, '土默特左旗', '21', '土默特左旗', '150121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9d611d0af77f4c88afb41aae6cb753cd', 'dc525fdeeb4d4d4a93e1a8ee410cbb15', '010200', null, '托克托县', '22', '托克托县', '150122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dcad9dad0aa6403aa4aab785d87f5bbb', 'dc525fdeeb4d4d4a93e1a8ee410cbb15', '011500', null, '和林格尔县', '23', '和林格尔县', '150123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('846f95f34462486e99640049a6c1b102', 'dc525fdeeb4d4d4a93e1a8ee410cbb15', '011600', null, '清水河县', '24', '清水河县', '150124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fe36ca85253f4f1b81bcb5d783185a0f', 'dc525fdeeb4d4d4a93e1a8ee410cbb15', '011700', null, '武川县', '25', '武川县', '150125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e9c7c81df00c446c8150affcd854a394', 'f52d20e8efa14e458b7e12d803073951', '014000', null, '市辖区', '01', '市辖区', '150201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b8c1640596cc41558ea91fadc480896b', 'f52d20e8efa14e458b7e12d803073951', '014000', null, '东河区', '02', '东河区', '150202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d1f06bab5948465b8c36c8458dbde44f', 'f52d20e8efa14e458b7e12d803073951', '014000', null, '昆都仑区', '03', '昆都仑区', '150203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('412e5b8438b24a35b64646ceccacc5bb', 'f52d20e8efa14e458b7e12d803073951', '014000', null, '青山区', '04', '青山区', '150204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('62b213d6aef04e55b0691f2d8fe3506f', 'f52d20e8efa14e458b7e12d803073951', '014000', null, '石拐区', '05', '石拐区', '150205', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2cc76515069745b6892ecafbe421f4d3', 'f52d20e8efa14e458b7e12d803073951', '014000', null, '白云矿区', '06', '白云矿区', '150206', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('45da2347afce4edcb070dcc837a485cd', 'f52d20e8efa14e458b7e12d803073951', '014000', null, '九原区', '07', '九原区', '150207', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('044b759c45bb4ea897ebe489d5e272c1', 'f52d20e8efa14e458b7e12d803073951', '014100', null, '土默特右旗', '21', '土默特右旗', '150221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('08d20aff6dba4304994e67687bc1c7e7', 'f52d20e8efa14e458b7e12d803073951', '014200', null, '固阳县', '22', '固阳县', '150222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('72650270e2df4222806faca054cbffb0', 'f52d20e8efa14e458b7e12d803073951', '014500', null, '达尔罕茂明安联合旗', '23', '达尔罕茂明安联合旗', '150223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('96dc4a9b168342adb83c0dc42cb66087', '746ab0b6b0974a89b45cde14f80c15be', '016000', null, '市辖区', '01', '市辖区', '150301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fa0577b49c6c45c7a1bad3139917c246', '746ab0b6b0974a89b45cde14f80c15be', '016000', null, '海勃湾区', '02', '海勃湾区', '150302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bddd42d9a2c9480a8f74688e98b40e18', '746ab0b6b0974a89b45cde14f80c15be', '016000', null, '海南区', '03', '海南区', '150303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a056db900e15428089631ac67ebd0005', '746ab0b6b0974a89b45cde14f80c15be', '016000', null, '乌达区', '04', '乌达区', '150304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3c9c215df86a40b0b1ef5ed0b1c06302', 'd740c573976d40e880ce13ec316fdda9', '024000', null, '市辖区', '01', '市辖区', '150401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9a7d4908393643eba3d2423fd5507a02', 'b1661da6929548f58fc4ac41d14d2b89', '055450', null, '柏乡县', '24', '柏乡县', '130524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b73c6dad6de342b2b2bd67c778e4235f', 'b34159526635417eac1df82dd9c7859b', '272000', null, '兖州市', '82', '兖州市', '370882', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8b4428f9c6ce40699e6cd287de3ef590', 'b34159526635417eac1df82dd9c7859b', '273500', null, '邹城市', '83', '邹城市', '370883', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fabd48dbec2040df8a071f44875d149b', 'f04b7fdbaab14550914ec25ef9299498', '271000', null, '市辖区', '01', '市辖区', '370901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6bde0d56455a4955bf84eeb603fe7267', 'f04b7fdbaab14550914ec25ef9299498', '271000', null, '泰山区', '02', '泰山区', '370902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2a160fecd3a5457eb3614e1bb98ca792', 'f04b7fdbaab14550914ec25ef9299498', '271000', null, '岱岳区', '03', '岱岳区', '370903', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c329858962344f38bd22b85cdaf57d95', 'f04b7fdbaab14550914ec25ef9299498', '271400', null, '宁阳县', '21', '宁阳县', '370921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fd958ed79f7a4601bec87253ac51f7ee', 'f04b7fdbaab14550914ec25ef9299498', '271500', null, '东平县', '23', '东平县', '370923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8573632193fa4f3c91f79bd623ca1105', 'f04b7fdbaab14550914ec25ef9299498', '271200', null, '新泰市', '82', '新泰市', '370982', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2a682dc2fea8437b840f91ca5b0e7308', 'f04b7fdbaab14550914ec25ef9299498', '271600', null, '肥城市', '83', '肥城市', '370983', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6360f3f5b2694f31887554e48beb3701', 'a39d0fc8049d4c8e8ac862df4bbb7ebc', '264000', null, '市辖区', '01', '市辖区', '371001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ead14d9b549843cc82d4bff538dd79c4', 'a39d0fc8049d4c8e8ac862df4bbb7ebc', '264200', null, '环翠区', '02', '环翠区', '371002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f95df306d9bd48a5b72474ebe9085760', 'a39d0fc8049d4c8e8ac862df4bbb7ebc', '264400', null, '文登市', '81', '文登市', '371081', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3de8adb9eea84ea4b1f394abada07e15', 'a39d0fc8049d4c8e8ac862df4bbb7ebc', '264300', null, '荣成市', '82', '荣成市', '371082', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('67e216b4da924e48931982a998793943', 'a39d0fc8049d4c8e8ac862df4bbb7ebc', '264500', null, '乳山市', '83', '乳山市', '371083', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cf222d85cdb44339a2e93a8a5d887064', '3344436933104790acb9de9e63a859e9', '276800', null, '市辖区', '01', '市辖区', '371101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('74b01b66ca0344c09a9eea07f14f0bba', '3344436933104790acb9de9e63a859e9', '276800', null, '东港区', '02', '东港区', '371102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9a717bbf6c754b43a14014e11912f2d9', '3344436933104790acb9de9e63a859e9', '276800', null, '岚山区', '03', '岚山区', '371103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('650a30c0bc27482d9080a061a745b469', '3344436933104790acb9de9e63a859e9', '262300', null, '五莲县', '21', '五莲县', '371121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ae130d4713b24c8b8b61491684ed7de1', '3344436933104790acb9de9e63a859e9', '276500', null, '莒县', '22', '莒县', '371122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4fb0e96d617f4441acb2d5539a338c26', '7844d926e0c94aeca55889ee6ede41d8', '271100', null, '市辖区', '01', '市辖区', '371201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f9f2a49bfbc446d8a921ee31056444ad', '7844d926e0c94aeca55889ee6ede41d8', '271100', null, '莱城区', '02', '莱城区', '371202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c0e358db08404c09ad57713bebe86b2d', '7844d926e0c94aeca55889ee6ede41d8', '271100', null, '钢城区', '03', '钢城区', '371203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('02fae101a73d4633801309b6f4e1aa65', 'ef87eb2c68254dda8ded0308e20e4dac', '276000', null, '市辖区', '01', '市辖区', '371301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('473a3ae4601b49249a3dcfc5110a2dbf', 'ef87eb2c68254dda8ded0308e20e4dac', '276000', null, '兰山区', '02', '兰山区', '371302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('10b2650e10d347fab62c94e946e3f2b2', 'ef87eb2c68254dda8ded0308e20e4dac', '276000', null, '罗庄区', '11', '罗庄区', '371311', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4b166e2e03d544bd9673bfb5541189cc', 'ef87eb2c68254dda8ded0308e20e4dac', '276000', null, '河东区', '12', '河东区', '371312', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6bd8dcb9e2f84d66be5738f89786e980', 'ef87eb2c68254dda8ded0308e20e4dac', '276300', null, '沂南县', '21', '沂南县', '371321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e19c4b3f237b4c0795bb4cf1b7f22b74', 'ef87eb2c68254dda8ded0308e20e4dac', '276100', null, '郯城县', '22', '郯城县', '371322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('91bf7b227c3f4bd084cf312d14ce1ae4', 'ef87eb2c68254dda8ded0308e20e4dac', '276400', null, '沂水县', '23', '沂水县', '371323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0700732fb342431c871d64c14b95d7d6', 'ef87eb2c68254dda8ded0308e20e4dac', '277700', null, '苍山县', '24', '苍山县', '371324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e367aef2581e4bc48ad8ad2da5f077dc', 'ef87eb2c68254dda8ded0308e20e4dac', '273400', null, '费县', '25', '费县', '371325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('44eb7202423c4071b76fda37a1672ae3', 'ef87eb2c68254dda8ded0308e20e4dac', '273300', null, '平邑县', '26', '平邑县', '371326', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('90e584032fe54f95acc6785e4791acfe', 'ef87eb2c68254dda8ded0308e20e4dac', '276600', null, '莒南县', '27', '莒南县', '371327', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b8c4f1db0c9648ce853b351d83befac4', 'ef87eb2c68254dda8ded0308e20e4dac', '276200', null, '蒙阴县', '28', '蒙阴县', '371328', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8dbf259716e74774a17b75d11e5c2e63', 'ef87eb2c68254dda8ded0308e20e4dac', '276700', null, '临沭县', '29', '临沭县', '371329', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9019261eac9241a2b9d10d2b9b5cd466', '0dc3aad6447a4a92818dc72d59bb1a44', '253000', null, '市辖区', '01', '市辖区', '371401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cf33d24f3aef4a00aba7cdfa86e5840c', '0dc3aad6447a4a92818dc72d59bb1a44', '253000', null, '德城区', '02', '德城区', '371402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b2e74ae857b34787a20fc1b0f4830d2f', '0dc3aad6447a4a92818dc72d59bb1a44', '253500', null, '陵县', '21', '陵县', '371421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2e969a1fc3784c39aed85e8b50838565', '0dc3aad6447a4a92818dc72d59bb1a44', '253400', null, '宁津县', '22', '宁津县', '371422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('937df3535b6b4465a94ae1b1b17cedc5', '0dc3aad6447a4a92818dc72d59bb1a44', '253700', null, '庆云县', '23', '庆云县', '371423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ef2d68912d884895b7c116e41883e3df', '0dc3aad6447a4a92818dc72d59bb1a44', '251500', null, '临邑县', '24', '临邑县', '371424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ee830df5504344c9bbf04d1b6789066c', '0dc3aad6447a4a92818dc72d59bb1a44', '251100', null, '齐河县', '25', '齐河县', '371425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('be512cdb35c9472eb29f7f3990d60d4e', '0dc3aad6447a4a92818dc72d59bb1a44', '253100', null, '平原县', '26', '平原县', '371426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('371b8a1c806c486ba8d273e7bf2c7470', '0dc3aad6447a4a92818dc72d59bb1a44', '253200', null, '夏津县', '27', '夏津县', '371427', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c3bb20246b5d44f5a16bcd64d573cf90', '0dc3aad6447a4a92818dc72d59bb1a44', '253300', null, '武城县', '28', '武城县', '371428', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d970cf05f8284d00bbc44a746598ea31', '0dc3aad6447a4a92818dc72d59bb1a44', '253600', null, '乐陵市', '81', '乐陵市', '371481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3a154a70dcd9470d92a19219264a80c6', '38ee852f7125442d8c90540ecf8fbfcc', '045300', null, '昔阳县', '24', '昔阳县', '140724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2ecd0ebc4a93434d8922f494c908bbfc', '38ee852f7125442d8c90540ecf8fbfcc', '031700', null, '寿阳县', '25', '寿阳县', '140725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c906c5e504fb4c1fa697cf7fecd99129', '38ee852f7125442d8c90540ecf8fbfcc', '030800', null, '太谷县', '26', '太谷县', '140726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0e687bfcebac4ec29fcf2642d563a3f9', '38ee852f7125442d8c90540ecf8fbfcc', '030900', null, '祁县', '27', '祁县', '140727', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7613fc9781ab41ecb7f8dab60b0b2398', '38ee852f7125442d8c90540ecf8fbfcc', '031100', null, '平遥县', '28', '平遥县', '140728', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('67d8a0c0aae94e598a53d74db3742bd4', '38ee852f7125442d8c90540ecf8fbfcc', '031300', null, '灵石县', '29', '灵石县', '140729', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bc19c3dfe5bb4c7fb1b6745e44311a44', '38ee852f7125442d8c90540ecf8fbfcc', '031200', null, '介休市', '81', '介休市', '140781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('12bbce2056c04be99dd6b7f5024deb87', 'a38ecbcdd84a434280f6a45b609558ad', '044000', null, '市辖区', '01', '市辖区', '140801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cee8d97a190a4514b92ad9b02ddbdbe7', 'a38ecbcdd84a434280f6a45b609558ad', '044000', null, '盐湖区', '02', '盐湖区', '140802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('56746a1c830f425ea23fb2fff5b38c03', 'a38ecbcdd84a434280f6a45b609558ad', '044100', null, '临猗县', '21', '临猗县', '140821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('49ce98edec3c4c4d9d6adb1e20655ae3', 'a38ecbcdd84a434280f6a45b609558ad', '044200', null, '万荣县', '22', '万荣县', '140822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b9025e12217f4f1b8e158077a731ab2f', 'a38ecbcdd84a434280f6a45b609558ad', '043800', null, '闻喜县', '23', '闻喜县', '140823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f197e058522043779d7f0065b3c6ff4e', 'a38ecbcdd84a434280f6a45b609558ad', '043200', null, '稷山县', '24', '稷山县', '140824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d04766511b7e4c749f4012c8072ad7d8', 'a38ecbcdd84a434280f6a45b609558ad', '043100', null, '新绛县', '25', '新绛县', '140825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f62b3ab567674ef79481bd0f3528e7b2', 'a38ecbcdd84a434280f6a45b609558ad', '043600', null, '绛县', '26', '绛县', '140826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8ed3b0fdfaa249ab880986d10a89adfa', 'a38ecbcdd84a434280f6a45b609558ad', '043700', null, '垣曲县', '27', '垣曲县', '140827', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aa4929ccd44c4f59905aa0bcdb7041d9', 'a38ecbcdd84a434280f6a45b609558ad', '044400', null, '夏县', '28', '夏县', '140828', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4a1ab9bd7026481181d4c3854047c564', 'a38ecbcdd84a434280f6a45b609558ad', '044300', null, '平陆县', '29', '平陆县', '140829', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6718d9cf2c7d42e9bd5d2c76ce493d81', 'a38ecbcdd84a434280f6a45b609558ad', '044600', null, '芮城县', '30', '芮城县', '140830', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8ee8ffd5f71e4b75931e6cf85bb79b3a', 'a38ecbcdd84a434280f6a45b609558ad', '044500', null, '永济市', '81', '永济市', '140881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4b20cc3bdf7d43eea6d930008bf08b1f', 'a38ecbcdd84a434280f6a45b609558ad', '043300', null, '河津市', '82', '河津市', '140882', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2abcac830dbe4c65b57919f07b9a86c3', '264018e21b854c78866dd48622f2d326', '034000', null, '市辖区', '01', '市辖区', '140901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f4a7e8d9a3c4501a25530c3325996c9', '264018e21b854c78866dd48622f2d326', '034000', null, '忻府区', '02', '忻府区', '140902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f2ad0b5ac4b34677bb40688f2c21a89e', '264018e21b854c78866dd48622f2d326', '035400', null, '定襄县', '21', '定襄县', '140921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('46ebeee4199448b384cc820ad8eb0656', '264018e21b854c78866dd48622f2d326', '035500', null, '五台县', '22', '五台县', '140922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b50d5d44171d484eb2017c598bd0ec6b', '264018e21b854c78866dd48622f2d326', '034200', null, '代县', '23', '代县', '140923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('302f606adff6466ab441b5dbc007c85c', '264018e21b854c78866dd48622f2d326', '034300', null, '繁峙县', '24', '繁峙县', '140924', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('48e7437afbfa4b9384056edd6c4f54cc', '264018e21b854c78866dd48622f2d326', '035100', null, '静乐县', '26', '静乐县', '140926', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('620d1ea79eff4212b5f044920225893a', '264018e21b854c78866dd48622f2d326', '036100', null, '神池县', '27', '神池县', '140927', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3abd24f7cbff4b21838af30ee9ce50c9', '264018e21b854c78866dd48622f2d326', '036200', null, '五寨县', '28', '五寨县', '140928', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('61ba01eecce44de686cf7e0e926d87fb', '264018e21b854c78866dd48622f2d326', '036300', null, '岢岚县', '29', '岢岚县', '140929', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('913cff4f1eb14c0397aa13368b8e9d4d', '264018e21b854c78866dd48622f2d326', '036500', null, '河曲县', '30', '河曲县', '140930', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1cf81dfc77874b9d9553b0ee34abb1aa', '264018e21b854c78866dd48622f2d326', '036600', null, '保德县', '31', '保德县', '140931', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8f46a7df564f449ead83ff990c705853', '264018e21b854c78866dd48622f2d326', '036400', null, '偏关县', '32', '偏关县', '140932', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6835bd2ffd7a4c8ab5af6c4b0c41bfdb', '264018e21b854c78866dd48622f2d326', '034100', null, '原平市', '81', '原平市', '140981', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('af32776d0bc24af3bccfb7e711380eb7', 'f01f08e264f240c78e12fea9d8d2c41a', '041000', null, '市辖区', '01', '市辖区', '141001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5ef3d1b138c54fc8becb54d608c0c4dd', 'f01f08e264f240c78e12fea9d8d2c41a', '041000', null, '尧都区', '02', '尧都区', '141002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('30aaf52391964371878d5196ae135070', 'f01f08e264f240c78e12fea9d8d2c41a', '043400', null, '曲沃县', '21', '曲沃县', '141021', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('24dac856bfb744868e887b678b7fe36b', 'f01f08e264f240c78e12fea9d8d2c41a', '043500', null, '翼城县', '22', '翼城县', '141022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a19192a013df4e8490970f35b0a0e0b3', 'f01f08e264f240c78e12fea9d8d2c41a', '041500', null, '襄汾县', '23', '襄汾县', '141023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('55e37726dc7b4ec08e97145d4a04059b', 'f01f08e264f240c78e12fea9d8d2c41a', '031600', null, '洪洞县', '24', '洪洞县', '141024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5da54d06a34a4e6ea62a1492d9d7d0d6', 'f01f08e264f240c78e12fea9d8d2c41a', '042400', null, '古县', '25', '古县', '141025', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('352ee25e1bd345da9e9f8614197bc553', 'f01f08e264f240c78e12fea9d8d2c41a', '042500', null, '安泽县', '26', '安泽县', '141026', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('12545d65f1404790875c3a9769a4eedb', 'f01f08e264f240c78e12fea9d8d2c41a', '042600', null, '浮山县', '27', '浮山县', '141027', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c1190ff09d0249c88a9bd1b55569a8b9', 'f01f08e264f240c78e12fea9d8d2c41a', '042200', null, '吉县', '28', '吉县', '141028', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0f5b28d122e24e18a26aaf3100b60ec2', 'f01f08e264f240c78e12fea9d8d2c41a', '042100', null, '乡宁县', '29', '乡宁县', '141029', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aa55af7cbd994a63afee28d5c5fcde0c', 'f01f08e264f240c78e12fea9d8d2c41a', '042300', null, '大宁县', '30', '大宁县', '141030', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a04c003dcffe43388aedaf35a87589aa', 'f01f08e264f240c78e12fea9d8d2c41a', '041300', null, '隰县', '31', '隰县', '141031', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eb6222aef95447ae9f93810e60ea15f0', 'f01f08e264f240c78e12fea9d8d2c41a', '041400', null, '永和县', '32', '永和县', '141032', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1ad35eb650bb43ba97b876794178bb89', 'f01f08e264f240c78e12fea9d8d2c41a', '041200', null, '蒲县', '33', '蒲县', '141033', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5609a41f5211452c8f33c58b80e5834e', 'f01f08e264f240c78e12fea9d8d2c41a', '031500', null, '汾西县', '34', '汾西县', '141034', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('19952609fd3040d2bde9bdb48e563f78', 'f01f08e264f240c78e12fea9d8d2c41a', '043000', null, '侯马市', '81', '侯马市', '141081', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e50b42dd754c41bfb492f2c94e2db831', 'f01f08e264f240c78e12fea9d8d2c41a', '031400', null, '霍州市', '82', '霍州市', '141082', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6811640211f945899d6559880f28eecf', '246df1df62e141c68397e33cc08f5adf', '033000', null, '市辖区', '01', '市辖区', '141101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('581367ab9f4947cbaa6debb7cbc0b08a', '246df1df62e141c68397e33cc08f5adf', '033000', null, '离石区', '02', '离石区', '141102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4c69c7e1f8394887b30914b60f9e6cc0', '246df1df62e141c68397e33cc08f5adf', '032100', null, '文水县', '21', '文水县', '141121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('adbde55b2c614c7ab30441d21442e357', '246df1df62e141c68397e33cc08f5adf', '030500', null, '交城县', '22', '交城县', '141122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5d43561218d844cc9d100cf353b418ff', '246df1df62e141c68397e33cc08f5adf', '035300', null, '兴县', '23', '兴县', '141123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b0351e0129844cc6a25ebc36cef08b41', '246df1df62e141c68397e33cc08f5adf', '033200', null, '临县', '24', '临县', '141124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('504ee72aacaf47febd87248fdff03da2', '246df1df62e141c68397e33cc08f5adf', '033300', null, '柳林县', '25', '柳林县', '141125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('402fa8a3daee435993cfa4e9a365267b', '246df1df62e141c68397e33cc08f5adf', '032500', null, '石楼县', '26', '石楼县', '141126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('82cc48b7b5c749e78f3896982c85d014', '246df1df62e141c68397e33cc08f5adf', '035200', null, '岚县', '27', '岚县', '141127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bcd71751a3924b3ea0547f493bf5f199', '246df1df62e141c68397e33cc08f5adf', '033100', null, '方山县', '28', '方山县', '141128', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('17ff75b15f244604ba7738af63dd0300', '246df1df62e141c68397e33cc08f5adf', '033400', null, '中阳县', '29', '中阳县', '141129', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dd9015f7fb7a4e9c8cbf01105454935b', '246df1df62e141c68397e33cc08f5adf', '032400', null, '交口县', '30', '交口县', '141130', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('650313fbb4444d45b7328541feff8622', '246df1df62e141c68397e33cc08f5adf', '032300', null, '孝义市', '81', '孝义市', '141181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('14d02bbe448b462583def46663277f36', '246df1df62e141c68397e33cc08f5adf', '032200', null, '汾阳市', '82', '汾阳市', '141182', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2b9d372059984c2eb2b8fb3e187d98fc', 'dc525fdeeb4d4d4a93e1a8ee410cbb15', '010000', null, '市辖区', '01', '市辖区', '150101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('079b17fb41cb4f6bb9950bbd3c1320aa', 'dc525fdeeb4d4d4a93e1a8ee410cbb15', '010000', null, '新城区', '02', '新城区', '150102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a9aef79fde404bca9158ad2869f1a6c1', 'dc525fdeeb4d4d4a93e1a8ee410cbb15', '010000', null, '回民区', '03', '回民区', '150103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('baa17a588482457a8549ea1fbfb118cc', 'cbf57834e6314708abbbb577e400e698', '050500', null, '灵寿县', '26', '灵寿县', '130126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a0dac0b1b7ff4e12be73c135e500dae2', 'cbf57834e6314708abbbb577e400e698', '051330', null, '高邑县', '27', '高邑县', '130127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eac50389544743c290a2355c952aadc6', 'cbf57834e6314708abbbb577e400e698', '052500', null, '深泽县', '28', '深泽县', '130128', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bbdeae76c7ed4e31898772a2c2c50f9f', 'cbf57834e6314708abbbb577e400e698', '051230', null, '赞皇县', '29', '赞皇县', '130129', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('971de97bfb714c6aab74d68540a8a0eb', 'cbf57834e6314708abbbb577e400e698', '052400', null, '无极县', '30', '无极县', '130130', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f21321500c3f4dde95da60b3f0dc183c', 'cbf57834e6314708abbbb577e400e698', '050400', null, '平山县', '31', '平山县', '130131', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b47ad47df3144017b85aff600426c8dc', 'cbf57834e6314708abbbb577e400e698', '051130', null, '元氏县', '32', '元氏县', '130132', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('115ff955eb24492f9e6440fe3419f41b', 'cbf57834e6314708abbbb577e400e698', '051530', null, '赵县', '33', '赵县', '130133', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('90ee9675129d4ff18ff6632591b2d3f3', 'cbf57834e6314708abbbb577e400e698', '052300', null, '辛集市', '81', '辛集市', '130181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('91a6887d2b9b4b9993d4ec23a8e76261', 'cbf57834e6314708abbbb577e400e698', '052160', null, '藁城市', '82', '藁城市', '130182', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1a9417dd48704efc87ced3a5daff4796', 'cbf57834e6314708abbbb577e400e698', '052200', null, '晋州市', '83', '晋州市', '130183', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a949fc32634a49e7842019cd2d173920', 'cbf57834e6314708abbbb577e400e698', '050700', null, '新乐市', '84', '新乐市', '130184', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9d077d035f2f456fb59a6f1954b136ae', 'cbf57834e6314708abbbb577e400e698', '050200', null, '鹿泉市', '85', '鹿泉市', '130185', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3a1b44126800481490755c695d4f7f69', 'eb9674438d3b4d568aa8119ea8881a91', '063000', null, '市辖区', '01', '市辖区', '130201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e8a4facc75cc40638ce426a5bdc1d8e0', 'eb9674438d3b4d568aa8119ea8881a91', '063000', null, '路南区', '02', '路南区', '130202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f18f84aedec4f0db65971d173afc6bd', 'eb9674438d3b4d568aa8119ea8881a91', '063000', null, '路北区', '03', '路北区', '130203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('952f588c28b94c97a53850135cce67fb', 'eb9674438d3b4d568aa8119ea8881a91', '063000', null, '古冶区', '04', '古冶区', '130204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('57fa9d89e9e8453b87458652176c5500', 'eb9674438d3b4d568aa8119ea8881a91', '063000', null, '开平区', '05', '开平区', '130205', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3498e9226eea41a49163397b63b1a0a6', 'eb9674438d3b4d568aa8119ea8881a91', '063300', null, '丰南区', '07', '丰南区', '130207', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9056dd864c07498caea12d79782757bf', 'eb9674438d3b4d568aa8119ea8881a91', '063000', null, '丰润区', '08', '丰润区', '130208', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1761ceef11a846b8adb5c66dc60a7b90', 'eb9674438d3b4d568aa8119ea8881a91', '063700', null, '滦县', '23', '滦县', '130223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ec397fdb9083406e9d38fdeef2773081', 'eb9674438d3b4d568aa8119ea8881a91', '063500', null, '滦南县', '24', '滦南县', '130224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('84191657686f4a58b62477101d4f2148', 'eb9674438d3b4d568aa8119ea8881a91', '063600', null, '乐亭县', '25', '乐亭县', '130225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('61ffbdcdad8e4c64ab34c81124c6b657', 'eb9674438d3b4d568aa8119ea8881a91', '064300', null, '迁西县', '27', '迁西县', '130227', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('73344bc43f3443d8ad8fa5ac4f66bfba', 'eb9674438d3b4d568aa8119ea8881a91', '064100', null, '玉田县', '29', '玉田县', '130229', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ddebf5a2889646c2878033c3679ea706', 'eb9674438d3b4d568aa8119ea8881a91', '063200', null, '唐海县', '30', '唐海县', '130230', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0878b2cfd8f34d119e5187a768602b3c', 'eb9674438d3b4d568aa8119ea8881a91', '064200', null, '遵化市', '81', '遵化市', '130281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fe51187e39cd4d6490ddf3df6de5b7d6', 'eb9674438d3b4d568aa8119ea8881a91', '064400', null, '迁安市', '83', '迁安市', '130283', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e33b11f79a674b55938bc232476ec0ed', '0c198b04fac8436fbd64f504af86ed74', '066000', null, '市辖区', '01', '市辖区', '130301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('83100b9338f643be91d6d7450eef83f2', '0c198b04fac8436fbd64f504af86ed74', '066000', null, '海港区', '02', '海港区', '130302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fafe9d5da9fc40ff859a4db253c2785a', '0c198b04fac8436fbd64f504af86ed74', '066200', null, '山海关区', '03', '山海关区', '130303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0ecda5b707034efbbf2fc5afba80da2b', '0c198b04fac8436fbd64f504af86ed74', '066100', null, '北戴河区', '04', '北戴河区', '130304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0d4434be5e9c440dbe20e64f635bf624', '0c198b04fac8436fbd64f504af86ed74', '066500', null, '青龙满族自治县', '21', '青龙满族自治县', '130321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('56a689958f6b4c8b995b059372881cef', '0c198b04fac8436fbd64f504af86ed74', '066600', null, '昌黎县', '22', '昌黎县', '130322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('11cc57151d174c4a856865c9cbac6180', '0c198b04fac8436fbd64f504af86ed74', '066300', null, '抚宁县', '23', '抚宁县', '130323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1c3fd33ee6b14bc4b68280a0639744c4', '0c198b04fac8436fbd64f504af86ed74', '066400', null, '卢龙县', '24', '卢龙县', '130324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e88c1dfa2b034ffeacac8d0e7093808b', 'c6db83b3a6b24136bffb63610712f5de', '056000', null, '市辖区', '01', '市辖区', '130401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4f56a0b05576432f9d57814c943e7bf6', 'c6db83b3a6b24136bffb63610712f5de', '056000', null, '邯山区', '02', '邯山区', '130402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4c4e3bcacce940458c44c667265ed96d', 'c6db83b3a6b24136bffb63610712f5de', '056000', null, '丛台区', '03', '丛台区', '130403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('79b59cb7c9db41c399fe26b4356c3c4c', 'c6db83b3a6b24136bffb63610712f5de', '056000', null, '复兴区', '04', '复兴区', '130404', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a29a1f5383d245c098a150df498cc3cc', 'c6db83b3a6b24136bffb63610712f5de', '056200', null, '峰峰矿区', '06', '峰峰矿区', '130406', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('79ea42b462774142999854508ad3dd79', 'c6db83b3a6b24136bffb63610712f5de', '056000', null, '邯郸县', '21', '邯郸县', '130421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('31f7b481a00349348c990e642fb0c58c', 'c6db83b3a6b24136bffb63610712f5de', '056600', null, '临漳县', '23', '临漳县', '130423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7cd4ae18d98a47789d4542207c29cb21', 'c6db83b3a6b24136bffb63610712f5de', '056700', null, '成安县', '24', '成安县', '130424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b5499fe42541494ba756b398748219a4', 'c6db83b3a6b24136bffb63610712f5de', '056900', null, '大名县', '25', '大名县', '130425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b3fae10223b2438290f03dfc29630982', 'c6db83b3a6b24136bffb63610712f5de', '056400', null, '涉县', '26', '涉县', '130426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f51a7c73393240698debefbb8fd07981', 'c6db83b3a6b24136bffb63610712f5de', '056500', null, '磁县', '27', '磁县', '130427', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2840af9e8b784705a20cd1254e00fa3e', 'c6db83b3a6b24136bffb63610712f5de', '057550', null, '肥乡县', '28', '肥乡县', '130428', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2b0fb1ca2d8c40ba981a3233b323da89', 'c6db83b3a6b24136bffb63610712f5de', '057150', null, '永年县', '29', '永年县', '130429', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f119b8b1d0ed4c5eba42ba6f58289db2', 'c6db83b3a6b24136bffb63610712f5de', '057450', null, '邱县', '30', '邱县', '130430', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cd3b56e8175c4c51b10191a5a7f5ff53', 'c6db83b3a6b24136bffb63610712f5de', '057350', null, '鸡泽县', '31', '鸡泽县', '130431', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6149d8fca7854cf0955e99098527a900', 'c6db83b3a6b24136bffb63610712f5de', '057650', null, '广平县', '32', '广平县', '130432', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('39fb48cfc2b04f17bdf41dd17e22420a', 'c6db83b3a6b24136bffb63610712f5de', '057750', null, '馆陶县', '33', '馆陶县', '130433', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0f911fe820d3418dbd3e3455c98b7b88', 'c6db83b3a6b24136bffb63610712f5de', '056800', null, '魏县', '34', '魏县', '130434', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7187b8b1033e48fc9df00f991bdfdbff', 'c6db83b3a6b24136bffb63610712f5de', '057250', null, '曲周县', '35', '曲周县', '130435', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fc0faa8286604eb1828ed6d05807a845', 'c6db83b3a6b24136bffb63610712f5de', '056300', null, '武安市', '81', '武安市', '130481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('00ebb2441059466cbb9c1074dfe64c87', 'b1661da6929548f58fc4ac41d14d2b89', '054000', null, '市辖区', '01', '市辖区', '130501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('19933fd8681d46a888d2c483e5d3cb3a', 'b1661da6929548f58fc4ac41d14d2b89', '054000', null, '桥东区', '02', '桥东区', '130502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f443e4f903d34a55b54c01a71ae546e3', 'b1661da6929548f58fc4ac41d14d2b89', '054000', null, '桥西区', '03', '桥西区', '130503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0e6a53fa392a478d8fcecfc9ab26b79f', 'b1661da6929548f58fc4ac41d14d2b89', '054000', null, '邢台县', '21', '邢台县', '130521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('479ce1e593b647e3a4e19ed5e822a0db', 'b1661da6929548f58fc4ac41d14d2b89', '054300', null, '临城县', '22', '临城县', '130522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ec08f816e3fd4e9893ceebbc4b48f215', 'b1661da6929548f58fc4ac41d14d2b89', '054200', null, '内丘县', '23', '内丘县', '130523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('71705e5963b74a2aa26ee1c8035e3cd4', 'bd2d77f833b2472d8a828a90f402f861', '131300', null, '大安市', '82', '大安市', '220882', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a99a6e1e37444388bd37a30e2560f74e', 'd740c573976d40e880ce13ec316fdda9', '024000', null, '红山区', '02', '红山区', '150402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5bd9c996a097442daf7adb5a62437ccc', 'd740c573976d40e880ce13ec316fdda9', '024000', null, '元宝山区', '03', '元宝山区', '150403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7ba5fcf148844f0aa36b54f8d92f243b', 'd740c573976d40e880ce13ec316fdda9', '024000', null, '松山区', '04', '松山区', '150404', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('59e5792ffdab44c184a9d653b6be2928', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '岳阳市', '06', '岳阳市', '430600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d3589d39ff2453ba5f0cfc69cb129e5', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '常德市', '07', '常德市', '430700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0f4a3711d5f4424aabfb4f4be55050da', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '张家界市', '08', '张家界市', '430800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4ebefadf49c442bb86cd3047a05b1859', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '益阳市', '09', '益阳市', '430900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('73cb965eec364b56bd1f37da06615a45', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '郴州市', '10', '郴州市', '431000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fd915aadafda49b68d1cf622418a9f82', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '永州市', '11', '永州市', '431100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7b81bf0743fd447ebdf08758d3308330', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '怀化市', '12', '怀化市', '431200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('adcc2c768e274f2d89f802ea109c3235', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '娄底市', '13', '娄底市', '431300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0f23a4dca3524daabdae8f9e25604b96', '33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, '湘西土家族苗族自治州', '31', '湘西土家族苗族自治州', '433100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('74c34515a15e469e92d05c95aaca78ab', 'b51c615743e24581bf67975def934d06', null, null, '广州市', '01', '广州市', '440100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a7a5db86046e4359b593d5bb51806516', 'b51c615743e24581bf67975def934d06', null, null, '韶关市', '02', '韶关市', '440200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6a4a9d34b6904464805411c3d91a1313', 'b51c615743e24581bf67975def934d06', null, null, '深圳市', '03', '深圳市', '440300', null);
commit;
----prompt 500 records committed...
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fc52a64b6b3748229bd8f9afab749793', 'b51c615743e24581bf67975def934d06', null, null, '珠海市', '04', '珠海市', '440400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5fe5cbee4e394883b75404f0b700c38f', 'b51c615743e24581bf67975def934d06', null, null, '汕头市', '05', '汕头市', '440500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a12ecc146129443e9fd9fa29cdf3f4ec', 'b51c615743e24581bf67975def934d06', null, null, '佛山市', '06', '佛山市', '440600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aa148f66edba4d79a319608c3110200c', 'b51c615743e24581bf67975def934d06', null, null, '江门市', '07', '江门市', '440700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3a654d6fa00b41afbd9e9eaa5d123224', 'b51c615743e24581bf67975def934d06', null, null, '湛江市', '08', '湛江市', '440800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('af7ede8649de428e81c513d1ba57420d', 'b51c615743e24581bf67975def934d06', null, null, '茂名市', '09', '茂名市', '440900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6fed53cde91a4336b0b2023c9c7da06b', 'b51c615743e24581bf67975def934d06', null, null, '肇庆市', '12', '肇庆市', '441200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('42ed28a2d2cf4a0ab128fdba1486ba90', 'b51c615743e24581bf67975def934d06', null, null, '惠州市', '13', '惠州市', '441300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ab33919c65c7421e95b62e88c00a809e', 'b51c615743e24581bf67975def934d06', null, null, '梅州市', '14', '梅州市', '441400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bcc33574fca64b2c9936de8b2e69fa53', 'b51c615743e24581bf67975def934d06', null, null, '汕尾市', '15', '汕尾市', '441500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9ab8b8c02064408fb354679975276d42', 'b51c615743e24581bf67975def934d06', null, null, '河源市', '16', '河源市', '441600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2bd37a3d909f4620b756803efe2fa5da', 'b51c615743e24581bf67975def934d06', null, null, '阳江市', '17', '阳江市', '441700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b14f71ca712e4aea9fdb427384026a75', 'b51c615743e24581bf67975def934d06', null, null, '清远市', '18', '清远市', '441800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('131cd1bc6ab44780924b517a43ebccbb', 'b51c615743e24581bf67975def934d06', null, null, '潮州市', '51', '潮州市', '445100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('03a5d1e6c2c24023ba09c41ba51b7b94', 'b51c615743e24581bf67975def934d06', null, null, '揭阳市', '52', '揭阳市', '445200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('42db031cba074ff2a68b68b2eb36e043', 'b51c615743e24581bf67975def934d06', null, null, '云浮市', '53', '云浮市', '445300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9e986231263c41118f58c81e9d4cab3b', '47cf09ecda50413398cdf4afa27101e8', null, null, '南宁市', '01', '南宁市', '450100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3a8faee14d6a473493ddf5b00fe9eab7', '47cf09ecda50413398cdf4afa27101e8', null, null, '柳州市', '02', '柳州市', '450200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('87571143e8fd43b8b3aff17c93e3041b', '47cf09ecda50413398cdf4afa27101e8', null, null, '桂林市', '03', '桂林市', '450300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a9dc7c04401b43fc92297dfe7d331f81', '47cf09ecda50413398cdf4afa27101e8', null, null, '梧州市', '04', '梧州市', '450400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1f022fdf2fe84a96acc2b187e208d31b', '47cf09ecda50413398cdf4afa27101e8', null, null, '北海市', '05', '北海市', '450500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3ea02e362c824c1680a222ff06d7611b', '47cf09ecda50413398cdf4afa27101e8', null, null, '防城港市', '06', '防城港市', '450600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('330e2c8f1a1441dd8bee96e040e1ef7f', '47cf09ecda50413398cdf4afa27101e8', null, null, '钦州市', '07', '钦州市', '450700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c4e897a6a2174240baf29d7bfad235ba', '47cf09ecda50413398cdf4afa27101e8', null, null, '贵港市', '08', '贵港市', '450800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e420d3d39d12490ab67e5091b54bcdab', '47cf09ecda50413398cdf4afa27101e8', null, null, '玉林市', '09', '玉林市', '450900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5944b21cd62d4404bab999965db12d4a', '47cf09ecda50413398cdf4afa27101e8', null, null, '百色市', '10', '百色市', '451000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('94e911567a7647aebcaf864e4d2e0e59', '47cf09ecda50413398cdf4afa27101e8', null, null, '贺州市', '11', '贺州市', '451100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('241206b6912b4472bc71573bab0a2b1b', '47cf09ecda50413398cdf4afa27101e8', null, null, '河池市', '12', '河池市', '451200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a3b03952a36b474dbb441c665fab6913', '47cf09ecda50413398cdf4afa27101e8', null, null, '来宾市', '13', '来宾市', '451300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2e26f89fa8a54d59b4d85abfc42b1ebe', '47cf09ecda50413398cdf4afa27101e8', null, null, '崇左市', '14', '崇左市', '451400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('64a868e81b664b20b3f818bff115cf71', 'c87dbdbabac04801a83a8f7c8070235e', null, null, '海口市', '01', '海口市', '460100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e123506da0ff4e6fa019c8fceece5a0e', 'c87dbdbabac04801a83a8f7c8070235e', null, null, '三亚市', '02', '三亚市', '460200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('97727b55303e4938afa1eb316b3d58cb', 'c87dbdbabac04801a83a8f7c8070235e', null, null, '省直辖县级行政单位', '90', '省直辖县级行政单位', '469000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b980cca7c3e04419a36d045d0745ad97', '005b3f1def644d8aae1231bb6c7499d5', null, null, '重庆市', '01', '重庆市', '500100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('08cb7a128990421a99d0528514ebe24c', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '成都市', '01', '成都市', '510100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c119b8ebe0464e6e8535bca0598e13eb', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '自贡市', '03', '自贡市', '510300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e416c82c26c848c1a9532943280f7738', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '攀枝花市', '04', '攀枝花市', '510400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('988dcd4876d041d190834258b0f2a8d4', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '泸州市', '05', '泸州市', '510500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c87b68c64f854490888b630fbcbd0b15', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '德阳市', '06', '德阳市', '510600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('48fb275bc9004d74aeb5ff42510ade11', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '绵阳市', '07', '绵阳市', '510700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9d9c7883ebbe4190abfa32a3b2e001d6', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '广元市', '08', '广元市', '510800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aded03dddeff43778b7b5b6f0c070a56', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '遂宁市', '09', '遂宁市', '510900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('20cbbf557ea1420a960c6e9ce04de1e3', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '内江市', '10', '内江市', '511000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('69bd3ecc0d324699ba96fe24b0356639', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '乐山市', '11', '乐山市', '511100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7652787b72664f18bbfd327f363fb188', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '南充市', '13', '南充市', '511300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8800e3a2c9d24c758e8ef1eea71aa8a4', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '眉山市', '14', '眉山市', '511400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('199ea73f863b4550982e14d759a1ad27', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '宜宾市', '15', '宜宾市', '511500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bbf2f2bcf0ec4c41b319bffbcfb51941', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '广安市', '16', '广安市', '511600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c29af6ded1b64cbea4cd6a79fa153e07', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '达州市', '17', '达州市', '511700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('87081bc7c2b44b4db666df033cb09e88', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '雅安市', '18', '雅安市', '511800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b6f3e780164d4fd8b64fbe128d7ca50d', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '巴中市', '19', '巴中市', '511900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b467acdde0f64c6ba0739ba8b386215d', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '资阳市', '20', '资阳市', '512000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('405b1da4465e49088c798360db70c15b', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '阿坝藏族羌族自治州', '32', '阿坝藏族羌族自治州', '513200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e2b4b10999ff41bbafb98f60bb00c0ae', '79c341fcd1fe4b91a5d97cbb1a070068', null, null, '甘孜藏族自治州', '33', '甘孜藏族自治州', '513300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('70c6e0c0b2e0451f99b6b8986f13ca07', '862442793c45460da8884117d171c83d', null, null, '银川市', '01', '银川市', '640100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d211795dd1e6415294416b8d85e1ca3d', '862442793c45460da8884117d171c83d', null, null, '石嘴山市', '02', '石嘴山市', '640200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c12b062dc20e422ca8b66e9578738b74', '862442793c45460da8884117d171c83d', null, null, '吴忠市', '03', '吴忠市', '640300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('48a58b66b9394f1aa364c352ba1da9d3', '862442793c45460da8884117d171c83d', null, null, '固原市', '04', '固原市', '640400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('462784740efd4b7787f04c3ca0411c64', '862442793c45460da8884117d171c83d', null, null, '中卫市', '05', '中卫市', '640500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1bcb916fa3f64e599569392aaaf05b7a', '2f37fad27ab344108f4da87d9d21e767', null, null, '乌鲁木齐市', '01', '乌鲁木齐市', '650100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1a1c0daee49a410abe7540db0be7088a', '2f37fad27ab344108f4da87d9d21e767', null, null, '克拉玛依市', '02', '克拉玛依市', '650200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d7c967cb651462cbf8ebf9e1d44676e', '2f37fad27ab344108f4da87d9d21e767', null, null, '吐鲁番地区', '21', '吐鲁番地区', '652100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('722028de91e449f9a753de307cdb0d97', '2f37fad27ab344108f4da87d9d21e767', null, null, '哈密地区', '22', '哈密地区', '652200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('abb7d66db87e4d2996304371f67e37a6', '2f37fad27ab344108f4da87d9d21e767', null, null, '昌吉回族自治州', '23', '昌吉回族自治州', '652300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dfcf7241f1744ba1a5102d7ac628aee8', '2f37fad27ab344108f4da87d9d21e767', null, null, '博尔塔拉蒙古自治州', '27', '博尔塔拉蒙古自治州', '652700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b9b5bc2ccede4027a1f74f80e6341da6', '2f37fad27ab344108f4da87d9d21e767', null, null, '巴音郭楞蒙古自治州', '28', '巴音郭楞蒙古自治州', '652800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2ff89e0bff1b460db144ac09b148128d', '2f37fad27ab344108f4da87d9d21e767', null, null, '阿克苏地区', '29', '阿克苏地区', '652900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('39d4b2c4532c408c8f5c415bca3646d0', '2f37fad27ab344108f4da87d9d21e767', null, null, '克孜勒苏柯尔克孜自治州', '30', '克孜勒苏柯尔克孜自治州', '653000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ab1026be2a6249d6970816590fc19145', '2f37fad27ab344108f4da87d9d21e767', null, null, '喀什地区', '31', '喀什地区', '653100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb8405b610ee45ee9b7aac1f46c2fee3', '2f37fad27ab344108f4da87d9d21e767', null, null, '和田地区', '32', '和田地区', '653200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5af36941bec94e909e006b557150a1d4', '2f37fad27ab344108f4da87d9d21e767', null, null, '伊犁哈萨克自治州', '40', '伊犁哈萨克自治州', '654000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9e7badeaaf6e4b81947d64eee34d696e', '2f37fad27ab344108f4da87d9d21e767', null, null, '塔城地区', '42', '塔城地区', '654200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9e4de59c90544481a5c5163355474dee', '2f37fad27ab344108f4da87d9d21e767', null, null, '阿勒泰地区', '43', '阿勒泰地区', '654300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('25a0ad7d58b1411ca8fd5fe2a73bdb6f', '2f37fad27ab344108f4da87d9d21e767', null, null, '省直辖行政单位', '90', '省直辖行政单位', '659000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0d92c2dd3d8b4d568f5e4213b994f731', '3c96b28c5ada4a2f825530c2b6759f57', null, null, '香港', '81', '香港', '810000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b071cf5bb5b14629a19e2929bc219029', 'fcbe56f302194a42a7f51066cadc4577', null, null, '澳门', '82', '澳门', '820000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f46010d30af84774a1f8385753b28a93', '1e0a610de3b241058546ad6c891fcfb4', null, null, '台湾', '71', '台湾', '710000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9e7baa2d1a5b422189e813d735c19a6e', 'bb2c98b3923c431da6a1566bc808c10g', '100000', null, '东城区', '01', '东城区', '110101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5312ba82363b4471ab2ccb710b8868e3', 'bb2c98b3923c431da6a1566bc808c10g', '100000', null, '西城区', '02', '西城区', '110102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0326216041a14a9bb179d60266995789', 'bb2c98b3923c431da6a1566bc808c10g', '100000', null, '崇文区', '03', '崇文区', '110103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0321a2b255544dfeae29fbeabd299b4c', 'bb2c98b3923c431da6a1566bc808c10g', '100000', null, '宣武区', '04', '宣武区', '110104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('61e7e61897984f3dbbfce087561216d7', 'bb2c98b3923c431da6a1566bc808c10g', '100000', null, '朝阳区', '05', '朝阳区', '110105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a7bec1a275cc4882bcb31280a81d2a36', 'bb2c98b3923c431da6a1566bc808c10g', '100000', null, '丰台区', '06', '丰台区', '110106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('816b41debc0b42a1a22a94d3cb9a5f4d', 'bb2c98b3923c431da6a1566bc808c10g', '100000', null, '石景山区', '07', '石景山区', '110107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f3c922147224269957308256500574c', 'bb2c98b3923c431da6a1566bc808c10g', '100000', null, '海淀区', '08', '海淀区', '110108', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6ab356797086471bacfc11d2ea2d6319', 'bb2c98b3923c431da6a1566bc808c10g', '102300', null, '门头沟区', '09', '门头沟区', '110109', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f23d0b9bb06b4847aee556272c9415f6', 'bb2c98b3923c431da6a1566bc808c10g', '102400', null, '房山区', '11', '房山区', '110111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('183f6863e1064e2ba196a6d9826f955c', 'bb2c98b3923c431da6a1566bc808c10g', '101100', null, '通州区', '12', '通州区', '110112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9e88083d921d4dd0b01a897fc6ded595', 'bb2c98b3923c431da6a1566bc808c10g', '101300', null, '顺义区', '13', '顺义区', '110113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e9ebe2960c5e4948a35d8c6a64cb273c', 'bb2c98b3923c431da6a1566bc808c10g', '102200', null, '昌平区', '14', '昌平区', '110114', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2863a85c2ede4b7d8ee8474894f4e025', 'bb2c98b3923c431da6a1566bc808c10g', '102600', null, '大兴区', '15', '大兴区', '110115', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f170a19379c3427d843d06b7750d2994', 'bb2c98b3923c431da6a1566bc808c10g', '101400', null, '怀柔区', '16', '怀柔区', '110116', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2e6f72ccdd264bcb8edf7adcb4b01958', 'bb2c98b3923c431da6a1566bc808c10g', '101200', null, '平谷区', '17', '平谷区', '110117', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ddaa8a34894846aa9bd598f083f7b18b', 'bb2c98b3923c431da6a1566bc808c10g', '101500', null, '密云县', '28', '密云县', '110228', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('006e818c772c491b866b4b0d235c6981', 'bb2c98b3923c431da6a1566bc808c10g', '102100', null, '延庆县', '29', '延庆县', '110229', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fbfd1574ac7b4db5905b6ef722ca826f', 'bb2c98b3923c431da6a1566bc808c10f', '300000', null, '和平区', '01', '和平区', '120101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('447aadfea7f147aaa2c6499fdfa2dcc9', 'bb2c98b3923c431da6a1566bc808c10f', '300000', null, '河东区', '02', '河东区', '120102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d5489554ef3149888624e732f07d5082', 'bb2c98b3923c431da6a1566bc808c10f', '300000', null, '河西区', '03', '河西区', '120103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a3864f60e5b648c4acb76376e6c69f5e', 'bb2c98b3923c431da6a1566bc808c10f', '300000', null, '南开区', '04', '南开区', '120104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('72f69932d24546ab9ad836c32da3dd09', 'bb2c98b3923c431da6a1566bc808c10f', '300000', null, '河北区', '05', '河北区', '120105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6fc343f53db4465c9920a70d0ae610f6', 'bb2c98b3923c431da6a1566bc808c10f', '300000', null, '红桥区', '06', '红桥区', '120106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('585ece77331543fbaca9139f13074ca0', 'bb2c98b3923c431da6a1566bc808c10f', '300450', null, '塘沽区', '07', '塘沽区', '120107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7fe5efabd32346d19390ae1404f1536c', 'bb2c98b3923c431da6a1566bc808c10f', '300480', null, '汉沽区', '08', '汉沽区', '120108', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bd5eedcee2654305a8fd3f72aac1bd82', 'bb2c98b3923c431da6a1566bc808c10f', '300000', null, '大港区', '09', '大港区', '120109', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('42233a14f78b41f0b25a2c523f1d0458', 'bb2c98b3923c431da6a1566bc808c10f', '300000', null, '东丽区', '10', '东丽区', '120110', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f8f13e8e3ff54d5a9fb8709419a31593', 'bb2c98b3923c431da6a1566bc808c10f', '300000', null, '西青区', '11', '西青区', '120111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9fb067ed377b4eef80da1c46594fdf1d', 'bb2c98b3923c431da6a1566bc808c10f', '300000', null, '津南区', '12', '津南区', '120112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('29e847fcbe824faaae66d4aab671b4b5', 'bb2c98b3923c431da6a1566bc808c10f', '300000', null, '北辰区', '13', '北辰区', '120113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('79e19f4266f74d4b973f07f6c1f41aef', 'bb2c98b3923c431da6a1566bc808c10f', '301700', null, '武清区', '14', '武清区', '120114', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4446bd43335c42aab1092401a1501640', 'bb2c98b3923c431da6a1566bc808c10f', '301800', null, '宝坻区', '15', '宝坻区', '120115', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('42de56306a6943318faf413132d9e0a4', 'bb2c98b3923c431da6a1566bc808c10f', '301500', null, '宁河县', '21', '宁河县', '120221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f963d9f93054dda9a81458a06c63643', 'bb2c98b3923c431da6a1566bc808c10f', '301600', null, '静海县', '23', '静海县', '120223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d8332dda9f14751b53aec5b492426fe', 'bb2c98b3923c431da6a1566bc808c10f', '301900', null, '蓟县', '25', '蓟县', '120225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('03089d1b5b2441f592b9da1894ce332d', 'cbf57834e6314708abbbb577e400e698', '050000', null, '市辖区', '01', '市辖区', '130101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6c61249cca294362a6f568ac5ab99e9c', 'cbf57834e6314708abbbb577e400e698', '050000', null, '长安区', '02', '长安区', '130102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6f51616bbfbc4f148353be23fcd40eed', 'cbf57834e6314708abbbb577e400e698', '050000', null, '桥东区', '03', '桥东区', '130103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3bb45a837d114653814383bcacf480f5', 'cbf57834e6314708abbbb577e400e698', '050000', null, '桥西区', '04', '桥西区', '130104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cd61b5e0b7324852b89697eb04f94032', 'cbf57834e6314708abbbb577e400e698', '050000', null, '新华区', '05', '新华区', '130105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('76a931178f594f3eab2e1d3e51c95e1b', 'cbf57834e6314708abbbb577e400e698', '051000', null, '井陉矿区', '07', '井陉矿区', '130107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6f19262da77c47388024b918fbc9071d', 'cbf57834e6314708abbbb577e400e698', '050000', null, '裕华区', '08', '裕华区', '130108', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8b7f649ed9844c88843c8c702ad82baa', 'cbf57834e6314708abbbb577e400e698', '050300', null, '井陉县', '21', '井陉县', '130121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ec1b21d82b25432594821d2cf415b088', 'cbf57834e6314708abbbb577e400e698', '050800', null, '正定县', '23', '正定县', '130123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('994a6826c2fc4459833bc60a14bfe6df', 'cbf57834e6314708abbbb577e400e698', '051430', null, '栾城县', '24', '栾城县', '130124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('27c244a5af05481787fb9396882d9b12', 'cbf57834e6314708abbbb577e400e698', '050600', null, '行唐县', '25', '行唐县', '130125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bccb2f3371c549638fb5e083d7badfbf', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '盘锦市', '11', '盘锦市', '211100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0e4703c44e4540d6b28fba9380400e92', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '铁岭市', '12', '铁岭市', '211200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('15afb64f4c90488f9b38836c2eb77d18', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '朝阳市', '13', '朝阳市', '211300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f09d74ecd8c34b269879aa4c409cafcf', '2478110f8a104a189fb6f4a0eb4bde1c', null, null, '葫芦岛市', '14', '葫芦岛市', '211400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3a3f1ba7751f47dabb57b457b678be60', '26697abbf2fb49239b261c010a69a343', null, null, '长春市', '01', '长春市', '220100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7774e0ff0e204d1e8f1c239d87344aa2', '26697abbf2fb49239b261c010a69a343', null, null, '吉林市', '02', '吉林市', '220200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('00d948ff21b342779471d96e783f9822', '26697abbf2fb49239b261c010a69a343', null, null, '四平市', '03', '四平市', '220300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8ce5a37dedc84f23832b14be8e0c601e', '26697abbf2fb49239b261c010a69a343', null, null, '辽源市', '04', '辽源市', '220400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c2cf2135b6be4b99b8fd891bbd43f686', '26697abbf2fb49239b261c010a69a343', null, null, '通化市', '05', '通化市', '220500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3551b526f5e7417fae31cf0d2edb4d9d', '26697abbf2fb49239b261c010a69a343', null, null, '白山市', '06', '白山市', '220600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a0ee1a7af5be4b53b88627407200545f', '26697abbf2fb49239b261c010a69a343', null, null, '松原市', '07', '松原市', '220700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bd2d77f833b2472d8a828a90f402f861', '26697abbf2fb49239b261c010a69a343', null, null, '白城市', '08', '白城市', '220800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('02f726a87a1e43ddb4fac108dd68b46b', '26697abbf2fb49239b261c010a69a343', null, null, '延边朝鲜族自治州', '24', '延边朝鲜族自治州', '222400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('18f439ed744a48ae89ca7f469af554fd', '909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, '哈尔滨市', '01', '哈尔滨市', '230100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4f42860a0c8e4a6ab50d18f9e73d84a4', '909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, '齐齐哈尔市', '02', '齐齐哈尔市', '230200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c87e34444f484566923db62964bf3fc0', '909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, '鸡西市', '03', '鸡西市', '230300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('23fc3577d5b5453eae1ae4af187d0c86', '909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, '鹤岗市', '04', '鹤岗市', '230400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8fdba2c226b74f689e9095d060a98cd2', '909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, '双鸭山市', '05', '双鸭山市', '230500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b4f698e29e7e44a5b58a6d86e8783e36', '909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, '大庆市', '06', '大庆市', '230600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('31a1d04a3c394bf3bf77d67153cdc2c6', '909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, '伊春市', '07', '伊春市', '230700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0625ff8646c740ae83931ea039f1d8ba', '909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, '佳木斯市', '08', '佳木斯市', '230800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7d964b3b2e26428b8f12284ddf2654c4', '909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, '七台河市', '09', '七台河市', '230900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a850022c32f047a39f070ecdb64c10cf', '909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, '牡丹江市', '10', '牡丹江市', '231000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e94124d72ea049559b68d29c33d5e9f6', '909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, '黑河市', '11', '黑河市', '231100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0700bce39eff4bbaad9989a4e5283ea5', '909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, '绥化市', '12', '绥化市', '231200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ba25a32ee5ea4cbaae42084151c8cd4c', '909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, '大兴安岭地区', '27', '大兴安岭地区', '232700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9cf48c1bd1494b26b7dfeb12ea3238d8', '3b6cce816ea04ff7b3dc68abeca243dd', null, null, '上海市', '01', '上海市', '310100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e15988d61b834780bec69b7dac6c283a', '02c8619f11814155982eb5b1873353bd', null, null, '南京市', '01', '南京市', '320100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b02f8deca60a49b98e7ed5aa0428e5e6', '02c8619f11814155982eb5b1873353bd', null, null, '无锡市', '02', '无锡市', '320200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('02fd4185ea2343ffaae15ca2c5caf2b3', '02c8619f11814155982eb5b1873353bd', null, null, '徐州市', '03', '徐州市', '320300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0c09b62ba8c74384bc7edf68979f3caf', '02c8619f11814155982eb5b1873353bd', null, null, '常州市', '04', '常州市', '320400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('09e191fc259b41d49524f1ffa57f641f', '02c8619f11814155982eb5b1873353bd', null, null, '苏州市', '05', '苏州市', '320500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b98b1f8bf0b94b8785ca162c17011d3f', '02c8619f11814155982eb5b1873353bd', null, null, '南通市', '06', '南通市', '320600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c85fe163313c4fd78e007d8ab1d9a9c7', '02c8619f11814155982eb5b1873353bd', null, null, '连云港市', '07', '连云港市', '320700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('83fcca5dad594e5da9b2c4e7fe0c6ba8', '02c8619f11814155982eb5b1873353bd', null, null, '淮安市', '08', '淮安市', '320800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('789b2371daed489babc5ce0b82cf9bec', '02c8619f11814155982eb5b1873353bd', null, null, '盐城市', '09', '盐城市', '320900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a9330bf8add64d57927ab4faae098a13', '02c8619f11814155982eb5b1873353bd', null, null, '扬州市', '10', '扬州市', '321000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1f444db499d740989434bb11e14f54a3', '02c8619f11814155982eb5b1873353bd', null, null, '镇江市', '11', '镇江市', '321100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('835c9ac0e6824b37a4af2b626524362f', '02c8619f11814155982eb5b1873353bd', null, null, '泰州市', '12', '泰州市', '321200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d6fe0afb4aec42bc8cb70ad349bfb31a', '02c8619f11814155982eb5b1873353bd', null, null, '宿迁市', '13', '宿迁市', '321300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('948adc095d0448cbbc8a28a43b126cd7', 'ea63e61e420c4134be3db192220422f9', null, null, '杭州市', '01', '杭州市', '330100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b579455d7ae4445fb895e24f98caa299', 'ea63e61e420c4134be3db192220422f9', null, null, '宁波市', '02', '宁波市', '330200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('725d382f33c54a83a7db831c3da82665', 'ea63e61e420c4134be3db192220422f9', null, null, '温州市', '03', '温州市', '330300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1884978b76d6469c871140b620617381', 'ea63e61e420c4134be3db192220422f9', null, null, '嘉兴市', '04', '嘉兴市', '330400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('77e868a833554971a102184336921723', 'ea63e61e420c4134be3db192220422f9', null, null, '湖州市', '05', '湖州市', '330500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('962cb7e4670547ffb73d8ee3b44532dd', 'ea63e61e420c4134be3db192220422f9', null, null, '绍兴市', '06', '绍兴市', '330600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8df5d2d1bf024ffa92c29fe60871da10', 'ea63e61e420c4134be3db192220422f9', null, null, '金华市', '07', '金华市', '330700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('39ef5e82145c4f11a07dc5a6503d596b', 'ea63e61e420c4134be3db192220422f9', null, null, '衢州市', '08', '衢州市', '330800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c56cf7ba5aec447eaa0588684c1347f8', 'ea63e61e420c4134be3db192220422f9', null, null, '舟山市', '09', '舟山市', '330900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1901b2c30bc24b45a4abca1c5b03b4ba', 'ea63e61e420c4134be3db192220422f9', null, null, '台州市', '10', '台州市', '331000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e2d22a554b0141759f6ffc200a5a7c5a', 'ea63e61e420c4134be3db192220422f9', null, null, '丽水市', '11', '丽水市', '331100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('db9ba52f83f943c3bb606a0d52ad769e', '82f82898ec5d42a797e25a8039a7c1da', null, null, '合肥市', '01', '合肥市', '340100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e3a4a4ba5c56445c92c6a4d932ae463e', '82f82898ec5d42a797e25a8039a7c1da', null, null, '芜湖市', '02', '芜湖市', '340200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a2c7a37f793c4880a33dd7ca60198d51', '82f82898ec5d42a797e25a8039a7c1da', null, null, '蚌埠市', '03', '蚌埠市', '340300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eebd1b2f46a7490ead76d682d03caa3d', '82f82898ec5d42a797e25a8039a7c1da', null, null, '淮南市', '04', '淮南市', '340400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0d19c7615d3e4c3e882056f94b5aecae', '82f82898ec5d42a797e25a8039a7c1da', null, null, '马鞍山市', '05', '马鞍山市', '340500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('99b8d897937b424c98d2d8f6a66e15bc', '82f82898ec5d42a797e25a8039a7c1da', null, null, '淮北市', '06', '淮北市', '340600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('db87ace1e601499894596f7ad2f1ec8a', '82f82898ec5d42a797e25a8039a7c1da', null, null, '铜陵市', '07', '铜陵市', '340700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b7a3e50258a6477c986d9617cb2da1ca', '82f82898ec5d42a797e25a8039a7c1da', null, null, '安庆市', '08', '安庆市', '340800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aeb93b0d0bad495ebf128dfccc009d5a', '82f82898ec5d42a797e25a8039a7c1da', null, null, '黄山市', '10', '黄山市', '341000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('56f6e70756b24b2b9b6819c3263e4c19', '82f82898ec5d42a797e25a8039a7c1da', null, null, '滁州市', '11', '滁州市', '341100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5afe0ab733f946d2be079f263536d1e4', '82f82898ec5d42a797e25a8039a7c1da', null, null, '阜阳市', '12', '阜阳市', '341200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cc3bd80ea79c413ea58d4d69cb283e70', '82f82898ec5d42a797e25a8039a7c1da', null, null, '宿州市', '13', '宿州市', '341300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3777ebad7996423cb39c8c8a5eef1038', '82f82898ec5d42a797e25a8039a7c1da', null, null, '巢湖市', '14', '巢湖市', '341400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aabcff251e8d49538a041fd8a1992561', '82f82898ec5d42a797e25a8039a7c1da', null, null, '六安市', '15', '六安市', '341500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e78a8a06ed6b4b469f72d85bcf4331af', '82f82898ec5d42a797e25a8039a7c1da', null, null, '亳州市', '16', '亳州市', '341600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('77f0da77ecc84e2c9cdd0bf884cb7437', '82f82898ec5d42a797e25a8039a7c1da', null, null, '池州市', '17', '池州市', '341700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('915283302a1448d8a6a5f4c3fe3811b7', '82f82898ec5d42a797e25a8039a7c1da', null, null, '宣城市', '18', '宣城市', '341800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('61188ed689124e8693ad2da355082375', '31f843473a4d4710a5d8cb462ee84cd1', null, null, '福州市', '01', '福州市', '350100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c600d641b3d3489399d3557c9bc5e188', '31f843473a4d4710a5d8cb462ee84cd1', null, null, '厦门市', '02', '厦门市', '350200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f90bd8facf994bdbb6571b195d0de4cd', '7cb33ba7dcc9456caac8ec92e8640636', '068350', null, '丰宁满族自治县', '26', '丰宁满族自治县', '130826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9a9e0dab70c840508a7c3b6a0a2a4191', '7cb33ba7dcc9456caac8ec92e8640636', '067600', null, '宽城满族自治县', '27', '宽城满族自治县', '130827', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('720ecd35507141fc921fa1ce7dbe24ce', '7cb33ba7dcc9456caac8ec92e8640636', '068450', null, '围场满族蒙古族自治县', '28', '围场满族蒙古族自治县', '130828', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fd22b6601c2046cab327224dc1260736', 'c012a6672c5a4d51a2dd7c869e6e2f94', '061000', null, '市辖区', '01', '市辖区', '130901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('78e1e223b6544377910df22b27e6a719', 'c012a6672c5a4d51a2dd7c869e6e2f94', '061000', null, '新华区', '02', '新华区', '130902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d630dbe29fdc4ffca95cfe36a90915bc', 'c012a6672c5a4d51a2dd7c869e6e2f94', '061000', null, '运河区', '03', '运河区', '130903', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d91f8e6e517945ef9e2171e2356410af', 'c012a6672c5a4d51a2dd7c869e6e2f94', '061000', null, '沧县', '21', '沧县', '130921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0c9c2d1fcb5c4a68b972506e5886f18d', 'c012a6672c5a4d51a2dd7c869e6e2f94', '062650', null, '青县', '22', '青县', '130922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('12205ce938074a8aa1a83d007af0d771', 'c012a6672c5a4d51a2dd7c869e6e2f94', '061600', null, '东光县', '23', '东光县', '130923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b53562981fca4e43b0359787756f891a', 'c012a6672c5a4d51a2dd7c869e6e2f94', '061200', null, '海兴县', '24', '海兴县', '130924', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5c910bd552544d84a62b18059e65f127', 'c012a6672c5a4d51a2dd7c869e6e2f94', '061300', null, '盐山县', '25', '盐山县', '130925', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e1333d235f494e98b5adad8993d9068a', 'c012a6672c5a4d51a2dd7c869e6e2f94', '062350', null, '肃宁县', '26', '肃宁县', '130926', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('075bd1db89874ad48377cbd31fcfb607', 'c012a6672c5a4d51a2dd7c869e6e2f94', '061500', null, '南皮县', '27', '南皮县', '130927', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3e2f3d16af44acbb428e507a907539b', 'c012a6672c5a4d51a2dd7c869e6e2f94', '061800', null, '吴桥县', '28', '吴桥县', '130928', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('70e3354f92f24d13b12ef96238882cd7', 'c012a6672c5a4d51a2dd7c869e6e2f94', '062250', null, '献县', '29', '献县', '130929', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9d608756899b474889d6465ef86696d7', 'c012a6672c5a4d51a2dd7c869e6e2f94', '061400', null, '孟村回族自治县', '30', '孟村回族自治县', '130930', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4c9415d5f1a54fdfb021253c409d17ec', 'c012a6672c5a4d51a2dd7c869e6e2f94', '062150', null, '泊头市', '81', '泊头市', '130981', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('edec66ffbb7f4aea8c21e8e7a4d7eab3', 'c012a6672c5a4d51a2dd7c869e6e2f94', '062550', null, '任丘市', '82', '任丘市', '130982', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eaa8ca4fa0d54cb68581dbefcee53384', 'c012a6672c5a4d51a2dd7c869e6e2f94', '061100', null, '黄骅市', '83', '黄骅市', '130983', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('23b53f58af3f4c63960ff086c47e1042', 'c012a6672c5a4d51a2dd7c869e6e2f94', '062450', null, '河间市', '84', '河间市', '130984', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6a07a628b50b462e9f5404ce10d4a31a', 'e9fcaf25bb7e4954ba725288edd530b4', '065000', null, '市辖区', '01', '市辖区', '131001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('963fded5b145401091e7936c646850e9', 'e9fcaf25bb7e4954ba725288edd530b4', '065000', null, '安次区', '02', '安次区', '131002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d6f713640b8543419e2777757297f1ff', 'e9fcaf25bb7e4954ba725288edd530b4', '065000', null, '广阳区', '03', '广阳区', '131003', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4a2623c4a7bd4fd4a51d1a82381822c0', 'e9fcaf25bb7e4954ba725288edd530b4', '065500', null, '固安县', '22', '固安县', '131022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b60e9ebf9baa49d69543f71a2cca11c2', 'e9fcaf25bb7e4954ba725288edd530b4', '065600', null, '永清县', '23', '永清县', '131023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3f8df74edb1f4a23861222cc40591b2c', 'e9fcaf25bb7e4954ba725288edd530b4', '065400', null, '香河县', '24', '香河县', '131024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('84aaac05e529456d8a33685e79a2a7a4', 'e9fcaf25bb7e4954ba725288edd530b4', '065900', null, '大城县', '25', '大城县', '131025', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('16772954b63441eeb94814a36e2bdd38', 'e9fcaf25bb7e4954ba725288edd530b4', '065800', null, '文安县', '26', '文安县', '131026', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a9cd68845b214961b3c4432d3fc356d8', 'e9fcaf25bb7e4954ba725288edd530b4', '065300', null, '大厂回族自治县', '28', '大厂回族自治县', '131028', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0a3839740ecb408d8f4aa38a917096c0', 'e9fcaf25bb7e4954ba725288edd530b4', '065700', null, '霸州市', '81', '霸州市', '131081', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f0831172cfcc420f80769b814bd4c897', 'e9fcaf25bb7e4954ba725288edd530b4', '065200', null, '三河市', '82', '三河市', '131082', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f4f739c168a845a3867400b52141d0f4', '23a701cb7a9441e7b601f2b4522d90ff', '053000', null, '市辖区', '01', '市辖区', '131101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b5b094ae6105461e847f4c1ac3e29952', '23a701cb7a9441e7b601f2b4522d90ff', '053000', null, '桃城区', '02', '桃城区', '131102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7396d0dec8dd42cda34373f27dfdb8d2', '23a701cb7a9441e7b601f2b4522d90ff', '053100', null, '枣强县', '21', '枣强县', '131121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cc76d2e171534331a652904319b6322a', '23a701cb7a9441e7b601f2b4522d90ff', '053400', null, '武邑县', '22', '武邑县', '131122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bcdb3c7bf3e34eedbf76b8b0920dff4e', '23a701cb7a9441e7b601f2b4522d90ff', '053300', null, '武强县', '23', '武强县', '131123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4e004ec38e044768819d34836556d349', '23a701cb7a9441e7b601f2b4522d90ff', '053900', null, '饶阳县', '24', '饶阳县', '131124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('814c43c1122241f0b0d69c4ee117de27', '23a701cb7a9441e7b601f2b4522d90ff', '053600', null, '安平县', '25', '安平县', '131125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9a27d6cbdcb94c89afbebf7f6c81c090', '23a701cb7a9441e7b601f2b4522d90ff', '053800', null, '故城县', '26', '故城县', '131126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('028554b83f554f1cafe6a77c43cac260', '23a701cb7a9441e7b601f2b4522d90ff', '053500', null, '景县', '27', '景县', '131127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ad97b63b38e2419ca7286770755e40e6', '23a701cb7a9441e7b601f2b4522d90ff', '053700', null, '阜城县', '28', '阜城县', '131128', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b92d5fa34a554cecae0de33ac0535586', '23a701cb7a9441e7b601f2b4522d90ff', '053200', null, '冀州市', '81', '冀州市', '131181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('43c88e27032c4d3bba9535795e0fcd9a', '23a701cb7a9441e7b601f2b4522d90ff', '052800', null, '深州市', '82', '深州市', '131182', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('36b8183e8d1b4210aa6a50788325d6dd', 'b7f87c79f8344d97accf425e966da23a', '030000', null, '市辖区', '01', '市辖区', '140101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('78ddeb74c3b844aca8803f4baf973b06', 'b7f87c79f8344d97accf425e966da23a', '030000', null, '小店区', '05', '小店区', '140105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c9639da553b74ddc90ab38a4fb3c63ed', 'b7f87c79f8344d97accf425e966da23a', '030000', null, '迎泽区', '06', '迎泽区', '140106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('df0ff2bba89a4b699a9edcc180ce5dec', 'b7f87c79f8344d97accf425e966da23a', '030000', null, '杏花岭区', '07', '杏花岭区', '140107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5c497c2f988647928aba431f74e05544', 'b7f87c79f8344d97accf425e966da23a', '030000', null, '尖草坪区', '08', '尖草坪区', '140108', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('697a4e164f4043df8f52cbffb8bf98fd', 'b7f87c79f8344d97accf425e966da23a', '030000', null, '万柏林区', '09', '万柏林区', '140109', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7b624a8289ad4cfa85e372dfdd7dc52f', 'b7f87c79f8344d97accf425e966da23a', '030000', null, '晋源区', '10', '晋源区', '140110', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7921a166551d4aa4888c06574bf87a72', 'b7f87c79f8344d97accf425e966da23a', '030400', null, '清徐县', '21', '清徐县', '140121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b4f37722c021459dadc250b62dfe990a', 'b7f87c79f8344d97accf425e966da23a', '030100', null, '阳曲县', '22', '阳曲县', '140122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c6b185a1f2f34c60a42c98f7214e757b', 'b7f87c79f8344d97accf425e966da23a', '030300', null, '娄烦县', '23', '娄烦县', '140123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e7ff00b21abe47f4b7d3a714cd2b0ab8', 'b7f87c79f8344d97accf425e966da23a', '030200', null, '古交市', '81', '古交市', '140181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ac3a060698644032a5aadd4b32a26a74', '6bdf07875675456cad494b60cf611d83', '037000', null, '市辖区', '01', '市辖区', '140201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ddf1cd710de44a8eaca282613a06659b', '6bdf07875675456cad494b60cf611d83', '037000', null, '城区', '02', '城区', '140202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cabb9ca3150248bd9fa9505400b67765', '6bdf07875675456cad494b60cf611d83', '037000', null, '矿区', '03', '矿区', '140203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb244668c35949ea8a3b440cc0369e4e', '6bdf07875675456cad494b60cf611d83', '037000', null, '南郊区', '11', '南郊区', '140211', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('98790b5f795b49508dfff2b66f18d309', '6bdf07875675456cad494b60cf611d83', '037000', null, '新荣区', '12', '新荣区', '140212', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b9059e286c89475e9c18931bf61f8d8c', '6bdf07875675456cad494b60cf611d83', '038100', null, '阳高县', '21', '阳高县', '140221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e6d5a92661a435e9c7899cc470e84db', '6bdf07875675456cad494b60cf611d83', '038200', null, '天镇县', '22', '天镇县', '140222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8440e350e5bf4aaa904734952e55228f', '6bdf07875675456cad494b60cf611d83', '037500', null, '广灵县', '23', '广灵县', '140223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9c9ac548c3cb4e16ae3fb04ef86077ec', '6bdf07875675456cad494b60cf611d83', '034400', null, '灵丘县', '24', '灵丘县', '140224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('187a8f27a6564cc8969d2f0ca9c023a0', '6bdf07875675456cad494b60cf611d83', '037400', null, '浑源县', '25', '浑源县', '140225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6b072780236e4cf69842c5acbff5cb22', '6bdf07875675456cad494b60cf611d83', '037100', null, '左云县', '26', '左云县', '140226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4be3d0940a304cadb570aecb46b79a93', '264018e21b854c78866dd48622f2d326', '036000', null, '宁武县', '25', '宁武县', '140925', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f8d1e6c013844db3bcea93befea75c9b', '2ba645b8f3634fa8b493153e4a5ed8f6', '137400', null, '乌兰浩特市', '01', '乌兰浩特市', '152201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('236791bfabf94d3eb4b5bcf706d3f107', '2ba645b8f3634fa8b493153e4a5ed8f6', '137400', null, '阿尔山市', '02', '阿尔山市', '152202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('42a8101f4e0f495d819be34eaf1d109b', '2ba645b8f3634fa8b493153e4a5ed8f6', '137400', null, '科尔沁右翼前旗', '21', '科尔沁右翼前旗', '152221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8fd8a66c7c5342d5a62dff8c70be0952', '2ba645b8f3634fa8b493153e4a5ed8f6', '029400', null, '科尔沁右翼中旗', '22', '科尔沁右翼中旗', '152222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f2cbbf9cbb84b4e9eee634aeabd395e', '2ba645b8f3634fa8b493153e4a5ed8f6', '137600', null, '扎赉特旗', '23', '扎赉特旗', '152223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7e87d88abd2b43a6ab24dd043adf512f', '2ba645b8f3634fa8b493153e4a5ed8f6', '137500', null, '突泉县', '24', '突泉县', '152224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0eb7d15aff1b45be8e836f2228061ea4', '8e3b599f883a4795a8ebede218cfa3c5', '012600', null, '二连浩特市', '01', '二连浩特市', '152501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f936d86cceb248b99ed44daae3ccf070', '8e3b599f883a4795a8ebede218cfa3c5', '026000', null, '锡林浩特市', '02', '锡林浩特市', '152502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fe4e8e5533a64267b8604b41b6e66f71', '8e3b599f883a4795a8ebede218cfa3c5', '011400', null, '阿巴嘎旗', '22', '阿巴嘎旗', '152522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('66db023f517e43c18d1597b7e569c686', '8e3b599f883a4795a8ebede218cfa3c5', '011300', null, '苏尼特左旗', '23', '苏尼特左旗', '152523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b93e78005cdd4ac5be137e7db21c20b6', '8e3b599f883a4795a8ebede218cfa3c5', '011200', null, '苏尼特右旗', '24', '苏尼特右旗', '152524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f3e3c5dcf3ac41b8b9ef43d1fb78d473', '8e3b599f883a4795a8ebede218cfa3c5', '026300', null, '东乌珠穆沁旗', '25', '东乌珠穆沁旗', '152525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2be5d87ef7514d4a8a57c814146820bd', '8e3b599f883a4795a8ebede218cfa3c5', '026200', null, '西乌珠穆沁旗', '26', '西乌珠穆沁旗', '152526', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1076f83beea04bf6a7aebb20ba66f1db', '8e3b599f883a4795a8ebede218cfa3c5', '027000', null, '太仆寺旗', '27', '太仆寺旗', '152527', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('14a099f2af7a4fd3911dd8a1a0d7c42a', '8e3b599f883a4795a8ebede218cfa3c5', '013250', null, '镶黄旗', '28', '镶黄旗', '152528', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0acd793a028b4bfb8dc0dc83d37f2aba', '8e3b599f883a4795a8ebede218cfa3c5', '013800', null, '正镶白旗', '29', '正镶白旗', '152529', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8bc7a9ad977a40daba97d965bd0ce2cd', '8e3b599f883a4795a8ebede218cfa3c5', '027200', null, '正蓝旗', '30', '正蓝旗', '152530', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c8c05bdf8a624875b903fa7a6703e57e', '8e3b599f883a4795a8ebede218cfa3c5', '027300', null, '多伦县', '31', '多伦县', '152531', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d4faeedba8ef417789a72a492c0a3c55', '750ccb3644114acbaf7cb9f3979fa14e', '750300', null, '阿拉善左旗', '21', '阿拉善左旗', '152921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a14a6e1ed2714fe0b8d81b8bb288b6c6', '750ccb3644114acbaf7cb9f3979fa14e', '737300', null, '阿拉善右旗', '22', '阿拉善右旗', '152922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('998f6551f0244747aaff9750467de4cd', '750ccb3644114acbaf7cb9f3979fa14e', '735400', null, '额济纳旗', '23', '额济纳旗', '152923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4471a8975e814ae89bb91aa7d5d10502', 'd4dc7fd748b54bfd85730b31208b8983', '110000', null, '市辖区', '01', '市辖区', '210101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d72e1439b93b4213a3aed3e76c5083c0', 'd4dc7fd748b54bfd85730b31208b8983', '110000', null, '和平区', '02', '和平区', '210102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('001dafd32e8a4ecd82e652865de7dbea', 'd4dc7fd748b54bfd85730b31208b8983', '110000', null, '沈河区', '03', '沈河区', '210103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3a9493ca7cf94adb952ef381b62d4af1', 'd4dc7fd748b54bfd85730b31208b8983', '110000', null, '大东区', '04', '大东区', '210104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('726e4f338fdd4fbdafbe899a5f30e611', 'd4dc7fd748b54bfd85730b31208b8983', '110000', null, '皇姑区', '05', '皇姑区', '210105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c55f8220c482415e9b3aa13552141351', 'd4dc7fd748b54bfd85730b31208b8983', '110020', null, '铁西区', '06', '铁西区', '210106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('647b6681eb3f4c66be105f029392966a', 'd4dc7fd748b54bfd85730b31208b8983', '110100', null, '苏家屯区', '11', '苏家屯区', '210111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('71a37896265e41af92d84c90e85889d2', 'd4dc7fd748b54bfd85730b31208b8983', '110000', null, '东陵区', '12', '东陵区', '210112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f6243a133a44736b022fbba10eadb81', 'd4dc7fd748b54bfd85730b31208b8983', '110000', null, '沈北新区', '13', '沈北新区', '210113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4f9ce31880a64d09838d802a4b0c7bd4', 'd4dc7fd748b54bfd85730b31208b8983', '110000', null, '于洪区', '14', '于洪区', '210114', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f79e9b0b098746eabf907ffd731f24e8', 'd4dc7fd748b54bfd85730b31208b8983', '110200', null, '辽中县', '22', '辽中县', '210122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('47751d6f5fe447db8f5c81caa61e5a95', 'd4dc7fd748b54bfd85730b31208b8983', '110500', null, '康平县', '23', '康平县', '210123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f0214cbda19442e4972d2353fb927ddb', 'd4dc7fd748b54bfd85730b31208b8983', '110400', null, '法库县', '24', '法库县', '210124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cd0a1d8a0b2847eeadf6abf773f12aa1', 'd4dc7fd748b54bfd85730b31208b8983', '110300', null, '新民市', '81', '新民市', '210181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7fcb966057e5495ebe93fac22d0a781d', '5246279f38814f9a80d551d0c4ec88cb', '116000', null, '市辖区', '01', '市辖区', '210201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cb1d1e713fb04275a8696cfc612600fc', '5246279f38814f9a80d551d0c4ec88cb', '116000', null, '中山区', '02', '中山区', '210202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('366f3eb6fb5b47b3aaec4cae8e53437f', '5246279f38814f9a80d551d0c4ec88cb', '116000', null, '西岗区', '03', '西岗区', '210203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4af02700330c4a0686ec4898b95a349f', '5246279f38814f9a80d551d0c4ec88cb', '116000', null, '沙河口区', '04', '沙河口区', '210204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c4354df141eb4bdd9f0676c90710db82', '5246279f38814f9a80d551d0c4ec88cb', '116000', null, '甘井子区', '11', '甘井子区', '210211', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('583d7f4c422f4b508365b37f45c0380f', '5246279f38814f9a80d551d0c4ec88cb', '116000', null, '旅顺口区', '12', '旅顺口区', '210212', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a5a7fddef50d403ebcabdb383ce8912c', '5246279f38814f9a80d551d0c4ec88cb', '116000', null, '金州区', '13', '金州区', '210213', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('96bee19aa46a4e37b3e20b57890967f3', '5246279f38814f9a80d551d0c4ec88cb', '116500', null, '长海县', '24', '长海县', '210224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fe75dca2b0594b85b99adf3ae2ad2319', '5246279f38814f9a80d551d0c4ec88cb', '116300', null, '瓦房店市', '81', '瓦房店市', '210281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7de3c2f25fc34951b9b07d605da9d4af', '5246279f38814f9a80d551d0c4ec88cb', '116200', null, '普兰店市', '82', '普兰店市', '210282', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dfe8ecf75ef645b28f46b80cf7c06d65', '5246279f38814f9a80d551d0c4ec88cb', '116400', null, '庄河市', '83', '庄河市', '210283', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d366036d09ce411abef1ff570cc66c1c', '77697bfbce0b42e3a0ab3a35f66cc591', '114000', null, '市辖区', '01', '市辖区', '210301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a1f4764972d449a083c39aab2802468e', '77697bfbce0b42e3a0ab3a35f66cc591', '114000', null, '铁东区', '02', '铁东区', '210302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fbccacee11d44a18a684017bab029414', '77697bfbce0b42e3a0ab3a35f66cc591', '114000', null, '铁西区', '03', '铁西区', '210303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a1625cb3ec0e4a94af4c0cd8120c527c', '77697bfbce0b42e3a0ab3a35f66cc591', '114000', null, '立山区', '04', '立山区', '210304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('69dde36cc41b44b4aeddaff243490d4c', '77697bfbce0b42e3a0ab3a35f66cc591', '114000', null, '千山区', '11', '千山区', '210311', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('20c38e7233b74dd1b48c18f670331ddb', '77697bfbce0b42e3a0ab3a35f66cc591', '114100', null, '台安县', '21', '台安县', '210321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aba3b12505104acfa4cdb6af4d648690', '77697bfbce0b42e3a0ab3a35f66cc591', '118400', null, '岫岩满族自治县', '23', '岫岩满族自治县', '210323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('68873cf573d44696a2a5008656671469', '77697bfbce0b42e3a0ab3a35f66cc591', '114200', null, '海城市', '81', '海城市', '210381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0bbb4cc512a5466996ee19d9b205d943', '2dae9d3b1ff147988878f48b30ca29e6', '113000', null, '市辖区', '01', '市辖区', '210401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5a15221dbd294e53946ec5ef06a13c5d', '2dae9d3b1ff147988878f48b30ca29e6', '113000', null, '新抚区', '02', '新抚区', '210402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('401d3a67b24b420890c0edc2d42b2dee', '2dae9d3b1ff147988878f48b30ca29e6', '113000', null, '东洲区', '03', '东洲区', '210403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6b74447cb08847e9ad91a52202ef3b8a', '2dae9d3b1ff147988878f48b30ca29e6', '113000', null, '望花区', '04', '望花区', '210404', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b2fd5b367dfd48be905b77becf86c499', '2dae9d3b1ff147988878f48b30ca29e6', '113000', null, '顺城区', '11', '顺城区', '210411', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('80e689f0393943c390657015b12ca1c4', '2dae9d3b1ff147988878f48b30ca29e6', '113100', null, '抚顺县', '21', '抚顺县', '210421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c3714eba38154ed1ba73d60f9499c5ad', '2dae9d3b1ff147988878f48b30ca29e6', '113200', null, '新宾满族自治县', '22', '新宾满族自治县', '210422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e347f21647f545d39da6197b364a5e14', '2dae9d3b1ff147988878f48b30ca29e6', '113300', null, '清原满族自治县', '23', '清原满族自治县', '210423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6e4a7bf4261542d895cf70026784c936', '133d81bc3b4c48e7803bde263c887d8f', '117000', null, '市辖区', '01', '市辖区', '210501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a931713a606b4c92b9279967858d62e1', 'd3b62fa78aa843649485428da6b36015', null, null, '遵义市', '03', '遵义市', '520300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('413d723baf1e4e9a89d84bd05d36ff6c', 'd3b62fa78aa843649485428da6b36015', null, null, '安顺市', '04', '安顺市', '520400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6af6ff6ad30d464c8ab0883b16557eb7', 'd3b62fa78aa843649485428da6b36015', null, null, '铜仁地区', '22', '铜仁地区', '522200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e6c957a7e6764d25ae824740397d1146', 'd3b62fa78aa843649485428da6b36015', null, null, '黔西南布依族苗族自治州', '23', '黔西南布依族苗族自治州', '522300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3bc2acb5a13f41f68fd1926c57a97d79', 'd3b62fa78aa843649485428da6b36015', null, null, '毕节地区', '24', '毕节地区', '522400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eb15b91b9ab84251bc78527a6bc9f98a', 'd3b62fa78aa843649485428da6b36015', null, null, '黔东南苗族侗族自治州', '26', '黔东南苗族侗族自治州', '522600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('61b919f7685248a3bb577513bd98786c', 'd3b62fa78aa843649485428da6b36015', null, null, '黔南布依族苗族自治州', '27', '黔南布依族苗族自治州', '522700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5ab6b67e085546caa372b13ec883e55d', '876e69ae2bfa4251883a30c66df81480', null, null, '昆明市', '01', '昆明市', '530100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('32f1279ae35c4dd4bc2aff7a08755344', '876e69ae2bfa4251883a30c66df81480', null, null, '曲靖市', '03', '曲靖市', '530300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b32eb2d28ea84cacb3190db9a12588db', '876e69ae2bfa4251883a30c66df81480', null, null, '玉溪市', '04', '玉溪市', '530400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f5abf200b664ad595bc1a8c7098b9af', '876e69ae2bfa4251883a30c66df81480', null, null, '保山市', '05', '保山市', '530500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('71565bd32ec9492b81bb4ab47436ddf0', '876e69ae2bfa4251883a30c66df81480', null, null, '昭通市', '06', '昭通市', '530600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6b376cbe3f17409599ef29acccd2d5f0', '876e69ae2bfa4251883a30c66df81480', null, null, '丽江市', '07', '丽江市', '530700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6343ca91165140d1bcc25205a1235335', '876e69ae2bfa4251883a30c66df81480', null, null, '思茅市', '08', '思茅市', '530800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3ac67eb93544b9da681781f1f27fa5d', '876e69ae2bfa4251883a30c66df81480', null, null, '临沧市', '09', '临沧市', '530900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f9f4657fe4aa48bb8d324167750c9b1c', '876e69ae2bfa4251883a30c66df81480', null, null, '楚雄彝族自治州', '23', '楚雄彝族自治州', '532300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4ac9c25b5e964e4cae428ca3b28fd2c5', '876e69ae2bfa4251883a30c66df81480', null, null, '红河哈尼族彝族自治州', '25', '红河哈尼族彝族自治州', '532500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0a7b3b59379a4bb2a99de96b44f607df', '876e69ae2bfa4251883a30c66df81480', null, null, '文山壮族苗族自治州', '26', '文山壮族苗族自治州', '532600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fe36a09e2995441791c4e76473137fd8', '876e69ae2bfa4251883a30c66df81480', null, null, '西双版纳傣族自治州', '28', '西双版纳傣族自治州', '532800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f890338eab6453e9b4015b33fd8abfc', '876e69ae2bfa4251883a30c66df81480', null, null, '大理白族自治州', '29', '大理白族自治州', '532900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('45023fee4aae4edfb6a91ea17a0b368f', '876e69ae2bfa4251883a30c66df81480', null, null, '德宏傣族景颇族自治州', '31', '德宏傣族景颇族自治州', '533100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7009390a34474afe8e3122be8006dd75', '876e69ae2bfa4251883a30c66df81480', null, null, '怒江傈僳族自治州', '33', '怒江傈僳族自治州', '533300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d87d78ea6435473faf023cc21eabb452', '876e69ae2bfa4251883a30c66df81480', null, null, '迪庆藏族自治州', '34', '迪庆藏族自治州', '533400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c5b38e0ab90d494dad25c3d85b510cee', 'a7aed62816bb4066ab1be9188bfd8c35', null, null, '拉萨市', '01', '拉萨市', '540100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0f59a76aeef144489eaaf8edd763f507', 'a7aed62816bb4066ab1be9188bfd8c35', null, null, '昌都地区', '21', '昌都地区', '542100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0127cc2437fb4b1aab1311ed373da4d5', 'a7aed62816bb4066ab1be9188bfd8c35', null, null, '山南地区', '22', '山南地区', '542200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f146c88e9f61487e8187bcdc280e2897', 'a7aed62816bb4066ab1be9188bfd8c35', null, null, '日喀则地区', '23', '日喀则地区', '542300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ad1a12715fab4d57bf0bfdda2eb9db6a', 'a7aed62816bb4066ab1be9188bfd8c35', null, null, '那曲地区', '24', '那曲地区', '542400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('be59c52820d04d2c9b5c91d7f4dae34f', 'a7aed62816bb4066ab1be9188bfd8c35', null, null, '阿里地区', '25', '阿里地区', '542500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('83bc76056d074e4c94c5824d81e94650', 'a7aed62816bb4066ab1be9188bfd8c35', null, null, '林芝地区', '26', '林芝地区', '542600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('66d88b8406a8414580256a8811834fea', 'e6540d12ad4047daa20ff64b371161d6', null, null, '西安市', '01', '西安市', '610100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dc7a159373914f47badac80b9cf2017c', 'e6540d12ad4047daa20ff64b371161d6', null, null, '铜川市', '02', '铜川市', '610200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('82170bdd8f344d218a4c5ac36f7ecba1', 'e6540d12ad4047daa20ff64b371161d6', null, null, '宝鸡市', '03', '宝鸡市', '610300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a32c87dbe139417e9453b255f5e8245e', 'e6540d12ad4047daa20ff64b371161d6', null, null, '咸阳市', '04', '咸阳市', '610400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1c33dae1d58144d9b2fa688784875771', 'e6540d12ad4047daa20ff64b371161d6', null, null, '渭南市', '05', '渭南市', '610500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a5ab6a40f75e4885a2aa4e6137d9d84d', 'e6540d12ad4047daa20ff64b371161d6', null, null, '延安市', '06', '延安市', '610600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('626c4abdd9e94c4c86bc68b3da343b20', 'e6540d12ad4047daa20ff64b371161d6', null, null, '汉中市', '07', '汉中市', '610700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('288c789701ac4bcc8096dd8d85085239', 'e6540d12ad4047daa20ff64b371161d6', null, null, '榆林市', '08', '榆林市', '610800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b39593a949c4411ebe181f0f397daf3d', 'e6540d12ad4047daa20ff64b371161d6', null, null, '安康市', '09', '安康市', '610900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('96efc0d8bf4b4484adde54865b3e7c63', 'e6540d12ad4047daa20ff64b371161d6', null, null, '商洛市', '10', '商洛市', '611000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('53d713790c804ce1b1c4d65acd66b7a0', '247ea530058f4ff9a212f3b5649dc552', null, null, '兰州市', '01', '兰州市', '620100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3d08413da874670810bc7cb5e0ca7de', '247ea530058f4ff9a212f3b5649dc552', null, null, '嘉峪关市', '02', '嘉峪关市', '620200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c4e09846f7cc4ed69c3e6564e1c4d4ad', '247ea530058f4ff9a212f3b5649dc552', null, null, '金昌市', '03', '金昌市', '620300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('072c6981f53d4706a27a9d05225eafa2', '247ea530058f4ff9a212f3b5649dc552', null, null, '白银市', '04', '白银市', '620400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2388cbcd7b30404292f8e01ad88e6f8d', '247ea530058f4ff9a212f3b5649dc552', null, null, '天水市', '05', '天水市', '620500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fb52b2008d774fd2b47b94f855cd16ec', '247ea530058f4ff9a212f3b5649dc552', null, null, '武威市', '06', '武威市', '620600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1a27e665108d48c09c043c88ff56c67d', '247ea530058f4ff9a212f3b5649dc552', null, null, '张掖市', '07', '张掖市', '620700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0e2ee1874f68474c938f9443a89fcfb1', '247ea530058f4ff9a212f3b5649dc552', null, null, '平凉市', '08', '平凉市', '620800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3f166d4baf12434eb102caddab35da47', '247ea530058f4ff9a212f3b5649dc552', null, null, '酒泉市', '09', '酒泉市', '620900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1c075e3ccaa749859d5b0cecef73e511', '247ea530058f4ff9a212f3b5649dc552', null, null, '庆阳市', '10', '庆阳市', '621000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('624e4398f3b2409cbbda688316142235', '247ea530058f4ff9a212f3b5649dc552', null, null, '定西市', '11', '定西市', '621100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4032edf9271c4bb8868553b88b39f0a8', '247ea530058f4ff9a212f3b5649dc552', null, null, '陇南市', '12', '陇南市', '621200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c655ecb0f154555be84a4fbea473151', '247ea530058f4ff9a212f3b5649dc552', null, null, '临夏回族自治州', '29', '临夏回族自治州', '622900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1357e5dfbbf14671863b4ab27f3a49c5', '247ea530058f4ff9a212f3b5649dc552', null, null, '甘南藏族自治州', '30', '甘南藏族自治州', '623000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('08f84a76863048f9becb8841b144612a', '76aa51345f1441c7993b0f2a0f7f0acd', null, null, '西宁市', '01', '西宁市', '630100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ad6f5e8260eb417b92b45279a5eb6541', '76aa51345f1441c7993b0f2a0f7f0acd', null, null, '海东地区', '21', '海东地区', '632100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a74335d4de524feb84872d0b37ad5a91', '76aa51345f1441c7993b0f2a0f7f0acd', null, null, '海北藏族自治州', '22', '海北藏族自治州', '632200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ee978f1e33d6487199681886cb542a85', '76aa51345f1441c7993b0f2a0f7f0acd', null, null, '黄南藏族自治州', '23', '黄南藏族自治州', '632300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9ade5d5a68fb4caca8f084aee72998ce', '76aa51345f1441c7993b0f2a0f7f0acd', null, null, '海南藏族自治州', '25', '海南藏族自治州', '632500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7a81f15f33a24260be9be6bd5c899858', '76aa51345f1441c7993b0f2a0f7f0acd', null, null, '果洛藏族自治州', '26', '果洛藏族自治州', '632600', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dc53af9d04744ee0a57c7d0bbdf69f22', '76aa51345f1441c7993b0f2a0f7f0acd', null, null, '玉树藏族自治州', '27', '玉树藏族自治州', '632700', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dcd38da0a0c847798551ec50c280dab0', '76aa51345f1441c7993b0f2a0f7f0acd', null, null, '海西蒙古族藏族自治州', '28', '海西蒙古族藏族自治州', '632800', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('69256a8474b549efa757e0a17618ed51', '1884978b76d6469c871140b620617381', '314000', null, '秀洲区', '11', '秀洲区', '330411', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0da634a617854436bfdb79a93fe20187', null, null, null, '天津市', '12', '天津市', '120000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d4bd283cbd04c1c85722c6865f1b772', null, null, null, '河北省', '13', '河北省', '130000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f8761dec97040dfb75f459d1657a84b', null, null, null, '山西省', '14', '山西省', '140000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d5795820975447d090bdbd135c4e4edc', null, null, null, '内蒙古', '15', '内蒙古', '150000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2478110f8a104a189fb6f4a0eb4bde1c', null, null, null, '辽宁省', '21', '辽宁省', '210000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fd50361298cb470087d56f69e7734640', '31f843473a4d4710a5d8cb462ee84cd1', null, null, '莆田市', '03', '莆田市', '350300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('26697abbf2fb49239b261c010a69a343', null, null, null, '吉林省', '22', '吉林省', '220000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('909b15dd3d9c4c4b9aeee646b5ffc8a8', null, null, null, '黑龙江省', '23', '黑龙江省', '230000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3b6cce816ea04ff7b3dc68abeca243dd', null, null, null, '上海市', '31', '上海市', '310000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('02c8619f11814155982eb5b1873353bd', null, null, null, '江苏省', '32', '江苏省', '320000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ea63e61e420c4134be3db192220422f9', null, null, null, '浙江省', '33', '浙江省', '330000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('82f82898ec5d42a797e25a8039a7c1da', null, null, null, '安徽省', '34', '安徽省', '340000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('31f843473a4d4710a5d8cb462ee84cd1', null, null, null, '福建省', '35', '福建省', '350000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('89af740e57c443e8bf70af185481d025', null, null, null, '江西省', '36', '江西省', '360000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('43e6e48fca984902b2da31dc7babd4f5', null, null, null, '山东省', '37', '山东省', '370000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8c9c2e275ecb461fa3bd1039d130a011', null, null, null, '河南省', '41', '河南省', '410000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3cda75cb85e3483881ba373b0ef35585', null, null, null, '湖北省', '42', '湖北省', '420000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('33bc3bb1a9dc4533b9de70de59c1ec1c', null, null, null, '湖南省', '43', '湖南省', '430000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b51c615743e24581bf67975def934d06', null, null, null, '广东省', '44', '广东省', '440000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('47cf09ecda50413398cdf4afa27101e8', null, null, null, '广西', '45', '广西', '450000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c87dbdbabac04801a83a8f7c8070235e', null, null, null, '海南省', '46', '海南省', '460000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('005b3f1def644d8aae1231bb6c7499d5', null, null, null, '重庆市', '50', '重庆市', '500000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('79c341fcd1fe4b91a5d97cbb1a070068', null, null, null, '四川省', '51', '四川省', '510000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3b62fa78aa843649485428da6b36015', null, null, null, '贵州省', '52', '贵州省', '520000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('876e69ae2bfa4251883a30c66df81480', null, null, null, '云南省', '53', '云南省', '530000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a7aed62816bb4066ab1be9188bfd8c35', null, null, null, '西藏自治区', '54', '西藏自治区', '540000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e6540d12ad4047daa20ff64b371161d6', null, null, null, '陕西省', '61', '陕西省', '610000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('247ea530058f4ff9a212f3b5649dc552', null, null, null, '甘肃省', '62', '甘肃省', '620000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('76aa51345f1441c7993b0f2a0f7f0acd', null, null, null, '青海省', '63', '青海省', '630000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('862442793c45460da8884117d171c83d', null, null, null, '宁夏回族自治区', '64', '宁夏回族自治区', '640000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2f37fad27ab344108f4da87d9d21e767', null, null, null, '新疆维吾尔自治区', '65', '新疆维吾尔自治区', '650000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3c96b28c5ada4a2f825530c2b6759f57', null, null, null, '香港', '81', '香港', '810000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fcbe56f302194a42a7f51066cadc4577', null, null, null, '澳门', '82', '澳门', '820000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e0a610de3b241058546ad6c891fcfb4', null, null, null, '台湾', '71', '台湾', '710000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb2c98b3923c431da6a1566bc808c10g', 'b7aaf275ffe04792adcf47668fc7f7ba', null, null, '北京市', '01', '北京市', '110100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb2c98b3923c431da6a1566bc808c10f', '0da634a617854436bfdb79a93fe20187', null, null, '天津市', '01', '天津市', '120100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cbf57834e6314708abbbb577e400e698', '3d4bd283cbd04c1c85722c6865f1b772', null, null, '石家庄市', '01', '石家庄市', '130100', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eb9674438d3b4d568aa8119ea8881a91', '3d4bd283cbd04c1c85722c6865f1b772', null, null, '唐山市', '02', '唐山市', '130200', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0c198b04fac8436fbd64f504af86ed74', '3d4bd283cbd04c1c85722c6865f1b772', null, null, '秦皇岛市', '03', '秦皇岛市', '130300', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c6db83b3a6b24136bffb63610712f5de', '3d4bd283cbd04c1c85722c6865f1b772', null, null, '邯郸市', '04', '邯郸市', '130400', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b1661da6929548f58fc4ac41d14d2b89', '3d4bd283cbd04c1c85722c6865f1b772', null, null, '邢台市', '05', '邢台市', '130500', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ba486a249618479f92af7c2f6b1f7c12', 'c85fe163313c4fd78e007d8ab1d9a9c7', '222000', null, '新浦区', '05', '新浦区', '320705', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('92ed57654fcc4880adeb1b5d7929eb79', 'c85fe163313c4fd78e007d8ab1d9a9c7', '222000', null, '海州区', '06', '海州区', '320706', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5211809c31bd4f649c2a63b27f5f285c', 'c85fe163313c4fd78e007d8ab1d9a9c7', '222100', null, '赣榆县', '21', '赣榆县', '320721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c57da7fbefa74da3876cc04e0210e9ec', 'c85fe163313c4fd78e007d8ab1d9a9c7', '222300', null, '东海县', '22', '东海县', '320722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b38039cef91d4aa487db9e56b965f2cf', 'c85fe163313c4fd78e007d8ab1d9a9c7', '222200', null, '灌云县', '23', '灌云县', '320723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e32092cd4b5745d087156dbb6c6e3310', 'c85fe163313c4fd78e007d8ab1d9a9c7', '223500', null, '灌南县', '24', '灌南县', '320724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('725b7f33d6a14bf499f089df3316826b', '83fcca5dad594e5da9b2c4e7fe0c6ba8', '223000', null, '市辖区', '01', '市辖区', '320801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8cba31fcc0264e4bb8deee1fd7bff628', '83fcca5dad594e5da9b2c4e7fe0c6ba8', '223001', null, '清河区', '02', '清河区', '320802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('259abc9454f94100a81cb51d81b61d2d', '83fcca5dad594e5da9b2c4e7fe0c6ba8', '223200', null, '楚州区', '03', '楚州区', '320803', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e94cadfb8ff24d1aa574bb8ab173ff11', '83fcca5dad594e5da9b2c4e7fe0c6ba8', '223300', null, '淮阴区', '04', '淮阴区', '320804', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b96205cf03c546fa935493193778d0fe', '83fcca5dad594e5da9b2c4e7fe0c6ba8', '223001', null, '清浦区', '11', '清浦区', '320811', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2e160060ced44fe08facd0de9da5a2dd', '83fcca5dad594e5da9b2c4e7fe0c6ba8', '223400', null, '涟水县', '26', '涟水县', '320826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5718b689b7ec4067857dcf03d0ea3f6c', '83fcca5dad594e5da9b2c4e7fe0c6ba8', '223100', null, '洪泽县', '29', '洪泽县', '320829', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d51cca695b6d43b5a4726eb7e734e81e', '83fcca5dad594e5da9b2c4e7fe0c6ba8', '211700', null, '盱眙县', '30', '盱眙县', '320830', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ecfc1d5a3ae54cc292ca2e025331b7fb', '83fcca5dad594e5da9b2c4e7fe0c6ba8', '211600', null, '金湖县', '31', '金湖县', '320831', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('525740b0641947cbad72159c8d01525e', '789b2371daed489babc5ce0b82cf9bec', '224000', null, '市辖区', '01', '市辖区', '320901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5e619456f34c4f2eb643b00d2ba0e8a3', '789b2371daed489babc5ce0b82cf9bec', '224000', null, '亭湖区', '02', '亭湖区', '320902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1f2124a5beda40a594e6807689d9bf28', '789b2371daed489babc5ce0b82cf9bec', '224000', null, '盐都区', '03', '盐都区', '320903', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1dd8a44a4dbb4e78a9e93ada13f828e6', '789b2371daed489babc5ce0b82cf9bec', '224600', null, '响水县', '21', '响水县', '320921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a51db186566247cca8aa312bd746f41f', '789b2371daed489babc5ce0b82cf9bec', '224000', null, '滨海县', '22', '滨海县', '320922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1ad561cdc321463fba927b445ca7c275', '789b2371daed489babc5ce0b82cf9bec', '224400', null, '阜宁县', '23', '阜宁县', '320923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2ca15e927d3b49bca5d0b04fbea24666', '789b2371daed489babc5ce0b82cf9bec', '224300', null, '射阳县', '24', '射阳县', '320924', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e5314c25d3ab43eb88ca40f213a03a05', '789b2371daed489babc5ce0b82cf9bec', '224700', null, '建湖县', '25', '建湖县', '320925', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('411d10ca617a4b9bbffa29a2f3ee32af', '789b2371daed489babc5ce0b82cf9bec', '224200', null, '东台市', '81', '东台市', '320981', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('13de32c1839f47bc83412d585eba8770', '789b2371daed489babc5ce0b82cf9bec', '224100', null, '大丰市', '82', '大丰市', '320982', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7fb1c1006c4e4decb2a3909067087fcb', 'a9330bf8add64d57927ab4faae098a13', '225000', null, '市辖区', '01', '市辖区', '321001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('054ecc93f49e4424859a52fe2bf21c96', 'a9330bf8add64d57927ab4faae098a13', '225000', null, '广陵区', '02', '广陵区', '321002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5a83c9b6ae7443e9b84171664eed0d88', 'a9330bf8add64d57927ab4faae098a13', '225100', null, '邗江区', '03', '邗江区', '321003', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d8d1d1377b46421cb05c73c18a3aa116', 'a9330bf8add64d57927ab4faae098a13', '225200', null, '郊区', '11', '郊区', '321011', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4344b8efb04b40a3903639aafc525f2a', 'a9330bf8add64d57927ab4faae098a13', '225800', null, '宝应县', '23', '宝应县', '321023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a6a58dc9a64c46568e0d9e2c630da148', 'a9330bf8add64d57927ab4faae098a13', '211400', null, '仪征市', '81', '仪征市', '321081', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6cff6d7484af4247a0e15c18bd855e9f', 'a9330bf8add64d57927ab4faae098a13', '225600', null, '高邮市', '84', '高邮市', '321084', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('72fad3a4342b4272b9204c24569934ff', 'a9330bf8add64d57927ab4faae098a13', '225200', null, '江都市', '88', '江都市', '321088', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7a107ef6f3a84cd486c386f50a92b7d4', 'b34159526635417eac1df82dd9c7859b', '272600', null, '梁山县', '32', '梁山县', '370832', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6d9442998a6f4c04957abac513ceed24', '405b1da4465e49088c798360db70c15b', '623500', null, '黑水县', '28', '黑水县', '513228', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ea1b0c79a53746a9be38269d4fe30767', '405b1da4465e49088c798360db70c15b', '624000', null, '马尔康县', '29', '马尔康县', '513229', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('042daaa6b1c74e6cbf709bd62294cfa5', '405b1da4465e49088c798360db70c15b', '624300', null, '壤塘县', '30', '壤塘县', '513230', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('48a4e3ad7b7c4aef99e16d094c63e6f8', '405b1da4465e49088c798360db70c15b', '624600', null, '阿坝县', '31', '阿坝县', '513231', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2b5b80feff514d2a96219f989fe8a9f7', '405b1da4465e49088c798360db70c15b', '624500', null, '若尔盖县', '32', '若尔盖县', '513232', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('57d742d03fc4496caa5397527fed6189', '405b1da4465e49088c798360db70c15b', '624400', null, '红原县', '33', '红原县', '513233', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1745371df9c34ed188f308c83b123033', 'e2b4b10999ff41bbafb98f60bb00c0ae', '626000', null, '康定县', '21', '康定县', '513321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('43c161b5514e41ac8fcedba8137b13e7', 'e2b4b10999ff41bbafb98f60bb00c0ae', '626100', null, '泸定县', '22', '泸定县', '513322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2d9f076ec6054c7e85a1b9e5d8647130', 'e2b4b10999ff41bbafb98f60bb00c0ae', '626300', null, '丹巴县', '23', '丹巴县', '513323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('44021d2c808a4fc79a8d97315ad69416', 'e2b4b10999ff41bbafb98f60bb00c0ae', '616200', null, '九龙县', '24', '九龙县', '513324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('92658aeba461438a84cf2b43310d704d', 'e2b4b10999ff41bbafb98f60bb00c0ae', '627450', null, '雅江县', '25', '雅江县', '513325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0a6a33a30df048cb8f365399d4de2150', 'e2b4b10999ff41bbafb98f60bb00c0ae', '626400', null, '道孚县', '26', '道孚县', '513326', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('79bdb0c88df7448b999f7d52cf24f996', 'e2b4b10999ff41bbafb98f60bb00c0ae', '626500', null, '炉霍县', '27', '炉霍县', '513327', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eeb949e483384aa38887452ac4bb4a4a', 'e2b4b10999ff41bbafb98f60bb00c0ae', '626700', null, '甘孜县', '28', '甘孜县', '513328', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6d3019ca3cff48dcb8de803f7721b332', 'e2b4b10999ff41bbafb98f60bb00c0ae', '626800', null, '新龙县', '29', '新龙县', '513329', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e31b95c4e9da443ca425080b5d29eeba', 'e2b4b10999ff41bbafb98f60bb00c0ae', '627250', null, '德格县', '30', '德格县', '513330', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('99b79d41b2f242b4b029a205990fcb49', 'e2b4b10999ff41bbafb98f60bb00c0ae', '627150', null, '白玉县', '31', '白玉县', '513331', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0e954e02b0784e50a247a540f436b183', 'e2b4b10999ff41bbafb98f60bb00c0ae', '627350', null, '石渠县', '32', '石渠县', '513332', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ccf32b11307d409eb6afd172cba958eb', 'e2b4b10999ff41bbafb98f60bb00c0ae', '626600', null, '色达县', '33', '色达县', '513333', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('726310cdf3f7450daab08b4f5f22e883', 'e2b4b10999ff41bbafb98f60bb00c0ae', '624300', null, '理塘县', '34', '理塘县', '513334', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('602ea94a388a45b08124ac76e3aecba6', 'e2b4b10999ff41bbafb98f60bb00c0ae', '627650', null, '巴塘县', '35', '巴塘县', '513335', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('356698d25e9349a0b1bd4e216f40021b', 'e2b4b10999ff41bbafb98f60bb00c0ae', '627850', null, '乡城县', '36', '乡城县', '513336', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('acb83656d5d841e5932f16431fdb4522', 'e2b4b10999ff41bbafb98f60bb00c0ae', '627750', null, '稻城县', '37', '稻城县', '513337', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f9dcba4160304242bdb5596673c47787', 'e2b4b10999ff41bbafb98f60bb00c0ae', '627950', null, '得荣县', '38', '得荣县', '513338', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e2e565250da6481ea615b72505fed785', 'd6b0f77426fb44c690e4059d93094127', '615000', null, '西昌市', '01', '西昌市', '513401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('50ab07b6e7824a488f44b97ff4547014', 'd6b0f77426fb44c690e4059d93094127', '615800', null, '木里藏族自治县', '22', '木里藏族自治县', '513422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3e2cbd4f64f34c4d87f2057f49c9cb72', 'd6b0f77426fb44c690e4059d93094127', '615700', null, '盐源县', '23', '盐源县', '513423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dc70db69786f4b76adc4eaa1fccf2f12', 'd6b0f77426fb44c690e4059d93094127', '615500', null, '德昌县', '24', '德昌县', '513424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d9671e49f7384983ab769788353f36c3', 'd6b0f77426fb44c690e4059d93094127', '615100', null, '会理县', '25', '会理县', '513425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('74497faff4ed46d58bd0741eb0bf29d8', 'd6b0f77426fb44c690e4059d93094127', '615200', null, '会东县', '26', '会东县', '513426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e5c70a853a31485d82f970624939f199', 'd6b0f77426fb44c690e4059d93094127', '615400', null, '宁南县', '27', '宁南县', '513427', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('34c93656dbb044f8949f8947f9ab815a', 'd6b0f77426fb44c690e4059d93094127', '615300', null, '普格县', '28', '普格县', '513428', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c4d2193ca96e48fb99f77dd790f3c374', 'd6b0f77426fb44c690e4059d93094127', '615350', null, '布拖县', '29', '布拖县', '513429', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1c01397a6f394c878a69ac4e0c08faf5', 'd6b0f77426fb44c690e4059d93094127', '616250', null, '金阳县', '30', '金阳县', '513430', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('085a48cb84f04b7987e217408562202d', 'd6b0f77426fb44c690e4059d93094127', '616150', null, '昭觉县', '31', '昭觉县', '513431', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('389f5ae4c4684c9aa04f6df58940eb5b', 'd6b0f77426fb44c690e4059d93094127', '616750', null, '喜德县', '32', '喜德县', '513432', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8e864b49e998492c9f28a4ba7bba6a99', 'd6b0f77426fb44c690e4059d93094127', '615600', null, '冕宁县', '33', '冕宁县', '513433', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f7ca6189a14343b4ad2376d6703a6885', 'd6b0f77426fb44c690e4059d93094127', '616650', null, '越西县', '34', '越西县', '513434', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1c91b7c85b1045a780fb421fd9602cb6', 'd6b0f77426fb44c690e4059d93094127', '616850', null, '甘洛县', '35', '甘洛县', '513435', null);
commit;
----prompt 1000 records committed...
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f193e12564f54bb38445478efad16cb1', 'd6b0f77426fb44c690e4059d93094127', '616450', null, '美姑县', '36', '美姑县', '513436', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('94fd0e6a9a6d470cb980c1aa7cae3621', 'd6b0f77426fb44c690e4059d93094127', '616550', null, '雷波县', '37', '雷波县', '513437', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7441d72350e3452ea47ecba693712a4b', 'f8bee6d70b4d4aaebf536852686432c1', '550000', null, '市辖区', '01', '市辖区', '520101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2336f16c3d384e4d9b7d99b782b5ac4e', 'f8bee6d70b4d4aaebf536852686432c1', '550000', null, '南明区', '02', '南明区', '520102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d355100a65d248c493bce3c69036c3ac', 'f8bee6d70b4d4aaebf536852686432c1', '550000', null, '云岩区', '03', '云岩区', '520103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('021bd3d5f2b34160939622ad87e42a0a', 'f8bee6d70b4d4aaebf536852686432c1', '550000', null, '花溪区', '11', '花溪区', '520111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('032be45221e74de1a668e086370fd328', 'f8bee6d70b4d4aaebf536852686432c1', '550000', null, '乌当区', '12', '乌当区', '520112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('544e596e692a44f0b9c91602446b346d', 'f8bee6d70b4d4aaebf536852686432c1', '550000', null, '白云区', '13', '白云区', '520113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8fa99d1af30e48a696f3b51acf7340cd', 'f8bee6d70b4d4aaebf536852686432c1', '550000', null, '小河区', '14', '小河区', '520114', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d276d9abef214e09ab0cd122b7e5fdb4', 'f8bee6d70b4d4aaebf536852686432c1', '550300', null, '开阳县', '21', '开阳县', '520121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1956900f137640eea25d2c6906088b5f', 'f8bee6d70b4d4aaebf536852686432c1', '551100', null, '息烽县', '22', '息烽县', '520122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dc3719e3c28d4caa92d9304780744697', 'f8bee6d70b4d4aaebf536852686432c1', '550200', null, '修文县', '23', '修文县', '520123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('995497df634e4fa1b2faaa034f926e8b', 'f8bee6d70b4d4aaebf536852686432c1', '551400', null, '清镇市', '81', '清镇市', '520181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4d07e54dcd5442d5ac094f88d4f9082a', 'f027f86e80f547bd898e22f4695c1146', '553000', null, '钟山区', '01', '钟山区', '520201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('82b7e4d7ff14417882405ee52703e962', 'f027f86e80f547bd898e22f4695c1146', '553400', null, '六枝特区', '03', '六枝特区', '520203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ee4e9d7b98bf47458e883c25f732c133', 'f027f86e80f547bd898e22f4695c1146', '553000', null, '水城县', '21', '水城县', '520221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('24a75134e51c43a3a5e41a1fd8279392', 'f027f86e80f547bd898e22f4695c1146', '561600', null, '盘县', '22', '盘县', '520222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6b17e463b17d4170add96034d5762835', 'a931713a606b4c92b9279967858d62e1', '563000', null, '市辖区', '01', '市辖区', '520301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('94502a33c2a5436b8154e1990a547c4a', 'a931713a606b4c92b9279967858d62e1', '563000', null, '红花岗区', '02', '红花岗区', '520302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eb44f4efc81f4c999a11a4d7568c5fc4', '97727b55303e4938afa1eb316b3d58cb', '572300', null, '保亭黎族苗族自治县', '35', '保亭黎族苗族自治县', '469035', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ffffe5f24b7f4b23ad3c873ea46c3e90', '97727b55303e4938afa1eb316b3d58cb', '572900', null, '琼中黎族苗族自治县', '36', '琼中黎族苗族自治县', '469036', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ad3f30c1a86d43b3bd49dd6d9e4e3f68', '97727b55303e4938afa1eb316b3d58cb', '572000', null, '西沙群岛', '37', '西沙群岛', '469037', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('10d02bbd86ab478397276c2c3e6bc1fb', '97727b55303e4938afa1eb316b3d58cb', '572000', null, '南沙群岛', '38', '南沙群岛', '469038', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f957a689d42541d2b8ddb6bf06abeeb9', '97727b55303e4938afa1eb316b3d58cb', '572000', null, '中沙群岛的岛礁及其海域', '39', '中沙群岛的岛礁及其海域', '469039', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('072d6624adbb4a2090e7ec66be56e9f1', 'b980cca7c3e04419a36d045d0745ad97', '404100', null, '万州区', '01', '万州区', '500101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('98c9a9f0067447b493d50ee64293a9c2', '5944b21cd62d4404bab999965db12d4a', '533100', null, '凌云县', '27', '凌云县', '451027', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1a5de9b3761e4b01816258b257ba300b', 'e416c82c26c848c1a9532943280f7738', '617000', null, '东区', '02', '东区', '510402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b8160ab2a6aa4528a143c38c2b262a38', 'e416c82c26c848c1a9532943280f7738', '617000', null, '西区', '03', '西区', '510403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('94d56d47973f4296930fab55a1a824f0', 'e416c82c26c848c1a9532943280f7738', '617000', null, '仁和区', '11', '仁和区', '510411', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c487e3058e9e48028d28d494cb70303d', 'e416c82c26c848c1a9532943280f7738', '617200', null, '米易县', '21', '米易县', '510421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('036ce523ef374af0bc770a2770c39af2', 'e416c82c26c848c1a9532943280f7738', '617100', null, '盐边县', '22', '盐边县', '510422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8655b2a2bb3a418c8536736eb76e9e8a', '988dcd4876d041d190834258b0f2a8d4', '646000', null, '市辖区', '01', '市辖区', '510501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e79b1ca506d4536ac3d2896d4cc7004', '988dcd4876d041d190834258b0f2a8d4', '646000', null, '江阳区', '02', '江阳区', '510502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c4fd569521c54c46b2aab70472a842be', '988dcd4876d041d190834258b0f2a8d4', '646300', null, '纳溪区', '03', '纳溪区', '510503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0ee22ed3eb804a829711171d26be82b0', '988dcd4876d041d190834258b0f2a8d4', '646000', null, '龙马潭区', '04', '龙马潭区', '510504', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f9a4f31fe50c4fa3be83b439bd7f32a1', '988dcd4876d041d190834258b0f2a8d4', '646100', null, '泸县', '21', '泸县', '510521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d0109492c4354c6392ef341ce1570184', '988dcd4876d041d190834258b0f2a8d4', '646200', null, '合江县', '22', '合江县', '510522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('15f6d1c3e92145379a5077296392e80a', '988dcd4876d041d190834258b0f2a8d4', '646400', null, '叙永县', '24', '叙永县', '510524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0c11f69f2bc342208d5ec89744b1bb5b', '988dcd4876d041d190834258b0f2a8d4', '646500', null, '古蔺县', '25', '古蔺县', '510525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0eacb23d6ee44a81a84ee68f06814142', 'c87b68c64f854490888b630fbcbd0b15', '618000', null, '市辖区', '01', '市辖区', '510601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('14c000f26ae6428e90e333dbf17941e2', 'c87b68c64f854490888b630fbcbd0b15', '618000', null, '旌阳区', '03', '旌阳区', '510603', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a4765259b1e74ea0839f7fc6ecf315d1', 'c87b68c64f854490888b630fbcbd0b15', '618300', null, '中江县', '23', '中江县', '510623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e2101dbda660468da86f499d55554c7d', 'c87b68c64f854490888b630fbcbd0b15', '618500', null, '罗江县', '26', '罗江县', '510626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d4ffa145da704aff9bdb57ff29c35ea2', 'c87b68c64f854490888b630fbcbd0b15', '618300', null, '广汉市', '81', '广汉市', '510681', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0953dabc18c74a7cb26377c132d491fe', 'c87b68c64f854490888b630fbcbd0b15', '618400', null, '什邡市', '82', '什邡市', '510682', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eb42b27ab7f24e89bb04b417de99bcd9', 'c87b68c64f854490888b630fbcbd0b15', '618200', null, '绵竹市', '83', '绵竹市', '510683', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bfc1785f90874e1bbae4443d92cd8ac9', '48fb275bc9004d74aeb5ff42510ade11', '621000', null, '市辖区', '01', '市辖区', '510701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('425f27f955d04a1e8eeeeb84a301689d', '48fb275bc9004d74aeb5ff42510ade11', '621000', null, '涪城区', '03', '涪城区', '510703', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5bdfdcb11dbb47abbd7cad901bca2242', '48fb275bc9004d74aeb5ff42510ade11', '621000', null, '游仙区', '04', '游仙区', '510704', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('33ded9bd3c394f41b54a71f94f44fc69', '48fb275bc9004d74aeb5ff42510ade11', '621100', null, '三台县', '22', '三台县', '510722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('65a8a8eae0414a1788e1d6ae1a158f56', '48fb275bc9004d74aeb5ff42510ade11', '621600', null, '盐亭县', '23', '盐亭县', '510723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('85e053a732fe414c9bfd66e0c191e6c4', '48fb275bc9004d74aeb5ff42510ade11', '622650', null, '安县', '24', '安县', '510724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a3cd65f20d4e4d509db74e18922d99ed', '48fb275bc9004d74aeb5ff42510ade11', '622150', null, '梓潼县', '25', '梓潼县', '510725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('70bc5dce85e14a8ebad5a6ff829e1b3c', '48fb275bc9004d74aeb5ff42510ade11', '622550', null, '北川羌族自治县', '26', '北川羌族自治县', '510726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ff5e9a081ce143df8cf7991afa8c98bc', '48fb275bc9004d74aeb5ff42510ade11', '622550', null, '平武县', '27', '平武县', '510727', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e510ae334e594b8bb8cce07cf044a96d', '48fb275bc9004d74aeb5ff42510ade11', '621700', null, '江油市', '81', '江油市', '510781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8b70110e6dbf4bccba6bd72af06e12e6', '9d9c7883ebbe4190abfa32a3b2e001d6', '628000', null, '市辖区', '01', '市辖区', '510801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f7f56c8b8e504b2a9c48eb8e072bc7cf', '9d9c7883ebbe4190abfa32a3b2e001d6', '628000', null, '市中区', '02', '市中区', '510802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('565cc01b577e4be99a5269af3f9bfbe8', '9d9c7883ebbe4190abfa32a3b2e001d6', '628000', null, '元坝区', '11', '元坝区', '510811', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('03ff5136e55245c989ca13a982d1d280', '9d9c7883ebbe4190abfa32a3b2e001d6', '628000', null, '朝天区', '12', '朝天区', '510812', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b7b169ae33794e36b78e6674a1be87e1', '9d9c7883ebbe4190abfa32a3b2e001d6', '628200', null, '旺苍县', '21', '旺苍县', '510821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('56fc8afbf78e4eab9f466877322da2dc', '9d9c7883ebbe4190abfa32a3b2e001d6', '628100', null, '青川县', '22', '青川县', '510822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('662c44ba743a41068f928f3ff27d280d', '9d9c7883ebbe4190abfa32a3b2e001d6', '628300', null, '剑阁县', '23', '剑阁县', '510823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1c3e5aec3cbd4043b0d936b5a50ac86b', '9d9c7883ebbe4190abfa32a3b2e001d6', '628400', null, '苍溪县', '24', '苍溪县', '510824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7bc315dce4044c9aa8562e8fb14261ec', 'aded03dddeff43778b7b5b6f0c070a56', '629000', null, '市辖区', '01', '市辖区', '510901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0ba16625829348d989c8d66f62db6f42', 'aded03dddeff43778b7b5b6f0c070a56', '629000', null, '船山区', '03', '船山区', '510903', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c844f3170ac44bf690a1270af3aa9f7a', '0dc3aad6447a4a92818dc72d59bb1a44', '251200', null, '禹城市', '82', '禹城市', '371482', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b04cadc76785429d9499e8575094cc35', '54d95647b0ee4c219e70c84a2a74b396', '252000', null, '市辖区', '01', '市辖区', '371501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f4ee7612cf974ca0a22bbd0d12287449', '54d95647b0ee4c219e70c84a2a74b396', '252000', null, '东昌府区', '02', '东昌府区', '371502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('379e0a9de504445fa59908eea8bf297d', '54d95647b0ee4c219e70c84a2a74b396', '252300', null, '阳谷县', '21', '阳谷县', '371521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('85d1279d2ae44094bee6fba5255a836c', '54d95647b0ee4c219e70c84a2a74b396', '252400', null, '莘县', '22', '莘县', '371522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cc8c8e0550b34b4b84ecd9d7ef811c16', '54d95647b0ee4c219e70c84a2a74b396', '252100', null, '茌平县', '23', '茌平县', '371523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dbbc9414a6444451862ea87c9250f372', '54d95647b0ee4c219e70c84a2a74b396', '252200', null, '东阿县', '24', '东阿县', '371524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8df5e1a82ba1460eadb3c5d4ed41940b', '54d95647b0ee4c219e70c84a2a74b396', '252500', null, '冠县', '25', '冠县', '371525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e9efc3f3ba944469a18d5caf4b5d427d', '54d95647b0ee4c219e70c84a2a74b396', '252800', null, '高唐县', '26', '高唐县', '371526', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('af74dad0a0b740df899ccd0cc88e57f6', '54d95647b0ee4c219e70c84a2a74b396', '252600', null, '临清市', '81', '临清市', '371581', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f913555484d48f2b9d962a3811f4c12', '18d0a9122294487eb4aa8d5d6849ec93', '256600', null, '市辖区', '01', '市辖区', '371601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e274bbe6c6d48bcafc72775c5145558', '18d0a9122294487eb4aa8d5d6849ec93', '256600', null, '滨城区', '02', '滨城区', '371602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f40059e9c66d4921a5196ca35cae8805', '55b987a4d8ed49d99701fc0c6ad87720', '366200', null, '连城县', '25', '连城县', '350825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c0c95d892d1049d5b28b474ba4ada54a', '55b987a4d8ed49d99701fc0c6ad87720', '364400', null, '漳平市', '81', '漳平市', '350881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6205987226e440c6ab7d3bfe0e547888', '6fd17ced4f124cc4881a50ad26321855', '352000', null, '市辖区', '01', '市辖区', '350901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fa30b9c5258840869a16ccb72d65239f', '6fd17ced4f124cc4881a50ad26321855', '352000', null, '蕉城区', '02', '蕉城区', '350902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('200f03f97b5d46b882a46a39fc1b0344', '6fd17ced4f124cc4881a50ad26321855', '355100', null, '霞浦县', '21', '霞浦县', '350921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('170cb3ee7be248db87b8fceb9f27cabc', '6fd17ced4f124cc4881a50ad26321855', '352200', null, '古田县', '22', '古田县', '350922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d08d5950f83a4c7eaa9b44a3440f6262', '6fd17ced4f124cc4881a50ad26321855', '352300', null, '屏南县', '23', '屏南县', '350923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eff8ad44500b4a07969a3b0db262e787', 'fd50361298cb470087d56f69e7734640', '351100', null, '城厢区', '02', '城厢区', '350302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6304f8a3a03f422c8cd7922cb671a372', 'fd50361298cb470087d56f69e7734640', '351100', null, '涵江区', '03', '涵江区', '350303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('161e97a2dbf5448399ab6efe6a50296a', 'fd50361298cb470087d56f69e7734640', '351100', null, '荔城区', '04', '荔城区', '350304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('239eba3995ec4a7c937286ff57b02323', 'fd50361298cb470087d56f69e7734640', '351100', null, '秀屿区', '05', '秀屿区', '350305', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2482599d88ee4f53a2b1a97416a8157d', 'fd50361298cb470087d56f69e7734640', '351200', null, '仙游县', '22', '仙游县', '350322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f27f6c898cf3451d91199de25d311954', '75b39c1f74b445319410ef34beb28c3b', '365000', null, '市辖区', '01', '市辖区', '350401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e25c6236f58e4671a0deecefeb252d22', '75b39c1f74b445319410ef34beb28c3b', '365000', null, '梅列区', '02', '梅列区', '350402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f2b1d04534e44cf39b2c0b056468a77a', '75b39c1f74b445319410ef34beb28c3b', '365000', null, '三元区', '03', '三元区', '350403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('230fea32e84249a59b8c98c7c3a5ccd9', '75b39c1f74b445319410ef34beb28c3b', '365300', null, '明溪县', '21', '明溪县', '350421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8d218bec5bec49c984b95c565618b3c9', '75b39c1f74b445319410ef34beb28c3b', '365300', null, '清流县', '23', '清流县', '350423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('62c732f17abc4ed7bd566a876f25f784', '75b39c1f74b445319410ef34beb28c3b', '365400', null, '宁化县', '24', '宁化县', '350424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('884198b9f36d4c6a93158517ef626289', '75b39c1f74b445319410ef34beb28c3b', '366100', null, '大田县', '25', '大田县', '350425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f36658c4b1d440c7ad33615c130c0e97', '75b39c1f74b445319410ef34beb28c3b', '365100', null, '尤溪县', '26', '尤溪县', '350426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('acb95346e78b476fab566a31006090c6', '75b39c1f74b445319410ef34beb28c3b', '365500', null, '沙县', '27', '沙县', '350427', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('06130c2886e0492d914011b607e97e0e', '75b39c1f74b445319410ef34beb28c3b', '353300', null, '将乐县', '28', '将乐县', '350428', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4d8f048128d54b239c1f8f05cb35829b', '75b39c1f74b445319410ef34beb28c3b', '354400', null, '泰宁县', '29', '泰宁县', '350429', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('431f9557ae9f475d884b58025c7bd55c', '75b39c1f74b445319410ef34beb28c3b', '354500', null, '建宁县', '30', '建宁县', '350430', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb0c269fa6c54e52ad884ee208498833', '75b39c1f74b445319410ef34beb28c3b', '366000', null, '永安市', '81', '永安市', '350481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c3b97c19725f41dab1b7155e28302cd7', '60da25ef271a45e88a92c016ef7e469c', '362000', null, '市辖区', '01', '市辖区', '350501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6068847d8edd42cc84d04e290c5b79aa', '60da25ef271a45e88a92c016ef7e469c', '362000', null, '鲤城区', '02', '鲤城区', '350502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b8bba3d665124bda83996697970a9b50', '60da25ef271a45e88a92c016ef7e469c', '362000', null, '丰泽区', '03', '丰泽区', '350503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0ff6addd6dec488fa0398b54b65b24ee', '60da25ef271a45e88a92c016ef7e469c', '362000', null, '洛江区', '04', '洛江区', '350504', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('873afa1b97fc4194aa11037eb4b62d66', '60da25ef271a45e88a92c016ef7e469c', '362100', null, '泉港区', '05', '泉港区', '350505', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6540885201d448ddbae7f07e4b89607e', '60da25ef271a45e88a92c016ef7e469c', '362100', null, '惠安县', '21', '惠安县', '350521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fe4b3c8e56134b2e9c2115e48314bf74', '60da25ef271a45e88a92c016ef7e469c', '362400', null, '安溪县', '24', '安溪县', '350524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9e47a8aa7b4f4a49a37930d9c86aa3aa', '60da25ef271a45e88a92c016ef7e469c', '362600', null, '永春县', '25', '永春县', '350525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ec3bf607f9684099967489179f93ae03', '60da25ef271a45e88a92c016ef7e469c', '362500', null, '德化县', '26', '德化县', '350526', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9e5cd703373c4aae8411143dd2eb8b0c', '60da25ef271a45e88a92c016ef7e469c', '362000', null, '金门县', '27', '金门县', '350527', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2ebfe750008d46fba694e7ec11990253', '60da25ef271a45e88a92c016ef7e469c', '362700', null, '石狮市', '81', '石狮市', '350581', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('777bf8c15abe41c98f8a2ab9050b9e92', '60da25ef271a45e88a92c016ef7e469c', '362200', null, '晋江市', '82', '晋江市', '350582', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1beac1da384f419cb66fec83adedba4e', '60da25ef271a45e88a92c016ef7e469c', '362300', null, '南安市', '83', '南安市', '350583', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c1596533139d4105a2e773cc59c5830b', '523109f4617c4f9394d802e616806354', '363000', null, '市辖区', '01', '市辖区', '350601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0d97172992394666b9cdf32e4c1ee994', '523109f4617c4f9394d802e616806354', '363000', null, '芗城区', '02', '芗城区', '350602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('df60c2d48ac749b9945cfb7f5de86545', '523109f4617c4f9394d802e616806354', '363000', null, '龙文区', '03', '龙文区', '350603', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dd4a3a6c95a64d8da4a4cc4ff0946d28', '523109f4617c4f9394d802e616806354', '363300', null, '云霄县', '22', '云霄县', '350622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1c5d9c860ada4744b08207639684b798', '523109f4617c4f9394d802e616806354', '363200', null, '漳浦县', '23', '漳浦县', '350623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4cbb7449b7194f69b083f2ccf1a6b2f3', '523109f4617c4f9394d802e616806354', '363500', null, '诏安县', '24', '诏安县', '350624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e59ba2c5005a451bb9830205f96d1189', '523109f4617c4f9394d802e616806354', '363900', null, '长泰县', '25', '长泰县', '350625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f37291697ddc489893fb7cea9a498b3a', '523109f4617c4f9394d802e616806354', '363400', null, '东山县', '26', '东山县', '350626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('477442247f434c6d8e71af0ae27d7f1a', '523109f4617c4f9394d802e616806354', '363600', null, '南靖县', '27', '南靖县', '350627', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ca2fbfd531944c21bc44028cf730f4c5', '523109f4617c4f9394d802e616806354', '363700', null, '平和县', '28', '平和县', '350628', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('16049f668f2c4b138185296b396b5e2f', '523109f4617c4f9394d802e616806354', '363800', null, '华安县', '29', '华安县', '350629', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cb24ac8feb2a4a5cb152a4f958edff3e', '523109f4617c4f9394d802e616806354', '363100', null, '龙海市', '81', '龙海市', '350681', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('212d32bf814a48f5879f25c5499b49a4', '66c6fb2856b6486cad0f949d7c1045e3', '353000', null, '市辖区', '01', '市辖区', '350701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('88489217393b4fefabb31e030ea948e3', '66c6fb2856b6486cad0f949d7c1045e3', '353000', null, '延平区', '02', '延平区', '350702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6b9ca32a3a634a009d4fe0b9adf0e36b', '66c6fb2856b6486cad0f949d7c1045e3', '353200', null, '顺昌县', '21', '顺昌县', '350721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0bae3ae2d64940e1b0edc33b5b61fa6c', '66c6fb2856b6486cad0f949d7c1045e3', '353400', null, '浦城县', '22', '浦城县', '350722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d1aa081d36fe4ab0bff627cebb3aa15c', '66c6fb2856b6486cad0f949d7c1045e3', '354100', null, '光泽县', '23', '光泽县', '350723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b030bd996a8e4d739e9bc4a284f37224', '66c6fb2856b6486cad0f949d7c1045e3', '353500', null, '松溪县', '24', '松溪县', '350724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('340f6b359b944b9a84c44c4009fd3da4', '66c6fb2856b6486cad0f949d7c1045e3', '353600', null, '政和县', '25', '政和县', '350725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('602f9a027a914d7dbd867ace964c41eb', '66c6fb2856b6486cad0f949d7c1045e3', '354000', null, '邵武市', '81', '邵武市', '350781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('df5d0d4ca98b4573b0adfa96af2aced0', '66c6fb2856b6486cad0f949d7c1045e3', '354300', null, '武夷山市', '82', '武夷山市', '350782', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c4b86b7ee81e42bda12073886ac7cee0', '66c6fb2856b6486cad0f949d7c1045e3', '353100', null, '建瓯市', '83', '建瓯市', '350783', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('431ba40c7bda493ab42b6f18e30d2da3', '66c6fb2856b6486cad0f949d7c1045e3', '354200', null, '建阳市', '84', '建阳市', '350784', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8abdbe25a2404019a0d9fe0f0f14e14b', '55b987a4d8ed49d99701fc0c6ad87720', '364000', null, '市辖区', '01', '市辖区', '350801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0d2d4bc01ff34e74b2e28eab4755c5e8', '55b987a4d8ed49d99701fc0c6ad87720', '364000', null, '新罗区', '02', '新罗区', '350802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6a85a2612f234a659db7d816f4e01130', '55b987a4d8ed49d99701fc0c6ad87720', '366300', null, '长汀县', '21', '长汀县', '350821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3fdb604cb88e4463975337e4d31e9d32', '55b987a4d8ed49d99701fc0c6ad87720', '364100', null, '永定县', '22', '永定县', '350822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('301eb1f47e0f4809b17618e07707fa55', '55b987a4d8ed49d99701fc0c6ad87720', '364200', null, '上杭县', '23', '上杭县', '350823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3aee2ea9f5244f7cb5c2b8b5e4184528', '55b987a4d8ed49d99701fc0c6ad87720', '364300', null, '武平县', '24', '武平县', '350824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5d2171bade9c4c16b41c44f1ee63c7c5', 'b34159526635417eac1df82dd9c7859b', '272300', null, '鱼台县', '27', '鱼台县', '370827', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('68bd885c3a4941608fc7da9d5a7bbf76', 'a7a5db86046e4359b593d5bb51806516', '512200', null, '乐昌市', '81', '乐昌市', '440281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1efdeca6f1084c1b886905145e91e4da', 'a7a5db86046e4359b593d5bb51806516', '512400', null, '南雄市', '82', '南雄市', '440282', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8d76cd748b8e4f418752fba9d8e7488d', '6a4a9d34b6904464805411c3d91a1313', '518000', null, '市辖区', '01', '市辖区', '440301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fb3a7593af454dac9c62b75e384f3542', '6a4a9d34b6904464805411c3d91a1313', '518000', null, '罗湖区', '03', '罗湖区', '440303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('43296a0a150c4b7392dd69bdee0531a0', '6fd17ced4f124cc4881a50ad26321855', '355500', null, '寿宁县', '24', '寿宁县', '350924', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7c26dfdffbce47229f5b589b62873188', '8fdba2c226b74f689e9095d060a98cd2', '155800', null, '友谊县', '22', '友谊县', '230522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3cf4b71d6e0a49eb8d05a2d68f72bad3', '1f444db499d740989434bb11e14f54a3', '212000', null, '京口区', '02', '京口区', '321102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('607e3dae9454489b8627fdf4f22a7e0a', '1f444db499d740989434bb11e14f54a3', '212000', null, '润州区', '11', '润州区', '321111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('49506db6b05c4b0ca3c2e38da43b51e8', '1f444db499d740989434bb11e14f54a3', '212100', null, '丹徒区', '12', '丹徒区', '321112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('00b4283f86ba49e7811ee5a6a96a3e33', '1f444db499d740989434bb11e14f54a3', '212300', null, '丹阳市', '81', '丹阳市', '321181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c0e201198d504fa490757dc5273d7d6e', '1f444db499d740989434bb11e14f54a3', '212200', null, '扬中市', '82', '扬中市', '321182', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('be7c0c9c995745e3b8623f92d8c0d18f', '1f444db499d740989434bb11e14f54a3', '212400', null, '句容市', '83', '句容市', '321183', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('86152881188c473188e1cc0ea8b096f7', '835c9ac0e6824b37a4af2b626524362f', '225300', null, '市辖区', '01', '市辖区', '321201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aaaf5c46bb904915925635ff5564ba97', '835c9ac0e6824b37a4af2b626524362f', '225300', null, '海陵区', '02', '海陵区', '321202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('03cab6a7a0d4432c892f515775a83bf9', '835c9ac0e6824b37a4af2b626524362f', '225300', null, '高港区', '03', '高港区', '321203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('27d733bcf1ec49ea88c63a6bb83f42ce', '835c9ac0e6824b37a4af2b626524362f', '225700', null, '兴化市', '81', '兴化市', '321281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d550dc89cc994b798b9bc208375d781d', '835c9ac0e6824b37a4af2b626524362f', '214500', null, '靖江市', '82', '靖江市', '321282', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c39f7f5123a2412f8d5b5d18a118ece1', '835c9ac0e6824b37a4af2b626524362f', '225400', null, '泰兴市', '83', '泰兴市', '321283', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d2093255266431382238b91895cbd6b', '835c9ac0e6824b37a4af2b626524362f', '225500', null, '姜堰市', '84', '姜堰市', '321284', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('80d9ffe755054696869cbbf5af0bfd63', 'd6fe0afb4aec42bc8cb70ad349bfb31a', '223800', null, '市辖区', '01', '市辖区', '321301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fd20d19413a2400896a4ffae6b238e8b', 'd6fe0afb4aec42bc8cb70ad349bfb31a', '223800', null, '宿城区', '02', '宿城区', '321302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('07fc17040570474ba03ed63c309af86e', 'd6fe0afb4aec42bc8cb70ad349bfb31a', '223800', null, '宿豫区', '11', '宿豫区', '321311', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f35e49d1ed04fd5b4fc0da53742ea71', 'd6fe0afb4aec42bc8cb70ad349bfb31a', '223600', null, '沭阳县', '22', '沭阳县', '321322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('00ac7c4f83884f9d9d07d6a872bc8d9b', 'd6fe0afb4aec42bc8cb70ad349bfb31a', '223700', null, '泗阳县', '23', '泗阳县', '321323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('11cdee7dbfd34738a83b76de8d13aca1', 'd6fe0afb4aec42bc8cb70ad349bfb31a', '223900', null, '泗洪县', '24', '泗洪县', '321324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e10669f3c215465390156a14ff9da81f', '948adc095d0448cbbc8a28a43b126cd7', '310000', null, '市辖区', '01', '市辖区', '330101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5736c6f7f28e4823ac6330d2a375634b', '948adc095d0448cbbc8a28a43b126cd7', '310000', null, '上城区', '02', '上城区', '330102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2717334f9bfd40e8a2fdcdac868ac5ef', '948adc095d0448cbbc8a28a43b126cd7', '310000', null, '下城区', '03', '下城区', '330103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cc15cba827d24a71999a7d4d7676155c', '948adc095d0448cbbc8a28a43b126cd7', '310000', null, '江干区', '04', '江干区', '330104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('93c1db8a519f4e3d8454966efada6d15', '948adc095d0448cbbc8a28a43b126cd7', '310000', null, '拱墅区', '05', '拱墅区', '330105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b09f7f7e5c824d918c03240e196fe5c9', '948adc095d0448cbbc8a28a43b126cd7', '310000', null, '西湖区', '06', '西湖区', '330106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('47ac918e7354454c9791063dc6487161', '948adc095d0448cbbc8a28a43b126cd7', '310000', null, '滨江区', '08', '滨江区', '330108', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8c04b1a09f3a455c92dbd0fcfe42e0c3', '948adc095d0448cbbc8a28a43b126cd7', '311200', null, '萧山区', '09', '萧山区', '330109', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d97ec727dfe5429eae4a450ecc307de9', '948adc095d0448cbbc8a28a43b126cd7', '311100', null, '余杭区', '10', '余杭区', '330110', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('098bbcfff34c418ea5a898f12d724573', '948adc095d0448cbbc8a28a43b126cd7', '311500', null, '桐庐县', '22', '桐庐县', '330122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('930b9c431bcc4ef4a044a827e35f12d1', '948adc095d0448cbbc8a28a43b126cd7', '311700', null, '淳安县', '27', '淳安县', '330127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('baa02708f55a4de3a73adc25ad628690', '948adc095d0448cbbc8a28a43b126cd7', '311600', null, '建德市', '82', '建德市', '330182', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b50ecade13a649a5a75e6ca46def5a0c', '948adc095d0448cbbc8a28a43b126cd7', '311400', null, '富阳市', '83', '富阳市', '330183', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8701edc398484fa8a23bb94cbcd75b3a', '948adc095d0448cbbc8a28a43b126cd7', '311300', null, '临安市', '85', '临安市', '330185', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('587aa0d79b024f72bf93023d5ca8d848', 'b579455d7ae4445fb895e24f98caa299', '315000', null, '市辖区', '01', '市辖区', '330201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5e8025c7892c48f196c8a81e00ae426b', 'b579455d7ae4445fb895e24f98caa299', '315000', null, '海曙区', '03', '海曙区', '330203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0516bdd3f0e6454ab3b5c24df403387b', 'b579455d7ae4445fb895e24f98caa299', '315000', null, '江东区', '04', '江东区', '330204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a7f74552c2ff44bbbb0f66e59d6afa74', 'b579455d7ae4445fb895e24f98caa299', '315000', null, '江北区', '05', '江北区', '330205', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('956a6b84ef034366804640a448ca67fe', 'b579455d7ae4445fb895e24f98caa299', '315800', null, '北仑区', '06', '北仑区', '330206', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ceda6b11fb7b41cfabd4635220baa5b6', 'b579455d7ae4445fb895e24f98caa299', '315200', null, '镇海区', '11', '镇海区', '330211', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6095626675d84a6281b2cbc23a89e1f5', 'b579455d7ae4445fb895e24f98caa299', '315100', null, '鄞州区', '12', '鄞州区', '330212', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d499631212f44a6b9a7ffbde5a58f54', 'b579455d7ae4445fb895e24f98caa299', '315700', null, '象山县', '25', '象山县', '330225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('571cf67b0f49434cb051904cfe9a8227', 'b579455d7ae4445fb895e24f98caa299', '315600', null, '宁海县', '26', '宁海县', '330226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('acf540d2771c4af7bca198527488d4b1', 'b579455d7ae4445fb895e24f98caa299', '315400', null, '余姚市', '81', '余姚市', '330281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2519da1f494442b094fa373d520c0203', 'b579455d7ae4445fb895e24f98caa299', '315300', null, '慈溪市', '82', '慈溪市', '330282', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb5a188670354224ad45f1d64adf2161', 'b579455d7ae4445fb895e24f98caa299', '315500', null, '奉化市', '83', '奉化市', '330283', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e144ac66fd4541b8965dc3e8c1c87cfd', '725d382f33c54a83a7db831c3da82665', '325000', null, '市辖区', '01', '市辖区', '330301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aa37eee93c2f438884daf9951adbbddc', '725d382f33c54a83a7db831c3da82665', '325000', null, '鹿城区', '02', '鹿城区', '330302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f2dcbee7ad0c45d3ac7f048cd166046d', '725d382f33c54a83a7db831c3da82665', '325000', null, '龙湾区', '03', '龙湾区', '330303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('000a23afb49842958342afa196c056e8', '725d382f33c54a83a7db831c3da82665', '325000', null, '瓯海区', '04', '瓯海区', '330304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('72b01ef3704d4a79b60f3c0dceb5d156', '725d382f33c54a83a7db831c3da82665', '325700', null, '洞头县', '22', '洞头县', '330322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8b692bdfb1be4af7bd2224f1557aafa4', '725d382f33c54a83a7db831c3da82665', '325100', null, '永嘉县', '24', '永嘉县', '330324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0c990642780b477a9389311cc7cf5897', '725d382f33c54a83a7db831c3da82665', '325400', null, '平阳县', '26', '平阳县', '330326', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('28eb844182d74fa1bf153d6a2c228cc8', '725d382f33c54a83a7db831c3da82665', '325800', null, '苍南县', '27', '苍南县', '330327', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('99609fc8c205403bad849580b2dd6bf5', '725d382f33c54a83a7db831c3da82665', '325300', null, '文成县', '28', '文成县', '330328', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f39c62562d5c480d8b9794a00ce68807', '725d382f33c54a83a7db831c3da82665', '325500', null, '泰顺县', '29', '泰顺县', '330329', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('efcef8b9f2214295999e10fc98dcb211', '725d382f33c54a83a7db831c3da82665', '325200', null, '瑞安市', '81', '瑞安市', '330381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('adb37e5246504cd299d95e8c72e64c1b', '725d382f33c54a83a7db831c3da82665', '325600', null, '乐清市', '82', '乐清市', '330382', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('70e535782003463c8aedf8cbbe6909af', '1884978b76d6469c871140b620617381', '314000', null, '市辖区', '01', '市辖区', '330401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('da64ba27cb4c4230a498f8956c638c3d', '1884978b76d6469c871140b620617381', '314000', null, '南湖区', '02', '南湖区', '330402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('01c2ed127f874d32bdafdd97c591530c', 'a7a5db86046e4359b593d5bb51806516', '512600', null, '乳源瑶族自治县', '32', '乳源瑶族自治县', '440232', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('581a09e9b20e403bb3de1ae32f7260d0', '1884978b76d6469c871140b620617381', '314100', null, '嘉善县', '21', '嘉善县', '330421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c434ea5b2e474095b649ce4a77181d46', 'b34159526635417eac1df82dd9c7859b', '272200', null, '金乡县', '28', '金乡县', '370828', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('15d95077412b45cf9420bbb2b07c5fdd', 'b34159526635417eac1df82dd9c7859b', '272400', null, '嘉祥县', '29', '嘉祥县', '370829', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b3280d60acf24c90b0380bdf719313f2', 'b34159526635417eac1df82dd9c7859b', '272500', null, '汶上县', '30', '汶上县', '370830', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1fa8b9f960a04264acfcc359f0fbde38', 'b34159526635417eac1df82dd9c7859b', '273200', null, '泗水县', '31', '泗水县', '370831', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e4890c92cdf34a609e06cbff33d152a0', '77e868a833554971a102184336921723', '313000', null, '市辖区', '01', '市辖区', '330501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('26a0d0fd62cd4f239e224227f375e9f4', '21f243e300a74fb4abb0138b942daf00', '118000', null, '振安区', '04', '振安区', '210604', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fa1eeeec40db4e9f9e1e69631b502487', '21f243e300a74fb4abb0138b942daf00', '118200', null, '宽甸满族自治县', '24', '宽甸满族自治县', '210624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('01e25759bf9642829b708ff1d2863cff', '21f243e300a74fb4abb0138b942daf00', '118300', null, '东港市', '81', '东港市', '210681', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('185d7981be64419c93dab5b4208187fc', '21f243e300a74fb4abb0138b942daf00', '118100', null, '凤城市', '82', '凤城市', '210682', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e3c679951c0d46f3a32fed303df16a1d', '6cd8d97a762c424985e64493c40c3dd1', '121000', null, '市辖区', '01', '市辖区', '210701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c6fe52c63bed47138364ad2f5e75ea95', '6cd8d97a762c424985e64493c40c3dd1', '121000', null, '古塔区', '02', '古塔区', '210702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aa77c5a9a46646b48334c7ff4ec895a1', '6cd8d97a762c424985e64493c40c3dd1', '121000', null, '凌河区', '03', '凌河区', '210703', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0acf54cf67034f0eac3d5522d4e6abf3', '6cd8d97a762c424985e64493c40c3dd1', '121000', null, '太和区', '11', '太和区', '210711', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f4fffee7b2da4fc0803bdf3316d461fb', '6cd8d97a762c424985e64493c40c3dd1', '121400', null, '黑山县', '26', '黑山县', '210726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1b5c9c8950ac4fd6a6d24969a9746346', '6cd8d97a762c424985e64493c40c3dd1', '121100', null, '义县', '27', '义县', '210727', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ec3f265f5ab34fedaa4296edda1453f3', '6cd8d97a762c424985e64493c40c3dd1', '121200', null, '凌海市', '81', '凌海市', '210781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c31313e76df8422dbcabf38e927e3874', '6cd8d97a762c424985e64493c40c3dd1', '121300', null, '北镇市', '82', '北镇市', '210782', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dd26d804325a4dd0b45cadef323a3bff', '2395708e898b4fb59076a40fba93436a', '115000', null, '市辖区', '01', '市辖区', '210801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f3f870129c4440959a4a1818b5a2e61f', '2395708e898b4fb59076a40fba93436a', '115000', null, '站前区', '02', '站前区', '210802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2f98d5004ab84f5eb1cde9deefd0fd99', '2395708e898b4fb59076a40fba93436a', '115000', null, '西市区', '03', '西市区', '210803', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b86016aee1eb4f6f959979f734c34adb', '2395708e898b4fb59076a40fba93436a', '115000', null, '鲅鱼圈区', '04', '鲅鱼圈区', '210804', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7eeef746dfa94224b99b494d0cf5bd02', '2395708e898b4fb59076a40fba93436a', '115000', null, '老边区', '11', '老边区', '210811', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cc033d4d5e314fd1931322f0ccc4be18', '2395708e898b4fb59076a40fba93436a', '115200', null, '盖州市', '81', '盖州市', '210881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8e9d8c0353564435bcc951966d25db9f', '2395708e898b4fb59076a40fba93436a', '115100', null, '大石桥市', '82', '大石桥市', '210882', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0d9b09b6d1a641a08720b24653ae430c', '575d6ce067aa4da9a890efc1ee49b8d7', '123000', null, '市辖区', '01', '市辖区', '210901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3f757a611e7a438fad958500162de255', '575d6ce067aa4da9a890efc1ee49b8d7', '123000', null, '海州区', '02', '海州区', '210902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e8f47d594acd439883575aaef5a81c30', '575d6ce067aa4da9a890efc1ee49b8d7', '123000', null, '新邱区', '03', '新邱区', '210903', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9ecb53023b964d819722a578aee13019', '575d6ce067aa4da9a890efc1ee49b8d7', '123000', null, '太平区', '04', '太平区', '210904', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c76530a1a7c3451d9190dbc7dce6d023', '575d6ce067aa4da9a890efc1ee49b8d7', '123000', null, '清河门区', '05', '清河门区', '210905', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fbe3c43173ed4302a77167b5a76ece4e', '575d6ce067aa4da9a890efc1ee49b8d7', '123000', null, '细河区', '11', '细河区', '210911', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d76bda0003e841688728fc4f8ea32971', '575d6ce067aa4da9a890efc1ee49b8d7', '123100', null, '阜新蒙古族自治县', '21', '阜新蒙古族自治县', '210921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d21b287e8fc2408091128bb2846580a9', '575d6ce067aa4da9a890efc1ee49b8d7', '123200', null, '彰武县', '22', '彰武县', '210922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('650a3901705d443791e71b47fcc4ce7c', 'fb07ee3fe7964963bc75133a6263f5f2', '111000', null, '市辖区', '01', '市辖区', '211001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6cc6242ee76d4c70ae9a68ed87ada043', 'fb07ee3fe7964963bc75133a6263f5f2', '111000', null, '白塔区', '02', '白塔区', '211002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c6609649716b47528c93d8beb782c4f0', 'fb07ee3fe7964963bc75133a6263f5f2', '111000', null, '文圣区', '03', '文圣区', '211003', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1ab4498273f6445c8488e6084d01160d', 'fb07ee3fe7964963bc75133a6263f5f2', '111000', null, '宏伟区', '04', '宏伟区', '211004', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ad277dc72af14913bb08e3d5e8b14436', 'fb07ee3fe7964963bc75133a6263f5f2', '111000', null, '弓长岭区', '05', '弓长岭区', '211005', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('df884bc59bc44c2f8d011ec7169d8e03', 'fb07ee3fe7964963bc75133a6263f5f2', '111000', null, '太子河区', '11', '太子河区', '211011', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('318c39f75c2d490f90bf6b023c09fbca', 'fb07ee3fe7964963bc75133a6263f5f2', '111200', null, '辽阳县', '21', '辽阳县', '211021', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bba40d3f437d44f9ac42b12c8ff3f8e5', 'fb07ee3fe7964963bc75133a6263f5f2', '111300', null, '灯塔市', '81', '灯塔市', '211081', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2233e44aa96e48468e443776860745a0', 'bccb2f3371c549638fb5e083d7badfbf', '124000', null, '市辖区', '01', '市辖区', '211101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e165b1224b944e7aa15af1813429904f', 'bccb2f3371c549638fb5e083d7badfbf', '124000', null, '双台子区', '02', '双台子区', '211102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('144b53ca5ac043f0a7b0893993f6a474', 'bccb2f3371c549638fb5e083d7badfbf', '124000', null, '兴隆台区', '03', '兴隆台区', '211103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('27767901efb54a6eabf487ec1458c113', 'bccb2f3371c549638fb5e083d7badfbf', '124200', null, '大洼县', '21', '大洼县', '211121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b1ee3cbb839e4f36ad2f54399984c5ca', 'bccb2f3371c549638fb5e083d7badfbf', '124100', null, '盘山县', '22', '盘山县', '211122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('27a983718f054f729ccf0c375f37437d', '0e4703c44e4540d6b28fba9380400e92', '112000', null, '市辖区', '01', '市辖区', '211201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b8c67b5789524cadbc72456bf4a3f86a', '0e4703c44e4540d6b28fba9380400e92', '112000', null, '银州区', '02', '银州区', '211202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('85e2e3a4edbd4ef18cbaaf467caf676f', '0e4703c44e4540d6b28fba9380400e92', '112000', null, '清河区', '04', '清河区', '211204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b72c03c58f35495886de41e4c2eb3e8f', '0e4703c44e4540d6b28fba9380400e92', '112600', null, '铁岭县', '21', '铁岭县', '211221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e13181596cc8453a94934ebcc45a38a1', '0e4703c44e4540d6b28fba9380400e92', '112400', null, '西丰县', '23', '西丰县', '211223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6bc02373df724699bf5dfe533b0a44f0', '0e4703c44e4540d6b28fba9380400e92', '112500', null, '昌图县', '24', '昌图县', '211224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c84877df5d3743feb046b27ae5a4f20f', '0e4703c44e4540d6b28fba9380400e92', '112700', null, '调兵山市', '81', '调兵山市', '211281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ce83a32ade514101a81c496df7176667', '0e4703c44e4540d6b28fba9380400e92', '112300', null, '开原市', '82', '开原市', '211282', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e144745c2f02419ea51fb06cf9f2dce5', '15afb64f4c90488f9b38836c2eb77d18', '122000', null, '市辖区', '01', '市辖区', '211301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fcee618e3fdf407bad9e3755b87aaf63', '15afb64f4c90488f9b38836c2eb77d18', '122000', null, '双塔区', '02', '双塔区', '211302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('41139bba5c7f4ca9976caea52d523182', '15afb64f4c90488f9b38836c2eb77d18', '122000', null, '龙城区', '03', '龙城区', '211303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('244472bcc158478887218051902cf043', '15afb64f4c90488f9b38836c2eb77d18', '122000', null, '朝阳县', '21', '朝阳县', '211321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('10b71f97cf9446148758241492f425d2', '15afb64f4c90488f9b38836c2eb77d18', '122400', null, '建平县', '22', '建平县', '211322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c2199f912b0d4f709d266c0258f205df', '15afb64f4c90488f9b38836c2eb77d18', '122300', null, '喀喇沁左翼蒙古族自治县', '24', '喀喇沁左翼蒙古族自治县', '211324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('92a51226807249a0b5b0dbf7fe4883a2', '15afb64f4c90488f9b38836c2eb77d18', '122100', null, '北票市', '81', '北票市', '211381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5a70f37ea1cb49aca3849f4888bea683', '15afb64f4c90488f9b38836c2eb77d18', '122500', null, '凌源市', '82', '凌源市', '211382', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4bad214e20bc4c2b8990f4596517b2a8', 'f09d74ecd8c34b269879aa4c409cafcf', '125000', null, '市辖区', '01', '市辖区', '211401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('351e47b8b4ce446c8fe3d43d9657e220', 'f09d74ecd8c34b269879aa4c409cafcf', '125000', null, '连山区', '02', '连山区', '211402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('60177abd2721459bbe65872895867d10', 'f09d74ecd8c34b269879aa4c409cafcf', '125000', null, '龙港区', '03', '龙港区', '211403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dc54bebdee5649da9aca85db30f030b0', 'f09d74ecd8c34b269879aa4c409cafcf', '125000', null, '南票区', '04', '南票区', '211404', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fbcb06ef432c4e3ba0d9e35df6b02c38', 'f09d74ecd8c34b269879aa4c409cafcf', '125200', null, '绥中县', '21', '绥中县', '211421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('91b020b2073148bbae98de4e182921af', 'f09d74ecd8c34b269879aa4c409cafcf', '125300', null, '建昌县', '22', '建昌县', '211422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('449a60f98f3b4bf59a3810ca58eec7e8', 'f09d74ecd8c34b269879aa4c409cafcf', '125100', null, '兴城市', '81', '兴城市', '211481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('66507853a0524b4baacc873d0c585d3a', '3a3f1ba7751f47dabb57b457b678be60', '130000', null, '市辖区', '01', '市辖区', '220101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('86009786ef59423481ccf729c85ad646', '3a3f1ba7751f47dabb57b457b678be60', '130000', null, '南关区', '02', '南关区', '220102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c545b5e61c89405e9858d471c7aa8447', 'e3a4a4ba5c56445c92c6a4d932ae463e', '241200', null, '繁昌县', '22', '繁昌县', '340222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a418fad399bb450ea6222f9ca130d456', 'e3a4a4ba5c56445c92c6a4d932ae463e', '242400', null, '南陵县', '23', '南陵县', '340223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e035074f5c19450680841b568ea62cd0', 'a2c7a37f793c4880a33dd7ca60198d51', '233000', null, '市辖区', '01', '市辖区', '340301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cc72ff17e03d4339baba18d2da58078c', 'a2c7a37f793c4880a33dd7ca60198d51', '233000', null, '龙子湖区', '02', '龙子湖区', '340302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3897d1c35164405b87e1db88a665ba28', 'a2c7a37f793c4880a33dd7ca60198d51', '233000', null, '蚌山区', '03', '蚌山区', '340303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('34fad95836b74aa19652473ea791321b', 'a2c7a37f793c4880a33dd7ca60198d51', '233000', null, '禹会区', '04', '禹会区', '340304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4d0489d289924516a2a17be40cc9c799', 'a2c7a37f793c4880a33dd7ca60198d51', '233000', null, '淮上区', '11', '淮上区', '340311', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6daad8ef8cee48988795e504dbbba0ab', 'a2c7a37f793c4880a33dd7ca60198d51', '233400', null, '怀远县', '21', '怀远县', '340321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('77c088176d3a46a8bdcb4e9ad7bf3725', 'a2c7a37f793c4880a33dd7ca60198d51', '233300', null, '五河县', '22', '五河县', '340322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('40a7c907cc844c6f9b540f63858c3152', 'a2c7a37f793c4880a33dd7ca60198d51', '233700', null, '固镇县', '23', '固镇县', '340323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8f53a2e0a7de476e912447dc7e9c9e6b', 'eebd1b2f46a7490ead76d682d03caa3d', '232000', null, '市辖区', '01', '市辖区', '340401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0d48423755a649d881c47491a708c803', 'eebd1b2f46a7490ead76d682d03caa3d', '232000', null, '大通区', '02', '大通区', '340402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f7c6ba2e0aae4667aecc9c83e624443f', 'eebd1b2f46a7490ead76d682d03caa3d', '232000', null, '田家庵区', '03', '田家庵区', '340403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1126cebb418c444b88fb3e0956ac589b', 'eebd1b2f46a7490ead76d682d03caa3d', '232000', null, '谢家集区', '04', '谢家集区', '340404', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('914a70461cc0482c9359640276302bcc', 'eebd1b2f46a7490ead76d682d03caa3d', '232000', null, '八公山区', '05', '八公山区', '340405', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('55b006317acf45758da699bc559fb9ee', 'eebd1b2f46a7490ead76d682d03caa3d', '232000', null, '潘集区', '06', '潘集区', '340406', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('efd67f0ad9f24d178a4932d8c8e42b25', 'eebd1b2f46a7490ead76d682d03caa3d', '232100', null, '凤台县', '21', '凤台县', '340421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('68055edede11471cb283aa2d15619a38', '0d19c7615d3e4c3e882056f94b5aecae', '243000', null, '市辖区', '01', '市辖区', '340501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('880d1cce85424195bd28a8ec2ec0685d', '0d19c7615d3e4c3e882056f94b5aecae', '243000', null, '金家庄区', '02', '金家庄区', '340502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('69aa0530100a4515b5102df00e3c478b', '0d19c7615d3e4c3e882056f94b5aecae', '243000', null, '花山区', '03', '花山区', '340503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b80ee31fcf7c4283b986729747a934bf', '0d19c7615d3e4c3e882056f94b5aecae', '243000', null, '雨山区', '04', '雨山区', '340504', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('26f2274b4847491fa6a8b9617713b74a', '0d19c7615d3e4c3e882056f94b5aecae', '243100', null, '当涂县', '21', '当涂县', '340521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d1e1d5655b914aab8fb16f888a48a343', '99b8d897937b424c98d2d8f6a66e15bc', '235000', null, '市辖区', '01', '市辖区', '340601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0379dfe5ccdb4f948ada91a70c97e78c', '99b8d897937b424c98d2d8f6a66e15bc', '235000', null, '杜集区', '02', '杜集区', '340602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eb78c14ab7d04c07a165a1e3bc867afd', '99b8d897937b424c98d2d8f6a66e15bc', '235000', null, '相山区', '03', '相山区', '340603', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7c6500e4bd024417a49bf8cae710b34d', '99b8d897937b424c98d2d8f6a66e15bc', '235000', null, '烈山区', '04', '烈山区', '340604', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5555db112d9e4c17b7eb6a4f9f9e5ab9', '99b8d897937b424c98d2d8f6a66e15bc', '235100', null, '濉溪县', '21', '濉溪县', '340621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dd07fec1df0340ab9b2e11c7c585994d', 'db87ace1e601499894596f7ad2f1ec8a', '244000', null, '市辖区', '01', '市辖区', '340701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('846dc05914404999bf7f037864c37d5a', 'db87ace1e601499894596f7ad2f1ec8a', '244000', null, '铜官山区', '02', '铜官山区', '340702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e1b30a56af914e23a793028efcb0d94a', 'db87ace1e601499894596f7ad2f1ec8a', '244000', null, '狮子山区', '03', '狮子山区', '340703', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('184a16576f4042cd8944f644628dbf96', 'db87ace1e601499894596f7ad2f1ec8a', '244000', null, '郊区', '11', '郊区', '340711', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6d77b363e56344a092dcf6fb5fa45e15', 'db87ace1e601499894596f7ad2f1ec8a', '244100', null, '铜陵县', '21', '铜陵县', '340721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('69388ea3791c49a4b0fef572f9d6f677', 'b7a3e50258a6477c986d9617cb2da1ca', '246000', null, '市辖区', '01', '市辖区', '340801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9459e56dcefe4ae294cdabfa2920614b', 'b7a3e50258a6477c986d9617cb2da1ca', '246000', null, '迎江区', '02', '迎江区', '340802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('18d78fcf10f843e68ea6525d7d619089', 'b7a3e50258a6477c986d9617cb2da1ca', '246000', null, '大观区', '03', '大观区', '340803', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('66b91ce34d1244d08c4bf16320acdac1', 'b7a3e50258a6477c986d9617cb2da1ca', '246000', null, '郊区', '11', '郊区', '340811', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2bf210ebac2c4f27a4d8b5c0ea0fdf64', 'b7a3e50258a6477c986d9617cb2da1ca', '246100', null, '怀宁县', '22', '怀宁县', '340822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aac23674cbba4fd89cee1a89ab84a246', 'b7a3e50258a6477c986d9617cb2da1ca', '246700', null, '枞阳县', '23', '枞阳县', '340823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('83283312543f4fc79967b8f934653a57', 'b7a3e50258a6477c986d9617cb2da1ca', '246300', null, '潜山县', '24', '潜山县', '340824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a5d44d79ca5c4b1ca46ec4ac4cbc2cf6', 'b7a3e50258a6477c986d9617cb2da1ca', '246400', null, '太湖县', '25', '太湖县', '340825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0350f440b9e6463da1a2ae092c94643c', 'b7a3e50258a6477c986d9617cb2da1ca', '246500', null, '宿松县', '26', '宿松县', '340826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('70855c92d92e438d89029a97f72dfbb5', 'b7a3e50258a6477c986d9617cb2da1ca', '246200', null, '望江县', '27', '望江县', '340827', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('13fe7694f7114159bd6c049bac25bf9f', 'b7a3e50258a6477c986d9617cb2da1ca', '246600', null, '岳西县', '28', '岳西县', '340828', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('27af3fc8473c4232950c8def14a9b315', 'b7a3e50258a6477c986d9617cb2da1ca', '231400', null, '桐城市', '81', '桐城市', '340881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e81edb87b8aa4a17b7fec187ce2ad04a', 'aeb93b0d0bad495ebf128dfccc009d5a', '245000', null, '市辖区', '01', '市辖区', '341001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9770117d4f1f49fd929250c5ef39a0ec', 'aeb93b0d0bad495ebf128dfccc009d5a', '245000', null, '屯溪区', '02', '屯溪区', '341002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b3a355459e354e8ea6f7d202e950f51c', 'aeb93b0d0bad495ebf128dfccc009d5a', '245000', null, '黄山区', '03', '黄山区', '341003', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4061ef821a0c452e94eb55d8a1be7892', 'aeb93b0d0bad495ebf128dfccc009d5a', '245000', null, '徽州区', '04', '徽州区', '341004', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a1bfb9bbe5cc43878c4bc81132fe1c67', 'aeb93b0d0bad495ebf128dfccc009d5a', '245200', null, '歙县', '21', '歙县', '341021', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b8785c97e71e4335999894d6e7bec1e6', 'aeb93b0d0bad495ebf128dfccc009d5a', '245400', null, '休宁县', '22', '休宁县', '341022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d33ff72333e1406c8d43688457b7d728', 'aeb93b0d0bad495ebf128dfccc009d5a', '245500', null, '黟县', '23', '黟县', '341023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c9723d96f57e445a9c60b42541472f57', 'aeb93b0d0bad495ebf128dfccc009d5a', '245600', null, '祁门县', '24', '祁门县', '341024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4de82fdfe82e46e1b6469531f67e5eb4', '56f6e70756b24b2b9b6819c3263e4c19', '239000', null, '市辖区', '01', '市辖区', '341101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('28d4f616115e409d94a81cc2a2ae920c', '56f6e70756b24b2b9b6819c3263e4c19', '239000', null, '琅琊区', '02', '琅琊区', '341102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b2ef922320224fff91598b8b03a81f07', '56f6e70756b24b2b9b6819c3263e4c19', '239000', null, '南谯区', '03', '南谯区', '341103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('61b89cf7c9554f9288c6814d473bdfb4', '56f6e70756b24b2b9b6819c3263e4c19', '239200', null, '来安县', '22', '来安县', '341122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb2c72b4108f4810903a45b36f2d002b', '56f6e70756b24b2b9b6819c3263e4c19', '239500', null, '全椒县', '24', '全椒县', '341124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ebb75cce1c714ca9bab3d2542d6b1da2', '56f6e70756b24b2b9b6819c3263e4c19', '233200', null, '定远县', '25', '定远县', '341125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('952ba3fbde9e43208b9b7652ce1d94bc', '56f6e70756b24b2b9b6819c3263e4c19', '233100', null, '凤阳县', '26', '凤阳县', '341126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('db9e1859769c48bc93aecabb4c645c29', '56f6e70756b24b2b9b6819c3263e4c19', '239300', null, '天长市', '81', '天长市', '341181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6545b2fb4e7c4cf8ab155a1061716205', '56f6e70756b24b2b9b6819c3263e4c19', '239400', null, '明光市', '82', '明光市', '341182', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8a3737f115e0457fa0d2c6f418b19d7d', '5afe0ab733f946d2be079f263536d1e4', '236000', null, '市辖区', '01', '市辖区', '341201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8311b658e753469f814eac8b6c695f95', '5afe0ab733f946d2be079f263536d1e4', '236000', null, '颍州区', '02', '颍州区', '341202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('16225389c9954837836eadb757bb3409', '5afe0ab733f946d2be079f263536d1e4', '236000', null, '颍东区', '03', '颍东区', '341203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bca4060b0850431c9834dfbb0a6a3dee', '5afe0ab733f946d2be079f263536d1e4', '236000', null, '颍泉区', '04', '颍泉区', '341204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ebaba78a95c64d619be32cc75990d40e', '1f444db499d740989434bb11e14f54a3', '212000', null, '市辖区', '01', '市辖区', '321101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4aae268baa484480a2faa0d91f08b848', '8fdba2c226b74f689e9095d060a98cd2', '155600', null, '宝清县', '23', '宝清县', '230523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e5a81627e1b24b7682b23a1e1274cda1', '8fdba2c226b74f689e9095d060a98cd2', '155700', null, '饶河县', '24', '饶河县', '230524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8fc871b844cc46e79a3b43a60040f5ea', 'b4f698e29e7e44a5b58a6d86e8783e36', '163000', null, '市辖区', '01', '市辖区', '230601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('781f608c12e745adb93252e93d0f8db9', 'b4f698e29e7e44a5b58a6d86e8783e36', '163000', null, '萨尔图区', '02', '萨尔图区', '230602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8c0b757dc12a45beb0d09321a288de6a', 'b4f698e29e7e44a5b58a6d86e8783e36', '163000', null, '龙凤区', '03', '龙凤区', '230603', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1172b7ee4995491e9ad0bd6720f953d9', 'b4f698e29e7e44a5b58a6d86e8783e36', '163000', null, '让胡路区', '04', '让胡路区', '230604', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d38d2e1f0ee543b48e05b656b41894b1', 'b4f698e29e7e44a5b58a6d86e8783e36', '163000', null, '红岗区', '05', '红岗区', '230605', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3e3c2f1b76e74aa9b6516995fc152d3f', 'b4f698e29e7e44a5b58a6d86e8783e36', '163000', null, '大同区', '06', '大同区', '230606', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a6facd5cf4964f308c90c4270d68f88a', 'b4f698e29e7e44a5b58a6d86e8783e36', '166400', null, '肇州县', '21', '肇州县', '230621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e3ca9fc304c14cbcaf079c86394d36ea', 'b4f698e29e7e44a5b58a6d86e8783e36', '166500', null, '肇源县', '22', '肇源县', '230622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ee0fcd37b06948b6b04ef8f003e873c2', 'b4f698e29e7e44a5b58a6d86e8783e36', '166300', null, '林甸县', '23', '林甸县', '230623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('432193b4b22847f0a6e28ae706d7c415', 'b4f698e29e7e44a5b58a6d86e8783e36', '166200', null, '杜尔伯特蒙古族自治县', '24', '杜尔伯特蒙古族自治县', '230624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ebb8ce5f9aa242dbb9899032bc062714', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '市辖区', '01', '市辖区', '230701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2a7fa21cb5064a2792abd3c544e8872b', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '伊春区', '02', '伊春区', '230702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('498f631ba9954ea3a9a9cf5758756787', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '南岔区', '03', '南岔区', '230703', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4a0121873b424b71a63bfc791cc4ba7d', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '友好区', '04', '友好区', '230704', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('82557908d6b546b9b267b0f8cb196f94', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '西林区', '05', '西林区', '230705', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('58463741eeda4cfcb2f4fd02ef9f4b1c', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '翠峦区', '06', '翠峦区', '230706', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b56444055f3149ef862188a8735fe041', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '新青区', '07', '新青区', '230707', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b47aa47f9ae4450dba5c41fc883d71c7', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '美溪区', '08', '美溪区', '230708', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a0973c4359054282901d5167b3c1b0c7', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '金山屯区', '09', '金山屯区', '230709', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5bdc31bdafda4f95b73d0a0500f87556', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '五营区', '10', '五营区', '230710', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d6752f4054514b6790239a7f3653eee3', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '乌马河区', '11', '乌马河区', '230711', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('16332424a58d40a09b4b3b1f332b8735', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '汤旺河区', '12', '汤旺河区', '230712', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b763607e167c43dd92fb3e2d61baf152', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '带岭区', '13', '带岭区', '230713', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c2051debd3ff4b3eba0f9a58ad12c94d', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '乌伊岭区', '14', '乌伊岭区', '230714', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('879dfdaa23a34b72ad9ed52ba66942bd', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '红星区', '15', '红星区', '230715', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1bca219e170f46639a18b9699d3f0bd6', '31a1d04a3c394bf3bf77d67153cdc2c6', '153000', null, '上甘岭区', '16', '上甘岭区', '230716', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d6d6f1afed2049f8b93f63a80aa3304d', '31a1d04a3c394bf3bf77d67153cdc2c6', '153200', null, '嘉荫县', '22', '嘉荫县', '230722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('23ab35817ad34f4d9c9a77d7d403b8ac', '31a1d04a3c394bf3bf77d67153cdc2c6', '152500', null, '铁力市', '81', '铁力市', '230781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('30742d4a022240cc8c6cf4d36d2f9b81', '0625ff8646c740ae83931ea039f1d8ba', '154000', null, '市辖区', '01', '市辖区', '230801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('282e33532408422091b54737336100d0', '0625ff8646c740ae83931ea039f1d8ba', '154000', null, '永红区', '02', '永红区', '230802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('55f4b3480440442c9708165ae089028e', '0625ff8646c740ae83931ea039f1d8ba', '154000', null, '向阳区', '03', '向阳区', '230803', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('572885326711474291314d17022b4483', '0625ff8646c740ae83931ea039f1d8ba', '154000', null, '前进区', '04', '前进区', '230804', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('75ce21ae53664933b2afdc09b192808c', '0625ff8646c740ae83931ea039f1d8ba', '154000', null, '东风区', '05', '东风区', '230805', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5fadbfc8ab3848568e8b27d63c0957e0', '0625ff8646c740ae83931ea039f1d8ba', '154000', null, '郊区', '11', '郊区', '230811', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a22f4ed9b223450e8b353a8a4c81e85b', '0625ff8646c740ae83931ea039f1d8ba', '154400', null, '桦南县', '22', '桦南县', '230822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fdcba05183044ff9b7a8daf8ad198678', '0625ff8646c740ae83931ea039f1d8ba', '154300', null, '桦川县', '26', '桦川县', '230826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ab4f30aaeabb448c9dc5a9e75e8bd7dd', '0625ff8646c740ae83931ea039f1d8ba', '154700', null, '汤原县', '28', '汤原县', '230828', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5941f42fd2f3488c897d212c17c73153', '0625ff8646c740ae83931ea039f1d8ba', '156500', null, '抚远县', '33', '抚远县', '230833', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('32111dc57b3449f2ac5bfd3ad18e2d1b', '0625ff8646c740ae83931ea039f1d8ba', '156400', null, '同江市', '81', '同江市', '230881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bcd75377461c49ccad8b7e280f85b8b7', '0625ff8646c740ae83931ea039f1d8ba', '156100', null, '富锦市', '82', '富锦市', '230882', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('58fc684160df4b4f97dadd6353143132', '7d964b3b2e26428b8f12284ddf2654c4', '154600', null, '市辖区', '01', '市辖区', '230901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ae33b1d9babb4bee9daff7b75c4439b0', '7d964b3b2e26428b8f12284ddf2654c4', '154600', null, '新兴区', '02', '新兴区', '230902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('df1689565313495e98e6f4f64eb1d86f', '7d964b3b2e26428b8f12284ddf2654c4', '154600', null, '桃山区', '03', '桃山区', '230903', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6b73e354998e49dabc0ad4d75b929a2d', '7d964b3b2e26428b8f12284ddf2654c4', '154600', null, '茄子河区', '04', '茄子河区', '230904', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('093d946d75f44180b65afe6db2f6ab38', '7d964b3b2e26428b8f12284ddf2654c4', '154500', null, '勃利县', '21', '勃利县', '230921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f659b2e2e95445bd87e7779310fb5882', 'a850022c32f047a39f070ecdb64c10cf', '157000', null, '市辖区', '01', '市辖区', '231001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('977ee4a1bb1f44c4a324c3dfbc18406f', 'a850022c32f047a39f070ecdb64c10cf', '157000', null, '东安区', '02', '东安区', '231002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('35bcffe8f9394dd1b173eebd557d40f1', 'a850022c32f047a39f070ecdb64c10cf', '157000', null, '阳明区', '03', '阳明区', '231003', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6b6e219ea6384e0d9e52054429760b62', 'a850022c32f047a39f070ecdb64c10cf', '157000', null, '爱民区', '04', '爱民区', '231004', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5ed1b5856b93448188b80cf9d1042cce', 'a850022c32f047a39f070ecdb64c10cf', '157000', null, '西安区', '05', '西安区', '231005', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d614668b3f784d8085a04171454ff4bf', 'a850022c32f047a39f070ecdb64c10cf', '157200', null, '东宁县', '24', '东宁县', '231024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f46a81ccce4547eda36fb11152bc5cb2', 'a850022c32f047a39f070ecdb64c10cf', '157600', null, '林口县', '25', '林口县', '231025', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('10049a1cbbec410d89fdf803e31ffd79', 'a850022c32f047a39f070ecdb64c10cf', '157300', null, '绥芬河市', '81', '绥芬河市', '231081', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('efc401cd8f034585b1241d28b897090d', 'a850022c32f047a39f070ecdb64c10cf', '157100', null, '海林市', '83', '海林市', '231083', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('04211cbbe33d4d48b012601c0a0554af', 'a850022c32f047a39f070ecdb64c10cf', '157400', null, '宁安市', '84', '宁安市', '231084', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5a38a5ccfe964d15a2282059dfc4fbbb', 'a850022c32f047a39f070ecdb64c10cf', '157500', null, '穆棱市', '85', '穆棱市', '231085', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('31a9972d3faf4e5f87a9e72271539d85', 'e94124d72ea049559b68d29c33d5e9f6', '164300', null, '市辖区', '01', '市辖区', '231101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b7b6ce62f4484ad69b3e75cf5d0b8d26', 'e94124d72ea049559b68d29c33d5e9f6', '164300', null, '爱辉区', '02', '爱辉区', '231102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('33058f790b7e40b2905b3ebc781607fb', 'e94124d72ea049559b68d29c33d5e9f6', '161400', null, '嫩江县', '21', '嫩江县', '231121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bfa6e45f36c443edae6f22c0f0b2b5d5', 'e94124d72ea049559b68d29c33d5e9f6', '164400', null, '逊克县', '23', '逊克县', '231123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f8190800e96748a5ba4fc3bff8977597', 'e94124d72ea049559b68d29c33d5e9f6', '164200', null, '孙吴县', '24', '孙吴县', '231124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('200f05ac43bf4724993d6eb0ec3f1c37', 'e94124d72ea049559b68d29c33d5e9f6', '164000', null, '北安市', '81', '北安市', '231181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4348feb984564409bbe7fe14df0fb7f0', 'e94124d72ea049559b68d29c33d5e9f6', '164100', null, '五大连池市', '82', '五大连池市', '231182', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('09ae4d4ff7164d27b23e80d47f0723bf', '0700bce39eff4bbaad9989a4e5283ea5', '152000', null, '市辖区', '01', '市辖区', '231201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ad5f12bc958249e6b382f4517d403ceb', '5afe0ab733f946d2be079f263536d1e4', '236400', null, '临泉县', '21', '临泉县', '341221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3446e5f50f6b4c38ba28a24459b3a2b6', '5afe0ab733f946d2be079f263536d1e4', '236600', null, '太和县', '22', '太和县', '341222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('64073cab574c49e186553d9a1d7bfef8', '5afe0ab733f946d2be079f263536d1e4', '236300', null, '阜南县', '25', '阜南县', '341225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3310a693169d4b9dbda53fb3dab3b3fa', '5afe0ab733f946d2be079f263536d1e4', '236200', null, '颍上县', '26', '颍上县', '341226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ebeece7cbde3497693d45b3aee28cffc', '5afe0ab733f946d2be079f263536d1e4', '236500', null, '界首市', '82', '界首市', '341282', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('803432fb639640c5a451108c30307528', 'cc3bd80ea79c413ea58d4d69cb283e70', '234000', null, '市辖区', '01', '市辖区', '341301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('77273e6cf4314ae8bc8545e8c0c63361', 'cc3bd80ea79c413ea58d4d69cb283e70', '234000', null, '埇桥区', '02', '埇桥区', '341302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bf884db13686483993e698cd66a02cdd', 'cc3bd80ea79c413ea58d4d69cb283e70', '235300', null, '砀山县', '21', '砀山县', '341321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('473d139842e14a108a1051e415a3be4b', 'cc3bd80ea79c413ea58d4d69cb283e70', '235200', null, '萧县', '22', '萧县', '341322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f979b11a7cd64916aaf26001dcdd78b0', 'cc3bd80ea79c413ea58d4d69cb283e70', '234200', null, '灵璧县', '23', '灵璧县', '341323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('23fd3ef07a974fcea71217132ee5a92a', 'cc3bd80ea79c413ea58d4d69cb283e70', '234300', null, '泗县', '24', '泗县', '341324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ac3e68541bfa417c8ccf77f7da14367f', '3777ebad7996423cb39c8c8a5eef1038', '238000', null, '市辖区', '01', '市辖区', '341401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('83bcd68856c849389bfa8f8105f2cee2', '3777ebad7996423cb39c8c8a5eef1038', '238000', null, '居巢区', '02', '居巢区', '341402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('52aba24e84b34a2ba991ab4e4528157d', '3777ebad7996423cb39c8c8a5eef1038', '231500', null, '庐江县', '21', '庐江县', '341421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('72445728f72548e68d4fa67b13967246', '3777ebad7996423cb39c8c8a5eef1038', '238300', null, '无为县', '22', '无为县', '341422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2291f4d66462437bbff20eee81813853', '3777ebad7996423cb39c8c8a5eef1038', '238100', null, '含山县', '23', '含山县', '341423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('88075f9ee8db466b9615af091e24bed5', '3777ebad7996423cb39c8c8a5eef1038', '238200', null, '和县', '24', '和县', '341424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('38c616a339d341628d380f40d05650ae', 'aabcff251e8d49538a041fd8a1992561', '237000', null, '市辖区', '01', '市辖区', '341501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c4999c0def34510a9edf05fc7173e61', 'aabcff251e8d49538a041fd8a1992561', '237000', null, '金安区', '02', '金安区', '341502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d782133b494248aeb1649c93fbe11fb6', 'aabcff251e8d49538a041fd8a1992561', '237000', null, '裕安区', '03', '裕安区', '341503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ddf924e8456441f1a3f307ed4b84bd5c', 'aabcff251e8d49538a041fd8a1992561', '232200', null, '寿县', '21', '寿县', '341521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b793670d765c4d44bdadeb143e36e430', 'aabcff251e8d49538a041fd8a1992561', '237400', null, '霍邱县', '22', '霍邱县', '341522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a016b72304324e389caa47f3048b588a', 'aabcff251e8d49538a041fd8a1992561', '231300', null, '舒城县', '23', '舒城县', '341523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('25ced09498db461a89010931b73b7e22', 'aabcff251e8d49538a041fd8a1992561', '237300', null, '金寨县', '24', '金寨县', '341524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6bd8496ea3a443dd8e1dab1d52110e27', 'aabcff251e8d49538a041fd8a1992561', '237200', null, '霍山县', '25', '霍山县', '341525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fe8cd4d025ab4c4cbf561b183df5c28b', 'e78a8a06ed6b4b469f72d85bcf4331af', '236000', null, '市辖区', '01', '市辖区', '341601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1ff27b20457d4697ae0cd4f8ab66dcbf', 'e78a8a06ed6b4b469f72d85bcf4331af', '236800', null, '谯城区', '02', '谯城区', '341602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('59d54c4d675343f6bcb08a896b284778', 'e78a8a06ed6b4b469f72d85bcf4331af', '233600', null, '涡阳县', '21', '涡阳县', '341621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aff9a208b35a4c4494f24ebca295ce8b', 'e78a8a06ed6b4b469f72d85bcf4331af', '233500', null, '蒙城县', '22', '蒙城县', '341622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('00f66539cb264b73893af57b369338ee', 'e78a8a06ed6b4b469f72d85bcf4331af', '236700', null, '利辛县', '23', '利辛县', '341623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a061810064b448479092bda909f963ab', '77f0da77ecc84e2c9cdd0bf884cb7437', '247100', null, '市辖区', '01', '市辖区', '341701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bdb18f5db4344a4f868de64d9612db0f', '77f0da77ecc84e2c9cdd0bf884cb7437', '247100', null, '贵池区', '02', '贵池区', '341702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d8b68adacd0943c09f84983467f8b8cc', '77f0da77ecc84e2c9cdd0bf884cb7437', '247200', null, '东至县', '21', '东至县', '341721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('44cfaaedfc664c7ebfcbb2ab61faf7df', '77f0da77ecc84e2c9cdd0bf884cb7437', '245100', null, '石台县', '22', '石台县', '341722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('527dc0823bf34a289df763f46ba356b2', '77f0da77ecc84e2c9cdd0bf884cb7437', '242800', null, '青阳县', '23', '青阳县', '341723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ce685c44dedc43e08f4a67a3d197b496', '915283302a1448d8a6a5f4c3fe3811b7', '242000', null, '市辖区', '01', '市辖区', '341801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('df505a68e00b4528bdafbe494e3bd629', '915283302a1448d8a6a5f4c3fe3811b7', '242000', null, '宣州区', '02', '宣州区', '341802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b25e725af9aa486f9a8edf2937b088d2', '915283302a1448d8a6a5f4c3fe3811b7', '242100', null, '郎溪县', '21', '郎溪县', '341821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ba73766db08d498493b7a6f4a2a23655', '915283302a1448d8a6a5f4c3fe3811b7', '242200', null, '广德县', '22', '广德县', '341822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7716baa88da94b4fbd2f663707d822f5', '915283302a1448d8a6a5f4c3fe3811b7', '242500', null, '泾县', '23', '泾县', '341823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f92ccc83cd864b6cb7396a801a3d271d', '915283302a1448d8a6a5f4c3fe3811b7', '245300', null, '绩溪县', '24', '绩溪县', '341824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ac95ec24a2c5497981a4bda87d6f7127', '915283302a1448d8a6a5f4c3fe3811b7', '242600', null, '旌德县', '25', '旌德县', '341825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a514d8b93fca470ebeeacac4040ee3c3', '915283302a1448d8a6a5f4c3fe3811b7', '242300', null, '宁国市', '81', '宁国市', '341881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ca637844836a4be4a3cba03bb143e209', '61188ed689124e8693ad2da355082375', '350000', null, '市辖区', '01', '市辖区', '350101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c8fa8e0ed451473f83b9426a003470ed', '61188ed689124e8693ad2da355082375', '350000', null, '鼓楼区', '02', '鼓楼区', '350102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3a2b86ed09a4dd5aec08f95f4dd3f7a', '61188ed689124e8693ad2da355082375', '350000', null, '台江区', '03', '台江区', '350103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aa1f2cebe7cd4a999ae5a94929fdd2e8', '61188ed689124e8693ad2da355082375', '350000', null, '仓山区', '04', '仓山区', '350104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8465a29adc154eee81364eae69e470c9', '61188ed689124e8693ad2da355082375', '350000', null, '马尾区', '05', '马尾区', '350105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f6a5a3f2a714522bf8f953a69ae8a75', '61188ed689124e8693ad2da355082375', '350000', null, '晋安区', '11', '晋安区', '350111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2d300ae0b0744d00925d61c9eb1dec63', '61188ed689124e8693ad2da355082375', '350100', null, '闽侯县', '21', '闽侯县', '350121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b07f27b7294d47c281c85c45e70b781c', '61188ed689124e8693ad2da355082375', '350500', null, '连江县', '22', '连江县', '350122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d59fdd5c93df4dabbced5c90be580a8d', '61188ed689124e8693ad2da355082375', '350600', null, '罗源县', '23', '罗源县', '350123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3ebf4dc2c5264f45a265411023a289d3', '61188ed689124e8693ad2da355082375', '350800', null, '闽清县', '24', '闽清县', '350124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8a2f937b8f13454d873619b6e826b1c7', '61188ed689124e8693ad2da355082375', '350700', null, '永泰县', '25', '永泰县', '350125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c25f6e5a154d48c0a672ca9e00f9ba14', '61188ed689124e8693ad2da355082375', '350400', null, '平潭县', '28', '平潭县', '350128', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('69ed063169e14a04a6367432d8954829', '61188ed689124e8693ad2da355082375', '350300', null, '福清市', '81', '福清市', '350181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ffd0fcb91e2d49a7981468487f136c72', '61188ed689124e8693ad2da355082375', '350200', null, '长乐市', '82', '长乐市', '350182', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d06a85e71c6b4a9ea191eed13701ac8b', 'c600d641b3d3489399d3557c9bc5e188', '361000', null, '市辖区', '01', '市辖区', '350201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dba5294e365e4589909d620c132afecf', 'c600d641b3d3489399d3557c9bc5e188', '361000', null, '思明区', '03', '思明区', '350203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aebd90dd4174405f99b957c349b7888e', 'c600d641b3d3489399d3557c9bc5e188', '361000', null, '海沧区', '05', '海沧区', '350205', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('65d7445f2b45477a9439dd08d389b616', 'c600d641b3d3489399d3557c9bc5e188', '361000', null, '湖里区', '06', '湖里区', '350206', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fd0ecf95f4d14f99a702c99eb258103d', 'c600d641b3d3489399d3557c9bc5e188', '361000', null, '集美区', '11', '集美区', '350211', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('11a93981e87e4435b7edebb2b3c560d9', 'c600d641b3d3489399d3557c9bc5e188', '361100', null, '同安区', '12', '同安区', '350212', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('89df18fe42c84676a709b5560cf448b7', 'c600d641b3d3489399d3557c9bc5e188', '361100', null, '翔安区', '13', '翔安区', '350213', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('52dcab395e094cd3b92eebba8c47b867', 'fd50361298cb470087d56f69e7734640', '351100', null, '市辖区', '01', '市辖区', '350301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('de7f6d3a4e164c2b9462cdb56fce70b7', '02f726a87a1e43ddb4fac108dd68b46b', '133400', null, '龙井市', '05', '龙井市', '222405', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f749828e3ac4e3e9419235c75ebcbef', 'b34159526635417eac1df82dd9c7859b', '273100', null, '曲阜市', '81', '曲阜市', '370881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9233f51b822b4101bee09103e8632b49', '77e868a833554971a102184336921723', '313000', null, '吴兴区', '02', '吴兴区', '330502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('676cdbb1fbad4598a2d4958f5294a2e9', '77e868a833554971a102184336921723', '313000', null, '南浔区', '03', '南浔区', '330503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e61d1d4e963945ee8379867e337a53ce', '77e868a833554971a102184336921723', '313200', null, '德清县', '21', '德清县', '330521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c0305ad197b846f7a1d55c7fa7daffb8', '77e868a833554971a102184336921723', '313100', null, '长兴县', '22', '长兴县', '330522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fecdfd4f36bd4321935ae821c2203a9e', '77e868a833554971a102184336921723', '313300', null, '安吉县', '23', '安吉县', '330523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ed354b5991d04bd5813fb60e38b04590', '962cb7e4670547ffb73d8ee3b44532dd', '312000', null, '市辖区', '01', '市辖区', '330601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('138a4619e4ec4293b98665c4411d9da2', '962cb7e4670547ffb73d8ee3b44532dd', '312000', null, '越城区', '02', '越城区', '330602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a24dda2385b046b4aca2739997af8f78', '962cb7e4670547ffb73d8ee3b44532dd', '312000', null, '绍兴县', '21', '绍兴县', '330621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('42cd4a6788ef4f40a7bd7c6152f0b79d', '962cb7e4670547ffb73d8ee3b44532dd', '312500', null, '新昌县', '24', '新昌县', '330624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('832b8a02206240ebba4288c84c36c018', '962cb7e4670547ffb73d8ee3b44532dd', '311800', null, '诸暨市', '81', '诸暨市', '330681', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('458f1f899151416ca205c1c60b83b572', '962cb7e4670547ffb73d8ee3b44532dd', '312300', null, '上虞市', '82', '上虞市', '330682', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('667338a7ae4f494ba7f3910e6bcab7e5', '962cb7e4670547ffb73d8ee3b44532dd', '312400', null, '嵊州市', '83', '嵊州市', '330683', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a6598dd6d7b44b39ab0b620d4d36a4c8', '8df5d2d1bf024ffa92c29fe60871da10', '321000', null, '市辖区', '01', '市辖区', '330701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dafbc314067a40a895f1a62734961fc4', '8df5d2d1bf024ffa92c29fe60871da10', '321000', null, '婺城区', '02', '婺城区', '330702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('efbdb3eccb28465bac798ff3205b1089', '8df5d2d1bf024ffa92c29fe60871da10', '321000', null, '金东区', '03', '金东区', '330703', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('18c6551881e244fab90f9bfc7ed80813', '8df5d2d1bf024ffa92c29fe60871da10', '321200', null, '武义县', '23', '武义县', '330723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3086b26b9c7242e481bf66eca46d8e63', '8df5d2d1bf024ffa92c29fe60871da10', '322200', null, '浦江县', '26', '浦江县', '330726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1989dc4ef2c340f49ae85cda4c1d058c', '8df5d2d1bf024ffa92c29fe60871da10', '322300', null, '磐安县', '27', '磐安县', '330727', null);
commit;
----prompt 1500 records committed...
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ee49f859be664dae9c6882c08f7ce3ba', '8df5d2d1bf024ffa92c29fe60871da10', '321100', null, '兰溪市', '81', '兰溪市', '330781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b867d149d940477ebe6c96a3ef9f0bca', '8df5d2d1bf024ffa92c29fe60871da10', '322000', null, '义乌市', '82', '义乌市', '330782', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('be1bf4380e744150bca32e680a2a119c', '8df5d2d1bf024ffa92c29fe60871da10', '322100', null, '东阳市', '83', '东阳市', '330783', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9b09ca4b3d974faea3f35e37a6d10253', '8df5d2d1bf024ffa92c29fe60871da10', '321300', null, '永康市', '84', '永康市', '330784', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a5a1282e8378455b909640837c14fdb6', '39ef5e82145c4f11a07dc5a6503d596b', '324000', null, '市辖区', '01', '市辖区', '330801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6472dce828bb467b9de56564722dede6', '39ef5e82145c4f11a07dc5a6503d596b', '324000', null, '柯城区', '02', '柯城区', '330802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dd2da6f3e0ee436895a2cec8ac2f9c21', '39ef5e82145c4f11a07dc5a6503d596b', '324000', null, '衢江区', '03', '衢江区', '330803', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9d3db3c095ad41b9890f9aaaee3432ba', '39ef5e82145c4f11a07dc5a6503d596b', '324200', null, '常山县', '22', '常山县', '330822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5cc10015767249658ea521933dba4f20', '39ef5e82145c4f11a07dc5a6503d596b', '324300', null, '开化县', '24', '开化县', '330824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('caccb0628b45498f903e2c394894e154', '39ef5e82145c4f11a07dc5a6503d596b', '324400', null, '龙游县', '25', '龙游县', '330825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b9a3f97c62c04d209aa8f0657caa6f0a', '39ef5e82145c4f11a07dc5a6503d596b', '324100', null, '江山市', '81', '江山市', '330881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cef21f8444e946b7b1fd9fb39aa790d8', 'c56cf7ba5aec447eaa0588684c1347f8', '316000', null, '市辖区', '01', '市辖区', '330901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c9a471f99c5949628083ac024c7af88d', 'c56cf7ba5aec447eaa0588684c1347f8', '316000', null, '定海区', '02', '定海区', '330902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9395a0718ef440a98df085d1f092e066', 'c56cf7ba5aec447eaa0588684c1347f8', '316100', null, '普陀区', '03', '普陀区', '330903', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a7557e93274241a29c93bf09e5cbe18d', 'c56cf7ba5aec447eaa0588684c1347f8', '316200', null, '岱山县', '21', '岱山县', '330921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('911fe4687c134071a43d13146c4a4031', 'c56cf7ba5aec447eaa0588684c1347f8', '202450', null, '嵊泗县', '22', '嵊泗县', '330922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5b5f5a0c836848ab8ced09a23c2a1782', '1901b2c30bc24b45a4abca1c5b03b4ba', '317000', null, '市辖区', '01', '市辖区', '331001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e512385d092e481a8237541f55f27194', '1901b2c30bc24b45a4abca1c5b03b4ba', '317700', null, '椒江区', '02', '椒江区', '331002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f46032ae5f8c4302a7108116904ce5c9', '1901b2c30bc24b45a4abca1c5b03b4ba', '318020', null, '黄岩区', '03', '黄岩区', '331003', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('40dd8b06a16442b18f758f9920e4fc85', '1901b2c30bc24b45a4abca1c5b03b4ba', '318000', null, '路桥区', '04', '路桥区', '331004', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c86942ea1c4940d695f9744e80f0e36c', '1901b2c30bc24b45a4abca1c5b03b4ba', '317600', null, '玉环县', '21', '玉环县', '331021', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1ef9fe0417624d6daf0a8ed2296c5c8a', '1901b2c30bc24b45a4abca1c5b03b4ba', '317100', null, '三门县', '22', '三门县', '331022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('788d7ded9b6c4794a8ac8249beabf216', '1901b2c30bc24b45a4abca1c5b03b4ba', '317200', null, '天台县', '23', '天台县', '331023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a8988abf0e814635b9aceb5eb35bd8ba', '1901b2c30bc24b45a4abca1c5b03b4ba', '317300', null, '仙居县', '24', '仙居县', '331024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2202d662f503492baf84d29ea35f6d14', '1901b2c30bc24b45a4abca1c5b03b4ba', '317500', null, '温岭市', '81', '温岭市', '331081', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fdb9659c65cd44a98a56cf262631bc32', '1901b2c30bc24b45a4abca1c5b03b4ba', '317000', null, '临海市', '82', '临海市', '331082', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e17eb81c10449be8daf75ab3ea58d1c', 'e2d22a554b0141759f6ffc200a5a7c5a', '323000', null, '市辖区', '01', '市辖区', '331101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bc58e08b7564446795689b8f05f9e41f', 'e2d22a554b0141759f6ffc200a5a7c5a', '323000', null, '莲都区', '02', '莲都区', '331102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c05a14546f9494ca7f392c5e0702f44', 'e2d22a554b0141759f6ffc200a5a7c5a', '323900', null, '青田县', '21', '青田县', '331121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cffd9bc839c44e2f93a7808bd0768347', 'e2d22a554b0141759f6ffc200a5a7c5a', '321400', null, '缙云县', '22', '缙云县', '331122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a754d0a4fb3a494787073dd399a425e8', 'e2d22a554b0141759f6ffc200a5a7c5a', '323300', null, '遂昌县', '23', '遂昌县', '331123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a393ca0e68cf473e9df6f6745072b12a', 'e2d22a554b0141759f6ffc200a5a7c5a', '323400', null, '松阳县', '24', '松阳县', '331124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('feac5c6cdffa412ea411c80573a5c044', 'e2d22a554b0141759f6ffc200a5a7c5a', '323600', null, '云和县', '25', '云和县', '331125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8d2b6057ad3e45c58ecae53193fb838a', 'e2d22a554b0141759f6ffc200a5a7c5a', '323800', null, '庆元县', '26', '庆元县', '331126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('230751ce7a524c7dbc0b764f37cfecbf', 'e2d22a554b0141759f6ffc200a5a7c5a', '323500', null, '景宁畲族自治县', '27', '景宁畲族自治县', '331127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2df3626d499c45b1b9ba9caaf7e98e87', 'e2d22a554b0141759f6ffc200a5a7c5a', '323700', null, '龙泉市', '81', '龙泉市', '331181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ae3aea0845ba48bba488a8010cac15d6', 'db9ba52f83f943c3bb606a0d52ad769e', '230000', null, '市辖区', '01', '市辖区', '340101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0152e4ed63ff44fea062ae7f73d6f6ff', 'db9ba52f83f943c3bb606a0d52ad769e', '230000', null, '瑶海区', '02', '瑶海区', '340102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ec8ab547db284ed58ca4936d40cf0a7e', 'db9ba52f83f943c3bb606a0d52ad769e', '230000', null, '庐阳区', '03', '庐阳区', '340103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('19ce7ca9718a44009de33264e13b9df9', 'db9ba52f83f943c3bb606a0d52ad769e', '230000', null, '蜀山区', '04', '蜀山区', '340104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d0c1c12b09a1467eb31e18b0c7d35773', 'db9ba52f83f943c3bb606a0d52ad769e', '230000', null, '包河区', '11', '包河区', '340111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('009d87f35b154a50a32a970051fc9218', 'db9ba52f83f943c3bb606a0d52ad769e', '231100', null, '长丰县', '21', '长丰县', '340121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('acfd7410487d45d0a99893dac2a0556f', 'db9ba52f83f943c3bb606a0d52ad769e', '230000', null, '肥东县', '22', '肥东县', '340122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('adacf4d4a4f64649a9a5b70e8c267317', '02f726a87a1e43ddb4fac108dd68b46b', '133000', null, '延吉市', '01', '延吉市', '222401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4ecd9935ecb946f7b3f51c7d3d143b97', '02f726a87a1e43ddb4fac108dd68b46b', '133100', null, '图们市', '02', '图们市', '222402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fd1a0de4d86941618e097de85f9c337b', '02f726a87a1e43ddb4fac108dd68b46b', '133700', null, '敦化市', '03', '敦化市', '222403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c051af65f41a434d98872602c74a3cb3', '02f726a87a1e43ddb4fac108dd68b46b', '133300', null, '珲春市', '04', '珲春市', '222404', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('06aecaf2036340b1bdb06b012979e3e3', 'adf505a23af74179b00c02a084407ca8', '266000', null, '李沧区', '13', '李沧区', '370213', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('397746d3cb014b7593abf716439ea311', 'adf505a23af74179b00c02a084407ca8', '266000', null, '城阳区', '14', '城阳区', '370214', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d5f4939649464289968d8285f9751207', 'adf505a23af74179b00c02a084407ca8', '266300', null, '胶州市', '81', '胶州市', '370281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('321cef4621b44638bceb0cb5dd0e2975', 'adf505a23af74179b00c02a084407ca8', '266200', null, '即墨市', '82', '即墨市', '370282', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('35b4bc87bc0a47af807d1365a7a1557c', 'adf505a23af74179b00c02a084407ca8', '266700', null, '平度市', '83', '平度市', '370283', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('81b8ec0374eb4365b8330dd9396d6f1e', 'adf505a23af74179b00c02a084407ca8', '266400', null, '胶南市', '84', '胶南市', '370284', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5443e5d664ab4b7ba91c484a8800e4a4', 'adf505a23af74179b00c02a084407ca8', '266600', null, '莱西市', '85', '莱西市', '370285', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b071c77de8c7487a90af9408fc624cb9', '85fb1b8433304911b85e1cd6cdb26d9e', '255100', null, '市辖区', '01', '市辖区', '370301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c489c555698e4009b146d247781e786a', '85fb1b8433304911b85e1cd6cdb26d9e', '255100', null, '淄川区', '02', '淄川区', '370302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7fa53bb580c0440b8d8435efd8999254', '85fb1b8433304911b85e1cd6cdb26d9e', '255000', null, '张店区', '03', '张店区', '370303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('79d496dd158d4a3dab2e45e7a64d6cca', '85fb1b8433304911b85e1cd6cdb26d9e', '255200', null, '博山区', '04', '博山区', '370304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0b479c2f63f044b2be4f9f40ca7d498b', '85fb1b8433304911b85e1cd6cdb26d9e', '255400', null, '临淄区', '05', '临淄区', '370305', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6d0dd7ff24344b20a2cb2f89c2ee66c7', '85fb1b8433304911b85e1cd6cdb26d9e', '255300', null, '周村区', '06', '周村区', '370306', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('afe53048148a48e09a8e1d7ab2fa4d5e', '85fb1b8433304911b85e1cd6cdb26d9e', '256400', null, '桓台县', '21', '桓台县', '370321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('41e924aada3742048fa5a3cb1579c06b', '85fb1b8433304911b85e1cd6cdb26d9e', '256300', null, '高青县', '22', '高青县', '370322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('15c40b6d757f410e828d84c2ecab332a', '85fb1b8433304911b85e1cd6cdb26d9e', '256100', null, '沂源县', '23', '沂源县', '370323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fe9dd6cc4a1c458f8c65cef60feb8ced', '7ceca56d1b8146d48e88aabf26741991', '277000', null, '市辖区', '01', '市辖区', '370401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('83a4e9c45ce04ecdafe7e5a2a50df034', '7ceca56d1b8146d48e88aabf26741991', '277000', null, '市中区', '02', '市中区', '370402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b891325559ab48adb162a27ba9d5d5d4', '7ceca56d1b8146d48e88aabf26741991', '277000', null, '薛城区', '03', '薛城区', '370403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('401a9c285a6c4a2eb4552f4dc6fedd9c', '7ceca56d1b8146d48e88aabf26741991', '277300', null, '峄城区', '04', '峄城区', '370404', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5a84bd647abf42d6889d7f63468d0bbb', '7ceca56d1b8146d48e88aabf26741991', '277400', null, '台儿庄区', '05', '台儿庄区', '370405', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b941418fe8f0408681ebe89a79a2f546', '7ceca56d1b8146d48e88aabf26741991', '277200', null, '山亭区', '06', '山亭区', '370406', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d989259651874411a89487b58cafbe34', '7ceca56d1b8146d48e88aabf26741991', '277500', null, '滕州市', '81', '滕州市', '370481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1bec1c19f305467ca9dd6b682adf121c', 'f2eb632af2014a9289fe6a736c9c12ac', '257000', null, '市辖区', '01', '市辖区', '370501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('998532892d4a41719af4a4e5c12f8782', 'f2eb632af2014a9289fe6a736c9c12ac', '257100', null, '东营区', '02', '东营区', '370502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('de5da57b3325430089ad866550acfff2', 'f2eb632af2014a9289fe6a736c9c12ac', '257200', null, '河口区', '03', '河口区', '370503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cb83347aa91249db904d3278758b204c', 'f2eb632af2014a9289fe6a736c9c12ac', '257500', null, '垦利县', '21', '垦利县', '370521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e6d48c41dd0b44c49ae65413b5f78876', 'f2eb632af2014a9289fe6a736c9c12ac', '257400', null, '利津县', '22', '利津县', '370522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f0b853f8bc9247a0b50c1b25d7f6dd2c', 'f2eb632af2014a9289fe6a736c9c12ac', '257300', null, '广饶县', '23', '广饶县', '370523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c2e25c35b3a741da9cb19cebe0cdcada', '5dc548802c6c40a3803e58511ec474bf', '264000', null, '市辖区', '01', '市辖区', '370601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c545dada32cc413fa3c4c775a7915a86', '5dc548802c6c40a3803e58511ec474bf', '264000', null, '芝罘区', '02', '芝罘区', '370602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7573eefac70b493c9ad8069eb045b745', '5dc548802c6c40a3803e58511ec474bf', '265500', null, '福山区', '11', '福山区', '370611', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fceed8a1fab94a6cb396e425feb71dcd', '5dc548802c6c40a3803e58511ec474bf', '264100', null, '牟平区', '12', '牟平区', '370612', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4be369e2509b43e7b385ecc54617067a', '5dc548802c6c40a3803e58511ec474bf', '264000', null, '莱山区', '13', '莱山区', '370613', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8bc11e5a05fc4065b87799871f3d8a9d', '5dc548802c6c40a3803e58511ec474bf', '265800', null, '长岛县', '34', '长岛县', '370634', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f5829194565f4d87b26bc84a7ce41c01', '5dc548802c6c40a3803e58511ec474bf', '265700', null, '龙口市', '81', '龙口市', '370681', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('be8af47afbab4e59b6048bbd8ec21296', '5dc548802c6c40a3803e58511ec474bf', '265200', null, '莱阳市', '82', '莱阳市', '370682', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dadf9c70a9384835bfc50f4f0398885e', '5dc548802c6c40a3803e58511ec474bf', '261400', null, '莱州市', '83', '莱州市', '370683', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('01960042378b4114861e8f6a62dd1f31', '5dc548802c6c40a3803e58511ec474bf', '265600', null, '蓬莱市', '84', '蓬莱市', '370684', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5fca5aeb106a4be09088b83cc8f474b4', '5dc548802c6c40a3803e58511ec474bf', '265400', null, '招远市', '85', '招远市', '370685', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('55d7c1707ab747d184be2c5804f59514', '5dc548802c6c40a3803e58511ec474bf', '265300', null, '栖霞市', '86', '栖霞市', '370686', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c003732b042d4cdd821fac058b13dc36', '5dc548802c6c40a3803e58511ec474bf', '265100', null, '海阳市', '87', '海阳市', '370687', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2a420179bb91480b9ec2079dd433d3e0', '4ae4336f1dab45c0a465fae057c383fe', '261000', null, '市辖区', '01', '市辖区', '370701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9342651407ce43b9a3759a445be03090', '4ae4336f1dab45c0a465fae057c383fe', '261000', null, '潍城区', '02', '潍城区', '370702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ea73e028ab584961bd877c3e64b5ab14', '4ae4336f1dab45c0a465fae057c383fe', '261100', null, '寒亭区', '03', '寒亭区', '370703', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9e54d3b2945242539e580872918eb0ab', '4ae4336f1dab45c0a465fae057c383fe', '261200', null, '坊子区', '04', '坊子区', '370704', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6a64e9a7a35449e3adba942a55c0bc29', '4ae4336f1dab45c0a465fae057c383fe', '261000', null, '奎文区', '05', '奎文区', '370705', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('78f8d78d9eab41daaab96fd0298db3fc', '4ae4336f1dab45c0a465fae057c383fe', '262600', null, '临朐县', '24', '临朐县', '370724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('211c3aa893c3421da85d0dc66c9dd212', '4ae4336f1dab45c0a465fae057c383fe', '262400', null, '昌乐县', '25', '昌乐县', '370725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('83ccdaa80a4842dcadc4a8230fb88df3', '4ae4336f1dab45c0a465fae057c383fe', '262500', null, '青州市', '81', '青州市', '370781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a6f0a0dd3b8f4cedb6a0ed1d473ffbbb', '4ae4336f1dab45c0a465fae057c383fe', '262200', null, '诸城市', '82', '诸城市', '370782', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f2bf1802dfa45fbae3c59ba9da5c635', '4ae4336f1dab45c0a465fae057c383fe', '262700', null, '寿光市', '83', '寿光市', '370783', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d8222ed0a36c46258df39ba2f9033b40', '4ae4336f1dab45c0a465fae057c383fe', '262100', null, '安丘市', '84', '安丘市', '370784', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7e4b4d137e4c45069d8b024c26e1b05e', '4ae4336f1dab45c0a465fae057c383fe', '261500', null, '高密市', '85', '高密市', '370785', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2f55cc2d2c2549208a9a87bbbca6f323', '4ae4336f1dab45c0a465fae057c383fe', '261300', null, '昌邑市', '86', '昌邑市', '370786', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1cae85fb2cec45e288300c7874239ee8', 'b34159526635417eac1df82dd9c7859b', '272000', null, '市辖区', '01', '市辖区', '370801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('43255b5fccdc472db2021b48a371229a', 'b34159526635417eac1df82dd9c7859b', '272000', null, '市中区', '02', '市中区', '370802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('527a8a08e5c04ab88830663e56901918', 'b34159526635417eac1df82dd9c7859b', '272000', null, '任城区', '11', '任城区', '370811', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4afaa9556fa6419d9f0a4b0eca8020b0', 'b34159526635417eac1df82dd9c7859b', '277600', null, '微山县', '26', '微山县', '370826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d28cf284300c4d0bb64658cd5f747896', '133d81bc3b4c48e7803bde263c887d8f', '117000', null, '平山区', '02', '平山区', '210502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f2c3af40cc28484daf1fc380efac48ae', '02fd4185ea2343ffaae15ca2c5caf2b3', '221000', null, '泉山区', '11', '泉山区', '320311', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fb42d926b0cd49539365212bf05b3974', '02fd4185ea2343ffaae15ca2c5caf2b3', '221700', null, '丰县', '21', '丰县', '320321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ac832d134ee84973a40c5be4822905f0', '02fd4185ea2343ffaae15ca2c5caf2b3', '221600', null, '沛县', '22', '沛县', '320322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d875181a563b4668a5e058184be6381b', '02fd4185ea2343ffaae15ca2c5caf2b3', '221100', null, '铜山县', '23', '铜山县', '320323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1f1a4d18eac54a94b8cfb8e33397fdcd', '02fd4185ea2343ffaae15ca2c5caf2b3', '221200', null, '睢宁县', '24', '睢宁县', '320324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9bd5a2ef96b347ce9fbd0342909b95e2', '02fd4185ea2343ffaae15ca2c5caf2b3', '221400', null, '新沂市', '81', '新沂市', '320381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a1be1687afcf42b1be5234187e97ddb5', '02f726a87a1e43ddb4fac108dd68b46b', '133500', null, '和龙市', '06', '和龙市', '222406', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1fff79f0dc70409eae0f3d5b008bdc33', '02f726a87a1e43ddb4fac108dd68b46b', '133200', null, '汪清县', '24', '汪清县', '222424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e1460e9d1f324d7d957b7e4e0befd6b7', '02f726a87a1e43ddb4fac108dd68b46b', '133600', null, '安图县', '26', '安图县', '222426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('01e4fdb14be24c81b626677f58905fb1', '18f439ed744a48ae89ca7f469af554fd', '150000', null, '道里区', '02', '道里区', '230102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fb2c31bbbdc7429bb23ef70d3b81702b', '18f439ed744a48ae89ca7f469af554fd', '150000', null, '南岗区', '03', '南岗区', '230103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('20d77cd85a6b4b52a6c8b8a0aeb7dc85', '18f439ed744a48ae89ca7f469af554fd', '150000', null, '道外区', '04', '道外区', '230104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a3e19b8c6d6e4fbbba2b60c9a0fbec5a', '18f439ed744a48ae89ca7f469af554fd', '150000', null, '香坊区', '06', '香坊区', '230106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3132717b7ce94343a29ceadb1ec0f087', '18f439ed744a48ae89ca7f469af554fd', '150000', null, '动力区', '07', '动力区', '230107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('87f5fac814194148aeef13d97dded20b', '18f439ed744a48ae89ca7f469af554fd', '150000', null, '平房区', '08', '平房区', '230108', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('756abb854b614870b57c488f682ebffb', '18f439ed744a48ae89ca7f469af554fd', '150000', null, '松北区', '09', '松北区', '230109', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f3216df4d66d452ca0364d1e79b0751a', '18f439ed744a48ae89ca7f469af554fd', '150500', null, '呼兰区', '11', '呼兰区', '230111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6fbd878b2ddc4cb8980e24b7bae89c92', '18f439ed744a48ae89ca7f469af554fd', '154800', null, '依兰县', '23', '依兰县', '230123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('007c9c1d79414946b1747cc982390f5a', '18f439ed744a48ae89ca7f469af554fd', '150800', null, '方正县', '24', '方正县', '230124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('57310cf7c8ca4747bbecb787cb4e2f94', '18f439ed744a48ae89ca7f469af554fd', '150400', null, '宾县', '25', '宾县', '230125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e3845db0918c4cc593f6d294daa34d17', '18f439ed744a48ae89ca7f469af554fd', '151800', null, '巴彦县', '26', '巴彦县', '230126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a9d6d17c1c304a0ba2c18a3d604aad57', '18f439ed744a48ae89ca7f469af554fd', '151900', null, '木兰县', '27', '木兰县', '230127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('84f6e8767dcf4643b32ff80e9f0f9fef', '18f439ed744a48ae89ca7f469af554fd', '150900', null, '通河县', '28', '通河县', '230128', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('728081d029024f9088b780b9d5aacf8e', '18f439ed744a48ae89ca7f469af554fd', '150700', null, '延寿县', '29', '延寿县', '230129', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f4746a091b824a7bbcd8293252ca9ef6', '18f439ed744a48ae89ca7f469af554fd', '150300', null, '阿城市', '81', '阿城市', '230181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('23e4078f6c5640eca3aa1ce3cf692f3d', '18f439ed744a48ae89ca7f469af554fd', '150100', null, '双城市', '82', '双城市', '230182', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bdbd90cf0c2e4616ac163474a097f932', '18f439ed744a48ae89ca7f469af554fd', '150600', null, '尚志市', '83', '尚志市', '230183', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d354efc5d2934807a4a38a01fb0bc340', '18f439ed744a48ae89ca7f469af554fd', '150200', null, '五常市', '84', '五常市', '230184', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1613e0892bc34d65adc5c1f43afc0c0e', '4f42860a0c8e4a6ab50d18f9e73d84a4', '161000', null, '市辖区', '01', '市辖区', '230201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3af68c92402f46798259c39cc700d3fd', '4f42860a0c8e4a6ab50d18f9e73d84a4', '161000', null, '龙沙区', '02', '龙沙区', '230202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d44a005e93ef4085aac2d25e6208b953', '4f42860a0c8e4a6ab50d18f9e73d84a4', '161000', null, '建华区', '03', '建华区', '230203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8df48513eb03423e99953ce41443d942', '4f42860a0c8e4a6ab50d18f9e73d84a4', '161000', null, '铁锋区', '04', '铁锋区', '230204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('375268fc29604036a7b4a9d0f31bc8a1', '4f42860a0c8e4a6ab50d18f9e73d84a4', '161000', null, '昂昂溪区', '05', '昂昂溪区', '230205', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2a34ac8b34174f5d8fb4d0c043d1d564', '4f42860a0c8e4a6ab50d18f9e73d84a4', '161000', null, '富拉尔基区', '06', '富拉尔基区', '230206', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d85df224a8f149588b90e731001aa0df', '4f42860a0c8e4a6ab50d18f9e73d84a4', '161000', null, '碾子山区', '07', '碾子山区', '230207', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f9488ca41f4d40dd944bf3e751f71486', '4f42860a0c8e4a6ab50d18f9e73d84a4', '161000', null, '梅里斯达斡尔族区', '08', '梅里斯达斡尔族区', '230208', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ff66f4ea7e4f41f28fd954001bc8b0dc', '4f42860a0c8e4a6ab50d18f9e73d84a4', '161100', null, '龙江县', '21', '龙江县', '230221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1180462b832b4f9caa476159e5f54981', '4f42860a0c8e4a6ab50d18f9e73d84a4', '161500', null, '依安县', '23', '依安县', '230223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('13b8878a46d54cb7ad7b15d5d6673e1e', '4f42860a0c8e4a6ab50d18f9e73d84a4', '162400', null, '泰来县', '24', '泰来县', '230224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7d8d489e03c547feafcada3b3a58e677', '4f42860a0c8e4a6ab50d18f9e73d84a4', '162100', null, '甘南县', '25', '甘南县', '230225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('03c8bc212a4449f6b973f8c8306d4cf3', '4f42860a0c8e4a6ab50d18f9e73d84a4', '161200', null, '富裕县', '27', '富裕县', '230227', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9fb06ebda0064e88823017d3a43eefab', '4f42860a0c8e4a6ab50d18f9e73d84a4', '161600', null, '克山县', '29', '克山县', '230229', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('855a6c0994674931935a32ae2e06eb68', '4f42860a0c8e4a6ab50d18f9e73d84a4', '164800', null, '克东县', '30', '克东县', '230230', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d9ec848e1bec4e5caa607276ddbbb764', '4f42860a0c8e4a6ab50d18f9e73d84a4', '164700', null, '拜泉县', '31', '拜泉县', '230231', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0837662e4c164fe69794421863206334', '4f42860a0c8e4a6ab50d18f9e73d84a4', '161300', null, '讷河市', '81', '讷河市', '230281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6b5eb4d1c3c54532864645490392b78e', 'c87e34444f484566923db62964bf3fc0', '158100', null, '市辖区', '01', '市辖区', '230301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0a2068f8daae4220b628876abc41e4a6', 'c87e34444f484566923db62964bf3fc0', '158100', null, '鸡冠区', '02', '鸡冠区', '230302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5dd3217b78a94b87b03f18dd1098f9a2', 'c87e34444f484566923db62964bf3fc0', '158100', null, '恒山区', '03', '恒山区', '230303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3df01abb0b6a407e9ebe9e81a8ba6b1b', 'c87e34444f484566923db62964bf3fc0', '158100', null, '滴道区', '04', '滴道区', '230304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('38d1465696824954bdb893c70567ce12', 'c87e34444f484566923db62964bf3fc0', '158100', null, '梨树区', '05', '梨树区', '230305', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4636164109484c498340c98ec1572034', 'c87e34444f484566923db62964bf3fc0', '158100', null, '城子河区', '06', '城子河区', '230306', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c688882a56e44b02b4bf437d03a69599', 'c87e34444f484566923db62964bf3fc0', '158100', null, '麻山区', '07', '麻山区', '230307', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('44386cd1bac8484e9920bd3edead06b6', 'c87e34444f484566923db62964bf3fc0', '158200', null, '鸡东县', '21', '鸡东县', '230321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d190bf371a6647dd9cbefc84ef21d0fc', 'c87e34444f484566923db62964bf3fc0', '158400', null, '虎林市', '81', '虎林市', '230381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f880d5bd2e7a4445830d9eed3452b26c', 'c87e34444f484566923db62964bf3fc0', '158300', null, '密山市', '82', '密山市', '230382', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e391a0a899f64e16825930f6308af3ca', '23fc3577d5b5453eae1ae4af187d0c86', '154000', null, '市辖区', '01', '市辖区', '230401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('52161cdeb052425aac929c94b9710740', '23fc3577d5b5453eae1ae4af187d0c86', '154000', null, '向阳区', '02', '向阳区', '230402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('48104261876443769fef0a1639c25897', '23fc3577d5b5453eae1ae4af187d0c86', '154100', null, '工农区', '03', '工农区', '230403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2f4b3f8c8ef546299fca95d9a5d44115', '23fc3577d5b5453eae1ae4af187d0c86', '154100', null, '南山区', '04', '南山区', '230404', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ff09cdc66a7645a58c1a6ca8393e4b98', '23fc3577d5b5453eae1ae4af187d0c86', '154100', null, '兴安区', '05', '兴安区', '230405', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('19c77b1e011c496cb13c48c9876817e0', '23fc3577d5b5453eae1ae4af187d0c86', '154100', null, '东山区', '06', '东山区', '230406', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8b824ade92f44aaa88aa2100d1f83763', '23fc3577d5b5453eae1ae4af187d0c86', '154100', null, '兴山区', '07', '兴山区', '230407', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a1b6af7605014abba5ec42bd06d00d7a', '23fc3577d5b5453eae1ae4af187d0c86', '154200', null, '萝北县', '21', '萝北县', '230421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('26009d89413b4dcf9cbdf11c5227a231', '23fc3577d5b5453eae1ae4af187d0c86', '156200', null, '绥滨县', '22', '绥滨县', '230422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a35100d871524a909e299e136bad223f', '8fdba2c226b74f689e9095d060a98cd2', '155100', null, '市辖区', '01', '市辖区', '230501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('49df869b54314a7d84a5fbf25cf71ba3', '8fdba2c226b74f689e9095d060a98cd2', '155100', null, '尖山区', '02', '尖山区', '230502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d7326db7f84c4cb7892093cf4b8a9858', '8fdba2c226b74f689e9095d060a98cd2', '155100', null, '岭东区', '03', '岭东区', '230503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bada5acfd8c74884b95143ccfa23f843', '8fdba2c226b74f689e9095d060a98cd2', '155100', null, '四方台区', '05', '四方台区', '230505', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('34e74fadcac3458e9bda4c5cad7c4062', '8fdba2c226b74f689e9095d060a98cd2', '155100', null, '宝山区', '06', '宝山区', '230506', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eeb833be8b124b63b35f2c1464f64150', '8fdba2c226b74f689e9095d060a98cd2', '155900', null, '集贤县', '21', '集贤县', '230521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bcc5cddb7aa1443a8cddaa8da26b8f23', '6fd17ced4f124cc4881a50ad26321855', '355400', null, '周宁县', '25', '周宁县', '350925', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4c5c6f28a7eb4d268b0c5cebf3c79740', '04639f4c045a44258ebff7fc94fec3e5', '343100', null, '吉安县', '21', '吉安县', '360821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5cace8bf1dd74c7d8b1918891d225ae1', '04639f4c045a44258ebff7fc94fec3e5', '331600', null, '吉水县', '22', '吉水县', '360822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c9b9733c0f0e4c61adb3f7c9f95768cc', '04639f4c045a44258ebff7fc94fec3e5', '331400', null, '峡江县', '23', '峡江县', '360823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1b3f94cc60564df69fa976264addcc8a', '04639f4c045a44258ebff7fc94fec3e5', '331300', null, '新干县', '24', '新干县', '360824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d0316083227440e7a2a2c259c4bf5615', '04639f4c045a44258ebff7fc94fec3e5', '331500', null, '永丰县', '25', '永丰县', '360825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('79271d4a150e46a8bdea568cf2fad9de', '04639f4c045a44258ebff7fc94fec3e5', '343700', null, '泰和县', '26', '泰和县', '360826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6691f042545740549255104add2c8aec', '04639f4c045a44258ebff7fc94fec3e5', '343900', null, '遂川县', '27', '遂川县', '360827', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7b7c168f32fc422aabbbd43dbcedc842', '04639f4c045a44258ebff7fc94fec3e5', '343800', null, '万安县', '28', '万安县', '360828', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dd3b4bab17f74702be818c71d90bb416', '04639f4c045a44258ebff7fc94fec3e5', '343200', null, '安福县', '29', '安福县', '360829', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2fa3406cfebd4644b813ceb340c2daac', '04639f4c045a44258ebff7fc94fec3e5', '343400', null, '永新县', '30', '永新县', '360830', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dffd772e409943c4853b0b89ab054fc6', '04639f4c045a44258ebff7fc94fec3e5', '343600', null, '井冈山市', '81', '井冈山市', '360881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('71795fe5302d4316b7c35b106f9117c5', 'ba92d925173c48ebac5841355f105db5', '336000', null, '市辖区', '01', '市辖区', '360901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4b80293ecf6641dea835f120b73df705', 'ba92d925173c48ebac5841355f105db5', '336000', null, '袁州区', '02', '袁州区', '360902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e2a97fea457641098b30878648bb12c7', 'ba92d925173c48ebac5841355f105db5', '330700', null, '奉新县', '21', '奉新县', '360921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0e874ade65f447e3a1962b87d4fc4628', 'ba92d925173c48ebac5841355f105db5', '336100', null, '万载县', '22', '万载县', '360922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d66f74c31eb44f1e8d741a757500cea8', 'ba92d925173c48ebac5841355f105db5', '336400', null, '上高县', '23', '上高县', '360923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('068d06fd83384560a428bed55bff7e42', 'ba92d925173c48ebac5841355f105db5', '336300', null, '宜丰县', '24', '宜丰县', '360924', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('93c9fa4137654aa08f5a29a2825ef96e', 'ba92d925173c48ebac5841355f105db5', '330600', null, '靖安县', '25', '靖安县', '360925', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c475852930b642ea9f184d3d1f6facc8', 'ba92d925173c48ebac5841355f105db5', '336200', null, '铜鼓县', '26', '铜鼓县', '360926', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a1ed745a5453470eb95081d404b99865', 'ba92d925173c48ebac5841355f105db5', '331100', null, '丰城市', '81', '丰城市', '360981', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d9c5619aaee2473ea9da343b8b511a87', 'ba92d925173c48ebac5841355f105db5', '331200', null, '樟树市', '82', '樟树市', '360982', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9ed2a213abfe4d42aa28d594ee2258e2', 'ba92d925173c48ebac5841355f105db5', '330800', null, '高安市', '83', '高安市', '360983', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('435af59152de4fc2996cf16026885e0b', 'bfcd8a0a0e484b12ac10a25b91a97e68', '344000', null, '市辖区', '01', '市辖区', '361001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b2b20d0a649f424ab02f3a99400556f7', 'bfcd8a0a0e484b12ac10a25b91a97e68', '344100', null, '临川区', '02', '临川区', '361002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d52c2bdbe79f4fa289658f7252677d46', 'bfcd8a0a0e484b12ac10a25b91a97e68', '344700', null, '南城县', '21', '南城县', '361021', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fccf274e36d84b0eae384609b013a93b', 'bfcd8a0a0e484b12ac10a25b91a97e68', '344600', null, '黎川县', '22', '黎川县', '361022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0ba9a6859821475dbf43157ae86f3fc3', 'bfcd8a0a0e484b12ac10a25b91a97e68', '344500', null, '南丰县', '23', '南丰县', '361023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e035299d42de478e8a9a3b83e08b8e47', 'bfcd8a0a0e484b12ac10a25b91a97e68', '344200', null, '崇仁县', '24', '崇仁县', '361024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('57f2f45307564841a3f515e183ed9539', 'bfcd8a0a0e484b12ac10a25b91a97e68', '344300', null, '乐安县', '25', '乐安县', '361025', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('240e6c22e5234c74aaceb56c8585da6c', 'bfcd8a0a0e484b12ac10a25b91a97e68', '344400', null, '宜黄县', '26', '宜黄县', '361026', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d2003c5a93764f6a9da3bb0eec2f89e9', 'bfcd8a0a0e484b12ac10a25b91a97e68', '344800', null, '金溪县', '27', '金溪县', '361027', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ad1a66a182f2486281fb6622a1dba322', 'bfcd8a0a0e484b12ac10a25b91a97e68', '335300', null, '资溪县', '28', '资溪县', '361028', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('835ee9d632314f098fcebc569d409055', 'bfcd8a0a0e484b12ac10a25b91a97e68', '331800', null, '东乡县', '29', '东乡县', '361029', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c393c587eb84c10b6219a199bdfaf94', 'bfcd8a0a0e484b12ac10a25b91a97e68', '344900', null, '广昌县', '30', '广昌县', '361030', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a92bd246996043569231306d5011ccd6', 'ae3e3d63e8b541b3a63dd96ec498e5d0', '334000', null, '市辖区', '01', '市辖区', '361101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2d93e2f499584d4da845e1feded5a0cf', 'ae3e3d63e8b541b3a63dd96ec498e5d0', '334000', null, '信州区', '02', '信州区', '361102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cc65f4939fbe4346a370b15f025310e9', 'ae3e3d63e8b541b3a63dd96ec498e5d0', '334100', null, '上饶县', '21', '上饶县', '361121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2487788534894ea6a1ec96db2aa0a3ee', 'ae3e3d63e8b541b3a63dd96ec498e5d0', '334600', null, '广丰县', '22', '广丰县', '361122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ee50fc2bc6744abbb43d296a0c77f23c', 'ae3e3d63e8b541b3a63dd96ec498e5d0', '334700', null, '玉山县', '23', '玉山县', '361123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aa180784ffbf4d7f9b23e03f37ed5173', 'ae3e3d63e8b541b3a63dd96ec498e5d0', '334500', null, '铅山县', '24', '铅山县', '361124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6acae4e912ca4a56b34ec318d996bb10', 'ae3e3d63e8b541b3a63dd96ec498e5d0', '334300', null, '横峰县', '25', '横峰县', '361125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('173609568caa4410a68de6a5211360f6', 'ae3e3d63e8b541b3a63dd96ec498e5d0', '334400', null, '弋阳县', '26', '弋阳县', '361126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e9de32842e7642ad9d4a68bdbdf9fcef', 'ae3e3d63e8b541b3a63dd96ec498e5d0', '335100', null, '余干县', '27', '余干县', '361127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ce54906e0d334a81820ee0aa29f0a390', 'ae3e3d63e8b541b3a63dd96ec498e5d0', '333100', null, '鄱阳县', '28', '鄱阳县', '361128', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4026a6c82ba84b7099cdfa7e51e45cbe', 'ae3e3d63e8b541b3a63dd96ec498e5d0', '335500', null, '万年县', '29', '万年县', '361129', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb1b78bfc2b84ea6a8c4a48f46558a40', 'ae3e3d63e8b541b3a63dd96ec498e5d0', '333200', null, '婺源县', '30', '婺源县', '361130', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('18e873b471594d44a47dbf7d24b596cf', 'ae3e3d63e8b541b3a63dd96ec498e5d0', '334200', null, '德兴市', '81', '德兴市', '361181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2eb6fc53baec41238e2d60dd9c990443', 'f1f171efba3d4ecb9a3489ae544cdd47', '250000', null, '市辖区', '01', '市辖区', '370101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1007a3cd7ed14088b78eed9ed6991d67', 'f1f171efba3d4ecb9a3489ae544cdd47', '250000', null, '历下区', '02', '历下区', '370102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('25badd8088794d358b2c7c02ee5aa7a1', 'f1f171efba3d4ecb9a3489ae544cdd47', '250000', null, '市中区', '03', '市中区', '370103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('24ec59902e644f42a8d66ced0779a533', 'f1f171efba3d4ecb9a3489ae544cdd47', '250000', null, '槐荫区', '04', '槐荫区', '370104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('20c78ee57293430f8e23a60b92f3f921', 'f1f171efba3d4ecb9a3489ae544cdd47', '250000', null, '天桥区', '05', '天桥区', '370105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('082a8d29e8c84ffd9375c5a3cb2ecd1a', 'f1f171efba3d4ecb9a3489ae544cdd47', '250100', null, '历城区', '12', '历城区', '370112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('de76c5f078fa4fdca4761290c50f689e', 'f1f171efba3d4ecb9a3489ae544cdd47', '250300', null, '长清区', '13', '长清区', '370113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3e822ea6ed54462dbca3274b4c11b407', 'f1f171efba3d4ecb9a3489ae544cdd47', '250400', null, '平阴县', '24', '平阴县', '370124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bd98544190f3420db4da0c5ebdfd2f33', 'f1f171efba3d4ecb9a3489ae544cdd47', '251400', null, '济阳县', '25', '济阳县', '370125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f32ab8d458d0461c83b9f67128995046', 'f1f171efba3d4ecb9a3489ae544cdd47', '251600', null, '商河县', '26', '商河县', '370126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6029394416fd444686e1c2b278e24883', 'f1f171efba3d4ecb9a3489ae544cdd47', '250200', null, '章丘市', '81', '章丘市', '370181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f02f8635f28b4493b93e6b32dc45d8ac', '133d81bc3b4c48e7803bde263c887d8f', '117000', null, '溪湖区', '03', '溪湖区', '210503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('417ea7d4ba7f4f1bb047a606de81bfd5', '133d81bc3b4c48e7803bde263c887d8f', '117000', null, '明山区', '04', '明山区', '210504', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('71e1be4ea550415a8ce6eb69f4f3472c', '133d81bc3b4c48e7803bde263c887d8f', '117000', null, '南芬区', '05', '南芬区', '210505', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f8f6099d1f6458bab141d53b6c68ef6', '133d81bc3b4c48e7803bde263c887d8f', '117100', null, '本溪满族自治县', '21', '本溪满族自治县', '210521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e0cad8bde1eb4796addd0b17b0045c15', '133d81bc3b4c48e7803bde263c887d8f', '117200', null, '桓仁满族自治县', '22', '桓仁满族自治县', '210522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e394ea8db31f4f8e89c18e89cf789874', '21f243e300a74fb4abb0138b942daf00', '118000', null, '市辖区', '01', '市辖区', '210601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3765470d0ae243268f0f464b857b85ba', '21f243e300a74fb4abb0138b942daf00', '118000', null, '元宝区', '02', '元宝区', '210602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('44b89db44e254231b5f7764a26519978', '21f243e300a74fb4abb0138b942daf00', '118000', null, '振兴区', '03', '振兴区', '210603', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('57fd69813a554ae190f161ebb4f7cc0f', '6fd17ced4f124cc4881a50ad26321855', '355300', null, '柘荣县', '26', '柘荣县', '350926', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('94bdd1e7bc6645bebe643ed5259d7e31', '6fd17ced4f124cc4881a50ad26321855', '355000', null, '福安市', '81', '福安市', '350981', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b3d2fd156ec044c1922cf910eeac018b', '6fd17ced4f124cc4881a50ad26321855', '355200', null, '福鼎市', '82', '福鼎市', '350982', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ddef5cfe355949df859e1544fd9b02bb', '4f7002a7097045428cafa1878f18556a', '330000', null, '市辖区', '01', '市辖区', '360101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b1aedf4674b948dda7cec2bdd730b536', '4f7002a7097045428cafa1878f18556a', '330000', null, '东湖区', '02', '东湖区', '360102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8804728c72944ec3bc9809fd197541dc', '4f7002a7097045428cafa1878f18556a', '330000', null, '西湖区', '03', '西湖区', '360103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e11a5c76d7d146eaa97760ab02ea7c77', '4f7002a7097045428cafa1878f18556a', '330000', null, '青云谱区', '04', '青云谱区', '360104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('46c7012a5bee4fcc9fa8ee271f4adc2f', '4f7002a7097045428cafa1878f18556a', '330000', null, '湾里区', '05', '湾里区', '360105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b04fd3904d98448ba79f24e0e9d54bdb', '4f7002a7097045428cafa1878f18556a', '330000', null, '青山湖区', '11', '青山湖区', '360111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('35d094bda33b4c6cac5e5ca4684ac76a', '4f7002a7097045428cafa1878f18556a', '330200', null, '南昌县', '21', '南昌县', '360121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fb9c6c844d1f4fd8a2189f74f5db5422', '4f7002a7097045428cafa1878f18556a', '330100', null, '新建县', '22', '新建县', '360122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d2118420d9bd4339a29ec6770ee9b73d', '4f7002a7097045428cafa1878f18556a', '330500', null, '安义县', '23', '安义县', '360123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1edbde17777c4458a4e2ddb25d01dd42', '4f7002a7097045428cafa1878f18556a', '331700', null, '进贤县', '24', '进贤县', '360124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ef753eebd9c54aa0816c9cbcc62064e1', '647fb0abceaf4c5d9ea5b24cdf2de227', '333000', null, '市辖区', '01', '市辖区', '360201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8b9877a5f81242e9bda1ca8488dcd1a3', '647fb0abceaf4c5d9ea5b24cdf2de227', '333000', null, '昌江区', '02', '昌江区', '360202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6070d27ecc814aeea453a003fdeff4ff', '647fb0abceaf4c5d9ea5b24cdf2de227', '333000', null, '珠山区', '03', '珠山区', '360203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ff149057bcba4821821cbeb278e57251', '647fb0abceaf4c5d9ea5b24cdf2de227', '333400', null, '浮梁县', '22', '浮梁县', '360222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bec0b6e547c74a74a6c71b1d6feb9b2e', '647fb0abceaf4c5d9ea5b24cdf2de227', '333300', null, '乐平市', '81', '乐平市', '360281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f3bd48aa05f54760b001a63ee7fd1035', '63879d4cb0b9445c86e98966d15f22d6', '337000', null, '市辖区', '01', '市辖区', '360301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('484ae2d52e17496c946978449925baf5', '63879d4cb0b9445c86e98966d15f22d6', '337000', null, '安源区', '02', '安源区', '360302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb62f0bfe796443b89944beb0ad7a8be', '63879d4cb0b9445c86e98966d15f22d6', '337000', null, '湘东区', '13', '湘东区', '360313', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c52a2e661f01433cb3b04a1e03cf00b2', '63879d4cb0b9445c86e98966d15f22d6', '337100', null, '莲花县', '21', '莲花县', '360321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('977e0d2540254c1bad0f4aba98168fb6', '63879d4cb0b9445c86e98966d15f22d6', '337000', null, '上栗县', '22', '上栗县', '360322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8c0515ee2f044a3ea4b398d3cf06c5f6', '63879d4cb0b9445c86e98966d15f22d6', '337000', null, '芦溪县', '23', '芦溪县', '360323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6c663f82ab9e436dbc87722eb4798b37', '160289800e4949a18ce764e082fa4bd0', '332000', null, '市辖区', '01', '市辖区', '360401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('03c084eecfdd429ea41301c2f8361dd1', '160289800e4949a18ce764e082fa4bd0', '332900', null, '庐山区', '02', '庐山区', '360402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e7ae478236444b60858c10f5cfd8da49', '160289800e4949a18ce764e082fa4bd0', '332000', null, '浔阳区', '03', '浔阳区', '360403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('79a8d79d86414c6f9e7296a2f6652509', '160289800e4949a18ce764e082fa4bd0', '332100', null, '九江县', '21', '九江县', '360421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('070b4f005e084afb9573831e2c7099ae', '160289800e4949a18ce764e082fa4bd0', '332300', null, '武宁县', '23', '武宁县', '360423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('08cc1765c07144aeb764eb524308a7ba', '160289800e4949a18ce764e082fa4bd0', '332400', null, '修水县', '24', '修水县', '360424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a76149756b5b4824ac7ee13aa659cc55', '160289800e4949a18ce764e082fa4bd0', '330300', null, '永修县', '25', '永修县', '360425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5209305e24894ea18e152ea47174d267', '160289800e4949a18ce764e082fa4bd0', '330400', null, '德安县', '26', '德安县', '360426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cfe93c259bae4836b6548ec86843bdd3', '160289800e4949a18ce764e082fa4bd0', '332800', null, '星子县', '27', '星子县', '360427', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f8dd88a464ef4d319914125463f0899e', '160289800e4949a18ce764e082fa4bd0', '332600', null, '都昌县', '28', '都昌县', '360428', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f07d7d08350e4b309163dd742f081307', '160289800e4949a18ce764e082fa4bd0', '332500', null, '湖口县', '29', '湖口县', '360429', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f085b991746e4845a6b7f94c9b9d5cd5', '160289800e4949a18ce764e082fa4bd0', '332700', null, '彭泽县', '30', '彭泽县', '360430', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('620924e675e34f1093efd76a7bd55fd3', '160289800e4949a18ce764e082fa4bd0', '332200', null, '瑞昌市', '81', '瑞昌市', '360481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8a3d7466420b450d8ce40fc7ec5177fe', 'e776f1045e3441a3bf1a91a222e248eb', '336500', null, '市辖区', '01', '市辖区', '360501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f2f094a1c184ea0892f1ca789345364', 'e776f1045e3441a3bf1a91a222e248eb', '336500', null, '渝水区', '02', '渝水区', '360502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('af49bfd91bf4449e926996f2c9ed7b85', 'e776f1045e3441a3bf1a91a222e248eb', '336600', null, '分宜县', '21', '分宜县', '360521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cace220f015c4987815a6e1fe5e1a1f2', 'f48fd507cbb24c9d85e8c2a2181c9115', '335000', null, '市辖区', '01', '市辖区', '360601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e2357ff187d14650bc76fa2f7e0f8817', 'f48fd507cbb24c9d85e8c2a2181c9115', '335000', null, '月湖区', '02', '月湖区', '360602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('78e1cdf05dbe4908aa1e38770cfd73a2', 'f48fd507cbb24c9d85e8c2a2181c9115', '335200', null, '余江县', '22', '余江县', '360622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f649c1e29dab4ad495ceba49e5129a0b', 'f48fd507cbb24c9d85e8c2a2181c9115', '335400', null, '贵溪市', '81', '贵溪市', '360681', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c994000ff132474d8d06b27003519d42', '0a3c848e26ed49d396eb5b00ecce7de0', '341000', null, '市辖区', '01', '市辖区', '360701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bfb7f97083a74af08263a64f358bb841', '0a3c848e26ed49d396eb5b00ecce7de0', '341000', null, '章贡区', '02', '章贡区', '360702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e64b02c12146490ea6a5b5ac5f9c7dae', '0a3c848e26ed49d396eb5b00ecce7de0', '341100', null, '赣县', '21', '赣县', '360721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('077acda2097f47ca999ab16e93da6671', '0a3c848e26ed49d396eb5b00ecce7de0', '341600', null, '信丰县', '22', '信丰县', '360722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6a41aa3da3804c8f8a768e9244c1f903', '0a3c848e26ed49d396eb5b00ecce7de0', '341500', null, '大余县', '23', '大余县', '360723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ab5f75a28947470ca6500beae06559a4', '0a3c848e26ed49d396eb5b00ecce7de0', '341200', null, '上犹县', '24', '上犹县', '360724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fa367fa728e74beba58062eff1c73cce', '0a3c848e26ed49d396eb5b00ecce7de0', '341300', null, '崇义县', '25', '崇义县', '360725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f02b9d89c2504d8ebc4633f1fe5daf30', '0a3c848e26ed49d396eb5b00ecce7de0', '342100', null, '安远县', '26', '安远县', '360726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('905f3d9ec51246dc9cc8d5b618f06d0b', '0a3c848e26ed49d396eb5b00ecce7de0', '341700', null, '龙南县', '27', '龙南县', '360727', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ecad4a47227340b89c8d03a9df604103', '0a3c848e26ed49d396eb5b00ecce7de0', '341900', null, '定南县', '28', '定南县', '360728', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6fb02bc640a046dbad1be91e2f95dfd9', '0a3c848e26ed49d396eb5b00ecce7de0', '341800', null, '全南县', '29', '全南县', '360729', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('63c64b11f66543479f67736cc7f73515', '0a3c848e26ed49d396eb5b00ecce7de0', '342800', null, '宁都县', '30', '宁都县', '360730', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('03b56018ce35467292294b6ea3444192', '0a3c848e26ed49d396eb5b00ecce7de0', '342300', null, '于都县', '31', '于都县', '360731', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0ba16338a51f4498a221523d0b2041ea', '0a3c848e26ed49d396eb5b00ecce7de0', '342400', null, '兴国县', '32', '兴国县', '360732', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eb20ac0af8c0495888cfa3d2a6567e81', '0a3c848e26ed49d396eb5b00ecce7de0', '342600', null, '会昌县', '33', '会昌县', '360733', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('77b5f0506b704ad9a0dc04ad31f9b906', '0a3c848e26ed49d396eb5b00ecce7de0', '342200', null, '寻乌县', '34', '寻乌县', '360734', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d3d4b1ab8de4692a70cfe8fbba17f2e', '0a3c848e26ed49d396eb5b00ecce7de0', '342700', null, '石城县', '35', '石城县', '360735', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('842e944b9ad94338af27b3de1bd0bd79', '0a3c848e26ed49d396eb5b00ecce7de0', '342500', null, '瑞金市', '81', '瑞金市', '360781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d205e009c37340a8aa7aa4780490c55a', '0a3c848e26ed49d396eb5b00ecce7de0', '341400', null, '南康市', '82', '南康市', '360782', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('14e8e725c8594fc1b795adcfa24e6c84', '04639f4c045a44258ebff7fc94fec3e5', '343000', null, '市辖区', '01', '市辖区', '360801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('452de1eca70948d89e2d2f660f430124', '04639f4c045a44258ebff7fc94fec3e5', '343000', null, '吉州区', '02', '吉州区', '360802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('84a695d5b0634a85a2dca02241fb0319', '04639f4c045a44258ebff7fc94fec3e5', '343000', null, '青原区', '03', '青原区', '360803', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e5ef3e58326f4b868767767ccc943dec', '3a3f1ba7751f47dabb57b457b678be60', '130000', null, '宽城区', '03', '宽城区', '220103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bdffc1307cc843a0938d23e41a9f9ae3', '3a3f1ba7751f47dabb57b457b678be60', '130000', null, '朝阳区', '04', '朝阳区', '220104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b8af6e8f8efa4be38186a2543c296f43', '3a3f1ba7751f47dabb57b457b678be60', '130000', null, '二道区', '05', '二道区', '220105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ccef5307e4a7470188f3ab7bef0ee461', '3a3f1ba7751f47dabb57b457b678be60', '130000', null, '绿园区', '06', '绿园区', '220106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('46004a4d1eef4e5ea88c8f53873e0ce9', '3a3f1ba7751f47dabb57b457b678be60', '130600', null, '双阳区', '12', '双阳区', '220112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('842feca2b01b4ad9bdd3539b619b4ad5', '3a3f1ba7751f47dabb57b457b678be60', '130200', null, '农安县', '22', '农安县', '220122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7c24597807ba4d70ae9fc37bb2c66056', '3a3f1ba7751f47dabb57b457b678be60', '130500', null, '九台市', '81', '九台市', '220181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('944e55738e074e92a22e3c30e9fd7976', '3a3f1ba7751f47dabb57b457b678be60', '130400', null, '榆树市', '82', '榆树市', '220182', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('674f926e61ea4d67a3c1242a07c2966f', '3a3f1ba7751f47dabb57b457b678be60', '130300', null, '德惠市', '83', '德惠市', '220183', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('64431ff7e3dc410aa14059b62550b74c', '7774e0ff0e204d1e8f1c239d87344aa2', '132000', null, '市辖区', '01', '市辖区', '220201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d5ef1713d2144f93ae450848b5f6b4fb', '7774e0ff0e204d1e8f1c239d87344aa2', '132000', null, '昌邑区', '02', '昌邑区', '220202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a573934eedc641d7aa4e03efee946f6a', '7774e0ff0e204d1e8f1c239d87344aa2', '132000', null, '龙潭区', '03', '龙潭区', '220203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('24a3686cfb004912801759ec943bff74', '7774e0ff0e204d1e8f1c239d87344aa2', '132000', null, '船营区', '04', '船营区', '220204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3fd38c6c6ba4019a39f20bdc76e1edb', '7774e0ff0e204d1e8f1c239d87344aa2', '132000', null, '丰满区', '11', '丰满区', '220211', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8784730772d843e99549a923e322a72f', '7774e0ff0e204d1e8f1c239d87344aa2', '132100', null, '永吉县', '21', '永吉县', '220221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('95c2720f6aac49999d7af0ed743df73d', '7774e0ff0e204d1e8f1c239d87344aa2', '132500', null, '蛟河市', '81', '蛟河市', '220281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('41ea709324a34155b8d076023d7fa84d', '7774e0ff0e204d1e8f1c239d87344aa2', '132400', null, '桦甸市', '82', '桦甸市', '220282', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('069efe93e6be4d7b89c087a158ddb0dd', '7774e0ff0e204d1e8f1c239d87344aa2', '132600', null, '舒兰市', '83', '舒兰市', '220283', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cfa8365fad8a472d917a2fa04ec1edb5', '7774e0ff0e204d1e8f1c239d87344aa2', '132300', null, '磐石市', '84', '磐石市', '220284', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('97b8500058664f389025a000366b6dc3', '00d948ff21b342779471d96e783f9822', '136000', null, '市辖区', '01', '市辖区', '220301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('01d0a7faf81e4efcb4e034bb22710181', '00d948ff21b342779471d96e783f9822', '136000', null, '铁西区', '02', '铁西区', '220302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dd5e707e74334130ab1bafd80883656a', '00d948ff21b342779471d96e783f9822', '136000', null, '铁东区', '03', '铁东区', '220303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('248fde75c1d644be94d4dc59f3d1acac', '00d948ff21b342779471d96e783f9822', '136500', null, '梨树县', '22', '梨树县', '220322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4fc86b76aceb4e2fa5ddb1fabf255218', '00d948ff21b342779471d96e783f9822', '130700', null, '伊通满族自治县', '23', '伊通满族自治县', '220323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fcc8c7d6c4b1425e87fe645591b0751f', '00d948ff21b342779471d96e783f9822', '136100', null, '公主岭市', '81', '公主岭市', '220381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6dc89fd557ec48fcb501374dd1aab123', '00d948ff21b342779471d96e783f9822', '136400', null, '双辽市', '82', '双辽市', '220382', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8560872e81034fc9a3825eb218364e41', '8ce5a37dedc84f23832b14be8e0c601e', '136200', null, '市辖区', '01', '市辖区', '220401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5a069b17a23346c0b8333717c2a65188', '8ce5a37dedc84f23832b14be8e0c601e', '136200', null, '龙山区', '02', '龙山区', '220402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('13d6ed5f8c9d455f818e02b21cb611b6', '8ce5a37dedc84f23832b14be8e0c601e', '136200', null, '西安区', '03', '西安区', '220403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e3e33324665f4921bfd4df61c64f4658', '8ce5a37dedc84f23832b14be8e0c601e', '136300', null, '东丰县', '21', '东丰县', '220421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('48079fbed33944189213ad44e4aec260', '8ce5a37dedc84f23832b14be8e0c601e', '136600', null, '东辽县', '22', '东辽县', '220422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0b378ff8d5fa40fb8a5837c88f6d3df4', 'c2cf2135b6be4b99b8fd891bbd43f686', '134000', null, '市辖区', '01', '市辖区', '220501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2d0ff7e82290422fb364b247057d4975', 'c2cf2135b6be4b99b8fd891bbd43f686', '134000', null, '东昌区', '02', '东昌区', '220502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f00a3f42718847869cca06e74c5d3990', 'c2cf2135b6be4b99b8fd891bbd43f686', '134000', null, '二道江区', '03', '二道江区', '220503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0d65473a4dda457db1a8ecc5d346f8ab', 'c2cf2135b6be4b99b8fd891bbd43f686', '134100', null, '通化县', '21', '通化县', '220521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d20439e20e9648b1aaef1589867091cb', 'c2cf2135b6be4b99b8fd891bbd43f686', '135100', null, '辉南县', '23', '辉南县', '220523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('544d0d2e40e14f888b11e67c99a301aa', 'c2cf2135b6be4b99b8fd891bbd43f686', '135300', null, '柳河县', '24', '柳河县', '220524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c42dedaae0b143b081ef1c954ab0cb1b', 'c2cf2135b6be4b99b8fd891bbd43f686', '135000', null, '梅河口市', '81', '梅河口市', '220581', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b8fec82934b24acab60d7509df038b46', 'c2cf2135b6be4b99b8fd891bbd43f686', '134200', null, '集安市', '82', '集安市', '220582', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2dcb0f2436f54ae0a105d54f0cb8eee4', '3551b526f5e7417fae31cf0d2edb4d9d', '134300', null, '市辖区', '01', '市辖区', '220601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('99bbbca0b38e4393aa2eaef3bf67a219', '3551b526f5e7417fae31cf0d2edb4d9d', '134300', null, '八道江区', '02', '八道江区', '220602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5115978cb0924624adeadbbe1c10f190', '3551b526f5e7417fae31cf0d2edb4d9d', '134500', null, '抚松县', '21', '抚松县', '220621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('515b7a16579d443d8707a53359fba6bb', '3551b526f5e7417fae31cf0d2edb4d9d', '135200', null, '靖宇县', '22', '靖宇县', '220622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d4cde58e7c244edbbf981cdd4b2e46ff', '3551b526f5e7417fae31cf0d2edb4d9d', '134400', null, '长白朝鲜族自治县', '23', '长白朝鲜族自治县', '220623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('09ba0626d4b44b9a97dad5f70bf5b7ed', '3551b526f5e7417fae31cf0d2edb4d9d', '134700', null, '江源区', '25', '江源区', '220625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5c943ad9a78d44a0950037119edd3ed0', '3551b526f5e7417fae31cf0d2edb4d9d', '134600', null, '临江市', '81', '临江市', '220681', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('69c173cc08bb43afae3a02245c303b88', 'a0ee1a7af5be4b53b88627407200545f', '138000', null, '市辖区', '01', '市辖区', '220701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a09681f177b4472c8b0fd431fa25b878', 'a0ee1a7af5be4b53b88627407200545f', '138000', null, '宁江区', '02', '宁江区', '220702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7ed7eab38e8747ac938eba076e5dfe10', 'a0ee1a7af5be4b53b88627407200545f', '131100', null, '前郭尔罗斯蒙古族自治县', '21', '前郭尔罗斯蒙古族自治县', '220721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2f47130ae9e942a7bf503c016c5e2d58', 'a0ee1a7af5be4b53b88627407200545f', '131500', null, '长岭县', '22', '长岭县', '220722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('597e1ad0cded48a48eadeca8ea67e98d', 'a0ee1a7af5be4b53b88627407200545f', '131400', null, '乾安县', '23', '乾安县', '220723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a8ae88a9a4e54568b7712292873f26bd', 'a0ee1a7af5be4b53b88627407200545f', '131200', null, '扶余县', '24', '扶余县', '220724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('02f07cb01edd4194a51e953dabf94325', 'bd2d77f833b2472d8a828a90f402f861', '137000', null, '市辖区', '01', '市辖区', '220801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('08586b0523584edf89475a2955f1a48d', 'bd2d77f833b2472d8a828a90f402f861', '137000', null, '洮北区', '02', '洮北区', '220802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5242f6457c4f46e1878df16a820bc03c', 'bd2d77f833b2472d8a828a90f402f861', '137300', null, '镇赉县', '21', '镇赉县', '220821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('75f144842bc4458fa864d602526f5881', 'bd2d77f833b2472d8a828a90f402f861', '137200', null, '通榆县', '22', '通榆县', '220822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('70119777667a42e2b9a7ebcf51571f0f', 'bd2d77f833b2472d8a828a90f402f861', '137100', null, '洮南市', '81', '洮南市', '220881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('80f17c3ae12d4c6ba7fa7534b9e4e6d8', '1d21c167dbe048d7942a636ec4ce172c', '472300', null, '义马市', '81', '义马市', '411281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('83f4aa9bbf3043cb8f9b2f9330527173', 'db9ba52f83f943c3bb606a0d52ad769e', '231200', null, '肥西县', '23', '肥西县', '340123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('edc01ef8f1314c58b9cc1e220ac49b64', 'e3a4a4ba5c56445c92c6a4d932ae463e', '241000', null, '市辖区', '01', '市辖区', '340201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e68c232d9c294bd2b62bc8cb91e99bf1', 'e3a4a4ba5c56445c92c6a4d932ae463e', '241000', null, '镜湖区', '02', '镜湖区', '340202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('96951cd3367343ce8fdc61e5f60b09a8', 'e3a4a4ba5c56445c92c6a4d932ae463e', '241000', null, '马塘区', '03', '马塘区', '340203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('98e41b79cb024c609b927474d2d14c90', 'e3a4a4ba5c56445c92c6a4d932ae463e', '241000', null, '新芜区', '04', '新芜区', '340204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6c4d3914a8624862a8e71dcfc41c3052', 'e3a4a4ba5c56445c92c6a4d932ae463e', '241000', null, '鸠江区', '07', '鸠江区', '340207', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7e5254d8b4ef4e72b226f7253fc12f3b', 'e3a4a4ba5c56445c92c6a4d932ae463e', '241100', null, '芜湖县', '21', '芜湖县', '340221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e1ae0535385d4171b0722412d981c000', '0700bce39eff4bbaad9989a4e5283ea5', '152000', null, '北林区', '02', '北林区', '231202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cab2bd32bfd9429daef07c667dc999ee', '0700bce39eff4bbaad9989a4e5283ea5', '152100', null, '望奎县', '21', '望奎县', '231221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6e90a1db12194fe0880fad61a2ee9a7a', '0700bce39eff4bbaad9989a4e5283ea5', '151500', null, '兰西县', '22', '兰西县', '231222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0f7c2ac27e3b4986b25328110ba6f218', '0700bce39eff4bbaad9989a4e5283ea5', '151600', null, '青冈县', '23', '青冈县', '231223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('62a8ab9dc84941089c2b4c6c16bcecc1', '0700bce39eff4bbaad9989a4e5283ea5', '152400', null, '庆安县', '24', '庆安县', '231224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5e4a58c7341f4e75a04e67e815970dcf', '0700bce39eff4bbaad9989a4e5283ea5', '151700', null, '明水县', '25', '明水县', '231225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2059b0e5bbb84b52aa81eb6e8f657b68', '0700bce39eff4bbaad9989a4e5283ea5', '152200', null, '绥棱县', '26', '绥棱县', '231226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e14fd9d655f446c696a53d907aff2d65', '0700bce39eff4bbaad9989a4e5283ea5', '151400', null, '安达市', '81', '安达市', '231281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6ec62519ae3541c695f2fcc6fbea550b', '0700bce39eff4bbaad9989a4e5283ea5', '151100', null, '肇东市', '82', '肇东市', '231282', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3ff4b70de31d4d31b0eab9f1af5d2384', '0700bce39eff4bbaad9989a4e5283ea5', '152300', null, '海伦市', '83', '海伦市', '231283', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('412ddca1d6a84e19841ca2604db6c503', 'ba25a32ee5ea4cbaae42084151c8cd4c', '165100', null, '呼玛县', '21', '呼玛县', '232721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('77b97e47716d44989e21ab4373ee6212', 'ba25a32ee5ea4cbaae42084151c8cd4c', '165200', null, '塔河县', '22', '塔河县', '232722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f5c02b9f7c047a89d1b31b3fd87e6b4', 'ba25a32ee5ea4cbaae42084151c8cd4c', '165300', null, '漠河县', '23', '漠河县', '232723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('413a888279364b00817856cee772e30c', '9cf48c1bd1494b26b7dfeb12ea3238d8', '200000', null, '黄浦区', '01', '黄浦区', '310101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('acbde2c70e5c466aa2041de131125641', '9cf48c1bd1494b26b7dfeb12ea3238d8', '200000', null, '卢湾区', '03', '卢湾区', '310103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('08702d03833f45efaf35b1226bae8ee1', '9cf48c1bd1494b26b7dfeb12ea3238d8', '200000', null, '徐汇区', '04', '徐汇区', '310104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3992790d3bdc466c9bc363c5b9f0b20d', '9cf48c1bd1494b26b7dfeb12ea3238d8', '200000', null, '长宁区', '05', '长宁区', '310105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7be3568d19f443e58f213cf479a11553', '9cf48c1bd1494b26b7dfeb12ea3238d8', '200000', null, '静安区', '06', '静安区', '310106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cdc5e540166a42c09b6a7ef944dca501', '9cf48c1bd1494b26b7dfeb12ea3238d8', '200000', null, '普陀区', '07', '普陀区', '310107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c5a5796aeb60418485a07b73c73ecdb0', '9cf48c1bd1494b26b7dfeb12ea3238d8', '200000', null, '闸北区', '08', '闸北区', '310108', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('65ce1fc6882442d3bef3648c12084922', '9cf48c1bd1494b26b7dfeb12ea3238d8', '200000', null, '虹口区', '09', '虹口区', '310109', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e7edc3e13a2545b79dd4fee37cbab926', '9cf48c1bd1494b26b7dfeb12ea3238d8', '200000', null, '杨浦区', '10', '杨浦区', '310110', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('61d98065c43d44299a842af349e7d8e6', '9cf48c1bd1494b26b7dfeb12ea3238d8', '201100', null, '闵行区', '12', '闵行区', '310112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f0b575ad559c4fd588b103110b527a3d', '9cf48c1bd1494b26b7dfeb12ea3238d8', '201900', null, '宝山区', '13', '宝山区', '310113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d88676cd8f6c4d4eaf5fb42637902c20', '9cf48c1bd1494b26b7dfeb12ea3238d8', '201800', null, '嘉定区', '14', '嘉定区', '310114', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e8985210b5b2495cb7aa0661771acdef', '9cf48c1bd1494b26b7dfeb12ea3238d8', '200120', null, '浦东新区', '15', '浦东新区', '310115', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3cd0f15149d24105b6d94ffbf9b45bb2', '9cf48c1bd1494b26b7dfeb12ea3238d8', '201500', null, '金山区', '16', '金山区', '310116', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('df1621f2212845f0b8d35a38e51ed81f', '9cf48c1bd1494b26b7dfeb12ea3238d8', '201600', null, '松江区', '17', '松江区', '310117', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7870c5d0aaea469498e84f2dc50f9f82', '9cf48c1bd1494b26b7dfeb12ea3238d8', '201700', null, '青浦区', '18', '青浦区', '310118', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a59800b72239400496be522ce44d94d1', '9cf48c1bd1494b26b7dfeb12ea3238d8', '201300', null, '南汇区', '19', '南汇区', '310119', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8c7cad8a9bab4547adb0afb9fcfe7c39', '9cf48c1bd1494b26b7dfeb12ea3238d8', '201400', null, '奉贤区', '20', '奉贤区', '310120', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6aab3a95115b42cca2de325b16b464cd', '9cf48c1bd1494b26b7dfeb12ea3238d8', '202150', null, '崇明县', '30', '崇明县', '310230', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8a72926d51524807bdba69004899dd5d', 'e15988d61b834780bec69b7dac6c283a', '210000', null, '市辖区', '01', '市辖区', '320101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3302343f401b44bb8e7707d70153d585', 'e15988d61b834780bec69b7dac6c283a', '210000', null, '玄武区', '02', '玄武区', '320102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bea67e2add404a4db49a728661c02e0d', 'e15988d61b834780bec69b7dac6c283a', '210000', null, '白下区', '03', '白下区', '320103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b610e8c359674cf2bb56dc332709f757', 'e15988d61b834780bec69b7dac6c283a', '210000', null, '秦淮区', '04', '秦淮区', '320104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('55ec3ca837174e22abbdb5cec5688ac4', 'e15988d61b834780bec69b7dac6c283a', '210000', null, '建邺区', '05', '建邺区', '320105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5ebf0d8369924e8abe369ae261c53a99', 'e15988d61b834780bec69b7dac6c283a', '210000', null, '鼓楼区', '06', '鼓楼区', '320106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2cc938949e944bbd9cd9e32776e0bdc3', 'e15988d61b834780bec69b7dac6c283a', '210000', null, '下关区', '07', '下关区', '320107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('18cfcb00bd644914833e0678dcd49b58', 'e15988d61b834780bec69b7dac6c283a', '210000', null, '浦口区', '11', '浦口区', '320111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('335afa07c57045d2976e55abdcc58e2d', 'e15988d61b834780bec69b7dac6c283a', '210000', null, '栖霞区', '13', '栖霞区', '320113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ad697b2753ec48d69c77fd609d20c669', 'e15988d61b834780bec69b7dac6c283a', '210000', null, '雨花台区', '14', '雨花台区', '320114', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0c542275d44145bf8de459445f048316', 'e15988d61b834780bec69b7dac6c283a', '211100', null, '江宁区', '15', '江宁区', '320115', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e3abf9a4410c4d0eb62bba155f902f0e', 'e15988d61b834780bec69b7dac6c283a', '211500', null, '六合区', '16', '六合区', '320116', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('50e87c6315464d709ff17380c5422c1b', 'e15988d61b834780bec69b7dac6c283a', '211200', null, '溧水县', '24', '溧水县', '320124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('072f0b4f06284fad936afe0e0d0e6189', 'e15988d61b834780bec69b7dac6c283a', '211300', null, '高淳县', '25', '高淳县', '320125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bbb2cb95c1e2450092fc1c3fa67b8081', 'b02f8deca60a49b98e7ed5aa0428e5e6', '214000', null, '市辖区', '01', '市辖区', '320201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('afb23849574346fb910f7e31298c0f1d', 'b02f8deca60a49b98e7ed5aa0428e5e6', '214000', null, '崇安区', '02', '崇安区', '320202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('32fe10222ada4489bdedcbcf71c8f6de', 'b02f8deca60a49b98e7ed5aa0428e5e6', '214000', null, '南长区', '03', '南长区', '320203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b66646ec0d194251b1f29792db71062c', 'b02f8deca60a49b98e7ed5aa0428e5e6', '214000', null, '北塘区', '04', '北塘区', '320204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ee081b763fa845ddaf05d38d27a5708a', 'b02f8deca60a49b98e7ed5aa0428e5e6', '214000', null, '锡山区', '05', '锡山区', '320205', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d03c9b71727e4dfcac8fc8bfb281bb9e', 'b02f8deca60a49b98e7ed5aa0428e5e6', '214000', null, '惠山区', '06', '惠山区', '320206', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0f97de95f5cd49ecb232e653e1e586ef', 'b02f8deca60a49b98e7ed5aa0428e5e6', '214000', null, '滨湖区', '11', '滨湖区', '320211', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('482a4d4211ea4e54af1fffe146c865d4', 'b02f8deca60a49b98e7ed5aa0428e5e6', '214400', null, '江阴市', '81', '江阴市', '320281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c3a171d014774d19be4bcb7a622fb2e3', 'b02f8deca60a49b98e7ed5aa0428e5e6', '214200', null, '宜兴市', '82', '宜兴市', '320282', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a362825afaa64316a5b0e7394b1f115a', '02fd4185ea2343ffaae15ca2c5caf2b3', '221000', null, '市辖区', '01', '市辖区', '320301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('47818cdd94a6496a8f2132e693ff1dda', '02fd4185ea2343ffaae15ca2c5caf2b3', '221000', null, '鼓楼区', '02', '鼓楼区', '320302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6e499b8ea85d4f85bed95324681452a9', '02fd4185ea2343ffaae15ca2c5caf2b3', '221000', null, '云龙区', '03', '云龙区', '320303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1ac1102d45f941159c3b8e73846cd4cf', '02fd4185ea2343ffaae15ca2c5caf2b3', '221000', null, '九里区', '04', '九里区', '320304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9e39d462851e41988fcc056fa344165c', '02fd4185ea2343ffaae15ca2c5caf2b3', '221000', null, '贾汪区', '05', '贾汪区', '320305', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('581dbbc4c5a648a1a51f01f1a895227b', 'adf505a23af74179b00c02a084407ca8', '266000', null, '市辖区', '01', '市辖区', '370201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7edba3a11e504eb19f9dc78fb146cdbb', 'adf505a23af74179b00c02a084407ca8', '266000', null, '市南区', '02', '市南区', '370202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e4ddb821ccd145fdbfe321f8ea544d31', 'adf505a23af74179b00c02a084407ca8', '266000', null, '市北区', '03', '市北区', '370203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0bb372c0466249a790302c0e63ec33d1', 'adf505a23af74179b00c02a084407ca8', '266000', null, '四方区', '05', '四方区', '370205', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c7463e9e8da4471e81de2be43ce624bc', 'adf505a23af74179b00c02a084407ca8', '266000', null, '黄岛区', '11', '黄岛区', '370211', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('926d102728534f35973b3790de030ba4', 'adf505a23af74179b00c02a084407ca8', '266100', null, '崂山区', '12', '崂山区', '370212', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('63ea2527dc5741309489c5fd1a2e150a', '02fd4185ea2343ffaae15ca2c5caf2b3', '221300', null, '邳州市', '82', '邳州市', '320382', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2e51ac7159e94b30a4e01b2b45581f21', '0c09b62ba8c74384bc7edf68979f3caf', '213000', null, '市辖区', '01', '市辖区', '320401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('55e6cbcc4dae41bb924e955a647fa9e0', '0c09b62ba8c74384bc7edf68979f3caf', '213000', null, '天宁区', '02', '天宁区', '320402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d9014da174d9476ca331a5f97312a4d2', '0c09b62ba8c74384bc7edf68979f3caf', '213000', null, '钟楼区', '04', '钟楼区', '320404', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('26f6793bc2584acdb01762caacfd4f31', '0c09b62ba8c74384bc7edf68979f3caf', '213000', null, '戚墅堰区', '05', '戚墅堰区', '320405', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e007c9863c34072bbe29ed06d897771', '0c09b62ba8c74384bc7edf68979f3caf', '213000', null, '新北区', '11', '新北区', '320411', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bdaa54fee7c1405ea671621ea1aaf4a0', '0c09b62ba8c74384bc7edf68979f3caf', '213100', null, '武进区', '12', '武进区', '320412', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6efde1669e99445eb687e822a083b5d6', '0c09b62ba8c74384bc7edf68979f3caf', '213300', null, '溧阳市', '81', '溧阳市', '320481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f2488a5d03d4412aa8ced57bec72941d', '0c09b62ba8c74384bc7edf68979f3caf', '213200', null, '金坛市', '82', '金坛市', '320482', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('547fc56376d4459592d1b83aafdb8779', '09e191fc259b41d49524f1ffa57f641f', '215000', null, '市辖区', '01', '市辖区', '320501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c582932c754f462cb849f4676e38cae6', '09e191fc259b41d49524f1ffa57f641f', '215000', null, '沧浪区', '02', '沧浪区', '320502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aff7914ffbb04e7c9f4870675538f9cc', '09e191fc259b41d49524f1ffa57f641f', '215000', null, '平江区', '03', '平江区', '320503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6863bf97c95a44428d3fa20906c05bcf', '09e191fc259b41d49524f1ffa57f641f', '215000', null, '金阊区', '04', '金阊区', '320504', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('746e11bfdf724828ba64dbf2e46a3a81', '09e191fc259b41d49524f1ffa57f641f', '215000', null, '虎丘区', '05', '虎丘区', '320505', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('351bfa47a8fb4bc49d27366fff57e41f', '09e191fc259b41d49524f1ffa57f641f', '215100', null, '吴中区', '06', '吴中区', '320506', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d819efc8a2c240e49743578cb7a00b8f', '09e191fc259b41d49524f1ffa57f641f', '215100', null, '相城区', '07', '相城区', '320507', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('08ee5cfd5a0b486f85ba6196d4fdf02d', '09e191fc259b41d49524f1ffa57f641f', '215500', null, '常熟市', '81', '常熟市', '320581', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c7cb9edc3b834b2489f248550c373b87', '09e191fc259b41d49524f1ffa57f641f', '215600', null, '张家港市', '82', '张家港市', '320582', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('94e7e116b4f345a78e154ce85cae4969', '09e191fc259b41d49524f1ffa57f641f', '215300', null, '昆山市', '83', '昆山市', '320583', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e9c32e4cbddd44e19f5b2634ab92b213', '09e191fc259b41d49524f1ffa57f641f', '215200', null, '吴江市', '84', '吴江市', '320584', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('223544a6f09d476a8a79b3ae22613669', '09e191fc259b41d49524f1ffa57f641f', '215400', null, '太仓市', '85', '太仓市', '320585', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('99df5e1435bd4dbbb9ebceeba2afd4ae', 'b98b1f8bf0b94b8785ca162c17011d3f', '226000', null, '市辖区', '01', '市辖区', '320601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('85e38fa47c014b239dc388be49376fbc', 'b98b1f8bf0b94b8785ca162c17011d3f', '226000', null, '崇川区', '02', '崇川区', '320602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fc887be5f650494ea0cce188b371c5a8', 'b98b1f8bf0b94b8785ca162c17011d3f', '226000', null, '港闸区', '11', '港闸区', '320611', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('558cfb58373341f992fe2375ef55e0e1', 'b98b1f8bf0b94b8785ca162c17011d3f', '226600', null, '海安县', '21', '海安县', '320621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('616e40587b5b4db69dfe2b492cbce9b6', 'b98b1f8bf0b94b8785ca162c17011d3f', '226400', null, '如东县', '23', '如东县', '320623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5896ef95a27e4e318425307f527125ac', 'b98b1f8bf0b94b8785ca162c17011d3f', '226200', null, '启东市', '81', '启东市', '320681', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ca1d1903946c4ff7aa11f402f695f44e', 'b98b1f8bf0b94b8785ca162c17011d3f', '226500', null, '如皋市', '82', '如皋市', '320682', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ea0de6f90c8947faa912d9b5fbe8a023', 'b98b1f8bf0b94b8785ca162c17011d3f', '226300', null, '通州市', '83', '通州市', '320683', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('75a9a778b96c4f7393138b5122a8f37a', 'b98b1f8bf0b94b8785ca162c17011d3f', '226100', null, '海门市', '84', '海门市', '320684', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9c53e2ac0e2349c3a78bd3b871e542ef', 'c85fe163313c4fd78e007d8ab1d9a9c7', '222000', null, '市辖区', '01', '市辖区', '320701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d5a1fae397f344d8b0345b9564294bbe', 'c85fe163313c4fd78e007d8ab1d9a9c7', '222000', null, '连云区', '03', '连云区', '320703', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d94a770db89d4342a0c93300d4bfb1c7', '08cb7a128990421a99d0528514ebe24c', '611600', null, '蒲江县', '31', '蒲江县', '510131', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7894580499244da0822a317f5c283249', '08cb7a128990421a99d0528514ebe24c', '611400', null, '新津县', '32', '新津县', '510132', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('38071602dd184fc198277eca81000232', '08cb7a128990421a99d0528514ebe24c', '611800', null, '都江堰市', '81', '都江堰市', '510181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('211aca7a0de5400089baf1b46b0fb794', '08cb7a128990421a99d0528514ebe24c', '610000', null, '彭州市', '82', '彭州市', '510182', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ff467d11c9c74a2b8f0159e5ec4c9251', '08cb7a128990421a99d0528514ebe24c', '611500', null, '邛崃市', '83', '邛崃市', '510183', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('860390f90c4148c793dd1ede0805d1a3', '08cb7a128990421a99d0528514ebe24c', '611200', null, '崇州市', '84', '崇州市', '510184', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3ce0f1c7048446a9bffacc651593d725', 'c119b8ebe0464e6e8535bca0598e13eb', '643000', null, '市辖区', '01', '市辖区', '510301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1c800c5485704623903fa449e1199beb', 'c119b8ebe0464e6e8535bca0598e13eb', '643000', null, '自流井区', '02', '自流井区', '510302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0c52398ab83942b48c2dda87b209dcdb', 'c119b8ebe0464e6e8535bca0598e13eb', '643020', null, '贡井区', '03', '贡井区', '510303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3b34ec44d6dc47529952c826e6a1ce1a', 'c119b8ebe0464e6e8535bca0598e13eb', '643010', null, '大安区', '04', '大安区', '510304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d0a933632ca04a878f17f5ad06c11c6a', 'c119b8ebe0464e6e8535bca0598e13eb', '643030', null, '沿滩区', '11', '沿滩区', '510311', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('84324997bd6742f4a484cd11cd646b52', 'c119b8ebe0464e6e8535bca0598e13eb', '643100', null, '荣县', '21', '荣县', '510321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7cd9bec3d89e4cdfbc4da67e9052b5c0', 'c119b8ebe0464e6e8535bca0598e13eb', '643200', null, '富顺县', '22', '富顺县', '510322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8a3c409f8de341ef803d67e25aa4542d', 'e416c82c26c848c1a9532943280f7738', '617000', null, '市辖区', '01', '市辖区', '510401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6815f0fdbd8f4a8b93347c3f1381747a', '8ebfb0cbf62d4b6597fd742963815e4d', '431400', null, '新洲区', '17', '新洲区', '420117', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('678c759721a147089945612eb1291e39', 'f0236aa5f8f246bfaa238b0f756c17d4', '435000', null, '市辖区', '01', '市辖区', '420201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('31e85afa3929414e8e95c8ef288b381c', 'f0236aa5f8f246bfaa238b0f756c17d4', '435000', null, '黄石港区', '02', '黄石港区', '420202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e83feaeede4342cea4e9ec636f099261', 'f0236aa5f8f246bfaa238b0f756c17d4', '435000', null, '西塞山区', '03', '西塞山区', '420203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('baae26e11db246089dbc1d42a725f19a', 'f0236aa5f8f246bfaa238b0f756c17d4', '435000', null, '下陆区', '04', '下陆区', '420204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b2283de412bd49538693cc5a6999bf2e', 'f0236aa5f8f246bfaa238b0f756c17d4', '435000', null, '铁山区', '05', '铁山区', '420205', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('77a2f2fd31f74852b413dda8f3490be3', 'f0236aa5f8f246bfaa238b0f756c17d4', '435200', null, '阳新县', '22', '阳新县', '420222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9d6f5d86c63241efb39012c947643d88', 'f0236aa5f8f246bfaa238b0f756c17d4', '435100', null, '大冶市', '81', '大冶市', '420281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e60f037eeea441b08098a015eeb4c2fc', 'd3a817abfa1a4d2f80ce7ca14cb04134', '442000', null, '市辖区', '01', '市辖区', '420301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('027068bce3714f79ace559d61c93bbec', 'd3a817abfa1a4d2f80ce7ca14cb04134', '442000', null, '茅箭区', '02', '茅箭区', '420302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f4d1d3edfbe41fe88787b2d582e2d02', 'd3a817abfa1a4d2f80ce7ca14cb04134', '442000', null, '张湾区', '03', '张湾区', '420303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('34b47c9481aa49d4b4102cfdf063d831', 'd3a817abfa1a4d2f80ce7ca14cb04134', '442500', null, '郧县', '21', '郧县', '420321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('39ad6eb1206748a7a929ba341914c434', 'd3a817abfa1a4d2f80ce7ca14cb04134', '442600', null, '郧西县', '22', '郧西县', '420322', null);
commit;
----prompt 2000 records committed...
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ceb67fd1148a454d81ca22a79fcacc0e', 'd3a817abfa1a4d2f80ce7ca14cb04134', '442200', null, '竹山县', '23', '竹山县', '420323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('62789c50cdd8432697fdd7b62452e45b', 'd3a817abfa1a4d2f80ce7ca14cb04134', '442300', null, '竹溪县', '24', '竹溪县', '420324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('17cad7d69d02484485a3f7ca9f5e4b17', 'd3a817abfa1a4d2f80ce7ca14cb04134', '442100', null, '房县', '25', '房县', '420325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0a6d43ffb3b141f286108eafa66a2e0a', 'd3a817abfa1a4d2f80ce7ca14cb04134', '442700', null, '丹江口市', '81', '丹江口市', '420381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c80457ffa3754abe89722702b777a84c', 'e3d5484dc1394cbb81b162633c379be5', '443000', null, '市辖区', '01', '市辖区', '420501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0a250abdf4374d4784279015e22c3dc6', 'e3d5484dc1394cbb81b162633c379be5', '443000', null, '西陵区', '02', '西陵区', '420502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('80943748861442efb9cb0a64652d7560', 'e3d5484dc1394cbb81b162633c379be5', '443000', null, '伍家岗区', '03', '伍家岗区', '420503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d4ca08ceab214659bbde44dd14afe640', 'e3d5484dc1394cbb81b162633c379be5', '443000', null, '点军区', '04', '点军区', '420504', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('58ddcecad76c4507b4dcb2bb4bd0f362', 'e3d5484dc1394cbb81b162633c379be5', '443000', null, '猇亭区', '05', '猇亭区', '420505', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c08bf63ef844f90b31adc5ef13c82e2', 'e3d5484dc1394cbb81b162633c379be5', '443100', null, '夷陵区', '06', '夷陵区', '420506', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6054583d4be64c1d88f248dbe51ab0a7', 'e3d5484dc1394cbb81b162633c379be5', '444200', null, '远安县', '25', '远安县', '420525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('88b116b127fe4507b576a23770a264b2', 'e3d5484dc1394cbb81b162633c379be5', '443700', null, '兴山县', '26', '兴山县', '420526', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d6e7162de8b64630a770e1669d900a02', 'e3d5484dc1394cbb81b162633c379be5', '443600', null, '秭归县', '27', '秭归县', '420527', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f424360a599e498fbb0f4dbb648c95ba', 'e3d5484dc1394cbb81b162633c379be5', '443500', null, '长阳土家族自治县', '28', '长阳土家族自治县', '420528', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('696012069a124c7387f1b380a5321c78', 'e3d5484dc1394cbb81b162633c379be5', '443400', null, '五峰土家族自治县', '29', '五峰土家族自治县', '420529', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('12fccd2d67d8472188eb7ca3fa93c612', 'e3d5484dc1394cbb81b162633c379be5', '443000', null, '宜都市', '81', '宜都市', '420581', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('232824df575e4a249c26bb79210de207', 'e3d5484dc1394cbb81b162633c379be5', '444100', null, '当阳市', '82', '当阳市', '420582', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('441311e624954bc08af3bb5363a133be', 'e3d5484dc1394cbb81b162633c379be5', '443200', null, '枝江市', '83', '枝江市', '420583', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4034b10bbc144321be20c24f40473283', 'cd4e23e0d23048a3837e85d24ad2783a', '441000', null, '市辖区', '01', '市辖区', '420601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c3f63adc09ee4ff49f598f4e84983d3a', 'cd4e23e0d23048a3837e85d24ad2783a', '441000', null, '襄城区', '02', '襄城区', '420602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f0ef3716f28041a897d65b565f83ddcb', 'cd4e23e0d23048a3837e85d24ad2783a', '441000', null, '樊城区', '06', '樊城区', '420606', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4e7dcf1fe2f146bcb76caf9f05cb4252', 'cd4e23e0d23048a3837e85d24ad2783a', '441100', null, '襄阳区', '07', '襄阳区', '420607', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('39e1decacb1c4d9592e11e7f1ea35ac9', 'cd4e23e0d23048a3837e85d24ad2783a', '441500', null, '南漳县', '24', '南漳县', '420624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c3057d3bb40454db986ef56189e9265', 'cd4e23e0d23048a3837e85d24ad2783a', '441700', null, '谷城县', '25', '谷城县', '420625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1505ba79216d4caf9162750301a4a5cc', 'cd4e23e0d23048a3837e85d24ad2783a', '441600', null, '保康县', '26', '保康县', '420626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('57034e64786445fdb001ec802a97c6d5', 'cd4e23e0d23048a3837e85d24ad2783a', '441800', null, '老河口市', '82', '老河口市', '420682', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d79dbe03d114b858ed103062a23fd1c', 'cd4e23e0d23048a3837e85d24ad2783a', '441200', null, '枣阳市', '83', '枣阳市', '420683', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('93d0d671e85c40faa5f87bc903f17fd9', 'cd4e23e0d23048a3837e85d24ad2783a', '441400', null, '宜城市', '84', '宜城市', '420684', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a09eb1235a5e4c8b99379a0ad1a4b4b5', '41054de8248f40979f122baf019dda58', '436000', null, '市辖区', '01', '市辖区', '420701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c676e06d41574cf799f63377452de68e', '41054de8248f40979f122baf019dda58', '436000', null, '梁子湖区', '02', '梁子湖区', '420702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('de46b22a5ff44c0e964519350615bb7d', '41054de8248f40979f122baf019dda58', '436000', null, '华容区', '03', '华容区', '420703', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1ba657cc6c5040a9a3e87412bf08a13a', '41054de8248f40979f122baf019dda58', '436000', null, '鄂城区', '04', '鄂城区', '420704', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b782ba32c0d449c883c47f2efe1ffa28', '3ed095ba7eea4793a022a5b3b2e21ce6', '448000', null, '市辖区', '01', '市辖区', '420801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b8ef68a808124428821e320323392921', '3ed095ba7eea4793a022a5b3b2e21ce6', '448000', null, '东宝区', '02', '东宝区', '420802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('86e646068e24416680e01ef75e727a61', '3ed095ba7eea4793a022a5b3b2e21ce6', '448000', null, '掇刀区', '04', '掇刀区', '420804', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('26279cf67cc541b99d395d09e8f54e7f', '3ed095ba7eea4793a022a5b3b2e21ce6', '431800', null, '京山县', '21', '京山县', '420821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8c8cc377eda14b638b73f31368295ddd', '3ed095ba7eea4793a022a5b3b2e21ce6', '448200', null, '沙洋县', '22', '沙洋县', '420822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('45a1d06faa9a4461860feb2e2b55e4c1', '3ed095ba7eea4793a022a5b3b2e21ce6', '431900', null, '钟祥市', '81', '钟祥市', '420881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ed691dbd86c84c7e988f4fcfb9ad6600', 'a9623076ba7f459882a4de744213da9f', '432000', null, '市辖区', '01', '市辖区', '420901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7cc717ffc7584949ae4e2530ad938288', 'a9623076ba7f459882a4de744213da9f', '432100', null, '孝南区', '02', '孝南区', '420902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8ca606779a79487cb3deca027c1ded84', 'a9623076ba7f459882a4de744213da9f', '432900', null, '孝昌县', '21', '孝昌县', '420921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4bad278fff4947a9994302cdac630fd3', 'a9623076ba7f459882a4de744213da9f', '432800', null, '大悟县', '22', '大悟县', '420922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9471c6e9ba5642f7a8305ad2e7f8ed09', 'a9623076ba7f459882a4de744213da9f', '432500', null, '云梦县', '23', '云梦县', '420923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('93211676c1fe4aa99a05d71c59af00df', 'a9623076ba7f459882a4de744213da9f', '432400', null, '应城市', '81', '应城市', '420981', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cdf515b2124f4598aa29a047bec03c54', 'a9623076ba7f459882a4de744213da9f', '432600', null, '安陆市', '82', '安陆市', '420982', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b0ef981d34944d83a7c62e4603dcbe0f', 'a9623076ba7f459882a4de744213da9f', '432300', null, '汉川市', '84', '汉川市', '420984', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bfb00644959a4f1a9f922b5f3da2f3b3', '4a6dbf97ae1346a1ae058aada593c83b', '434000', null, '市辖区', '01', '市辖区', '421001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c699fa41b14442be83760e8cf964e7be', '4a6dbf97ae1346a1ae058aada593c83b', '434000', null, '沙市区', '02', '沙市区', '421002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('88b98cc961ac4dd1bcac24039a1b419a', '4a6dbf97ae1346a1ae058aada593c83b', '434020', null, '荆州区', '03', '荆州区', '421003', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aa2437df156f484a8cae0b5aef92bf87', '4a6dbf97ae1346a1ae058aada593c83b', '434300', null, '公安县', '22', '公安县', '421022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8c8a32642b894b539b91a42438eb71a8', '4a6dbf97ae1346a1ae058aada593c83b', '433300', null, '监利县', '23', '监利县', '421023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b0834353e411404d9458d56942ce9371', '4a6dbf97ae1346a1ae058aada593c83b', '434100', null, '江陵县', '24', '江陵县', '421024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8570cc39278f40d58df3fc24ebf067d5', '4a6dbf97ae1346a1ae058aada593c83b', '434400', null, '石首市', '81', '石首市', '421081', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b1ba2c3e8c5a4ad38b64d4174442771d', '3a8faee14d6a473493ddf5b00fe9eab7', '545400', null, '融安县', '24', '融安县', '450224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a61fe11060a44816bd0e99e2ed20337f', '3a8faee14d6a473493ddf5b00fe9eab7', '545300', null, '融水苗族自治县', '25', '融水苗族自治县', '450225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bd5273463bf948e987b6b5e802705175', '3a8faee14d6a473493ddf5b00fe9eab7', '545500', null, '三江侗族自治县', '26', '三江侗族自治县', '450226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5ea84de435f84297874ca3d9703ba970', '87571143e8fd43b8b3aff17c93e3041b', '541000', null, '市辖区', '01', '市辖区', '450301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7296550dcb804d4b93d09717c1a32840', '87571143e8fd43b8b3aff17c93e3041b', '541000', null, '秀峰区', '02', '秀峰区', '450302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6a840bad134243e6970145b97d348d53', '87571143e8fd43b8b3aff17c93e3041b', '541000', null, '叠彩区', '03', '叠彩区', '450303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7ce384c9fb364e19b61fea8148527712', '87571143e8fd43b8b3aff17c93e3041b', '541000', null, '象山区', '04', '象山区', '450304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('504cb53235f6435087f182ef852af4f1', '87571143e8fd43b8b3aff17c93e3041b', '541000', null, '七星区', '05', '七星区', '450305', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c292bde822a6400dbdc06c9ca5917884', '87571143e8fd43b8b3aff17c93e3041b', '541000', null, '雁山区', '11', '雁山区', '450311', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fa741794a29e46aabf9a3cea04060916', '87571143e8fd43b8b3aff17c93e3041b', '541900', null, '阳朔县', '21', '阳朔县', '450321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('be7b210c69074810bb1dcf072f43e7c3', '87571143e8fd43b8b3aff17c93e3041b', '541100', null, '临桂县', '22', '临桂县', '450322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('675fcf5e6a4d42b5868b08d492bb7ded', '87571143e8fd43b8b3aff17c93e3041b', '541200', null, '灵川县', '23', '灵川县', '450323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('07bcb34d79aa4bf79f6c821cec93c70f', '87571143e8fd43b8b3aff17c93e3041b', '541500', null, '全州县', '24', '全州县', '450324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aef9f025b89b42d6855d987c3e2dc9e1', '87571143e8fd43b8b3aff17c93e3041b', '541300', null, '兴安县', '25', '兴安县', '450325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2d6b9eb76a6a4c0d8030eb4aef9f9058', '87571143e8fd43b8b3aff17c93e3041b', '541800', null, '永福县', '26', '永福县', '450326', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('30f5649b16b6468cac95a01a1715336c', '87571143e8fd43b8b3aff17c93e3041b', '541600', null, '灌阳县', '27', '灌阳县', '450327', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('83a8b527f7e943639512a48028bef2f0', '87571143e8fd43b8b3aff17c93e3041b', '541700', null, '龙胜各族自治县', '28', '龙胜各族自治县', '450328', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fb434f0be438495eb3469d8135309fc2', '87571143e8fd43b8b3aff17c93e3041b', '541400', null, '资源县', '29', '资源县', '450329', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5796565c480c4c02b0022b9cb377bd0d', '87571143e8fd43b8b3aff17c93e3041b', '542400', null, '平乐县', '30', '平乐县', '450330', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f10e8a313cb04f0fb53731132f9c63ad', '87571143e8fd43b8b3aff17c93e3041b', '546600', null, '荔蒲县', '31', '荔蒲县', '450331', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ddb47fc20e114f70be5562f164c0e872', '87571143e8fd43b8b3aff17c93e3041b', '542500', null, '恭城瑶族自治县', '32', '恭城瑶族自治县', '450332', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('91cad00c346a426ca09a565f976cdc19', 'a9dc7c04401b43fc92297dfe7d331f81', '543000', null, '市辖区', '01', '市辖区', '450401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e8192aee54f0473c8963cab48db5dda8', 'a9dc7c04401b43fc92297dfe7d331f81', '543000', null, '万秀区', '03', '万秀区', '450403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0be842c30cfc492a8190f360a7da70a7', 'a9dc7c04401b43fc92297dfe7d331f81', '543000', null, '蝶山区', '04', '蝶山区', '450404', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e6affc3e69fe4aa59d538255130efcdc', 'a9dc7c04401b43fc92297dfe7d331f81', '543000', null, '长洲区', '05', '长洲区', '450405', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5a41c23e399e4e2b809871c4b40edff5', 'a9dc7c04401b43fc92297dfe7d331f81', '543100', null, '苍梧县', '21', '苍梧县', '450421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('99ec6de1383a45e0abcb60c0cd4c3183', 'a9dc7c04401b43fc92297dfe7d331f81', '543300', null, '藤县', '22', '藤县', '450422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1fbc4b6e2a2f4821aab19be42c8c68fe', 'a9dc7c04401b43fc92297dfe7d331f81', '546700', null, '蒙山县', '23', '蒙山县', '450423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4d0d1874a81e430c947830f8f243b64b', 'a9dc7c04401b43fc92297dfe7d331f81', '543200', null, '岑溪市', '81', '岑溪市', '450481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f58dcfd5568c4dce9bc0b2d224715f71', '1f022fdf2fe84a96acc2b187e208d31b', '536000', null, '市辖区', '01', '市辖区', '450501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('56a21223c0e1498cbd62fb22c08b2854', '1f022fdf2fe84a96acc2b187e208d31b', '536000', null, '海城区', '02', '海城区', '450502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9b8f9c49f4494813994319ed8eda8f34', '1f022fdf2fe84a96acc2b187e208d31b', '536000', null, '银海区', '03', '银海区', '450503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3bf384340b9f48fb8940afbe03377252', '1f022fdf2fe84a96acc2b187e208d31b', '536000', null, '铁山港区', '12', '铁山港区', '450512', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6833789bb6f54090b996be58e2affb33', '1f022fdf2fe84a96acc2b187e208d31b', '536100', null, '合浦县', '21', '合浦县', '450521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('17a8e7214901467d8b91e4886f5dadc1', '3ea02e362c824c1680a222ff06d7611b', '538000', null, '市辖区', '01', '市辖区', '450601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0536fa1223494e80ba561e53423e3298', '3ea02e362c824c1680a222ff06d7611b', '538000', null, '港口区', '02', '港口区', '450602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a5101c90734142068b9b2dbd43370e76', '3ea02e362c824c1680a222ff06d7611b', '538000', null, '防城区', '03', '防城区', '450603', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e315b31c74c544678a6fa1de06256ec0', '3ea02e362c824c1680a222ff06d7611b', '535500', null, '上思县', '21', '上思县', '450621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8c224cc85bcc40238239a7100c027262', '3ea02e362c824c1680a222ff06d7611b', '538100', null, '东兴市', '81', '东兴市', '450681', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0676af19d5fd4c14971f706e3f968ed9', '330e2c8f1a1441dd8bee96e040e1ef7f', '535000', null, '市辖区', '01', '市辖区', '450701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5b544d0cf00046c8a8449dca2b1caa09', '330e2c8f1a1441dd8bee96e040e1ef7f', '535000', null, '钦南区', '02', '钦南区', '450702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b4d47e1734934050b176564454c29e3a', '330e2c8f1a1441dd8bee96e040e1ef7f', '535000', null, '钦北区', '03', '钦北区', '450703', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3012f48050a547a0a1578e7ee907ff0a', '330e2c8f1a1441dd8bee96e040e1ef7f', '535400', null, '灵山县', '21', '灵山县', '450721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ef8afeb65ffe4475b67cc707a8cba560', '330e2c8f1a1441dd8bee96e040e1ef7f', '535300', null, '浦北县', '22', '浦北县', '450722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('215a0642abb94cbcbb8f8dc77e5dffe9', 'c4e897a6a2174240baf29d7bfad235ba', '537100', null, '市辖区', '01', '市辖区', '450801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3e33af56a28d4293932640e72c4a2f70', 'c4e897a6a2174240baf29d7bfad235ba', '537100', null, '港北区', '02', '港北区', '450802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f92f6f004ce04ce599797c811570062c', 'c4e897a6a2174240baf29d7bfad235ba', '537100', null, '港南区', '03', '港南区', '450803', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('29ad3ab039f948cabfec4442d72180b2', 'c4e897a6a2174240baf29d7bfad235ba', '537100', null, '覃塘区', '04', '覃塘区', '450804', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('21d9228004554cb6a5f9ebcfcd1ad60a', 'c4e897a6a2174240baf29d7bfad235ba', '537300', null, '平南县', '21', '平南县', '450821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('638cf07bf981416c871811d9a5624de0', 'c4e897a6a2174240baf29d7bfad235ba', '537200', null, '桂平市', '81', '桂平市', '450881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f9d858743d1047078ba466c2f356030e', 'e420d3d39d12490ab67e5091b54bcdab', '537000', null, '市辖区', '01', '市辖区', '450901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('86c1ef8896ef4ecc995f5f39d707dc53', 'e420d3d39d12490ab67e5091b54bcdab', '537000', null, '玉州区', '02', '玉州区', '450902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('295fef733ed545ef8b9bfbdd5b8939ff', 'e420d3d39d12490ab67e5091b54bcdab', '537500', null, '容县', '21', '容县', '450921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bc42aa1f876a4623a4281c7bc74fc638', 'e420d3d39d12490ab67e5091b54bcdab', '537700', null, '陆川县', '22', '陆川县', '450922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3cfc24db3af546e2b907fa63253ab16d', 'e420d3d39d12490ab67e5091b54bcdab', '537600', null, '博白县', '23', '博白县', '450923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('53c85c442791464c81d9b7b81895fa6d', 'e420d3d39d12490ab67e5091b54bcdab', '537800', null, '兴业县', '24', '兴业县', '450924', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb023a6490f547b59ba625208a0c9223', 'e420d3d39d12490ab67e5091b54bcdab', '537400', null, '北流市', '81', '北流市', '450981', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('22b9465e33d54ed5a5991eb6955d75b5', '5944b21cd62d4404bab999965db12d4a', '533000', null, '市辖区', '01', '市辖区', '451001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('120caccbb0534c4ba1db08c3dd737451', '1d21c167dbe048d7942a636ec4ce172c', '472500', null, '灵宝市', '82', '灵宝市', '411282', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cd8ad955f7354fd695d6f445ec49ed9e', 'e16c41e4d0b5480786a44c95e8fc7a5c', '473000', null, '市辖区', '01', '市辖区', '411301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5199156c5af14cecb4ef9b4e8c6d7b8b', 'e16c41e4d0b5480786a44c95e8fc7a5c', '473000', null, '宛城区', '02', '宛城区', '411302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('089613aed97146d7b60fa6a50ddec409', 'e16c41e4d0b5480786a44c95e8fc7a5c', '473000', null, '卧龙区', '03', '卧龙区', '411303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e9f649e07db74fbe8791974439c74a45', 'fd915aadafda49b68d1cf622418a9f82', '425000', null, '芝山区', '02', '芝山区', '431102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('26a341e22eab46a4b9d4df018245332a', 'fd915aadafda49b68d1cf622418a9f82', '425000', null, '冷水滩区', '03', '冷水滩区', '431103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c39b8dcbc27b45b2bbef219e10b44409', 'fd915aadafda49b68d1cf622418a9f82', '421700', null, '祁阳县', '21', '祁阳县', '431121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2e50732c0f2f42cebf197de378c84750', 'fd915aadafda49b68d1cf622418a9f82', '425900', null, '东安县', '22', '东安县', '431122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9c3b32b9f0de4eb6ac1ffc8142c04aba', 'fd915aadafda49b68d1cf622418a9f82', '425200', null, '双牌县', '23', '双牌县', '431123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('91d91d9cffb2490187eeb56535a0068f', 'fd915aadafda49b68d1cf622418a9f82', '425300', null, '道县', '24', '道县', '431124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('39b66d6301ad4de591bee5c5081cd2c3', 'fd915aadafda49b68d1cf622418a9f82', '425400', null, '江永县', '25', '江永县', '431125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('afdc325e04e4497c9706d7c355d927d8', 'fd915aadafda49b68d1cf622418a9f82', '425600', null, '宁远县', '26', '宁远县', '431126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('78ca9c5ed22f470a9d69727351d5838d', 'fd915aadafda49b68d1cf622418a9f82', '425800', null, '蓝山县', '27', '蓝山县', '431127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8442e4e9651a4876b1341eebf643c3bc', 'fd915aadafda49b68d1cf622418a9f82', '425700', null, '新田县', '28', '新田县', '431128', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7b6746212df64601b1190306350a7d23', 'fd915aadafda49b68d1cf622418a9f82', '425500', null, '江华瑶族自治县', '29', '江华瑶族自治县', '431129', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c1e758b4897444adb3241cea5d9bc710', '7b81bf0743fd447ebdf08758d3308330', '418000', null, '市辖区', '01', '市辖区', '431201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('442f1db5243248f7868be3e55de11ff7', '7b81bf0743fd447ebdf08758d3308330', '418000', null, '鹤城区', '02', '鹤城区', '431202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b5f5b0528f424d04b0d34ee3c7941d96', '7b81bf0743fd447ebdf08758d3308330', '418000', null, '中方县', '21', '中方县', '431221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aaa4328ffae04c6a8f9f8dbd2f710553', '7b81bf0743fd447ebdf08758d3308330', '419600', null, '沅陵县', '22', '沅陵县', '431222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f03d2cce1bb42c2ae2c082c4430b5ee', '7b81bf0743fd447ebdf08758d3308330', '419500', null, '辰溪县', '23', '辰溪县', '431223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ecd633af46114223a267fc1309e46d6f', '7b81bf0743fd447ebdf08758d3308330', '419300', null, '溆浦县', '24', '溆浦县', '431224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('40932c4b796a4a619f3ac29e09d798b4', '7b81bf0743fd447ebdf08758d3308330', '418300', null, '会同县', '25', '会同县', '431225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('df77802a27ab4a1286cb72b98d8a90de', '7b81bf0743fd447ebdf08758d3308330', '419400', null, '麻阳苗族自治县', '26', '麻阳苗族自治县', '431226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4460b4eaa8d241579173fb6bb5d0a47c', '7b81bf0743fd447ebdf08758d3308330', '419200', null, '新晃侗族自治县', '27', '新晃侗族自治县', '431227', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ff3d4cae484c4b53a291b4220791daab', '7b81bf0743fd447ebdf08758d3308330', '419100', null, '芷江侗族自治县', '28', '芷江侗族自治县', '431228', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1974478b11194872905dbe1001c2eecc', '7b81bf0743fd447ebdf08758d3308330', '418400', null, '靖州苗族侗族自治县', '29', '靖州苗族侗族自治县', '431229', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b25b2a65984344f29751500224c18b5c', '7b81bf0743fd447ebdf08758d3308330', '418500', null, '通道侗族自治县', '30', '通道侗族自治县', '431230', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b121f444debd49d5b3fcbce085109531', '7b81bf0743fd447ebdf08758d3308330', '418200', null, '洪江市', '81', '洪江市', '431281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cb4a166d54e64771b70ec519417b04a7', 'adcc2c768e274f2d89f802ea109c3235', '417000', null, '市辖区', '01', '市辖区', '431301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ada0eeee014945debaa690c3e1d20f3f', 'adcc2c768e274f2d89f802ea109c3235', '417000', null, '娄星区', '02', '娄星区', '431302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0b25320d0f734eeb9702adaa2c3966c5', 'adcc2c768e274f2d89f802ea109c3235', '417700', null, '双峰县', '21', '双峰县', '431321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6f80873cffb542679c09a7950bdb4cfb', 'adcc2c768e274f2d89f802ea109c3235', '417600', null, '新化县', '22', '新化县', '431322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f54d9722637a4257a02f6227ed7d491a', 'adcc2c768e274f2d89f802ea109c3235', '417500', null, '冷水江市', '81', '冷水江市', '431381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0d8c46b4c0fd48a597917bfb8facda43', 'adcc2c768e274f2d89f802ea109c3235', '417100', null, '涟源市', '82', '涟源市', '431382', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e4ee18c1e27246be8c1202702ef2ec67', '0f23a4dca3524daabdae8f9e25604b96', '416000', null, '吉首市', '01', '吉首市', '433101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ed515fbb74e14c38b751269b390af973', '0f23a4dca3524daabdae8f9e25604b96', '416100', null, '泸溪县', '22', '泸溪县', '433122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('184c83e184974de1b5afe7b4936ab7cf', '0f23a4dca3524daabdae8f9e25604b96', '416200', null, '凤凰县', '23', '凤凰县', '433123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6196a58a3b9b4c4a9f2ea562561df633', '0f23a4dca3524daabdae8f9e25604b96', '416400', null, '花垣县', '24', '花垣县', '433124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('23e21a8b5e5840faaec710190a3643ef', '0f23a4dca3524daabdae8f9e25604b96', '416500', null, '保靖县', '25', '保靖县', '433125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a746c136422f41e492ab3da3cbee5176', '0f23a4dca3524daabdae8f9e25604b96', '416300', null, '古丈县', '26', '古丈县', '433126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ea9b134444404b61a83a9abb4bcf0a19', '0f23a4dca3524daabdae8f9e25604b96', '416700', null, '永顺县', '27', '永顺县', '433127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e08cc20b57bd4dbebfc4b2eba9438c38', '0f23a4dca3524daabdae8f9e25604b96', '416800', null, '龙山县', '30', '龙山县', '433130', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8c85be79596f443b8ecfafc10ac33e9b', '74c34515a15e469e92d05c95aaca78ab', '510000', null, '市辖区', '01', '市辖区', '440101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('15bdb3e9fa5c4a4b8f952c123c078972', '74c34515a15e469e92d05c95aaca78ab', '510000', null, '东山区', '02', '东山区', '440102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8b7d916b1f31431c8c8ef404a340d0fd', '74c34515a15e469e92d05c95aaca78ab', '510000', null, '荔湾区', '03', '荔湾区', '440103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('91f3498b9509454d82462f774e66e6eb', '74c34515a15e469e92d05c95aaca78ab', '510000', null, '越秀区', '04', '越秀区', '440104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d46ce16798b40d68f453993ef113f7a', '74c34515a15e469e92d05c95aaca78ab', '510000', null, '海珠区', '05', '海珠区', '440105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5e57ffb5a4b54ac6912efa45c9505fd6', '74c34515a15e469e92d05c95aaca78ab', '510000', null, '天河区', '06', '天河区', '440106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1ee604a06cdf428ab838469d0769a035', '74c34515a15e469e92d05c95aaca78ab', '510000', null, '芳村区', '07', '芳村区', '440107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3d0c51fee8e448a9e838ce34008919a', '74c34515a15e469e92d05c95aaca78ab', '510000', null, '白云区', '11', '白云区', '440111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6e06110b62774d9da87b4ed9722147a1', '74c34515a15e469e92d05c95aaca78ab', '510700', null, '黄埔区', '12', '黄埔区', '440112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f0e69246acac43519a85443ddbc72210', '74c34515a15e469e92d05c95aaca78ab', '511400', null, '番禺区', '13', '番禺区', '440113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e0e54e1b2414fc6b929867f8228b0d0', '74c34515a15e469e92d05c95aaca78ab', '510800', null, '花都区', '14', '花都区', '440114', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('068830fbb6f64c7dadc8778b72ccd1c2', '74c34515a15e469e92d05c95aaca78ab', '511300', null, '增城市', '83', '增城市', '440183', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9f247dedde274fbbb74100af13173d89', '74c34515a15e469e92d05c95aaca78ab', '510900', null, '从化市', '84', '从化市', '440184', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ca6feb417a3a46af928965fa606e3b8e', 'a7a5db86046e4359b593d5bb51806516', '512000', null, '市辖区', '01', '市辖区', '440201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0cb7e9715d6f48d4bcc91a598f0aa6ee', 'a7a5db86046e4359b593d5bb51806516', '512000', null, '武江区', '03', '武江区', '440203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('97cb64468eff415bb0163483f511b874', 'a7a5db86046e4359b593d5bb51806516', '512000', null, '浈江区', '04', '浈江区', '440204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('124e2f41ba2647bb9c77122d92274676', 'a7a5db86046e4359b593d5bb51806516', '512100', null, '曲江区', '05', '曲江区', '440205', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9b242e90f11141099f7051c3a4ae3e0e', 'a7a5db86046e4359b593d5bb51806516', '512500', null, '始兴县', '22', '始兴县', '440222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e1870f7b881a45c385b7d4a9643f1bf1', 'a7a5db86046e4359b593d5bb51806516', '512300', null, '仁化县', '24', '仁化县', '440224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7bd10b36fd5a43cba0a1162683c6bc46', 'a7a5db86046e4359b593d5bb51806516', '512600', null, '翁源县', '29', '翁源县', '440229', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0b1d396f757642d5aa1668f7a84d5256', '3f166d4baf12434eb102caddab35da47', '736300', null, '肃北蒙古族自治县', '23', '肃北蒙古族自治县', '620923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e9987bc667664807beb65c858de9d353', 'a7a5db86046e4359b593d5bb51806516', '511100', null, '新丰县', '33', '新丰县', '440233', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2a139cf30ef04307899e2bc32427f68a', '405b1da4465e49088c798360db70c15b', '623100', null, '理县', '22', '理县', '513222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8f94c76092de4dfaafb12255b6cb8657', '405b1da4465e49088c798360db70c15b', '623200', null, '茂县', '23', '茂县', '513223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3374b765c4a64f8480b2350d48b3d9d0', '405b1da4465e49088c798360db70c15b', '623300', null, '松潘县', '24', '松潘县', '513224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b120914bcdda41d6862da362f74c17a2', '405b1da4465e49088c798360db70c15b', '623400', null, '九寨沟县', '25', '九寨沟县', '513225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eba3f286110b4058b653df8eacb248ff', '6a4a9d34b6904464805411c3d91a1313', '518000', null, '福田区', '04', '福田区', '440304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f3552a876de48679e585293a00c6f93', '5944b21cd62d4404bab999965db12d4a', '533000', null, '右江区', '02', '右江区', '451002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('91f93a14f745494f841a5f713de1a9e4', '5944b21cd62d4404bab999965db12d4a', '533600', null, '田阳县', '21', '田阳县', '451021', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('87e3a5d99365402dab271b3663767b70', '5944b21cd62d4404bab999965db12d4a', '531500', null, '田东县', '22', '田东县', '451022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('50b580c0deef40e791a2bb3fe87f64ab', '5944b21cd62d4404bab999965db12d4a', '531400', null, '平果县', '23', '平果县', '451023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('16c8c98af8ce4af78ed432e85b1b74c6', '5944b21cd62d4404bab999965db12d4a', '533700', null, '德保县', '24', '德保县', '451024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('68460e63b2984d4482d60ac1511d0ad1', '5944b21cd62d4404bab999965db12d4a', '533800', null, '靖西县', '25', '靖西县', '451025', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6043f3b59be540ed944c84ac11447deb', '5944b21cd62d4404bab999965db12d4a', '533900', null, '那坡县', '26', '那坡县', '451026', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('45a0b886480d416180817a38b8e14514', 'e16c41e4d0b5480786a44c95e8fc7a5c', '474650', null, '南召县', '21', '南召县', '411321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('23da20fc8a3a40b3b2a916724f41ac86', '405b1da4465e49088c798360db70c15b', '624200', null, '小金县', '27', '小金县', '513227', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2fe7b44639204031a4cee141c625c189', '6a4a9d34b6904464805411c3d91a1313', '518000', null, '南山区', '05', '南山区', '440305', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('17b5e47c93a74400a555dfb980136447', '6a4a9d34b6904464805411c3d91a1313', '518100', null, '宝安区', '06', '宝安区', '440306', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7ede6ba37aa7428da57dcd32797b0e98', '6a4a9d34b6904464805411c3d91a1313', '518100', null, '龙岗区', '07', '龙岗区', '440307', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('970a70c2838a41f09625922fd05a2e87', '6a4a9d34b6904464805411c3d91a1313', '518000', null, '盐田区', '08', '盐田区', '440308', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ee51983b2981421e90a280fc383b13c8', 'fc52a64b6b3748229bd8f9afab749793', '519000', null, '市辖区', '01', '市辖区', '440401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('25f72693580a40139a3af639b58842d1', 'fc52a64b6b3748229bd8f9afab749793', '519000', null, '香洲区', '02', '香洲区', '440402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ff1e4101f79c497ab2f156e5ca1ad258', 'fc52a64b6b3748229bd8f9afab749793', '519100', null, '斗门区', '03', '斗门区', '440403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('902e00401aab478984ed8ff1f9873c0e', 'fc52a64b6b3748229bd8f9afab749793', '519090', null, '金湾区', '04', '金湾区', '440404', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('479802e5c6ee41dd85fd3d2fd68fc048', '5fe5cbee4e394883b75404f0b700c38f', '515000', null, '市辖区', '01', '市辖区', '440501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('422a68dc9e7645fc923b8fa7a3fd54b8', '5fe5cbee4e394883b75404f0b700c38f', '515000', null, '龙湖区', '07', '龙湖区', '440507', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0493300120584d1ba9c86f1e5bd88dbc', '5fe5cbee4e394883b75404f0b700c38f', '515000', null, '金平区', '11', '金平区', '440511', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('308c6a6603c54c108bab37987d6923ed', '5fe5cbee4e394883b75404f0b700c38f', '515000', null, '濠江区', '12', '濠江区', '440512', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('049ab5ab620641a096de62f2a59ba41e', '5fe5cbee4e394883b75404f0b700c38f', '515100', null, '潮阳区', '13', '潮阳区', '440513', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('143b5d01ced94ead9119703027ccdf9e', '5fe5cbee4e394883b75404f0b700c38f', '515100', null, '潮南区', '14', '潮南区', '440514', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('270460c56c554f99ba15a10b3fcf11e4', '5fe5cbee4e394883b75404f0b700c38f', '515800', null, '澄海区', '15', '澄海区', '440515', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6dee25bb1ddc4026ba7edb8ece761adf', '5fe5cbee4e394883b75404f0b700c38f', '515900', null, '南澳县', '23', '南澳县', '440523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('055a75197de9416fafc04451cf6851a7', 'a12ecc146129443e9fd9fa29cdf3f4ec', '528000', null, '市辖区', '01', '市辖区', '440601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6640e7f6896b41e897cd640ada6202ba', 'a12ecc146129443e9fd9fa29cdf3f4ec', '528000', null, '禅城区', '04', '禅城区', '440604', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ef739aaf6a9f48b4b0e634cd09945b68', 'a12ecc146129443e9fd9fa29cdf3f4ec', '528200', null, '南海区', '05', '南海区', '440605', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2d2529866d184c6f9a3dd08bfe153732', 'a12ecc146129443e9fd9fa29cdf3f4ec', '528000', null, '顺德区', '06', '顺德区', '440606', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('addc9604334446b993d58448d527c1cb', 'a12ecc146129443e9fd9fa29cdf3f4ec', '528100', null, '三水区', '07', '三水区', '440607', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0a2b0cba86534ffebfcefc1bdb04f2ed', 'a12ecc146129443e9fd9fa29cdf3f4ec', '528500', null, '高明区', '08', '高明区', '440608', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5bb917dc45c842e88eff184385051f28', 'aa148f66edba4d79a319608c3110200c', '529000', null, '市辖区', '01', '市辖区', '440701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a53e049b97a8414e8e9e0f8902376188', 'aa148f66edba4d79a319608c3110200c', '529000', null, '蓬江区', '03', '蓬江区', '440703', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c4964403b60b482fa362c9ffbe605353', 'aa148f66edba4d79a319608c3110200c', '529000', null, '江海区', '04', '江海区', '440704', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3a1f254f99b04c378a955446e87fee8d', 'aa148f66edba4d79a319608c3110200c', '529100', null, '新会区', '05', '新会区', '440705', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f01d9001825646cdb73f34c322bfc93c', 'aa148f66edba4d79a319608c3110200c', '529200', null, '台山市', '81', '台山市', '440781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d130f0fdfd4245dab05d91d4c20356ce', 'aa148f66edba4d79a319608c3110200c', '529300', null, '开平市', '83', '开平市', '440783', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bc680a2987bd42afa8511726f5c5829d', 'aa148f66edba4d79a319608c3110200c', '529700', null, '鹤山市', '84', '鹤山市', '440784', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2bcfe26bf5f54a8aad0722726b6086dd', 'aa148f66edba4d79a319608c3110200c', '529400', null, '恩平市', '85', '恩平市', '440785', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7df4f22e623642a6a1afa908d866daab', '3a654d6fa00b41afbd9e9eaa5d123224', '524000', null, '市辖区', '01', '市辖区', '440801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dc508881cdee40d2a8525a3547d91ed7', '3a654d6fa00b41afbd9e9eaa5d123224', '524000', null, '赤坎区', '02', '赤坎区', '440802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('436116350dea476cb69862da668607ba', '3a654d6fa00b41afbd9e9eaa5d123224', '524000', null, '霞山区', '03', '霞山区', '440803', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eebc9fd889de48f59c21808d280a899c', '3a654d6fa00b41afbd9e9eaa5d123224', '524000', null, '坡头区', '04', '坡头区', '440804', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5139f398f307426cafccd4ba99ba6f8f', '3a654d6fa00b41afbd9e9eaa5d123224', '524000', null, '麻章区', '11', '麻章区', '440811', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eaa45447bbbd47eabb21a2cbd9f06c95', '3a654d6fa00b41afbd9e9eaa5d123224', '524300', null, '遂溪县', '23', '遂溪县', '440823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d8ef20442436456ca678d9ef813a1105', '3a654d6fa00b41afbd9e9eaa5d123224', '524100', null, '徐闻县', '25', '徐闻县', '440825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e698c6d798d46ee8bf1399363dce837', '3a654d6fa00b41afbd9e9eaa5d123224', '524400', null, '廉江市', '81', '廉江市', '440881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e916cba9640641b9babe5db615be1a8f', '3a654d6fa00b41afbd9e9eaa5d123224', '524200', null, '雷州市', '82', '雷州市', '440882', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('06aea979192649fe84426f225fb1b4fa', '3a654d6fa00b41afbd9e9eaa5d123224', '524500', null, '吴川市', '83', '吴川市', '440883', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0bd3fd3d005b434798eb4a3faecbd8db', 'af7ede8649de428e81c513d1ba57420d', '525000', null, '市辖区', '01', '市辖区', '440901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('152fa8aab8f54ce5a7c2fdac94c50770', 'af7ede8649de428e81c513d1ba57420d', '525000', null, '茂南区', '02', '茂南区', '440902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f78424fadcfb439780b9ee62edd3d989', 'af7ede8649de428e81c513d1ba57420d', '525000', null, '茂港区', '03', '茂港区', '440903', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d1b455ad34064abb86c72e10acaff57b', 'af7ede8649de428e81c513d1ba57420d', '525400', null, '电白县', '23', '电白县', '440923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('269933afe4ec43abac6fa277ec99f070', 'af7ede8649de428e81c513d1ba57420d', '525200', null, '高州市', '81', '高州市', '440981', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ccd44361c1bc44deac4a4005e8aadf0f', 'af7ede8649de428e81c513d1ba57420d', '525100', null, '化州市', '82', '化州市', '440982', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('75c874bd1e224f25bf868fcf21a94bc6', 'af7ede8649de428e81c513d1ba57420d', '525300', null, '信宜市', '83', '信宜市', '440983', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6392abc3b52d4039a97a2416daef7896', '6fed53cde91a4336b0b2023c9c7da06b', '526000', null, '市辖区', '01', '市辖区', '441201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ef5afa14740f40eb893fdc7bcc16c714', '6fed53cde91a4336b0b2023c9c7da06b', '526000', null, '端州区', '02', '端州区', '441202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a0dc6b6a7804416ab37bbd870a6bafd0', '6fed53cde91a4336b0b2023c9c7da06b', '526000', null, '鼎湖区', '03', '鼎湖区', '441203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('27f12de495374ee3b4708f8cb29f542b', '6fed53cde91a4336b0b2023c9c7da06b', '526300', null, '广宁县', '23', '广宁县', '441223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7ced0823c5dd427d98832447c387328b', '6fed53cde91a4336b0b2023c9c7da06b', '526400', null, '怀集县', '24', '怀集县', '441224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9e52bb9d2be84b2f842d8f965fe5840d', '6fed53cde91a4336b0b2023c9c7da06b', '526500', null, '封开县', '25', '封开县', '441225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('85f753799e0644d199873724cb80641d', '6fed53cde91a4336b0b2023c9c7da06b', '526600', null, '德庆县', '26', '德庆县', '441226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b2ee511cc1c344eda2da283792ab8b03', '6fed53cde91a4336b0b2023c9c7da06b', '526100', null, '高要市', '83', '高要市', '441283', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dfbb2608e2cd4fa1bcd6266ab4f253e1', '6fed53cde91a4336b0b2023c9c7da06b', '526200', null, '四会市', '84', '四会市', '441284', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('233cf6302f9f4a0b8b9e87c8c17f8cae', '42ed28a2d2cf4a0ab128fdba1486ba90', '516000', null, '市辖区', '01', '市辖区', '441301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8024824cdf9046fe80a9fde7b7ee4a59', '42ed28a2d2cf4a0ab128fdba1486ba90', '516000', null, '惠城区', '02', '惠城区', '441302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b986afe63a9b47eca551688304b5d5dc', '42ed28a2d2cf4a0ab128fdba1486ba90', '516200', null, '惠阳区', '03', '惠阳区', '441303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6735aa16da0f46aba2ab158b1cb43d69', '42ed28a2d2cf4a0ab128fdba1486ba90', '516100', null, '博罗县', '22', '博罗县', '441322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ae88513131ba47d799cc8c6233a43fc9', '42ed28a2d2cf4a0ab128fdba1486ba90', '516300', null, '惠东县', '23', '惠东县', '441323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('96f53c2d2a4b4511b8559436219ec9a9', 'aded03dddeff43778b7b5b6f0c070a56', '629000', null, '安居区', '04', '安居区', '510904', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('12775de9877f4b9db66341c71df5625e', 'aded03dddeff43778b7b5b6f0c070a56', '629100', null, '蓬溪县', '21', '蓬溪县', '510921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('07ff20bb7bab473fbe4caa7413203a10', 'aded03dddeff43778b7b5b6f0c070a56', '629200', null, '射洪县', '22', '射洪县', '510922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bf4a3637bb3d4703b20fbdfcbf3f7d13', 'aded03dddeff43778b7b5b6f0c070a56', '629300', null, '大英县', '23', '大英县', '510923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8325407a5fbd464aa38fe196e8d3d061', '20cbbf557ea1420a960c6e9ce04de1e3', '628000', null, '市辖区', '01', '市辖区', '511001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('883d3a15891f4295a1392e21823c4c69', '20cbbf557ea1420a960c6e9ce04de1e3', '641000', null, '市中区', '02', '市中区', '511002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('79b24d21ea8845b1aae899d7fdc65787', '20cbbf557ea1420a960c6e9ce04de1e3', '641100', null, '东兴区', '11', '东兴区', '511011', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('68e813baffd84beab1467ea335dac951', '20cbbf557ea1420a960c6e9ce04de1e3', '642450', null, '威远县', '24', '威远县', '511024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6f9fd5bed10c432e9cc4ee7347d37a69', '20cbbf557ea1420a960c6e9ce04de1e3', '641200', null, '资中县', '25', '资中县', '511025', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0fce11632b394f7ba7ef8b8c60212886', '20cbbf557ea1420a960c6e9ce04de1e3', '642150', null, '隆昌县', '28', '隆昌县', '511028', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('da8a422f05e54177bcdab8269989ebfe', '69bd3ecc0d324699ba96fe24b0356639', '614000', null, '市辖区', '01', '市辖区', '511101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ff6aa734f4f14cb5b29fb8d542fd05c9', '69bd3ecc0d324699ba96fe24b0356639', '614000', null, '市中区', '02', '市中区', '511102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('945333057e714cd8bb0ca6ae2a7f2227', '69bd3ecc0d324699ba96fe24b0356639', '614900', null, '沙湾区', '11', '沙湾区', '511111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('866620bf5ea346f1a697a5a5a5a2c147', '69bd3ecc0d324699ba96fe24b0356639', '614800', null, '五通桥区', '12', '五通桥区', '511112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b74222b576134120b729e339374ed460', '69bd3ecc0d324699ba96fe24b0356639', '614700', null, '金口河区', '13', '金口河区', '511113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('de7e9d59e1e440e9a3821cf70200ed4e', '69bd3ecc0d324699ba96fe24b0356639', '614400', null, '犍为县', '23', '犍为县', '511123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c0c9d25e3e884516b7fe27a2f238a553', '69bd3ecc0d324699ba96fe24b0356639', '613100', null, '井研县', '24', '井研县', '511124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5922d3cfccc4416497bbed897dd8b733', '69bd3ecc0d324699ba96fe24b0356639', '614100', null, '夹江县', '26', '夹江县', '511126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('be93ea0a6f5b4c879523624a91570c1d', '18d0a9122294487eb4aa8d5d6849ec93', '251800', null, '阳信县', '22', '阳信县', '371622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eae251b67baa46e0b2038f93c3ad5b96', '18d0a9122294487eb4aa8d5d6849ec93', '251900', null, '无棣县', '23', '无棣县', '371623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6481fe9c60e847f7b39e3360a3db6a61', '18d0a9122294487eb4aa8d5d6849ec93', '256800', null, '沾化县', '24', '沾化县', '371624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('49637a466bd644b695eebc25432832ab', '18d0a9122294487eb4aa8d5d6849ec93', '256500', null, '博兴县', '25', '博兴县', '371625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c33af573b8f24220b001632f47a7522e', '18d0a9122294487eb4aa8d5d6849ec93', '256200', null, '邹平县', '26', '邹平县', '371626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0a5e4247a9ec403ea9a33e23959f4555', '3d9e443c24e1403caf4ab9e0e6fd05ed', '274000', null, '市辖区', '01', '市辖区', '371701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2f412c801e3c4b4ebc133b15892dfa4c', '3d9e443c24e1403caf4ab9e0e6fd05ed', '274000', null, '牡丹区', '02', '牡丹区', '371702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3cd179ce972e4a829a71d6dfc98b06f6', '3d9e443c24e1403caf4ab9e0e6fd05ed', '274400', null, '曹县', '21', '曹县', '371721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0d45fa519d094b28930aa7fa97d8682f', 'ab33919c65c7421e95b62e88c00a809e', '514100', null, '蕉岭县', '27', '蕉岭县', '441427', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aededd076498403f9b15c813afec163e', 'ab33919c65c7421e95b62e88c00a809e', '514500', null, '兴宁市', '81', '兴宁市', '441481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c91e1af92da74243974e64265c0d67cf', 'bcc33574fca64b2c9936de8b2e69fa53', '516600', null, '市辖区', '01', '市辖区', '441501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('976178d30a764c2ba81e47b68a16f034', 'bcc33574fca64b2c9936de8b2e69fa53', '516600', null, '城区', '02', '城区', '441502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7508b5753345474a9500b26c632cc557', 'bcc33574fca64b2c9936de8b2e69fa53', '516400', null, '海丰县', '21', '海丰县', '441521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('846547059e184db8939861da5ca16d42', 'bcc33574fca64b2c9936de8b2e69fa53', '516700', null, '陆河县', '23', '陆河县', '441523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3a8c48801291486cbad1997805d450a0', 'bcc33574fca64b2c9936de8b2e69fa53', '516500', null, '陆丰市', '81', '陆丰市', '441581', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3fba18166f8b4ffbad5e4a7a69c939ae', '9ab8b8c02064408fb354679975276d42', '517000', null, '市辖区', '01', '市辖区', '441601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e7ba7d60c1014324ac2d8bd3690879fb', '9ab8b8c02064408fb354679975276d42', '517000', null, '源城区', '02', '源城区', '441602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('54ceb3bd497e41c382d69beeb51cc3f0', '9ab8b8c02064408fb354679975276d42', '517400', null, '紫金县', '21', '紫金县', '441621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('30f23eb909794ecc969a9f1f96620617', '9ab8b8c02064408fb354679975276d42', '517300', null, '龙川县', '22', '龙川县', '441622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b75edb7091334683923eae15752746cc', '9ab8b8c02064408fb354679975276d42', '517100', null, '连平县', '23', '连平县', '441623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2a49a354c2c24d75a3e19281737e624d', '9ab8b8c02064408fb354679975276d42', '517200', null, '和平县', '24', '和平县', '441624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3b113f8d9b96401e9abc729a0674fd2f', '9ab8b8c02064408fb354679975276d42', '517500', null, '东源县', '25', '东源县', '441625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5ee6044d2ed44c189034c63474e9d81a', '2bd37a3d909f4620b756803efe2fa5da', '529500', null, '市辖区', '01', '市辖区', '441701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aaa2675abd344a76a03d8a0f97aa90a7', '2bd37a3d909f4620b756803efe2fa5da', '529500', null, '江城区', '02', '江城区', '441702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8c805581935f4536b07ffbb9f8204328', '2bd37a3d909f4620b756803efe2fa5da', '529800', null, '阳西县', '21', '阳西县', '441721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9de26af84e214779ab03e867d41321ae', '2bd37a3d909f4620b756803efe2fa5da', '529900', null, '阳东县', '23', '阳东县', '441723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('186633c6e592494bbb5dacfab7a3d577', '2bd37a3d909f4620b756803efe2fa5da', '529600', null, '阳春市', '81', '阳春市', '441781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b88227dc06f24c52912b9d072ffdfb29', 'b14f71ca712e4aea9fdb427384026a75', '511500', null, '市辖区', '01', '市辖区', '441801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dd520cdbe35848c9983c1ab5b3e5e012', 'b14f71ca712e4aea9fdb427384026a75', '511500', null, '清城区', '02', '清城区', '441802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8ada70f1576841188e7d91a323f94535', 'b14f71ca712e4aea9fdb427384026a75', '511600', null, '佛冈县', '21', '佛冈县', '441821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('24a054271f4145b099a6995e16b46c30', 'b14f71ca712e4aea9fdb427384026a75', '513100', null, '阳山县', '23', '阳山县', '441823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('37cbe84afe7948a2aa384d1a2614bc74', 'b14f71ca712e4aea9fdb427384026a75', '513200', null, '连山壮族瑶族自治县', '25', '连山壮族瑶族自治县', '441825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9286c00911924fc1a2bec48bcb96503c', 'b14f71ca712e4aea9fdb427384026a75', '513300', null, '连南瑶族自治县', '26', '连南瑶族自治县', '441826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e7c25fbaaf944e9b4f03deb094b8a38', 'b14f71ca712e4aea9fdb427384026a75', '511800', null, '清新县', '27', '清新县', '441827', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bde2fbffc4814dc1b2083f816e2b157f', 'b14f71ca712e4aea9fdb427384026a75', '513000', null, '英德市', '81', '英德市', '441881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9cdd8527d60747e3990df8ddbcfffa46', 'b14f71ca712e4aea9fdb427384026a75', '513400', null, '连州市', '82', '连州市', '441882', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e12a16496b934d43a4edebddb6f67512', '131cd1bc6ab44780924b517a43ebccbb', '521000', null, '市辖区', '01', '市辖区', '445101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8b50078dbb6b44bfa875ff7ed21f0bb3', '131cd1bc6ab44780924b517a43ebccbb', '521000', null, '湘桥区', '02', '湘桥区', '445102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('77652ad233284c0cab079bb0965f1a10', '131cd1bc6ab44780924b517a43ebccbb', '515600', null, '潮安县', '21', '潮安县', '445121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6598cbc171ff4ea7b245ffbcad107742', '131cd1bc6ab44780924b517a43ebccbb', '515700', null, '饶平县', '22', '饶平县', '445122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1fb6b6b9747c46419aeed480d74d9b47', '03a5d1e6c2c24023ba09c41ba51b7b94', '522000', null, '市辖区', '01', '市辖区', '445201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c18e1bd5b1e74dffb661e90074605d21', '03a5d1e6c2c24023ba09c41ba51b7b94', '522000', null, '榕城区', '02', '榕城区', '445202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5c468c13e83d4c1598a340b33fb74948', '03a5d1e6c2c24023ba09c41ba51b7b94', '515500', null, '揭东县', '21', '揭东县', '445221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dec626c4c15e42b0a05f0c54b783c6b6', '03a5d1e6c2c24023ba09c41ba51b7b94', '515400', null, '揭西县', '22', '揭西县', '445222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ed2cccade2a048588575cd19138fe68e', '03a5d1e6c2c24023ba09c41ba51b7b94', '515200', null, '惠来县', '24', '惠来县', '445224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bed84614e302406abe4d12935b3c5bb0', '03a5d1e6c2c24023ba09c41ba51b7b94', '515300', null, '普宁市', '81', '普宁市', '445281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('371e05d7767542a3babe94be4f7b2851', '42db031cba074ff2a68b68b2eb36e043', '527300', null, '市辖区', '01', '市辖区', '445301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('620f4a78176b4b43b61f08f5b0d88c5a', '42db031cba074ff2a68b68b2eb36e043', '527300', null, '云城区', '02', '云城区', '445302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d05d6ffb7d248718c4279ee2b3a0685', '42db031cba074ff2a68b68b2eb36e043', '527400', null, '新兴县', '21', '新兴县', '445321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('80809e6ab4a042c2ade86bad0b94f46b', '42db031cba074ff2a68b68b2eb36e043', '527100', null, '郁南县', '22', '郁南县', '445322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('20a1ea083499403b9178ae4e34bc250d', '42db031cba074ff2a68b68b2eb36e043', '527500', null, '云安县', '23', '云安县', '445323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e96a97700a054654a7bbc7fa54008905', '42db031cba074ff2a68b68b2eb36e043', '527200', null, '罗定市', '81', '罗定市', '445381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('75d8561fc96b45f2a912e3638149f9a1', '9e986231263c41118f58c81e9d4cab3b', '530000', null, '市辖区', '01', '市辖区', '450101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4717db6ad9254a81915a0cafb0ed22ca', '9e986231263c41118f58c81e9d4cab3b', '530000', null, '兴宁区', '02', '兴宁区', '450102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('87b09583ad4741618b50d3d3df0724cc', '9e986231263c41118f58c81e9d4cab3b', '530000', null, '青秀区', '03', '青秀区', '450103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f737f53b2a6343859a65aeec942a3dd5', '9e986231263c41118f58c81e9d4cab3b', '530000', null, '江南区', '05', '江南区', '450105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('24c6d373f5064e909a445a2783c98a9a', '9e986231263c41118f58c81e9d4cab3b', '530000', null, '西乡塘区', '07', '西乡塘区', '450107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('872713fcca1a49f389f327e1ef4fd00d', '9e986231263c41118f58c81e9d4cab3b', '530200', null, '良庆区', '08', '良庆区', '450108', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ee5755d99fed47e8b6372f4a91ff8b85', '9e986231263c41118f58c81e9d4cab3b', '530200', null, '邕宁区', '09', '邕宁区', '450109', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f170426379c144e7a20a93804dc66b52', '9e986231263c41118f58c81e9d4cab3b', '530100', null, '武鸣县', '22', '武鸣县', '450122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('458a5ad4b3ee472d89ccfbbdc2c40e4d', '9e986231263c41118f58c81e9d4cab3b', '532700', null, '隆安县', '23', '隆安县', '450123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4783c7b230394b4292b24afb079988a1', '9e986231263c41118f58c81e9d4cab3b', '530600', null, '马山县', '24', '马山县', '450124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ae77acae787847b5b0106732939a8aca', '9e986231263c41118f58c81e9d4cab3b', '530500', null, '上林县', '25', '上林县', '450125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bec93cde268748f99a5ffadea0070fc0', '9e986231263c41118f58c81e9d4cab3b', '530400', null, '宾阳县', '26', '宾阳县', '450126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('20d43724d97d400f8f5349247ce943ce', '9e986231263c41118f58c81e9d4cab3b', '530300', null, '横县', '27', '横县', '450127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1c215e5fde5d4e8696717e68e1daf79c', '3a8faee14d6a473493ddf5b00fe9eab7', '545000', null, '市辖区', '01', '市辖区', '450201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8cdd65dd562649828843e094f5c704b4', '3a8faee14d6a473493ddf5b00fe9eab7', '545000', null, '城中区', '02', '城中区', '450202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('216fb0c1d591457dac8a1ca703a7b169', '3a8faee14d6a473493ddf5b00fe9eab7', '545000', null, '鱼峰区', '03', '鱼峰区', '450203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c67333c30c17480c85f04a330c1645c8', '3a8faee14d6a473493ddf5b00fe9eab7', '545000', null, '柳南区', '04', '柳南区', '450204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6a09411d8c8245569987a97c49dd59ea', '3a8faee14d6a473493ddf5b00fe9eab7', '545000', null, '柳北区', '05', '柳北区', '450205', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9e2f14fb9fa64614b571484f62f1cda5', '3a8faee14d6a473493ddf5b00fe9eab7', '545100', null, '柳江县', '21', '柳江县', '450221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('390523f350064019a715f8bafc307b15', '3a8faee14d6a473493ddf5b00fe9eab7', '545200', null, '柳城县', '22', '柳城县', '450222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5282407c4e5547cfbf95e2f52341ff86', '3a8faee14d6a473493ddf5b00fe9eab7', '545600', null, '鹿寨县', '23', '鹿寨县', '450223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b3e9a3481c8e4bd18ea1beef2840736a', 'fd915aadafda49b68d1cf622418a9f82', '425000', null, '市辖区', '01', '市辖区', '431101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('379431aef2814ac08b4d2eee5b67d2bf', '5944b21cd62d4404bab999965db12d4a', '533200', null, '乐业县', '28', '乐业县', '451028', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('db0b902763a247dfb3bd0ee5935c3af6', '5944b21cd62d4404bab999965db12d4a', '533300', null, '田林县', '29', '田林县', '451029', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f2ca34a85a7d4d2d94df0c1683663cb2', '5944b21cd62d4404bab999965db12d4a', '533500', null, '西林县', '30', '西林县', '451030', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('59b9e0e2cfcf4c7d9f5db8d65b512bd0', '5944b21cd62d4404bab999965db12d4a', '533500', null, '隆林各族自治县', '31', '隆林各族自治县', '451031', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6c26b3a0932e438bb40354eb76cae1a6', '94e911567a7647aebcaf864e4d2e0e59', '542800', null, '市辖区', '01', '市辖区', '451101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8f88d8be39684316b405ebd27aa2936f', '94e911567a7647aebcaf864e4d2e0e59', '552106', null, '八步区', '02', '八步区', '451102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cfddaa6cafed4d788078d75636c171b7', '94e911567a7647aebcaf864e4d2e0e59', '546800', null, '昭平县', '21', '昭平县', '451121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('18809d5959f941bf9e16d0b2743aed18', '94e911567a7647aebcaf864e4d2e0e59', '542600', null, '钟山县', '22', '钟山县', '451122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('edf135134eed431c8860a99ae3456bb6', '94e911567a7647aebcaf864e4d2e0e59', '542700', null, '富川瑶族自治县', '23', '富川瑶族自治县', '451123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d27c9d6100f94849a70a817b62870ae4', '241206b6912b4472bc71573bab0a2b1b', '547000', null, '市辖区', '01', '市辖区', '451201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f0921c8a8e0e4961a4599d598e92e824', '241206b6912b4472bc71573bab0a2b1b', '547000', null, '金城江区', '02', '金城江区', '451202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('01ed9b8d313e490a990dc09939c7b1a4', '241206b6912b4472bc71573bab0a2b1b', '547200', null, '南丹县', '21', '南丹县', '451221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e79f3594df3e41d7add2206e4f057131', '241206b6912b4472bc71573bab0a2b1b', '547300', null, '天峨县', '22', '天峨县', '451222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('89df73fa287b4928bc7a919e511eb7ea', '241206b6912b4472bc71573bab0a2b1b', '547600', null, '凤山县', '23', '凤山县', '451223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('17c89edba77343228add744b70ad7c80', '241206b6912b4472bc71573bab0a2b1b', '547400', null, '东兰县', '24', '东兰县', '451224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('08d4715d9a06431ab2d92a4eb7be4d1b', '241206b6912b4472bc71573bab0a2b1b', '546400', null, '罗城仫佬族自治县', '25', '罗城仫佬族自治县', '451225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('17e4ac0925f0475dad446eca659039c2', '241206b6912b4472bc71573bab0a2b1b', '547100', null, '环江毛南族自治县', '26', '环江毛南族自治县', '451226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('03f1dbe30a354a7abe79218c55742b95', '241206b6912b4472bc71573bab0a2b1b', '547500', null, '巴马瑶族自治县', '27', '巴马瑶族自治县', '451227', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('48e39d2595f84afcb611aaf2270f44e6', '241206b6912b4472bc71573bab0a2b1b', '530700', null, '都安瑶族自治县', '28', '都安瑶族自治县', '451228', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('de6578cb0fa44c40972ddd19e428cdd2', '241206b6912b4472bc71573bab0a2b1b', '530800', null, '大化瑶族自治县', '29', '大化瑶族自治县', '451229', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e1e768a696b4323b99c37548146c055', '241206b6912b4472bc71573bab0a2b1b', '546300', null, '宜州市', '81', '宜州市', '451281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e006bb67324e456da3b4662f677fc6ca', 'a3b03952a36b474dbb441c665fab6913', '546100', null, '市辖区', '01', '市辖区', '451301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8f4afbb4e79f416da94ec904e5dbc68a', 'a3b03952a36b474dbb441c665fab6913', '546100', null, '兴宾区', '02', '兴宾区', '451302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f420b9a8d23c4592ad1afed559e92f01', 'a3b03952a36b474dbb441c665fab6913', '546200', null, '忻城县', '21', '忻城县', '451321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('471c26f7da1740ae874556d9a21e770d', 'a3b03952a36b474dbb441c665fab6913', '545800', null, '象州县', '22', '象州县', '451322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4dfa78b373004f57b7004283e3d56cfc', 'a3b03952a36b474dbb441c665fab6913', '545900', null, '武宣县', '23', '武宣县', '451323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('edb47d77b45141a3969bc5f2c69f754c', 'a3b03952a36b474dbb441c665fab6913', '545700', null, '金秀瑶族自治县', '24', '金秀瑶族自治县', '451324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('475370faf40d4fdcb8377c1f29629a34', 'a3b03952a36b474dbb441c665fab6913', '546500', null, '合山市', '81', '合山市', '451381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bfce033853174939a4ff3b250c74616f', '2e26f89fa8a54d59b4d85abfc42b1ebe', '532200', null, '市辖区', '01', '市辖区', '451401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ba1e209c4f074e91982cdf1316a94a41', '2e26f89fa8a54d59b4d85abfc42b1ebe', '532200', null, '江洲区', '02', '江洲区', '451402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c47eaa4dfab244d98d13d5f78061ac90', '2e26f89fa8a54d59b4d85abfc42b1ebe', '532100', null, '扶绥县', '21', '扶绥县', '451421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b2e19dcc26ab4fe988a41d63f58806fc', '2e26f89fa8a54d59b4d85abfc42b1ebe', '532500', null, '宁明县', '22', '宁明县', '451422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3dcbd74f0c754541a6b173f1c533d98b', '2e26f89fa8a54d59b4d85abfc42b1ebe', '532400', null, '龙州县', '23', '龙州县', '451423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b8fd09633d4c451c970eae43522b7cf5', '2e26f89fa8a54d59b4d85abfc42b1ebe', '532300', null, '大新县', '24', '大新县', '451424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('421a3e6680834524bb906d03e6541121', '2e26f89fa8a54d59b4d85abfc42b1ebe', '532800', null, '天等县', '25', '天等县', '451425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('72ac42893ac24221952b9fdda32f94f8', '2e26f89fa8a54d59b4d85abfc42b1ebe', '532600', null, '凭祥市', '81', '凭祥市', '451481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e7954db66ef245068d0c392353f5cef9', '64a868e81b664b20b3f818bff115cf71', '570100', null, '市辖区', '01', '市辖区', '460101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('01d930595bd34354b34fe45274926eeb', '64a868e81b664b20b3f818bff115cf71', '570100', null, '秀英区', '05', '秀英区', '460105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fbde6c2f455a4a35a74602a96947b978', '64a868e81b664b20b3f818bff115cf71', '570100', null, '龙华区', '06', '龙华区', '460106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e91bb5ddc1244ae9af0fc1ffae7b7bb1', '64a868e81b664b20b3f818bff115cf71', '571100', null, '琼山区', '07', '琼山区', '460107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9e121ba679324c8c8e3f00810e535cd4', '64a868e81b664b20b3f818bff115cf71', '570100', null, '美兰区', '08', '美兰区', '460108', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8d6b27c1aae64e2c8bd9b337f621813d', 'e123506da0ff4e6fa019c8fceece5a0e', '572000', null, '三亚市', '01', '三亚市', '460201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('614239e6d46e468295fa4561662a4d91', '97727b55303e4938afa1eb316b3d58cb', '572200', null, '五指山市', '01', '五指山市', '469001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('933d62384f9f459ead7b387f5ac25ee2', '97727b55303e4938afa1eb316b3d58cb', '571400', null, '琼海市', '02', '琼海市', '469002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0cc52ab587d14154809c18d6dc4ece27', '97727b55303e4938afa1eb316b3d58cb', '571700', null, '儋州市', '03', '儋州市', '469003', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3ce1c581ab31417495a2f050ce536da3', '97727b55303e4938afa1eb316b3d58cb', '571300', null, '文昌市', '05', '文昌市', '469005', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('13f98fcea86c4e32a4c9765b293b0c60', '97727b55303e4938afa1eb316b3d58cb', '571500', null, '万宁市', '06', '万宁市', '469006', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c3e493cf874e40f58abe00f7022aebd0', '97727b55303e4938afa1eb316b3d58cb', '572600', null, '东方市', '07', '东方市', '469007', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('228da0d084684842b799ac2a6c745c14', '97727b55303e4938afa1eb316b3d58cb', '571200', null, '定安县', '25', '定安县', '469025', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('415e105942994ab3b2ada4b77fdfb869', '97727b55303e4938afa1eb316b3d58cb', '571600', null, '屯昌县', '26', '屯昌县', '469026', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4e4a7ac8d8e342f3a34da5436acb3ce3', '97727b55303e4938afa1eb316b3d58cb', '571900', null, '澄迈县', '27', '澄迈县', '469027', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('09176e6455a943a2ae361b9fda3ae929', '97727b55303e4938afa1eb316b3d58cb', '571800', null, '临高县', '28', '临高县', '469028', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('20e303cecd03405cb39ad5fc64167719', '97727b55303e4938afa1eb316b3d58cb', '572800', null, '白沙黎族自治县', '30', '白沙黎族自治县', '469030', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d46c73dc0a64db0b381894c4a85d80d', '97727b55303e4938afa1eb316b3d58cb', '572700', null, '昌江黎族自治县', '31', '昌江黎族自治县', '469031', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5860e1dc56b94fbebcfce79c5b88e92b', '97727b55303e4938afa1eb316b3d58cb', '572500', null, '乐东黎族自治县', '33', '乐东黎族自治县', '469033', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('59a8afedbdd74ff6b58570c156434429', '97727b55303e4938afa1eb316b3d58cb', '572400', null, '陵水黎族自治县', '34', '陵水黎族自治县', '469034', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1a0603f987fa447a9848fbb2861eae96', '405b1da4465e49088c798360db70c15b', '623000', null, '汶川县', '21', '汶川县', '513221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('223af1674d984927917cdbcd9c5cf8a3', '6343ca91165140d1bcc25205a1235335', '665800', null, '孟连傣族拉祜族佤族自治县', '27', '孟连傣族拉祜族佤族自治县', '530827', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('70c71090d8de4319ae543498ba778ebd', '6343ca91165140d1bcc25205a1235335', '665600', null, '澜沧拉祜族自治县', '28', '澜沧拉祜族自治县', '530828', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8fed233292c44e6c8cad265120fed39e', '6343ca91165140d1bcc25205a1235335', '665700', null, '西盟佤族自治县', '29', '西盟佤族自治县', '530829', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5ac6900177d94650877298044fa9a3d5', 'd3ac67eb93544b9da681781f1f27fa5d', '677000', null, '市辖区', '01', '市辖区', '530901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dbcc63bf30b246b189c2c99509b628af', 'd3ac67eb93544b9da681781f1f27fa5d', '677000', null, '临翔区', '02', '临翔区', '530902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6e5dcca95af841e0b05ceac33299780c', 'b980cca7c3e04419a36d045d0745ad97', '408000', null, '涪陵区', '02', '涪陵区', '500102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f8506e918a64434e817dc8f2f3f239b1', '8ebfb0cbf62d4b6597fd742963815e4d', '432200', null, '黄陂区', '16', '黄陂区', '420116', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0d1d61c4a72e4ac6a033a076e521b01b', 'b980cca7c3e04419a36d045d0745ad97', '400000', null, '大渡口区', '04', '大渡口区', '500104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('96781fbda78942c2a7fc256a56f01a87', 'b980cca7c3e04419a36d045d0745ad97', '400000', null, '江北区', '05', '江北区', '500105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f63198d59c74dc19efeba9d1645ca1d', 'b980cca7c3e04419a36d045d0745ad97', '400000', null, '沙坪坝区', '06', '沙坪坝区', '500106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5c00f477f3864de796ed4dbb62a4dd6d', 'b980cca7c3e04419a36d045d0745ad97', '400000', null, '九龙坡区', '07', '九龙坡区', '500107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('64908b2828874bfea69669f49f648a7b', 'b980cca7c3e04419a36d045d0745ad97', '400000', null, '南岸区', '08', '南岸区', '500108', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2ef8a387318c4d389d636838a2fa969c', 'b980cca7c3e04419a36d045d0745ad97', '400700', null, '北碚区', '09', '北碚区', '500109', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('829b0077665e4abb818e6329c5f63101', 'b980cca7c3e04419a36d045d0745ad97', '400800', null, '万盛区', '10', '万盛区', '500110', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6291a65e9b954a5e924732ae4a5636bb', 'b980cca7c3e04419a36d045d0745ad97', '400900', null, '双桥区', '11', '双桥区', '500111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('de71fc8ac9fa4b97b30996d62a8be934', 'b980cca7c3e04419a36d045d0745ad97', '401120', null, '渝北区', '12', '渝北区', '500112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c28a903c172d41ec9b5b0526cec05ea7', 'b980cca7c3e04419a36d045d0745ad97', '401320', null, '巴南区', '13', '巴南区', '500113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('250a7ac7496745aeb456ebaa912aeb2b', 'b980cca7c3e04419a36d045d0745ad97', '409000', null, '黔江区', '14', '黔江区', '500114', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a6703083cead4f47917199a421dedd1e', 'b980cca7c3e04419a36d045d0745ad97', '401220', null, '长寿区', '15', '长寿区', '500115', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c508d23e03f944d0be50e19cae121a1d', 'b980cca7c3e04419a36d045d0745ad97', '401420', null, '綦江县', '22', '綦江县', '500222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('68f8ada610404b458e62faad27c0d3d9', 'b980cca7c3e04419a36d045d0745ad97', '402660', null, '潼南县', '23', '潼南县', '500223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b86209f930b54ec9a998a64b6cf7d376', 'b980cca7c3e04419a36d045d0745ad97', '402560', null, '铜梁县', '24', '铜梁县', '500224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('72fb4e3e2bba42e596682a5fe9fe3c10', 'b980cca7c3e04419a36d045d0745ad97', '402360', null, '大足县', '25', '大足县', '500225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('147d6ecec09941089f33a6e1459943f4', 'b980cca7c3e04419a36d045d0745ad97', '402460', null, '荣昌县', '26', '荣昌县', '500226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('07881cead92747c498bf38f3ef95e18c', 'b980cca7c3e04419a36d045d0745ad97', '402760', null, '璧山县', '27', '璧山县', '500227', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a83d1613ae544411b9faca8a4a05c42b', 'b980cca7c3e04419a36d045d0745ad97', '405200', null, '梁平县', '28', '梁平县', '500228', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e45670a12f0646e29456643ef71a9144', 'b980cca7c3e04419a36d045d0745ad97', '405900', null, '城口县', '29', '城口县', '500229', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ac78924d9c1046e69808ac86e65b8fa9', 'b980cca7c3e04419a36d045d0745ad97', '408200', null, '丰都县', '30', '丰都县', '500230', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cd7b3d36c8ce42a586f077c10a9ff4f8', 'b980cca7c3e04419a36d045d0745ad97', '408300', null, '垫江县', '31', '垫江县', '500231', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0a30d446fed142fdb02a5be8f94dd32b', 'b980cca7c3e04419a36d045d0745ad97', '408500', null, '武隆县', '32', '武隆县', '500232', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4c6079c6d00640fe8b6837f423736344', 'b980cca7c3e04419a36d045d0745ad97', '404300', null, '忠县', '33', '忠县', '500233', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('24c24eaa409d49d2b43835dcfbdcdf98', 'b980cca7c3e04419a36d045d0745ad97', '405400', null, '开县', '34', '开县', '500234', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('839186fe69d540a2a251d25f4a235fcc', 'b980cca7c3e04419a36d045d0745ad97', '404500', null, '云阳县', '35', '云阳县', '500235', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('892098d73a8f4ebbb23b1cd6803603d6', 'b980cca7c3e04419a36d045d0745ad97', '404600', null, '奉节县', '36', '奉节县', '500236', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cc7cc24e5ee640bd8c7054655a53be82', 'b980cca7c3e04419a36d045d0745ad97', '404700', null, '巫山县', '37', '巫山县', '500237', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7e73fd0788384342af6e32a2dd6a6b28', 'b980cca7c3e04419a36d045d0745ad97', '405800', null, '巫溪县', '38', '巫溪县', '500238', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('955fa50491bd44458ed5548a637194a3', 'b980cca7c3e04419a36d045d0745ad97', '409100', null, '石柱土家族自治县', '40', '石柱土家族自治县', '500240', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('715cb10d34f34b26b0dea7e32e912df3', 'b980cca7c3e04419a36d045d0745ad97', '409900', null, '秀山土家族苗族自治县', '41', '秀山土家族苗族自治县', '500241', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3b10892be7a2408da4772f31f4faae8f', 'b980cca7c3e04419a36d045d0745ad97', '409800', null, '酉阳土家族苗族自治县', '42', '酉阳土家族苗族自治县', '500242', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8f752387790d47d78f0e974896275367', 'b980cca7c3e04419a36d045d0745ad97', '409600', null, '彭水苗族土家族自治县', '43', '彭水苗族土家族自治县', '500243', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c42bd5f596144aa697561b8ad84be828', 'b980cca7c3e04419a36d045d0745ad97', '402260', null, '江津市', '81', '江津市', '500381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('42d9d9fee114439298e5dbd205d1e779', 'b980cca7c3e04419a36d045d0745ad97', '401520', null, '合川市', '82', '合川市', '500382', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0514a6d514c14db09415ef78abe43d15', 'b980cca7c3e04419a36d045d0745ad97', '402160', null, '永川市', '83', '永川市', '500383', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5927acb9875f4e2cad054729a569f5e1', 'b980cca7c3e04419a36d045d0745ad97', '408400', null, '南川市', '84', '南川市', '500384', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('20adf85bf7624d2fbdecfc167bc76992', '08cb7a128990421a99d0528514ebe24c', '610000', null, '市辖区', '01', '市辖区', '510101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3abd262e40564bce851bde7c2b91bebb', '08cb7a128990421a99d0528514ebe24c', '610000', null, '锦江区', '04', '锦江区', '510104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a9b9f2b928454d07bf76c1041695bb32', '08cb7a128990421a99d0528514ebe24c', '610000', null, '青羊区', '05', '青羊区', '510105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('680eebd4053c44e19f6e333ebbf3d935', '08cb7a128990421a99d0528514ebe24c', '610000', null, '金牛区', '06', '金牛区', '510106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b9dd5622f1a040329bdbd0a0697a612a', '08cb7a128990421a99d0528514ebe24c', '610000', null, '武侯区', '07', '武侯区', '510107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('00efdd3c568740b2918f10e1e52e34d3', '08cb7a128990421a99d0528514ebe24c', '610000', null, '成华区', '08', '成华区', '510108', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1059c980d5cb4402959848e975bf0e5e', '08cb7a128990421a99d0528514ebe24c', '610100', null, '龙泉驿区', '12', '龙泉驿区', '510112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7aaca4f6ede54bea8549b5c54acf7c5a', '08cb7a128990421a99d0528514ebe24c', '610300', null, '青白江区', '13', '青白江区', '510113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('52973be04a5b4a90adba519761b180dd', '08cb7a128990421a99d0528514ebe24c', '610500', null, '新都区', '14', '新都区', '510114', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('88c11c48570040cda325f727786c7427', '08cb7a128990421a99d0528514ebe24c', '611100', null, '温江区', '15', '温江区', '510115', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('396ffd1aba3a486ba7c8f17eff89ae25', '08cb7a128990421a99d0528514ebe24c', '610400', null, '金堂县', '21', '金堂县', '510121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3e4663927ff4f1da4ca40d19fcac174', '08cb7a128990421a99d0528514ebe24c', '610200', null, '双流县', '22', '双流县', '510122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bc0a17f3c53a46569ae4c98a456df6a0', '08cb7a128990421a99d0528514ebe24c', '611700', null, '郫县', '24', '郫县', '510124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('72802af3468844a4b098d8dc1fde8a1d', '08cb7a128990421a99d0528514ebe24c', '611300', null, '大邑县', '29', '大邑县', '510129', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eb90679961514883b51c5fd86a46505a', '7652787b72664f18bbfd327f363fb188', '637100', null, '高坪区', '03', '高坪区', '511303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f307da3fb9f47e3b8743fd014760282', '7652787b72664f18bbfd327f363fb188', '637500', null, '嘉陵区', '04', '嘉陵区', '511304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6c61c64f94654977a55dc6a30b4d62d3', '7652787b72664f18bbfd327f363fb188', '637300', null, '南部县', '21', '南部县', '511321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6e85d8a3a84b4b5cb9a8f9396abc1591', '7652787b72664f18bbfd327f363fb188', '637700', null, '营山县', '22', '营山县', '511322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('155a677cce4146059c00ad9e228161b5', '7652787b72664f18bbfd327f363fb188', '637800', null, '蓬安县', '23', '蓬安县', '511323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0d2623e8cad2483f90fbd0bd994058f0', '7652787b72664f18bbfd327f363fb188', '637600', null, '仪陇县', '24', '仪陇县', '511324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ae11b4cef01446fc9a993f056e107522', '7652787b72664f18bbfd327f363fb188', '637200', null, '西充县', '25', '西充县', '511325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f7fa8f90fa04bacbb59418ef89371e2', '7652787b72664f18bbfd327f363fb188', '637400', null, '阆中市', '81', '阆中市', '511381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9656ffba20d34f648bb698cbb645f9a9', '8800e3a2c9d24c758e8ef1eea71aa8a4', '620000', null, '市辖区', '01', '市辖区', '511401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a18b664a920945979d80725c50cf9142', '8800e3a2c9d24c758e8ef1eea71aa8a4', '620000', null, '东坡区', '02', '东坡区', '511402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d8f1acd325d4428b958a2600a0ba703', '8800e3a2c9d24c758e8ef1eea71aa8a4', '620500', null, '仁寿县', '21', '仁寿县', '511421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c675c2838a284141b6bea60342a0e54a', '8800e3a2c9d24c758e8ef1eea71aa8a4', '620800', null, '彭山县', '22', '彭山县', '511422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cf33d58e614147c29c3548a32aef0780', '8800e3a2c9d24c758e8ef1eea71aa8a4', '620300', null, '洪雅县', '23', '洪雅县', '511423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('95575d7ae2ee41dfa9e06a5cf4343dd7', '8800e3a2c9d24c758e8ef1eea71aa8a4', '620200', null, '丹棱县', '24', '丹棱县', '511424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('132b94b80d4d4cbf885c4a6f27ca23ee', '8800e3a2c9d24c758e8ef1eea71aa8a4', '620400', null, '青神县', '25', '青神县', '511425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6a2d24271186443da848d18e1eb7a93c', '199ea73f863b4550982e14d759a1ad27', '644000', null, '市辖区', '01', '市辖区', '511501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bed60141c87a4a52a1c2540b94e7faee', '199ea73f863b4550982e14d759a1ad27', '644000', null, '翠屏区', '02', '翠屏区', '511502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6e1a570b46774dc7918be289e6060142', '199ea73f863b4550982e14d759a1ad27', '644600', null, '宜宾县', '21', '宜宾县', '511521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e119f8f2bc8640b180822bff8bc04b5f', '199ea73f863b4550982e14d759a1ad27', '644100', null, '南溪县', '22', '南溪县', '511522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6d2bfecda1544ad1a577ba9da8f8de30', '199ea73f863b4550982e14d759a1ad27', '644200', null, '江安县', '23', '江安县', '511523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6060d6e18c70485ea46cd1dc9c33298a', '199ea73f863b4550982e14d759a1ad27', '644300', null, '长宁县', '24', '长宁县', '511524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a04a75d3a033495396df4a0aa8b89363', '199ea73f863b4550982e14d759a1ad27', '645150', null, '高县', '25', '高县', '511525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('09ce4d69a88b49af80a2294aaa271d5a', '199ea73f863b4550982e14d759a1ad27', '644500', null, '珙县', '26', '珙县', '511526', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d0f3abe3552e4ad6b4baa9782231dcf3', '199ea73f863b4550982e14d759a1ad27', '645250', null, '筠连县', '27', '筠连县', '511527', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c2013ba711ee46fbb42286b88f03d328', '199ea73f863b4550982e14d759a1ad27', '644400', null, '兴文县', '28', '兴文县', '511528', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b14e9a6404604540bfb90ef56670baee', '199ea73f863b4550982e14d759a1ad27', '645350', null, '屏山县', '29', '屏山县', '511529', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('08ea9d56ff644fc2a3014dba14e19590', 'bbf2f2bcf0ec4c41b319bffbcfb51941', '638550', null, '市辖区', '01', '市辖区', '511601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9cb1f8eba8414bbd805940c4c2585fd7', 'bbf2f2bcf0ec4c41b319bffbcfb51941', '638550', null, '广安区', '02', '广安区', '511602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bf7da56ef9ae4cd6a2f4f682dfda011f', 'bbf2f2bcf0ec4c41b319bffbcfb51941', '638300', null, '岳池县', '21', '岳池县', '511621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('82e53e4759654699baea53c97ce12238', 'bbf2f2bcf0ec4c41b319bffbcfb51941', '638400', null, '武胜县', '22', '武胜县', '511622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c861e50a5e7442eea02ec43b603a1fc8', 'bbf2f2bcf0ec4c41b319bffbcfb51941', '638500', null, '邻水县', '23', '邻水县', '511623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4b228be59a334996a42e44f7fe53bd8a', 'bbf2f2bcf0ec4c41b319bffbcfb51941', '638600', null, '华蓥市', '81', '华蓥市', '511681', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f4f37a48fef147d0b0b104d4879619d5', 'c29af6ded1b64cbea4cd6a79fa153e07', '635000', null, '市辖区', '01', '市辖区', '511701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('284941911e0349da9f25987b38f8ff66', 'c29af6ded1b64cbea4cd6a79fa153e07', '635000', null, '通川区', '02', '通川区', '511702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5e3f885306c5447f9e62117a4b314c63', 'c29af6ded1b64cbea4cd6a79fa153e07', '635000', null, '达县', '21', '达县', '511721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e954f5acaaf424e9eb6fd121c078cfe', 'c29af6ded1b64cbea4cd6a79fa153e07', '636150', null, '宣汉县', '22', '宣汉县', '511722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('05841e7239234c4aa82899b5b3905a69', 'c29af6ded1b64cbea4cd6a79fa153e07', '636250', null, '开江县', '23', '开江县', '511723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('90cb3e43eea9491c88c0c0eaf5bdbd33', 'c29af6ded1b64cbea4cd6a79fa153e07', '635100', null, '大竹县', '24', '大竹县', '511724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c5d3f52b52f544a4aef575268561cbd1', 'c29af6ded1b64cbea4cd6a79fa153e07', '635200', null, '渠县', '25', '渠县', '511725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('755695c3f2b04e3799cf03a041297a32', 'c29af6ded1b64cbea4cd6a79fa153e07', '636350', null, '万源市', '81', '万源市', '511781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7216496d56964d4083775dfe1ec59246', '87081bc7c2b44b4db666df033cb09e88', '625000', null, '市辖区', '01', '市辖区', '511801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('83e655138a6641d9b07e7985402f1971', '87081bc7c2b44b4db666df033cb09e88', '625000', null, '雨城区', '02', '雨城区', '511802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('94482c78c5f746949583c250091ef1f3', '87081bc7c2b44b4db666df033cb09e88', '625100', null, '名山县', '21', '名山县', '511821', null);
commit;
----prompt 2500 records committed...
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('43d3eabeb7a8425e9b2b5a41ce6345b7', '87081bc7c2b44b4db666df033cb09e88', '625200', null, '荥经县', '22', '荥经县', '511822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7c8be5d840214f159598fb059d8e4ee9', '87081bc7c2b44b4db666df033cb09e88', '625300', null, '汉源县', '23', '汉源县', '511823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8bf5e45b2c1b4de98db7ad0f61a684d1', '87081bc7c2b44b4db666df033cb09e88', '625400', null, '石棉县', '24', '石棉县', '511824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c98b6868892c46f7bec7370a7cb21832', '87081bc7c2b44b4db666df033cb09e88', '625500', null, '天全县', '25', '天全县', '511825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('256770ceaf584b7585688dcb78883592', '87081bc7c2b44b4db666df033cb09e88', '625600', null, '芦山县', '26', '芦山县', '511826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c81d7786366d49589fe24bcba050c8e3', '87081bc7c2b44b4db666df033cb09e88', '625700', null, '宝兴县', '27', '宝兴县', '511827', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aba54eb00fa74fbb920ad9260ff33200', 'b6f3e780164d4fd8b64fbe128d7ca50d', '636600', null, '市辖区', '01', '市辖区', '511901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3617c49a52ee4021ab6135a6233cd8cf', 'b6f3e780164d4fd8b64fbe128d7ca50d', '636600', null, '巴州区', '02', '巴州区', '511902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5c2213441a874111b102b2fd5f69a5cc', 'b6f3e780164d4fd8b64fbe128d7ca50d', '636700', null, '通江县', '21', '通江县', '511921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9f04b95264af47699df6e1783db37401', 'b6f3e780164d4fd8b64fbe128d7ca50d', '635600', null, '南江县', '22', '南江县', '511922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('07373b16e9e943e9a52354fd683230e5', 'b6f3e780164d4fd8b64fbe128d7ca50d', '636400', null, '平昌县', '23', '平昌县', '511923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5175c879865e4adeb3a05d5bab63c72d', 'b467acdde0f64c6ba0739ba8b386215d', '641300', null, '市辖区', '01', '市辖区', '512001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c5c015770b87466d8e363f811a93b17a', 'b467acdde0f64c6ba0739ba8b386215d', '641300', null, '雁江区', '02', '雁江区', '512002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b75cef598c6f4adeb5c9292467d2fb8d', 'b467acdde0f64c6ba0739ba8b386215d', '642350', null, '安岳县', '21', '安岳县', '512021', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('098ac4636844454d80cead48dc531ad2', 'b467acdde0f64c6ba0739ba8b386215d', '641500', null, '乐至县', '22', '乐至县', '512022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5cf5091b52484a229371ffde7cf8d3f5', 'b467acdde0f64c6ba0739ba8b386215d', '641400', null, '简阳市', '81', '简阳市', '512081', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0b0cceb3448342aba110c47c4611b880', '18d0a9122294487eb4aa8d5d6849ec93', '251700', null, '惠民县', '21', '惠民县', '371621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('538cdf5712464360b4ce517e3ba0ab3e', '1366c663bb614b20b4d433b637b286ed', '411300', null, '韶山市', '82', '韶山市', '430382', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2d29a29ec0ba4875ab4a1e5bf09afa29', '4d775ed4147c4a29896d82e845939e8b', '421000', null, '市辖区', '01', '市辖区', '430401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('75ee9a07320d48d1a7f7e4d7ff67528f', '4d775ed4147c4a29896d82e845939e8b', '421000', null, '珠晖区', '05', '珠晖区', '430405', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8b69865be39e430b845e3d8fc812725e', '4d775ed4147c4a29896d82e845939e8b', '421000', null, '雁峰区', '06', '雁峰区', '430406', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('69ee31c96f8b4a17aa7ec26293875889', '4d775ed4147c4a29896d82e845939e8b', '421000', null, '石鼓区', '07', '石鼓区', '430407', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a21180b5a4aa4fdfbcf719627c9ba7d3', '4d775ed4147c4a29896d82e845939e8b', '421000', null, '蒸湘区', '08', '蒸湘区', '430408', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('312baba5578e4c7e8dbb47c7cbb28e11', '3d9e443c24e1403caf4ab9e0e6fd05ed', '274300', null, '单县', '22', '单县', '371722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6c97b82db9054fcb838c6792e1ae57c0', '3d9e443c24e1403caf4ab9e0e6fd05ed', '274200', null, '成武县', '23', '成武县', '371723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('02736e604469407f91107eb562938a4d', '3d9e443c24e1403caf4ab9e0e6fd05ed', '274900', null, '巨野县', '24', '巨野县', '371724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1635c3f8bdf14cee8a1d7b46af640710', '3d9e443c24e1403caf4ab9e0e6fd05ed', '274700', null, '郓城县', '25', '郓城县', '371725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('44dbace568954f91a8aad84e9d328267', '3d9e443c24e1403caf4ab9e0e6fd05ed', '274600', null, '鄄城县', '26', '鄄城县', '371726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('874726fd1887404fb24d9a58eeb254db', '3d9e443c24e1403caf4ab9e0e6fd05ed', '274100', null, '定陶县', '27', '定陶县', '371727', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0080511c13f54d3aa1d049ee617d5264', '3d9e443c24e1403caf4ab9e0e6fd05ed', '274500', null, '东明县', '28', '东明县', '371728', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c2a7d83cb5ef49b39a5fcf5602b16de1', '849e41d6e28c41eea4e73753ec790c9b', '450000', null, '市辖区', '01', '市辖区', '410101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8f5b09a730414d2c9ccf53d9cd097dfb', '849e41d6e28c41eea4e73753ec790c9b', '450000', null, '中原区', '02', '中原区', '410102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4d1c18e63f4b4f3c8768932d75be6a27', '849e41d6e28c41eea4e73753ec790c9b', '450000', null, '二七区', '03', '二七区', '410103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9b0df6b1d2214e49b8c7b053d1263e31', '849e41d6e28c41eea4e73753ec790c9b', '450000', null, '管城回族区', '04', '管城回族区', '410104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('91579189005245f2803bf68309892289', '849e41d6e28c41eea4e73753ec790c9b', '450000', null, '金水区', '05', '金水区', '410105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f3c65899433d48bfa78f39fd39c51df2', '849e41d6e28c41eea4e73753ec790c9b', '450041', null, '上街区', '06', '上街区', '410106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c2e9db56ffc9490c9f416bb5200664e0', '849e41d6e28c41eea4e73753ec790c9b', '450000', null, '邙山区', '08', '邙山区', '410108', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9e748fd5a10a4821b81f0623d712d2b6', '849e41d6e28c41eea4e73753ec790c9b', '451450', null, '中牟县', '22', '中牟县', '410122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('755e81b832ed429da095890cd1a7cc50', '849e41d6e28c41eea4e73753ec790c9b', '452100', null, '巩义市', '81', '巩义市', '410181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f0abcedac6384e5c81c04c6f0dd01467', '849e41d6e28c41eea4e73753ec790c9b', '450100', null, '荥阳市', '82', '荥阳市', '410182', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5cfa8222098846a4a1aa771e376144e4', '849e41d6e28c41eea4e73753ec790c9b', '452370', null, '新密市', '83', '新密市', '410183', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c4fb5abbe345448888f84fc99bff750f', '849e41d6e28c41eea4e73753ec790c9b', '451100', null, '新郑市', '84', '新郑市', '410184', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6c6f7a5af2e142149d58082261b0d31c', '849e41d6e28c41eea4e73753ec790c9b', '452470', null, '登封市', '85', '登封市', '410185', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bd965cac5c614810895612d93802cf08', '4dbc4026e4944f11bae16adcae5b5e26', '475000', null, '市辖区', '01', '市辖区', '410201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fa50d1f997cf41b7b6485712ba73460b', '4dbc4026e4944f11bae16adcae5b5e26', '475000', null, '龙亭区', '02', '龙亭区', '410202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d20215e258964fdaa98ebfc96073d4a6', '4dbc4026e4944f11bae16adcae5b5e26', '475000', null, '顺河回族区', '03', '顺河回族区', '410203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f06a2f03ee7d41089c655ca666e0942f', '4dbc4026e4944f11bae16adcae5b5e26', '475000', null, '鼓楼区', '04', '鼓楼区', '410204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c887084caf3042468c1db31b57c009b9', '4dbc4026e4944f11bae16adcae5b5e26', '475000', null, '禹王台区', '05', '禹王台区', '410205', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9aab3fbe3b81430cab7980ee84f04e5d', '4dbc4026e4944f11bae16adcae5b5e26', '475000', null, '郊区', '11', '郊区', '410211', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9b2898dd5c9d4257ae7ec72a0b7181fb', '4dbc4026e4944f11bae16adcae5b5e26', '475200', null, '杞县', '21', '杞县', '410221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ac240726fee74e2697dce860c2879932', '4dbc4026e4944f11bae16adcae5b5e26', '452200', null, '通许县', '22', '通许县', '410222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fe940ce9a6ae4eb5aff0da5bd0792bd2', '4dbc4026e4944f11bae16adcae5b5e26', '452100', null, '尉氏县', '23', '尉氏县', '410223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ac5fe03e871b41a1b37c4dd0d408f17f', '4dbc4026e4944f11bae16adcae5b5e26', '475100', null, '开封县', '24', '开封县', '410224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0424e15dbe1d404b9d356ce826e17652', '4dbc4026e4944f11bae16adcae5b5e26', '475300', null, '兰考县', '25', '兰考县', '410225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('37c88e73a77e4536b6678a7828117d59', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471000', null, '市辖区', '01', '市辖区', '410301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('670d229ff0ec452b823fdaa6e9081ecc', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471000', null, '老城区', '02', '老城区', '410302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e6be1ae2fc0448fba19881304aaa8fd1', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471000', null, '西工区', '03', '西工区', '410303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('569ba0f0c137471b9de02d3b21d8c7cc', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471000', null, '廛河回族区', '04', '廛河回族区', '410304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a6b652262b4b4d858bd832d5ec8ae836', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471000', null, '涧西区', '05', '涧西区', '410305', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f4da426078d3470fac3b273877ca4fb9', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471000', null, '吉利区', '06', '吉利区', '410306', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e0f6f29cad2c4087a3e3240a93a5ed38', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471000', null, '洛龙区', '07', '洛龙区', '410307', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7ad84c6bd7644bcd8c020b4e5be6420f', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471100', null, '孟津县', '22', '孟津县', '410322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('933411424296414b8fbb65dcc6968883', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471800', null, '新安县', '23', '新安县', '410323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('44c89197663a45f4ac78f91c0c6ab403', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471500', null, '栾川县', '24', '栾川县', '410324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('74f197d1537c4ef1bb19217bd6092ac7', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471400', null, '嵩县', '25', '嵩县', '410325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f473d74c9a90499ebe1649dbd328000e', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471200', null, '汝阳县', '26', '汝阳县', '410326', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2dd656df64ad4c2e838ff7bb625dcd90', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471600', null, '宜阳县', '27', '宜阳县', '410327', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dcfbd3a4b1be4a9f8c89b8429ffe2b22', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471700', null, '洛宁县', '28', '洛宁县', '410328', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('585c5fbe30464b5c89793b83273c0993', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471300', null, '伊川县', '29', '伊川县', '410329', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7925aa0697734516bc2290333af045f5', 'b62c1ee0eef24fee8b6941a8b36c5a40', '471900', null, '偃师市', '81', '偃师市', '410381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d9af27507f264ffca87bb96202e9e197', '37804a77ddc4428f948d66acea1d5229', '467000', null, '市辖区', '01', '市辖区', '410401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4cc7e98c7b4b4d78a70ad10beebc8377', '37804a77ddc4428f948d66acea1d5229', '467000', null, '新华区', '02', '新华区', '410402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('312adee9bab54dea831632f43f4cafcb', '37804a77ddc4428f948d66acea1d5229', '467000', null, '卫东区', '03', '卫东区', '410403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a016924a05fd45c68afdc788912b0e4d', '37804a77ddc4428f948d66acea1d5229', '467000', null, '石龙区', '04', '石龙区', '410404', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('04a9cb36c9694da2a7676a80c36f5b24', '37804a77ddc4428f948d66acea1d5229', '467000', null, '湛河区', '11', '湛河区', '410411', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('031b2019d55948d6ae0c6441a87244db', '37804a77ddc4428f948d66acea1d5229', '467400', null, '宝丰县', '21', '宝丰县', '410421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cc6f1a9dcd2b4a7cb92207de47fded79', '37804a77ddc4428f948d66acea1d5229', '467200', null, '叶县', '22', '叶县', '410422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c38743421c2241ac943fdbd9a13ffddc', '37804a77ddc4428f948d66acea1d5229', '467300', null, '鲁山县', '23', '鲁山县', '410423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ce15748a0d2e42c08fbdb87df8ea1a98', '37804a77ddc4428f948d66acea1d5229', '467100', null, '郏县', '25', '郏县', '410425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bf3fb5acfb4b4575adfb4ec1d544d8cc', '37804a77ddc4428f948d66acea1d5229', '462500', null, '舞钢市', '81', '舞钢市', '410481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('706f086de9614e04a4ea84de3e25aead', '37804a77ddc4428f948d66acea1d5229', '467500', null, '汝州市', '82', '汝州市', '410482', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1271d34bfa5f44d3a7e25b566f7e001d', '521eaa766608414e800f68a916592753', '455000', null, '市辖区', '01', '市辖区', '410501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('263fe265c11e4b788f2d28009eebca4e', '521eaa766608414e800f68a916592753', '455000', null, '文峰区', '02', '文峰区', '410502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3ff7dee01a64f7a867c5d5b63a059c6', '521eaa766608414e800f68a916592753', '455000', null, '北关区', '03', '北关区', '410503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a3caef56f575459f8c264d1644016d64', '521eaa766608414e800f68a916592753', '455000', null, '殷都区', '05', '殷都区', '410505', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('37139031029f405080ec05c9c434e50f', '521eaa766608414e800f68a916592753', '455000', null, '龙安区', '06', '龙安区', '410506', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0cc212c2e8b64574abdefd86f0f7ec48', '521eaa766608414e800f68a916592753', '455100', null, '安阳县', '22', '安阳县', '410522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0b7c876c53a74140a8d7c1f1f0b74cd9', '521eaa766608414e800f68a916592753', '456150', null, '汤阴县', '23', '汤阴县', '410523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ec74cd6cc08140859e11e7ef617795a9', '521eaa766608414e800f68a916592753', '456400', null, '滑县', '26', '滑县', '410526', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c9e1d521c7ae46f8a1338e702a087dfa', '521eaa766608414e800f68a916592753', '456300', null, '内黄县', '27', '内黄县', '410527', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2098aebeaad14a3c89fdf234de2c4c00', '521eaa766608414e800f68a916592753', '456500', null, '林州市', '81', '林州市', '410581', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('283815eef22d4d28a607fe4cf715a594', '1b78854ef6cb4ca9bed5b981062bc3e5', '458000', null, '市辖区', '01', '市辖区', '410601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('64199bd664f042a593f9d28688117ffa', '1b78854ef6cb4ca9bed5b981062bc3e5', '458000', null, '鹤山区', '02', '鹤山区', '410602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ba25fe4522914aad80a4e5e2f736e67b', '1b78854ef6cb4ca9bed5b981062bc3e5', '458000', null, '山城区', '03', '山城区', '410603', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a186e3d4301244b29190873e6d28418e', '1b78854ef6cb4ca9bed5b981062bc3e5', '458000', null, '淇滨区', '11', '淇滨区', '410611', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4fc7b75872e34fd8a302a5c83ee7e789', '1b78854ef6cb4ca9bed5b981062bc3e5', '456250', null, '浚县', '21', '浚县', '410621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('512e0819f6834fad9f0fd49ff062c375', '1b78854ef6cb4ca9bed5b981062bc3e5', '456750', null, '淇县', '22', '淇县', '410622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7fb2ff8d3a6143f1a345066ace3a1c1c', '495e8497aed747bf8741de8bd42abaf7', '422500', null, '城步苗族自治县', '29', '城步苗族自治县', '430529', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c3d94cdbd95b4b40944a4e7af8ef267d', '495e8497aed747bf8741de8bd42abaf7', '422400', null, '武冈市', '81', '武冈市', '430581', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('03b3d0a451304f279b25453de0d51d72', '59e5792ffdab44c184a9d653b6be2928', '414000', null, '市辖区', '01', '市辖区', '430601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5c35a0c05fc2495baaa973d69b45da2c', '59e5792ffdab44c184a9d653b6be2928', '414000', null, '岳阳楼区', '02', '岳阳楼区', '430602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('23c634ec1ecd4401b67ed7c620f33624', '59e5792ffdab44c184a9d653b6be2928', '414000', null, '云溪区', '03', '云溪区', '430603', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dde95b98b5544bc38a7e1be8a099aa38', '59e5792ffdab44c184a9d653b6be2928', '414000', null, '君山区', '11', '君山区', '430611', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cd23408b555b449195e49b7450772a4c', '59e5792ffdab44c184a9d653b6be2928', '414100', null, '岳阳县', '21', '岳阳县', '430621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('60e85b208ae14c568e527a28b0569d85', '59e5792ffdab44c184a9d653b6be2928', '414200', null, '华容县', '23', '华容县', '430623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ebc7ddfa3c614b90a052b5288e0bdedf', '59e5792ffdab44c184a9d653b6be2928', '410500', null, '湘阴县', '24', '湘阴县', '430624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4a2fdffd95124281a09a193d28d10f1f', '59e5792ffdab44c184a9d653b6be2928', '410400', null, '平江县', '26', '平江县', '430626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3505c1c06bcd4c68bee494f19c706d9a', '59e5792ffdab44c184a9d653b6be2928', '414400', null, '汨罗市', '81', '汨罗市', '430681', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a31206f6102e473a82613e594c5a7122', '59e5792ffdab44c184a9d653b6be2928', '414300', null, '临湘市', '82', '临湘市', '430682', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a37178ab338b457db03ce41cf800c3c4', '3d3589d39ff2453ba5f0cfc69cb129e5', '415000', null, '市辖区', '01', '市辖区', '430701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4dd2a023760a4b10a71a8ee009e0f368', '3d3589d39ff2453ba5f0cfc69cb129e5', '415000', null, '武陵区', '02', '武陵区', '430702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('444eb73a01ed46dbaab4debdbee0ed5f', '3d3589d39ff2453ba5f0cfc69cb129e5', '415100', null, '鼎城区', '03', '鼎城区', '430703', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('96652bfca27b49168ce02524824aa9e4', '3d3589d39ff2453ba5f0cfc69cb129e5', '415600', null, '安乡县', '21', '安乡县', '430721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c1ec170b4b144c0594e5e388aef60432', '3d3589d39ff2453ba5f0cfc69cb129e5', '415900', null, '汉寿县', '22', '汉寿县', '430722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5faaa5e9813c4623ab12def5047ba66d', '3d3589d39ff2453ba5f0cfc69cb129e5', '415500', null, '澧县', '23', '澧县', '430723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b18cf74914e94616ad309b3dabf949fd', '3d3589d39ff2453ba5f0cfc69cb129e5', '415200', null, '临澧县', '24', '临澧县', '430724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('01a10dfd67cc47c682d47a67c19b0d10', '3d3589d39ff2453ba5f0cfc69cb129e5', '415700', null, '桃源县', '25', '桃源县', '430725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7258c671e29d41a1ac52010fab8a4700', '3d3589d39ff2453ba5f0cfc69cb129e5', '415300', null, '石门县', '26', '石门县', '430726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6721acb12c6343538cb7cb12b3768730', '3d3589d39ff2453ba5f0cfc69cb129e5', '415400', null, '津市市', '81', '津市市', '430781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('42ec076f0dca4b10a5952d1df151f7f8', '0f4a3711d5f4424aabfb4f4be55050da', '427000', null, '市辖区', '01', '市辖区', '430801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('91a892dca08d4735a35204fe2defbce6', '0f4a3711d5f4424aabfb4f4be55050da', '427000', null, '永定区', '02', '永定区', '430802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('530b1a25b8a64988971dcc98008a279e', '0f4a3711d5f4424aabfb4f4be55050da', '427400', null, '武陵源区', '11', '武陵源区', '430811', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d5cc67161c87418385f16f50b6b7261d', '0f4a3711d5f4424aabfb4f4be55050da', '427200', null, '慈利县', '21', '慈利县', '430821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aefb63bd86f94d079dcf94b764d1c719', '0f4a3711d5f4424aabfb4f4be55050da', '427100', null, '桑植县', '22', '桑植县', '430822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('12ed7b69eeab49f993d40889d2df2b8b', '4ebefadf49c442bb86cd3047a05b1859', '413000', null, '市辖区', '01', '市辖区', '430901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('15976c0fbfcd4021bafa1a140a012a4f', '4ebefadf49c442bb86cd3047a05b1859', '413000', null, '资阳区', '02', '资阳区', '430902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1cfdbabc9bac4b92b83f71ba33549a14', '4ebefadf49c442bb86cd3047a05b1859', '413000', null, '赫山区', '03', '赫山区', '430903', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0486c9748b6e4b3aa4e51edf20f5e8ff', '4ebefadf49c442bb86cd3047a05b1859', '413200', null, '南县', '21', '南县', '430921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a21aaf13aa8a4d129e964614f99c5b67', '4ebefadf49c442bb86cd3047a05b1859', '413400', null, '桃江县', '22', '桃江县', '430922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a8cc00950427406cae5ebf8dd36a1f78', '4ebefadf49c442bb86cd3047a05b1859', '413500', null, '安化县', '23', '安化县', '430923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('138edd2ceeca471987345ea912cd2b41', '4ebefadf49c442bb86cd3047a05b1859', '413100', null, '沅江市', '81', '沅江市', '430981', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e228467a2d624ebea81dee8c0b3be8c3', '73cb965eec364b56bd1f37da06615a45', '423000', null, '市辖区', '01', '市辖区', '431001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('131429f0572145c7abed6b0262190019', '73cb965eec364b56bd1f37da06615a45', '423000', null, '北湖区', '02', '北湖区', '431002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('502e74582dd549e88dab443bb2384c6a', '73cb965eec364b56bd1f37da06615a45', '423000', null, '苏仙区', '03', '苏仙区', '431003', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5e90e3f358194d2684684dfc5ed967d1', '73cb965eec364b56bd1f37da06615a45', '424400', null, '桂阳县', '21', '桂阳县', '431021', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('38296517a2134486afa3156926c706e0', '73cb965eec364b56bd1f37da06615a45', '424200', null, '宜章县', '22', '宜章县', '431022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('58c6b0ed0d0b4e0286ff171ab5c599ea', '73cb965eec364b56bd1f37da06615a45', '423300', null, '永兴县', '23', '永兴县', '431023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('48f09f6180e9485f9275041ba6895df4', '73cb965eec364b56bd1f37da06615a45', '424500', null, '嘉禾县', '24', '嘉禾县', '431024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('edd5d19c4d114fd683554d11b7452e77', '73cb965eec364b56bd1f37da06615a45', '424300', null, '临武县', '25', '临武县', '431025', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2303a6c2043541e4ab3701693b61b01b', '73cb965eec364b56bd1f37da06615a45', '424100', null, '汝城县', '26', '汝城县', '431026', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2afb795ae7d4458ea6a06b473f3fae2d', '73cb965eec364b56bd1f37da06615a45', '423500', null, '桂东县', '27', '桂东县', '431027', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ee5d0607ecff4f8498a155e693826412', '73cb965eec364b56bd1f37da06615a45', '423600', null, '安仁县', '28', '安仁县', '431028', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d936c19c049d41e2ad9d6578d134e61b', '73cb965eec364b56bd1f37da06615a45', '423400', null, '资兴市', '81', '资兴市', '431081', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2952dbccedec40a7be58df6cbb174831', '405b1da4465e49088c798360db70c15b', '624100', null, '金川县', '26', '金川县', '513226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c4d97d245fa04875a8afc58cab8929e9', '82170bdd8f344d218a4c5ac36f7ecba1', '721200', null, '陇县', '27', '陇县', '610327', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d7fe88a69adc423eb7a640cee492272f', '82170bdd8f344d218a4c5ac36f7ecba1', '721100', null, '千阳县', '28', '千阳县', '610328', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eb6e957fb3d945838fe188f5fa3c68ce', '82170bdd8f344d218a4c5ac36f7ecba1', '721500', null, '麟游县', '29', '麟游县', '610329', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('370dab2663ea46a18a1b4a80bcf60c88', '82170bdd8f344d218a4c5ac36f7ecba1', '721700', null, '凤县', '30', '凤县', '610330', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('87277a45425f49b7978f9712b7315c8f', '82170bdd8f344d218a4c5ac36f7ecba1', '721600', null, '太白县', '31', '太白县', '610331', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3057303699cb4dc2ba30839e23ba8b32', 'a32c87dbe139417e9453b255f5e8245e', '712000', null, '市辖区', '01', '市辖区', '610401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bd36689fbe944c48ae0bf8d38763fa0b', 'a32c87dbe139417e9453b255f5e8245e', '712000', null, '秦都区', '02', '秦都区', '610402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('52399af1578c46d7a2a6109e9e15b072', 'a32c87dbe139417e9453b255f5e8245e', '712000', null, '杨凌区', '03', '杨凌区', '610403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('093b0dd2133b45048e31e54365db5b0b', 'a32c87dbe139417e9453b255f5e8245e', '712000', null, '渭城区', '04', '渭城区', '610404', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f18459a7a7d2440ea27c8910e8433c2d', 'a32c87dbe139417e9453b255f5e8245e', '713800', null, '三原县', '22', '三原县', '610422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('66991039c6f441e5ab26ba36c2411769', 'a32c87dbe139417e9453b255f5e8245e', '713700', null, '泾阳县', '23', '泾阳县', '610423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('29253a814c27478eb905b85fe5ed93d4', 'a32c87dbe139417e9453b255f5e8245e', '713300', null, '乾县', '24', '乾县', '610424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f9e73b5270a04492bff11733cfa0cf55', 'a32c87dbe139417e9453b255f5e8245e', '713200', null, '礼泉县', '25', '礼泉县', '610425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('869687060a3c425fbc49e885a37a7459', 'a32c87dbe139417e9453b255f5e8245e', '713400', null, '永寿县', '26', '永寿县', '610426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('179eb8c378b647209f3be7f0149ee22b', 'a32c87dbe139417e9453b255f5e8245e', '713500', null, '彬县', '27', '彬县', '610427', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7573f965eaf24ceaa550b8be7f4b9d4c', 'a32c87dbe139417e9453b255f5e8245e', '713600', null, '长武县', '28', '长武县', '610428', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d939ad8d911149de930ee9566a44cd84', 'a32c87dbe139417e9453b255f5e8245e', '711300', null, '旬邑县', '29', '旬邑县', '610429', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d0b608cffd5243d2ae019f98fc77552c', 'a32c87dbe139417e9453b255f5e8245e', '711200', null, '淳化县', '30', '淳化县', '610430', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a1f23be08c92409a8b00cb37ed357663', 'a32c87dbe139417e9453b255f5e8245e', '712200', null, '武功县', '31', '武功县', '610431', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eacf6b46ffcb48468c2e71cff101848d', 'a32c87dbe139417e9453b255f5e8245e', '713100', null, '兴平市', '81', '兴平市', '610481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('299de3ac762345ab9a65f21e9f917ea8', '1c33dae1d58144d9b2fa688784875771', '714000', null, '市辖区', '01', '市辖区', '610501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('546b3f9f08394750a273040296bcdb55', '1c33dae1d58144d9b2fa688784875771', '714000', null, '临渭区', '02', '临渭区', '610502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3070cbe345ab45e685db5f6cc29b4ab5', '1c33dae1d58144d9b2fa688784875771', '714100', null, '华县', '21', '华县', '610521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('baefd8c799fb496ca047168f6f339df1', '9ade5d5a68fb4caca8f084aee72998ce', '813300', null, '兴海县', '24', '兴海县', '632524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('19900fac175e42fd8a592e14e4a135b3', '9ade5d5a68fb4caca8f084aee72998ce', '813100', null, '贵南县', '25', '贵南县', '632525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('138b579c0ac84049b070ac7dc8037596', '7a81f15f33a24260be9be6bd5c899858', '814000', null, '玛沁县', '21', '玛沁县', '632621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a997e3d434c743a7be9ab582a9651f1e', '7a81f15f33a24260be9be6bd5c899858', '814300', null, '班玛县', '22', '班玛县', '632622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9f7ef8043a734592b5c22cd6180da407', '7a81f15f33a24260be9be6bd5c899858', '814100', null, '甘德县', '23', '甘德县', '632623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f37e762ef19f487e9af6d589cbe201d4', '7a81f15f33a24260be9be6bd5c899858', '814200', null, '达日县', '24', '达日县', '632624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('be279b8b30dd4ad58b17aacaa4b71c60', '7a81f15f33a24260be9be6bd5c899858', '624700', null, '久治县', '25', '久治县', '632625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('26c7afa1232b497cbd3f7af049f7ee22', '7a81f15f33a24260be9be6bd5c899858', '813500', null, '玛多县', '26', '玛多县', '632626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('03ea1b303c4f4e1097816c14db56cf1e', 'dc53af9d04744ee0a57c7d0bbdf69f22', '815000', null, '玉树县', '21', '玉树县', '632721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('72f0721e7a8c4e608d7e7196d4cf2154', 'dc53af9d04744ee0a57c7d0bbdf69f22', '815300', null, '杂多县', '22', '杂多县', '632722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2a00b37a5bc44a9bbabb9fd9c51fa395', 'dc53af9d04744ee0a57c7d0bbdf69f22', '815100', null, '称多县', '23', '称多县', '632723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('db5bec182cd04939a9b5ac6d8eb181aa', 'dc53af9d04744ee0a57c7d0bbdf69f22', '815400', null, '治多县', '24', '治多县', '632724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c8743ca7a4d44b579b1ecb7ff0224394', 'dc53af9d04744ee0a57c7d0bbdf69f22', '815200', null, '囊谦县', '25', '囊谦县', '632725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('599600d515dd40fe8332ee3c2e37efae', 'dc53af9d04744ee0a57c7d0bbdf69f22', '815500', null, '曲麻莱县', '26', '曲麻莱县', '632726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e562ae8efbac405e9611ccad35f1cab0', 'dcd38da0a0c847798551ec50c280dab0', '816000', null, '格尔木市', '01', '格尔木市', '632801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9686408239fc4129aa92462dccd2b3fe', 'dcd38da0a0c847798551ec50c280dab0', '817000', null, '德令哈市', '02', '德令哈市', '632802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('04c587f680a14669b87320adcd511bfe', 'dcd38da0a0c847798551ec50c280dab0', '817100', null, '乌兰县', '21', '乌兰县', '632821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a6a39d85883449fc81fc4ea95039bdf2', 'dcd38da0a0c847798551ec50c280dab0', '816100', null, '都兰县', '22', '都兰县', '632822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c5935a8ad67b42b3ac8de2c55d7b064d', 'dcd38da0a0c847798551ec50c280dab0', '817200', null, '天峻县', '23', '天峻县', '632823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f6cc39d3140b4c928d3adb482c22ab24', '70c6e0c0b2e0451f99b6b8986f13ca07', '750000', null, '市辖区', '01', '市辖区', '640101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('910218ffdce945c4b3190cb9ac509887', '70c6e0c0b2e0451f99b6b8986f13ca07', '750000', null, '兴庆区', '04', '兴庆区', '640104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c661610a8d1a491d82a29fd5a238c221', '70c6e0c0b2e0451f99b6b8986f13ca07', '750000', null, '西夏区', '05', '西夏区', '640105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d479d0862e334ecba4472420f6e0ec6a', '70c6e0c0b2e0451f99b6b8986f13ca07', '750000', null, '金凤区', '06', '金凤区', '640106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a5752d7f300848a282f6c35766da1855', '70c6e0c0b2e0451f99b6b8986f13ca07', '750100', null, '永宁县', '21', '永宁县', '640121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('75e872944871493dbd3833a4ce1541ac', '70c6e0c0b2e0451f99b6b8986f13ca07', '750200', null, '贺兰县', '22', '贺兰县', '640122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b393e4665f3f46bb9d91c84bd47a3d95', '70c6e0c0b2e0451f99b6b8986f13ca07', '751400', null, '灵武市', '81', '灵武市', '640181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c78daf531ae8482db39055e722550a54', 'd211795dd1e6415294416b8d85e1ca3d', '753000', null, '市辖区', '01', '市辖区', '640201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ca9542ffebf6460685613745898fb7ca', 'd211795dd1e6415294416b8d85e1ca3d', '753000', null, '大武口区', '02', '大武口区', '640202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5e690f55e4e441988e0f04963c3926f3', 'd211795dd1e6415294416b8d85e1ca3d', '753600', null, '惠农区', '05', '惠农区', '640205', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('239706a272724112b5175121439c3802', 'd211795dd1e6415294416b8d85e1ca3d', '753400', null, '平罗县', '21', '平罗县', '640221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('348da6768fb143d1ac7b6afd52ec8939', 'c12b062dc20e422ca8b66e9578738b74', '751100', null, '市辖区', '01', '市辖区', '640301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('01308dcce5824a90b66898b2937f6972', 'c12b062dc20e422ca8b66e9578738b74', '751100', null, '利通区', '02', '利通区', '640302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8fb2c3e61fcc43f3b82876d32d9ca70f', 'c12b062dc20e422ca8b66e9578738b74', '751500', null, '盐池县', '23', '盐池县', '640323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ecc0f38403e042e484399400ca6e56d3', 'c12b062dc20e422ca8b66e9578738b74', '751300', null, '同心县', '24', '同心县', '640324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('28947a68d06044a5ad771ef502dda3c5', 'c12b062dc20e422ca8b66e9578738b74', '751600', null, '青铜峡市', '81', '青铜峡市', '640381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('21b2e738721e4a1c954bf62970b5f123', '48a58b66b9394f1aa364c352ba1da9d3', '756000', null, '市辖区', '01', '市辖区', '640401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('efdec66b2c474637bf5298236d8b8ac2', '48a58b66b9394f1aa364c352ba1da9d3', '756000', null, '原州区', '02', '原州区', '640402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb15e44c0755497b97a05859d2f10f5f', '48a58b66b9394f1aa364c352ba1da9d3', '756200', null, '西吉县', '22', '西吉县', '640422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8d5a5d5ceaff45bcbfd2e19cecacb4b8', '48a58b66b9394f1aa364c352ba1da9d3', '756300', null, '隆德县', '23', '隆德县', '640423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9c240d2ef2f8488cbd8520884eee9e26', '3f166d4baf12434eb102caddab35da47', '735000', null, '市辖区', '01', '市辖区', '620901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8cb42acacc1043a5a10a2bc38af76e34', '3f166d4baf12434eb102caddab35da47', '735000', null, '肃州区', '02', '肃州区', '620902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eb215ca9273e4eacb29bcf047a09383d', '3f166d4baf12434eb102caddab35da47', '735300', null, '金塔县', '21', '金塔县', '620921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('56d428fb84ea469db217106caf502981', '3f166d4baf12434eb102caddab35da47', '736100', null, '安西县', '22', '安西县', '620922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9cbabc3391154396a36f036a1654e748', '3f166d4baf12434eb102caddab35da47', '736400', null, '阿克塞哈萨克族自治县', '24', '阿克塞哈萨克族自治县', '620924', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('22b0a4b302864a4dadda6ac7d8a9b935', '3f166d4baf12434eb102caddab35da47', '735200', null, '玉门市', '81', '玉门市', '620981', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3220baceed8c44c8b236ef0af13bb24c', '3f166d4baf12434eb102caddab35da47', '736200', null, '敦煌市', '82', '敦煌市', '620982', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('311d354f87834f3e98c8f31d71d537bf', '1c075e3ccaa749859d5b0cecef73e511', '745000', null, '市辖区', '01', '市辖区', '621001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a32a410d86d44464be8862c35d7dc8a1', '1c075e3ccaa749859d5b0cecef73e511', '745000', null, '西峰区', '02', '西峰区', '621002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1856831e97c048558c9283477e4ce325', '1c075e3ccaa749859d5b0cecef73e511', '745000', null, '庆城县', '21', '庆城县', '621021', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0127a908afab481eb25900ebf797dfe9', '1c075e3ccaa749859d5b0cecef73e511', '745700', null, '环县', '22', '环县', '621022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d89948a85fa042609c6bac0fe448ed26', '1c075e3ccaa749859d5b0cecef73e511', '745600', null, '华池县', '23', '华池县', '621023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3b5cf6d4295f404780b5c768a42d0b8b', '1c075e3ccaa749859d5b0cecef73e511', '745400', null, '合水县', '24', '合水县', '621024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('00695854797846d9950e3b5a6997e3b3', '1c075e3ccaa749859d5b0cecef73e511', '745300', null, '正宁县', '25', '正宁县', '621025', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d42875f0180c487fbaa1a386d264d036', '1c075e3ccaa749859d5b0cecef73e511', '745200', null, '宁县', '26', '宁县', '621026', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9d74f731d471488692952f33a066fa45', '1c075e3ccaa749859d5b0cecef73e511', '744500', null, '镇原县', '27', '镇原县', '621027', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1b5d8797ea4043278b64270c6679620d', '624e4398f3b2409cbbda688316142235', '743000', null, '市辖区', '01', '市辖区', '621101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9c626dd30da84052b7f4abf76b908f2e', '624e4398f3b2409cbbda688316142235', '743000', null, '安定区', '02', '安定区', '621102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cad2e01eaf864803b17375bc84367ca0', '624e4398f3b2409cbbda688316142235', '743300', null, '通渭县', '21', '通渭县', '621121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('40c21d6cb65c4de693a2f18577787e10', '624e4398f3b2409cbbda688316142235', '748100', null, '陇西县', '22', '陇西县', '621122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('971f2a3057c645ea8c3342a69923075c', '624e4398f3b2409cbbda688316142235', '748200', null, '渭源县', '23', '渭源县', '621123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9d7af5d80f15422ea0edd09dc7484547', '624e4398f3b2409cbbda688316142235', '730500', null, '临洮县', '24', '临洮县', '621124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ab4fa889f7014fb1aea6798236453c38', '624e4398f3b2409cbbda688316142235', '748300', null, '漳县', '25', '漳县', '621125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('26446177ee6a4e5d90c34bb959eafab9', '624e4398f3b2409cbbda688316142235', '748400', null, '岷县', '26', '岷县', '621126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('42f02db10c3543e2a2975fd69e40fc6c', '4032edf9271c4bb8868553b88b39f0a8', '746000', null, '市辖区', '01', '市辖区', '621201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0ea3602d0a04497e9d75b18dff91f920', '4032edf9271c4bb8868553b88b39f0a8', '746000', null, '武都区', '02', '武都区', '621202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('505cb761b9224ef0b8ce936c9659fa6d', '4032edf9271c4bb8868553b88b39f0a8', '742500', null, '成县', '21', '成县', '621221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('256465abcec9432899e3105202ef1c5e', '4032edf9271c4bb8868553b88b39f0a8', '746400', null, '文县', '22', '文县', '621222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('72e7bb3fa34d4cb5a67a7f5a3debd5c9', '4032edf9271c4bb8868553b88b39f0a8', '748500', null, '宕昌县', '23', '宕昌县', '621223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f93aebab28e549f9bfb038ad9f27abf1', '4032edf9271c4bb8868553b88b39f0a8', '746500', null, '康县', '24', '康县', '621224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('758df5fe692848e7880c208c3295704e', '4032edf9271c4bb8868553b88b39f0a8', '742100', null, '西和县', '25', '西和县', '621225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('07ae07189da24553b2e416c8b3ba1103', '1c33dae1d58144d9b2fa688784875771', '714300', null, '潼关县', '22', '潼关县', '610522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c573fbb3163e41d1bcb7fedfac4ba34d', '1c33dae1d58144d9b2fa688784875771', '715100', null, '大荔县', '23', '大荔县', '610523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a4ae2bf113dc484dbbd77a549dac68b5', '1c33dae1d58144d9b2fa688784875771', '715300', null, '合阳县', '24', '合阳县', '610524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('84806c627fa04f119dd891759aa1123b', '1c33dae1d58144d9b2fa688784875771', '715200', null, '澄城县', '25', '澄城县', '610525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a2c023433c8f45f484c157528874b11b', '1c33dae1d58144d9b2fa688784875771', '715500', null, '蒲城县', '26', '蒲城县', '610526', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d68d23c9c07d43e9b5db5f85ca23236a', '1c33dae1d58144d9b2fa688784875771', '715600', null, '白水县', '27', '白水县', '610527', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fd5bdde24c7644fa943a724a72b0845b', '1c33dae1d58144d9b2fa688784875771', '711700', null, '富平县', '28', '富平县', '610528', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e622c17c09b47959de9547f8a20e3df', '1c33dae1d58144d9b2fa688784875771', '715400', null, '韩城市', '81', '韩城市', '610581', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dc88dfcbfefe41a5b5fb5f1ea046dd69', '1c33dae1d58144d9b2fa688784875771', '714200', null, '华阴市', '82', '华阴市', '610582', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5999f244872c424a94beeab40981539e', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '716000', null, '市辖区', '01', '市辖区', '610601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('620c86977ef34145973994d96d7610b5', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '716000', null, '宝塔区', '02', '宝塔区', '610602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fd2dacdb1bce4b58a2d74326e261bc1d', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '717100', null, '延长县', '21', '延长县', '610621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6d7f0f2e46e447a7b17feb4a58d760d0', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '717200', null, '延川县', '22', '延川县', '610622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b69af745fcaf43c0a45cecfdaa8800e7', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '717300', null, '子长县', '23', '子长县', '610623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3f0e6983e9f49519ff5b2e33988e565', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '717400', null, '安塞县', '24', '安塞县', '610624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d2c77ea443f249f6b9015570fd939f9d', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '717500', null, '志丹县', '25', '志丹县', '610625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b824dc02163040468a337e2fdeba2038', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '717600', null, '吴旗县', '26', '吴旗县', '610626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('89bab0b08e354aacbbf0b7f6ad8de59f', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '716100', null, '甘泉县', '27', '甘泉县', '610627', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cabf20b58e28438998dd4654cb497abe', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '727500', null, '富县', '28', '富县', '610628', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('777ae6d088574e68bc86f5109ea870af', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '727400', null, '洛川县', '29', '洛川县', '610629', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2e69dab521e44379ae6eaf4701d3ad81', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '716200', null, '宜川县', '30', '宜川县', '610630', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f9256bc9ba704f4ba32ac7243da40448', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '715700', null, '黄龙县', '31', '黄龙县', '610631', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8774828819024a9791cc4fb507c7ba5c', 'a5ab6a40f75e4885a2aa4e6137d9d84d', '727300', null, '黄陵县', '32', '黄陵县', '610632', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('72d6d06a857f444cb9976957710081b3', '626c4abdd9e94c4c86bc68b3da343b20', '723000', null, '市辖区', '01', '市辖区', '610701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cfdb1d0633364f6eb37aa4c67f809ded', '626c4abdd9e94c4c86bc68b3da343b20', '723000', null, '汉台区', '02', '汉台区', '610702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f18fbb210fa4b23a7a32ab60ab02a94', '626c4abdd9e94c4c86bc68b3da343b20', '723100', null, '南郑县', '21', '南郑县', '610721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f5dbee4ae52d4e668c1ee9df39f9d3bf', '626c4abdd9e94c4c86bc68b3da343b20', '723200', null, '城固县', '22', '城固县', '610722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7112c55c8d454b5cb3683ca6943b0e39', '626c4abdd9e94c4c86bc68b3da343b20', '723300', null, '洋县', '23', '洋县', '610723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('70fa44aa28b3459e85949881339cf772', '626c4abdd9e94c4c86bc68b3da343b20', '723500', null, '西乡县', '24', '西乡县', '610724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6989c5b76c6e4971bf46be6b395cfcc1', '626c4abdd9e94c4c86bc68b3da343b20', '724200', null, '勉县', '25', '勉县', '610725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('edb1d18ee040451297316c901f816b85', '626c4abdd9e94c4c86bc68b3da343b20', '724400', null, '宁强县', '26', '宁强县', '610726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb08f627b8f24adaa5323e395f37f52a', '626c4abdd9e94c4c86bc68b3da343b20', '724300', null, '略阳县', '27', '略阳县', '610727', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('438033a585df428a9e8418074eb63b59', '626c4abdd9e94c4c86bc68b3da343b20', '723600', null, '镇巴县', '28', '镇巴县', '610728', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e7380d794cb9476788dfccd91c27c511', '626c4abdd9e94c4c86bc68b3da343b20', '724100', null, '留坝县', '29', '留坝县', '610729', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('507ca86e0b90463194c9bece1c7680f3', '626c4abdd9e94c4c86bc68b3da343b20', '723400', null, '佛坪县', '30', '佛坪县', '610730', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2aa62780e1b34cd680db1f1755945c98', '288c789701ac4bcc8096dd8d85085239', '719000', null, '市辖区', '01', '市辖区', '610801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('06bf79f9e4a24d0fb0d6cfaae6b1a3c0', '288c789701ac4bcc8096dd8d85085239', '719000', null, '榆阳区', '02', '榆阳区', '610802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('74c0fb0fd3de407eae5618e9dab79b67', '288c789701ac4bcc8096dd8d85085239', '719300', null, '神木县', '21', '神木县', '610821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e163f445cd04229b48eee1f029bf03e', '288c789701ac4bcc8096dd8d85085239', '719400', null, '府谷县', '22', '府谷县', '610822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('520742bd5e3e4c08b55f379cab93cba6', '288c789701ac4bcc8096dd8d85085239', '719200', null, '横山县', '23', '横山县', '610823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e8256e93ee0d45cfa06fc23f1841ca24', '288c789701ac4bcc8096dd8d85085239', '718500', null, '靖边县', '24', '靖边县', '610824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e26e0af3d6f84034875ea945b3db649b', '288c789701ac4bcc8096dd8d85085239', '718600', null, '定边县', '25', '定边县', '610825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dfb378e7ebdc460ba017ae424bf3ae4b', '288c789701ac4bcc8096dd8d85085239', '718000', null, '绥德县', '26', '绥德县', '610826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('03a98a896b474fa0997198e7965077ce', '1357e5dfbbf14671863b4ab27f3a49c5', '747100', null, '夏河县', '27', '夏河县', '623027', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1fb79781085a417c9c228223c7cb78bc', '08f84a76863048f9becb8841b144612a', '810000', null, '市辖区', '01', '市辖区', '630101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f8de63ce72aa4c8b818c2864f2196cfc', '08f84a76863048f9becb8841b144612a', '810000', null, '城东区', '02', '城东区', '630102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e2085093da1b4d40a0d13f295e3a94f9', '08f84a76863048f9becb8841b144612a', '810000', null, '城中区', '03', '城中区', '630103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aa75037e861645c3affdec0baa452c4d', '08f84a76863048f9becb8841b144612a', '810000', null, '城西区', '04', '城西区', '630104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('217011b76ac74429b7df5d136cb72138', '08f84a76863048f9becb8841b144612a', '810000', null, '城北区', '05', '城北区', '630105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b4b54a5cc9124bcd8c837d08640d8568', '08f84a76863048f9becb8841b144612a', '810100', null, '大通回族土族自治县', '21', '大通回族土族自治县', '630121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('45ac839d6fdb491e9b4aedff73d2990f', '08f84a76863048f9becb8841b144612a', '811600', null, '湟中县', '22', '湟中县', '630122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c0fda959a99430c9c8d88f732f989c8', '08f84a76863048f9becb8841b144612a', '812100', null, '湟源县', '23', '湟源县', '630123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('68b9bb4fc0b541a5bf6707f3cdce53ea', 'ad6f5e8260eb417b92b45279a5eb6541', '810600', null, '平安县', '21', '平安县', '632121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b54e40e257c8402e9208015e46968a60', 'ad6f5e8260eb417b92b45279a5eb6541', '810800', null, '民和回族土族自治县', '22', '民和回族土族自治县', '632122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2366c5b945e84fdaa3d1029d86bcb4ee', 'ad6f5e8260eb417b92b45279a5eb6541', '810700', null, '乐都县', '23', '乐都县', '632123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fd8837e0461543c1bdce0a5387dc87bf', 'ad6f5e8260eb417b92b45279a5eb6541', '810500', null, '互助土族自治县', '26', '互助土族自治县', '632126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8d1cb4b4e3a448639da6826ff99176fe', 'ad6f5e8260eb417b92b45279a5eb6541', '810900', null, '化隆回族自治县', '27', '化隆回族自治县', '632127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1dc841ed61aa4e2589b6c22487a08443', 'ad6f5e8260eb417b92b45279a5eb6541', '811100', null, '循化撒拉族自治县', '28', '循化撒拉族自治县', '632128', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cea57ed9968e412d9b4854b56279eeaf', 'a74335d4de524feb84872d0b37ad5a91', '810300', null, '门源回族自治县', '21', '门源回族自治县', '632221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2a81d43961f84ec7bbb2c4c643e767bd', 'a74335d4de524feb84872d0b37ad5a91', '810400', null, '祁连县', '22', '祁连县', '632222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2937afa9b9794fb19ad63bf7c1c03d6f', 'a74335d4de524feb84872d0b37ad5a91', '812200', null, '海晏县', '23', '海晏县', '632223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('33dbfb2dc9d8436c9fa65ebc60b5a369', 'a74335d4de524feb84872d0b37ad5a91', '812300', null, '刚察县', '24', '刚察县', '632224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('044db706406247eb966b7e22e157b1b9', 'ee978f1e33d6487199681886cb542a85', '811300', null, '同仁县', '21', '同仁县', '632321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('232d784c759041b8b4b812485b479fdb', 'ee978f1e33d6487199681886cb542a85', '811200', null, '尖扎县', '22', '尖扎县', '632322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fff2cad321c44b2791ebfe938c88d068', 'ee978f1e33d6487199681886cb542a85', '811400', null, '泽库县', '23', '泽库县', '632323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9ddf07f4973c48d5a8971fad40765b57', 'ee978f1e33d6487199681886cb542a85', '811500', null, '河南蒙古族自治县', '24', '河南蒙古族自治县', '632324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e207724805e84846b144291ace28f492', '9ade5d5a68fb4caca8f084aee72998ce', '813000', null, '共和县', '21', '共和县', '632521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f9943aa6a1944bcd97db9895335446fd', '9ade5d5a68fb4caca8f084aee72998ce', '813200', null, '同德县', '22', '同德县', '632522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ebee5cec893549f9826c6055c5f45a2b', '9ade5d5a68fb4caca8f084aee72998ce', '811700', null, '贵德县', '23', '贵德县', '632523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('627fe9850a9e454b84b091cd28f1ebc0', '0685a404d9eb48e69f442f0fecd81238', '453000', null, '市辖区', '01', '市辖区', '410701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cc46dfc69c7c40109ba1eb0939b78900', '0685a404d9eb48e69f442f0fecd81238', '453000', null, '红旗区', '02', '红旗区', '410702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7ccc5bad0c1a44cfa05e134345bc976b', '0685a404d9eb48e69f442f0fecd81238', '453000', null, '卫滨区', '03', '卫滨区', '410703', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c67364f999db49829b778e042b932dda', '0685a404d9eb48e69f442f0fecd81238', '453000', null, '凤泉区', '04', '凤泉区', '410704', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('abcef94beab84801917ca67e9db40196', '0685a404d9eb48e69f442f0fecd81238', '453000', null, '牧野区', '11', '牧野区', '410711', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6bf8183489034839878e018d437461d7', '0685a404d9eb48e69f442f0fecd81238', '453700', null, '新乡县', '21', '新乡县', '410721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f71456b5cb15456881fb693db22c1f0c', '0685a404d9eb48e69f442f0fecd81238', '453800', null, '获嘉县', '24', '获嘉县', '410724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a6e0669420a347fcb60da9302087d994', '0685a404d9eb48e69f442f0fecd81238', '453500', null, '原阳县', '25', '原阳县', '410725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b37759a6223a44828140744086c086ef', '0685a404d9eb48e69f442f0fecd81238', '453200', null, '延津县', '26', '延津县', '410726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f8e36a92cf274fc78cf56b65392f8a5b', '0685a404d9eb48e69f442f0fecd81238', '453300', null, '封丘县', '27', '封丘县', '410727', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e715ead78bc54f6a9697d65fbc4adb02', '0685a404d9eb48e69f442f0fecd81238', '453400', null, '长垣县', '28', '长垣县', '410728', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('43d5332bac1e4ba0a13cce286336ae89', '0685a404d9eb48e69f442f0fecd81238', '453100', null, '卫辉市', '81', '卫辉市', '410781', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('daa43bc0bea24ab8b0cff382021fc3cc', '0685a404d9eb48e69f442f0fecd81238', '453600', null, '辉县市', '82', '辉县市', '410782', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9eaa547b08394f60bc844a1c4f96c27b', '2c262f32b8254b56b1e1468a5812ad71', '454150', null, '市辖区', '01', '市辖区', '410801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0eacb09317b54481b460d8f237df919b', '2c262f32b8254b56b1e1468a5812ad71', '454150', null, '解放区', '02', '解放区', '410802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('12f7140819bf4a7695ea63a58cafcb7b', '2c262f32b8254b56b1e1468a5812ad71', '454150', null, '中站区', '03', '中站区', '410803', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3c2ccb4614514eb9b4311510f77d3a21', '2c262f32b8254b56b1e1468a5812ad71', '454150', null, '马村区', '04', '马村区', '410804', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('52222fb880b4497491782da448a3a4ea', '2c262f32b8254b56b1e1468a5812ad71', '454150', null, '山阳区', '11', '山阳区', '410811', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a378879ec6f546a5bb81822da53494d0', '2c262f32b8254b56b1e1468a5812ad71', '454350', null, '修武县', '21', '修武县', '410821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dd4539b6324647938984b70772a16805', '2c262f32b8254b56b1e1468a5812ad71', '454450', null, '博爱县', '22', '博爱县', '410822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9aad1fc520734dfeade07230a5521012', '2c262f32b8254b56b1e1468a5812ad71', '454950', null, '武陟县', '23', '武陟县', '410823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cad9da9918644880bd8f2d7e33e150cc', '2c262f32b8254b56b1e1468a5812ad71', '454850', null, '温县', '25', '温县', '410825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('21782114652b40ce8a8e472521807d74', '2c262f32b8254b56b1e1468a5812ad71', '454650', null, '济源市', '81', '济源市', '410881', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5b8226c91f2a49af964f39ccb9bf0306', '2c262f32b8254b56b1e1468a5812ad71', '454550', null, '沁阳市', '82', '沁阳市', '410882', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cd5304e4f8394996988db3ad5b4bc139', '2c262f32b8254b56b1e1468a5812ad71', '454750', null, '孟州市', '83', '孟州市', '410883', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ae57b4b4fc7740b3a31b3c0c339a8119', '620533741dd14610b937e008ac996c69', '457000', null, '市辖区', '01', '市辖区', '410901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3e6b484117c24bb4ab7742d36e39a853', '620533741dd14610b937e008ac996c69', '457000', null, '华龙区', '02', '华龙区', '410902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('79b3f9489f43479fa99da95ac09cce16', '620533741dd14610b937e008ac996c69', '457300', null, '清丰县', '22', '清丰县', '410922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2e38dd02adc043e7a972ebe9c0ee5fc5', '620533741dd14610b937e008ac996c69', '457400', null, '南乐县', '23', '南乐县', '410923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e7f1ab4bc01642418d4327ac462063db', '620533741dd14610b937e008ac996c69', '457500', null, '范县', '26', '范县', '410926', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3e21b1e4be264dbc89abebb66c16ae8f', '620533741dd14610b937e008ac996c69', '457600', null, '台前县', '27', '台前县', '410927', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('15230f6c4d9249cfb643fc027e55f6e9', '620533741dd14610b937e008ac996c69', '457100', null, '濮阳县', '28', '濮阳县', '410928', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('defa811077ed4d15bfbced9c1c7c922d', 'a1c30fcc46124323a7742e62970e5e79', '461000', null, '市辖区', '01', '市辖区', '411001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7ff8a0c617f9411095261660f9337dfc', 'a1c30fcc46124323a7742e62970e5e79', '461000', null, '魏都区', '02', '魏都区', '411002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fc0236a7113a4cb4a9735f8af3cdfa69', 'a1c30fcc46124323a7742e62970e5e79', '461100', null, '许昌县', '23', '许昌县', '411023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4e15ab7845144801ae962166acb0b445', 'a1c30fcc46124323a7742e62970e5e79', '461200', null, '鄢陵县', '24', '鄢陵县', '411024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a552d661f5f94165b7dda941d8ceac2f', 'a1c30fcc46124323a7742e62970e5e79', '452670', null, '襄城县', '25', '襄城县', '411025', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ada70f2ecd204fe9b4c082282e1ca603', 'a1c30fcc46124323a7742e62970e5e79', '452570', null, '禹州市', '81', '禹州市', '411081', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('79a2e4c53db1477695fd108e468820b3', 'a1c30fcc46124323a7742e62970e5e79', '461500', null, '长葛市', '82', '长葛市', '411082', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bba096d481114274b425854b9d18b956', '318e394e38bd4bd38a60562a064fac5d', '462000', null, '市辖区', '01', '市辖区', '411101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ad5a4f58413f4b6a846c43c67eec8408', '318e394e38bd4bd38a60562a064fac5d', '462000', null, '源汇区', '02', '源汇区', '411102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b02a7b5359bf4bd0bbb781e2d32288b0', '318e394e38bd4bd38a60562a064fac5d', '462300', null, '郾城区', '03', '郾城区', '411103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a69eca3092d84095b4450a5bce2a832c', '318e394e38bd4bd38a60562a064fac5d', '462300', null, '召陵区', '04', '召陵区', '411104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3e390e5f35e47f1aa017cbd618841da', '318e394e38bd4bd38a60562a064fac5d', '462400', null, '舞阳县', '21', '舞阳县', '411121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d1794da7fe9741468fe5be119c040a60', '318e394e38bd4bd38a60562a064fac5d', '462600', null, '临颍县', '22', '临颍县', '411122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('59750b3c878a4e4ab42466bef9db8ed2', '1d21c167dbe048d7942a636ec4ce172c', '472000', null, '市辖区', '01', '市辖区', '411201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('82866d9cbf08443fa0ee69ea0d7aa58f', '1d21c167dbe048d7942a636ec4ce172c', '472000', null, '湖滨区', '02', '湖滨区', '411202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5007ea79f0aa49f8b5e2fcd3e63f42f2', '1d21c167dbe048d7942a636ec4ce172c', '472400', null, '渑池县', '21', '渑池县', '411221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('927b23ea3d6f4ee68262a5748774b874', '1d21c167dbe048d7942a636ec4ce172c', '472100', null, '陕县', '22', '陕县', '411222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('51787a5dc3e24b29b6d113026be770e4', '1d21c167dbe048d7942a636ec4ce172c', '472200', null, '卢氏县', '24', '卢氏县', '411224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('efd151bf7419434a86263e3c5b378f1d', '42ed28a2d2cf4a0ab128fdba1486ba90', '516800', null, '龙门县', '24', '龙门县', '441324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cd11bda891ee449782078244bfe3390c', 'ab33919c65c7421e95b62e88c00a809e', '514000', null, '市辖区', '01', '市辖区', '441401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b523577fc12d441da50791f6b0b587ac', 'ab33919c65c7421e95b62e88c00a809e', '514000', null, '梅江区', '02', '梅江区', '441402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3049b8ea346b4c7eaa93bfaf21c732e0', 'ab33919c65c7421e95b62e88c00a809e', '514700', null, '梅县', '21', '梅县', '441421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('230acb8648e74633bff10551cc323b21', 'ab33919c65c7421e95b62e88c00a809e', '514200', null, '大埔县', '22', '大埔县', '441422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fd6ec3535f2b4c79b1e0b49e07471e14', 'ab33919c65c7421e95b62e88c00a809e', '514300', null, '丰顺县', '23', '丰顺县', '441423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b9c1b5a33c634b66a41d957d448e3b0d', 'ab33919c65c7421e95b62e88c00a809e', '514400', null, '五华县', '24', '五华县', '441424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('40cd67310d3849e7a30fa425c9fd7d10', 'ab33919c65c7421e95b62e88c00a809e', '514600', null, '平远县', '26', '平远县', '441426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0a991977c0134d8e805b9a881f2fa651', 'e16c41e4d0b5480786a44c95e8fc7a5c', '473200', null, '方城县', '22', '方城县', '411322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d1afb5a8b7664c46b1ee0cbb81f4dd50', 'e16c41e4d0b5480786a44c95e8fc7a5c', '474550', null, '西峡县', '23', '西峡县', '411323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('67a20c140f034572a07f49d64eb1db23', 'e16c41e4d0b5480786a44c95e8fc7a5c', '474250', null, '镇平县', '24', '镇平县', '411324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5d6f32efd081471d80b6f708b5456b9d', 'e16c41e4d0b5480786a44c95e8fc7a5c', '474350', null, '内乡县', '25', '内乡县', '411325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3c852d5611b64704ad146504e9756bc3', 'e16c41e4d0b5480786a44c95e8fc7a5c', '474450', null, '淅川县', '26', '淅川县', '411326', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a20ba80813094c9fba76ffd912a04443', 'e16c41e4d0b5480786a44c95e8fc7a5c', '473300', null, '社旗县', '27', '社旗县', '411327', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('06f6842f262d4a30a0d2f54e4bae0fe2', 'e16c41e4d0b5480786a44c95e8fc7a5c', '473400', null, '唐河县', '28', '唐河县', '411328', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d5d5628d742a4576830ce6081348f599', 'e16c41e4d0b5480786a44c95e8fc7a5c', '473500', null, '新野县', '29', '新野县', '411329', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3cde7daccc964542b5930bde9e9b78ff', 'e16c41e4d0b5480786a44c95e8fc7a5c', '474750', null, '桐柏县', '30', '桐柏县', '411330', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('11c4330b93404e728a1431ee160a2292', 'e16c41e4d0b5480786a44c95e8fc7a5c', '474150', null, '邓州市', '81', '邓州市', '411381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e831ea3c03a741718d0309aa36525c36', '815767f8485d4636acbaa4eae0b5234c', '476000', null, '市辖区', '01', '市辖区', '411401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb9b31da120e48818e9b2f407332d0b3', '815767f8485d4636acbaa4eae0b5234c', '476000', null, '梁园区', '02', '梁园区', '411402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c510bd2c6bc94b2a92e837b178496c42', '815767f8485d4636acbaa4eae0b5234c', '476000', null, '睢阳区', '03', '睢阳区', '411403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c171b2c802c542eaa367d85344a16c37', '815767f8485d4636acbaa4eae0b5234c', '476800', null, '民权县', '21', '民权县', '411421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('874a01cd196d483c95d60443735c1ab1', '815767f8485d4636acbaa4eae0b5234c', '476900', null, '睢县', '22', '睢县', '411422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d7077cb35114c01982ff6df92e94c8c', '815767f8485d4636acbaa4eae0b5234c', '476700', null, '宁陵县', '23', '宁陵县', '411423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('692a90b6c42a4ed591428efa28cc5c4e', '815767f8485d4636acbaa4eae0b5234c', '476200', null, '柘城县', '24', '柘城县', '411424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('66c16a07d55a4f869538f469365bd769', '815767f8485d4636acbaa4eae0b5234c', '476300', null, '虞城县', '25', '虞城县', '411425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5d117edc799b4823a7e6e279d048cb41', '815767f8485d4636acbaa4eae0b5234c', '476400', null, '夏邑县', '26', '夏邑县', '411426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cd14213e5a904adf910fc5ea73efb372', '815767f8485d4636acbaa4eae0b5234c', '476600', null, '永城市', '81', '永城市', '411481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6d0d4a2d8370449f8385a0c59f7970d1', '380f7b3b49a44eae82cfa793b89dbb92', '464000', null, '市辖区', '01', '市辖区', '411501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2cac7b6d987241a0b0e8a2b37bc7d913', '380f7b3b49a44eae82cfa793b89dbb92', '464000', null, '浉河区', '02', '浉河区', '411502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c83362172fad4a3b8b61413b0352a40e', '380f7b3b49a44eae82cfa793b89dbb92', '464000', null, '平桥区', '03', '平桥区', '411503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9da6e36704fe41e4aa7937489f9f313b', '380f7b3b49a44eae82cfa793b89dbb92', '464200', null, '罗山县', '21', '罗山县', '411521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7d7cbb09313f479da1b52c26e8b01c92', '380f7b3b49a44eae82cfa793b89dbb92', '465450', null, '光山县', '22', '光山县', '411522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3585c8ecd9f44cafb7a30e29737f5db3', '380f7b3b49a44eae82cfa793b89dbb92', '465500', null, '新县', '23', '新县', '411523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eb5ad59d88394b6f8fe16b4407ffd175', '380f7b3b49a44eae82cfa793b89dbb92', '465350', null, '商城县', '24', '商城县', '411524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fdc243529d5d4a4f9dfed588297d3644', '380f7b3b49a44eae82cfa793b89dbb92', '465200', null, '固始县', '25', '固始县', '411525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8b1095bb0eb7489bae13755ee0ed6446', '380f7b3b49a44eae82cfa793b89dbb92', '465150', null, '潢川县', '26', '潢川县', '411526', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5538bdb7e5154b92843f7ff31c0ae25f', '380f7b3b49a44eae82cfa793b89dbb92', '464400', null, '淮滨县', '27', '淮滨县', '411527', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ad9e362c8a9645d8bc208b7d6e33a83a', '380f7b3b49a44eae82cfa793b89dbb92', '464300', null, '息县', '28', '息县', '411528', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2a50082f2f274fa695b3ed19322ed210', '78e3f9f0494b42a789f858385a476d44', '466000', null, '市辖区', '01', '市辖区', '411601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('36bd86d061fa4dd0a86bd3dde506b232', '78e3f9f0494b42a789f858385a476d44', '466000', null, '川汇区', '02', '川汇区', '411602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('674b2662846d481e90b51ef443a7ad3b', '78e3f9f0494b42a789f858385a476d44', '461300', null, '扶沟县', '21', '扶沟县', '411621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ddda97e4d22d43a9aa98ad5d23b9a5b3', '78e3f9f0494b42a789f858385a476d44', '466600', null, '西华县', '22', '西华县', '411622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('64aeada02ee3430ab560c3c094c55d24', '78e3f9f0494b42a789f858385a476d44', '466100', null, '商水县', '23', '商水县', '411623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9b4200044a75420a89728754a21631ef', '78e3f9f0494b42a789f858385a476d44', '466300', null, '沈丘县', '24', '沈丘县', '411624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4b4acb1b308e42eba11182837eca44bc', '78e3f9f0494b42a789f858385a476d44', '477150', null, '郸城县', '25', '郸城县', '411625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d62f7d22dc748cd82cf7e62b3c120f0', '78e3f9f0494b42a789f858385a476d44', '466700', null, '淮阳县', '26', '淮阳县', '411626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2ed6e775d6044ee980c07685728011b4', '78e3f9f0494b42a789f858385a476d44', '475400', null, '太康县', '27', '太康县', '411627', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('32daeda3f9aa4feca8f02f2b7905ad5f', '78e3f9f0494b42a789f858385a476d44', '477200', null, '鹿邑县', '28', '鹿邑县', '411628', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2ea83d1928e04e2a8d4d714085add868', '78e3f9f0494b42a789f858385a476d44', '466200', null, '项城市', '81', '项城市', '411681', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6c500a16fcc54051af9c2ec7c80ab1a4', '7d42b8147aa24128ae7315db8d920b90', '463000', null, '市辖区', '01', '市辖区', '411701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b45b54bbf14a438898bdf3878341364f', '7d42b8147aa24128ae7315db8d920b90', '463000', null, '驿城区', '02', '驿城区', '411702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d2c35ee42b62486cb2ab72aa18786a52', '7d42b8147aa24128ae7315db8d920b90', '463900', null, '西平县', '21', '西平县', '411721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a5bcaafefc0e4ea8bd313b7a3def08c9', '7d42b8147aa24128ae7315db8d920b90', '463800', null, '上蔡县', '22', '上蔡县', '411722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cc4ed21705db42708ee6a5e7a57a7d24', '7d42b8147aa24128ae7315db8d920b90', '463400', null, '平舆县', '23', '平舆县', '411723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bde7a69d58e146df8ac57f10009740a7', '7d42b8147aa24128ae7315db8d920b90', '463600', null, '正阳县', '24', '正阳县', '411724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4e6a9bf2a3ab4ec68411c93c3f395c82', '7d42b8147aa24128ae7315db8d920b90', '463200', null, '确山县', '25', '确山县', '411725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a1ef1f8299154528bdd66251a56de8f0', '7d42b8147aa24128ae7315db8d920b90', '463700', null, '泌阳县', '26', '泌阳县', '411726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('93b22266400940819ff8cf3ca2937fe3', '7d42b8147aa24128ae7315db8d920b90', '463300', null, '汝南县', '27', '汝南县', '411727', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7bebd11cb31d47cc8c424c55c3b0f021', '7d42b8147aa24128ae7315db8d920b90', '463100', null, '遂平县', '28', '遂平县', '411728', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('209fc2b73d2b4ffd8b2b52f82c48e49a', '7d42b8147aa24128ae7315db8d920b90', '463500', null, '新蔡县', '29', '新蔡县', '411729', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6ecb154d043f443988ebcc11c96d6b63', '8ebfb0cbf62d4b6597fd742963815e4d', '430000', null, '市辖区', '01', '市辖区', '420101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f41ff795d550492d85192a21e34d73f5', '8ebfb0cbf62d4b6597fd742963815e4d', '430014', null, '江岸区', '02', '江岸区', '420102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a73e4206e74c46479194132cf7f1da18', '8ebfb0cbf62d4b6597fd742963815e4d', '430000', null, '江汉区', '03', '江汉区', '420103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('65c6c0fced6d4fd38e6b7f47dff5a07a', '8ebfb0cbf62d4b6597fd742963815e4d', '430000', null, '乔口区', '04', '乔口区', '420104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fe3efa5bd1c944ad9e3dfd95ef96869b', '8ebfb0cbf62d4b6597fd742963815e4d', '430050', null, '汉阳区', '05', '汉阳区', '420105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fc0ea42771b84394acd36ed9db5bb692', '8ebfb0cbf62d4b6597fd742963815e4d', '430000', null, '武昌区', '06', '武昌区', '420106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('62a0f0800b4c472ebce75acf4fdb8bd2', '8ebfb0cbf62d4b6597fd742963815e4d', '430080', null, '青山区', '07', '青山区', '420107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5f498a1f2e0442d88bc4b242a515d208', '8ebfb0cbf62d4b6597fd742963815e4d', '430070', null, '洪山区', '11', '洪山区', '420111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b2bd97484c7349df867ceca46d333972', '8ebfb0cbf62d4b6597fd742963815e4d', '430040', null, '东西湖区', '12', '东西湖区', '420112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0f334a4ecdde4a758aa7245a3098d06a', '8ebfb0cbf62d4b6597fd742963815e4d', '430090', null, '汉南区', '13', '汉南区', '420113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('203cd64b409a4350a9044097a7d6195a', '8ebfb0cbf62d4b6597fd742963815e4d', '430100', null, '蔡甸区', '14', '蔡甸区', '420114', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8645987ac0b84312b27768248a8a3171', '8ebfb0cbf62d4b6597fd742963815e4d', '430200', null, '江夏区', '15', '江夏区', '420115', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('347d1446472a44a78b109a11f88f02f6', 'b980cca7c3e04419a36d045d0745ad97', '400000', null, '渝中区', '03', '渝中区', '500103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4ff76e7fd2714e37a3d7c2d560f5d258', '4a6dbf97ae1346a1ae058aada593c83b', '433200', null, '洪湖市', '83', '洪湖市', '421083', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('313f07f205b748fa8e45b52a5e58dc66', '4a6dbf97ae1346a1ae058aada593c83b', '434200', null, '松滋市', '87', '松滋市', '421087', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0d6eb51d3523468d845200c0c588b0d4', '88495c56c828443ca445e66c6d99e988', '438000', null, '市辖区', '01', '市辖区', '421101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('06ffccaeb4ab4a74a5eb2ec96019cecc', '88495c56c828443ca445e66c6d99e988', '438000', null, '黄州区', '02', '黄州区', '421102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6764cdf9849446caade8be656b270c5e', '88495c56c828443ca445e66c6d99e988', '438000', null, '团风县', '21', '团风县', '421121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('16b5572e23184a99ae67f15e8de6e496', '88495c56c828443ca445e66c6d99e988', '438400', null, '红安县', '22', '红安县', '421122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('61b094d50ff74ffcb3672dff4429fd39', '88495c56c828443ca445e66c6d99e988', '438600', null, '罗田县', '23', '罗田县', '421123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9fc6214afea74352a40e54d31adf44fe', '88495c56c828443ca445e66c6d99e988', '438700', null, '英山县', '24', '英山县', '421124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('64a63e7fd4bf4abc8417ae7ef3b9d2e1', '88495c56c828443ca445e66c6d99e988', '438200', null, '浠水县', '25', '浠水县', '421125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('56398f4d372942febde954f4c9d8ed7d', '88495c56c828443ca445e66c6d99e988', '435300', null, '蕲春县', '26', '蕲春县', '421126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cba22fcd9aee47fc9187c66ce44b6b7c', '88495c56c828443ca445e66c6d99e988', '435500', null, '黄梅县', '27', '黄梅县', '421127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('251d64f7b5fc4f9c89afc09e8bc492d3', '88495c56c828443ca445e66c6d99e988', '438300', null, '麻城市', '81', '麻城市', '421181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b5a38e86a4c44d59afcefd8d17030b28', '88495c56c828443ca445e66c6d99e988', '435400', null, '武穴市', '82', '武穴市', '421182', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0bcd47c95f4a4c089642852847e0adc8', '5cbfd640dd1e427e93dee73568bc7f41', '437000', null, '市辖区', '01', '市辖区', '421201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bc65d98dbcb946b3b5863cbdc933e5a7', '5cbfd640dd1e427e93dee73568bc7f41', '437000', null, '咸安区', '02', '咸安区', '421202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4dcfbe31425d4acf812e33705381ed90', '5cbfd640dd1e427e93dee73568bc7f41', '437200', null, '嘉鱼县', '21', '嘉鱼县', '421221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('991c767d38d04cc1bcd9b2157f967f78', '5cbfd640dd1e427e93dee73568bc7f41', '437400', null, '通城县', '22', '通城县', '421222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('db30bfdbbb1c4217a9decb1c867eddb1', '5cbfd640dd1e427e93dee73568bc7f41', '437500', null, '崇阳县', '23', '崇阳县', '421223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ec82203eb0894a608a5e63c1b93c2456', '5cbfd640dd1e427e93dee73568bc7f41', '437600', null, '通山县', '24', '通山县', '421224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cd77ac7bc87a43769f001d5a3fbb18d9', '5cbfd640dd1e427e93dee73568bc7f41', '437300', null, '赤壁市', '81', '赤壁市', '421281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f76dc456d6eb4ee18c4b6da982f9896b', 'a2c47feb005a467e83020bce64d6a551', '441300', null, '市辖区', '01', '市辖区', '421301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d6da48a16fa74dc7a33626528f72dc18', 'a2c47feb005a467e83020bce64d6a551', '441300', null, '曾都区', '02', '曾都区', '421302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9bad45a7821c49938e0650a8492abcac', 'a2c47feb005a467e83020bce64d6a551', '432700', null, '广水市', '81', '广水市', '421381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('25ae2c48713c468daa3ebbd10b25642a', 'ede3533eebc24764a993c9c8b694c26b', '445000', null, '恩施市', '01', '恩施市', '422801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ae84e8ef67e4477689dc93b154889c72', 'ede3533eebc24764a993c9c8b694c26b', '445400', null, '利川市', '02', '利川市', '422802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d4b29db13a1049c29ff66919dbf1c386', 'ede3533eebc24764a993c9c8b694c26b', '445300', null, '建始县', '22', '建始县', '422822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b648e2f598bc4fce8076320b673db1c5', 'ede3533eebc24764a993c9c8b694c26b', '444300', null, '巴东县', '23', '巴东县', '422823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('34ed77a968f043e8986d37904af5653b', 'ede3533eebc24764a993c9c8b694c26b', '445500', null, '宣恩县', '25', '宣恩县', '422825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('14fd2eddc3fb45f185c75fa944828eab', 'ede3533eebc24764a993c9c8b694c26b', '445600', null, '咸丰县', '26', '咸丰县', '422826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b032a195f0944a2a84db80194162ced2', 'ede3533eebc24764a993c9c8b694c26b', '445700', null, '来凤县', '27', '来凤县', '422827', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('37426d7ea7584f6e9b250ccdb24cdd4f', 'ede3533eebc24764a993c9c8b694c26b', '445800', null, '鹤峰县', '28', '鹤峰县', '422828', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9689b5f941bd49d186ce5bed8f622ab9', '368a7e6a7a6f409e8af26a6793354867', '433000', null, '仙桃市', '04', '仙桃市', '429004', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('907553f05e1e41e1819bd09cc1cf7500', '368a7e6a7a6f409e8af26a6793354867', '433100', null, '潜江市', '05', '潜江市', '429005', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0dfb32969d804c3fba2ef950364b2b9c', '368a7e6a7a6f409e8af26a6793354867', '431700', null, '天门市', '06', '天门市', '429006', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('801699780424488cb58f9a06c424832c', '368a7e6a7a6f409e8af26a6793354867', '442400', null, '神农架林区', '21', '神农架林区', '429021', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fab2b235d58b4a3c8a9d85a70e3d3e95', '1e44bd32e5c84c3c852e00f22f6fda95', '410000', null, '市辖区', '01', '市辖区', '430101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a61d8982562b419787903edd39fa5cbf', '1e44bd32e5c84c3c852e00f22f6fda95', '410000', null, '芙蓉区', '02', '芙蓉区', '430102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b69a5af3ab9b43f485496d5204ea05b7', '1e44bd32e5c84c3c852e00f22f6fda95', '410000', null, '天心区', '03', '天心区', '430103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('32ec7a5d09d840d98ff959cba36367fb', '1e44bd32e5c84c3c852e00f22f6fda95', '410000', null, '岳麓区', '04', '岳麓区', '430104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0cb4f00ce41c42b38187107fb380894f', '1e44bd32e5c84c3c852e00f22f6fda95', '410000', null, '开福区', '05', '开福区', '430105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a8ac689984f742f28cb2ef1270f05de1', '1e44bd32e5c84c3c852e00f22f6fda95', '410000', null, '雨花区', '11', '雨花区', '430111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dcf30abcae89450cb0a169eaa41a1b34', '1e44bd32e5c84c3c852e00f22f6fda95', '410100', null, '长沙县', '21', '长沙县', '430121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('55019f6d327c47e48e128e072484c562', '1e44bd32e5c84c3c852e00f22f6fda95', '410200', null, '望城县', '22', '望城县', '430122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('732ca780a88f409fbda73b6632e6493a', '1e44bd32e5c84c3c852e00f22f6fda95', '410600', null, '宁乡县', '24', '宁乡县', '430124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6c824b15994447d284eba60cac9d1ce3', '1e44bd32e5c84c3c852e00f22f6fda95', '410300', null, '浏阳市', '81', '浏阳市', '430181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('daa97d7fe5974e61b6235a2c072a2f61', '1cb06b4200264436a52680229df355c0', '412000', null, '市辖区', '01', '市辖区', '430201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2e859e8efaf845a08bf495437fbe14ec', '1cb06b4200264436a52680229df355c0', '412000', null, '荷塘区', '02', '荷塘区', '430202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8f7cce3da17f4ac29f9892d94da90fc1', '1cb06b4200264436a52680229df355c0', '412000', null, '芦淞区', '03', '芦淞区', '430203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('76ee4292dc2743539544c960ddc567a4', '1cb06b4200264436a52680229df355c0', '412000', null, '石峰区', '04', '石峰区', '430204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e4ee90794fa4ab78152a91fe7727eb5', '1cb06b4200264436a52680229df355c0', '412000', null, '天元区', '11', '天元区', '430211', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a2a302736eda481caca464013867e5a3', '1cb06b4200264436a52680229df355c0', '412000', null, '株洲县', '21', '株洲县', '430221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('895120fc425a496cb80ea3ad6d98bbca', '1cb06b4200264436a52680229df355c0', '412300', null, '攸县', '23', '攸县', '430223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('de692d8095e3458abeeb382a1720ab32', '1cb06b4200264436a52680229df355c0', '412400', null, '茶陵县', '24', '茶陵县', '430224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b696f491e217442a8ffbf7200984b446', '1cb06b4200264436a52680229df355c0', '412500', null, '炎陵县', '25', '炎陵县', '430225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('457c00962b4f484b8667c0259389c337', '1cb06b4200264436a52680229df355c0', '412200', null, '醴陵市', '81', '醴陵市', '430281', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fab6c80092e04911870d8f0a5915b9a8', '1366c663bb614b20b4d433b637b286ed', '411100', null, '市辖区', '01', '市辖区', '430301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f8ad253c6ef74b7e9ff84d05fe8b8517', '1366c663bb614b20b4d433b637b286ed', '411100', null, '雨湖区', '02', '雨湖区', '430302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2762f74ca8364e67a525ce6e19ff8f8a', '1366c663bb614b20b4d433b637b286ed', '411100', null, '岳塘区', '04', '岳塘区', '430304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('53a98ca1bdff430886697a7eb578df40', '1366c663bb614b20b4d433b637b286ed', '411200', null, '湘潭县', '21', '湘潭县', '430321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7774676822b14b5aae61637532cc1ac1', '1366c663bb614b20b4d433b637b286ed', '411400', null, '湘乡市', '81', '湘乡市', '430381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f5d8460abcf749aab2705df7e5981756', '69bd3ecc0d324699ba96fe24b0356639', '614500', null, '沐川县', '29', '沐川县', '511129', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d6c7ba71c5814395be78d2ebea673527', '69bd3ecc0d324699ba96fe24b0356639', '614300', null, '峨边彝族自治县', '32', '峨边彝族自治县', '511132', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('16f90f94c8b34142957b4ef79a9acbe3', '69bd3ecc0d324699ba96fe24b0356639', '614600', null, '马边彝族自治县', '33', '马边彝族自治县', '511133', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f4d2bff8f7d24d7b8a3d28b0094aefcf', '69bd3ecc0d324699ba96fe24b0356639', '614200', null, '峨眉山市', '81', '峨眉山市', '511181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('128307d4e7624654adbf91c9a3b842c6', '7652787b72664f18bbfd327f363fb188', '637000', null, '市辖区', '01', '市辖区', '511301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('84cb45a9d9bf4bbe812da6f5938d9029', '7652787b72664f18bbfd327f363fb188', '637000', null, '顺庆区', '02', '顺庆区', '511302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8f2cf005b2e745629219ba1dede69364', '4d775ed4147c4a29896d82e845939e8b', '421000', null, '南岳区', '12', '南岳区', '430412', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d98901ebf1b44c9b73467e6b9142c15', '4d775ed4147c4a29896d82e845939e8b', '421200', null, '衡阳县', '21', '衡阳县', '430421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('96ff142b3aab4e4ab849f87ae40f5e79', '4d775ed4147c4a29896d82e845939e8b', '421100', null, '衡南县', '22', '衡南县', '430422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('23b4513fe0814a5995d8fae1e4b50061', '4d775ed4147c4a29896d82e845939e8b', '421300', null, '衡山县', '23', '衡山县', '430423', null);
commit;
----prompt 3000 records committed...
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7839c9559b374c2cbdc380767d55d29b', '4d775ed4147c4a29896d82e845939e8b', '421400', null, '衡东县', '24', '衡东县', '430424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3714a9056815462594129ac95c5e43c8', '4d775ed4147c4a29896d82e845939e8b', '421600', null, '祁东县', '26', '祁东县', '430426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb6d72c560df480d8b9cc6af7e2a8673', '4d775ed4147c4a29896d82e845939e8b', '421800', null, '耒阳市', '81', '耒阳市', '430481', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2b3fc4d7807c4d18810555e7119335e4', '4d775ed4147c4a29896d82e845939e8b', '421500', null, '常宁市', '82', '常宁市', '430482', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8add0e8aec9e4b339971a9d1c4d7dd0a', '495e8497aed747bf8741de8bd42abaf7', '422000', null, '市辖区', '01', '市辖区', '430501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ad17e0593ed1421193d95fbaaed9de48', '495e8497aed747bf8741de8bd42abaf7', '422000', null, '双清区', '02', '双清区', '430502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1317ca22b90f42eaa68481240bb30f2d', '495e8497aed747bf8741de8bd42abaf7', '422000', null, '大祥区', '03', '大祥区', '430503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1f9e5d60fbbd4e5882385b42f7d2c7ca', '495e8497aed747bf8741de8bd42abaf7', '422000', null, '北塔区', '11', '北塔区', '430511', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4b5fd4e3ea924a22b41578b173ef1ec9', '495e8497aed747bf8741de8bd42abaf7', '422800', null, '邵东县', '21', '邵东县', '430521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e12cdaeb6f6f42bbb85a7e0541f7df85', '495e8497aed747bf8741de8bd42abaf7', '422900', null, '新邵县', '22', '新邵县', '430522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8288678fd1ec4e7d81358e69f75b18ae', '495e8497aed747bf8741de8bd42abaf7', '422100', null, '邵阳县', '23', '邵阳县', '430523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9b1f56457efa483bb125bc63edd61ba3', '495e8497aed747bf8741de8bd42abaf7', '422200', null, '隆回县', '24', '隆回县', '430524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e4bda772979c43d3a06f3ef0bd8cd62c', '495e8497aed747bf8741de8bd42abaf7', '422300', null, '洞口县', '25', '洞口县', '430525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bce19130fa2e41dc95f7a079a911fa68', '495e8497aed747bf8741de8bd42abaf7', '422600', null, '绥宁县', '27', '绥宁县', '430527', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c6dc033017d840f580adc26616b8f583', '495e8497aed747bf8741de8bd42abaf7', '422700', null, '新宁县', '28', '新宁县', '430528', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bdaba7a149c34779b889abf62b570bab', 'b9b5bc2ccede4027a1f74f80e6341da6', '841800', null, '若羌县', '24', '若羌县', '652824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0e5e9945dc354017b1456e0f47e7c1e7', 'b9b5bc2ccede4027a1f74f80e6341da6', '841900', null, '且末县', '25', '且末县', '652825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c69c85e516d64a6fb3e3641cd7b27e71', 'b9b5bc2ccede4027a1f74f80e6341da6', '841100', null, '焉耆回族自治县', '26', '焉耆回族自治县', '652826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('904e9239d77849b7adfcdbfba0fa4200', 'b9b5bc2ccede4027a1f74f80e6341da6', '841300', null, '和静县', '27', '和静县', '652827', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b5f7c3eb43c04aea8a1fa5e304f87c92', 'b9b5bc2ccede4027a1f74f80e6341da6', '841200', null, '和硕县', '28', '和硕县', '652828', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8f80388a189841be863ce640890e2841', 'b9b5bc2ccede4027a1f74f80e6341da6', '841400', null, '博湖县', '29', '博湖县', '652829', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('158e177f9cf948c68d1cd54269165a6b', '2ff89e0bff1b460db144ac09b148128d', '843000', null, '阿克苏市', '01', '阿克苏市', '652901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3037105b90a466489a2bd2fbddf7d9b', '2ff89e0bff1b460db144ac09b148128d', '843100', null, '温宿县', '22', '温宿县', '652922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('894f40b28308499e8a13090a3e6df8e5', '2ff89e0bff1b460db144ac09b148128d', '842000', null, '库车县', '23', '库车县', '652923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6f0f8a1b38ca4f81b0084e2ccef7d18d', '2ff89e0bff1b460db144ac09b148128d', '842200', null, '沙雅县', '24', '沙雅县', '652924', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a499ef9e6d2846cb8cfd2094eb5fa690', '2ff89e0bff1b460db144ac09b148128d', '842100', null, '新和县', '25', '新和县', '652925', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4bd484010dfa4310bfc9f1fd40ee6c1a', '2ff89e0bff1b460db144ac09b148128d', '842300', null, '拜城县', '26', '拜城县', '652926', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('805637c33c1946d081d4e40c2dbd4cd8', '2ff89e0bff1b460db144ac09b148128d', '843400', null, '乌什县', '27', '乌什县', '652927', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('049647d3dd154b1ca89ddee09c8cf251', '2ff89e0bff1b460db144ac09b148128d', '843200', null, '阿瓦提县', '28', '阿瓦提县', '652928', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0689d63857b746219b2ad1c273ebac2a', '2ff89e0bff1b460db144ac09b148128d', '845350', null, '柯坪县', '29', '柯坪县', '652929', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7e9723a259864c989d70a82251608387', '39d4b2c4532c408c8f5c415bca3646d0', '845350', null, '阿图什市', '01', '阿图什市', '653001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4d3d063bd29047278fcc3614f4945deb', '39d4b2c4532c408c8f5c415bca3646d0', '845550', null, '阿克陶县', '22', '阿克陶县', '653022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7bd2acf10b89447fbc0f2d83642c8372', '39d4b2c4532c408c8f5c415bca3646d0', '843500', null, '阿合奇县', '23', '阿合奇县', '653023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8ec4d9ad907d4eb09b27ae110b5cc28a', '39d4b2c4532c408c8f5c415bca3646d0', '845450', null, '乌恰县', '24', '乌恰县', '653024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e576a6290f644efb98be31bf30d08a1b', 'ab1026be2a6249d6970816590fc19145', '844000', null, '喀什市', '01', '喀什市', '653101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('55d3b85aef8045e78305e19df02cf772', 'ab1026be2a6249d6970816590fc19145', '844100', null, '疏附县', '21', '疏附县', '653121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c0ebbf8e3a5a452ba24fcd886ed0daf4', 'ab1026be2a6249d6970816590fc19145', '844200', null, '疏勒县', '22', '疏勒县', '653122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8d6ab25414514f2684749cdae0d7148c', 'ab1026be2a6249d6970816590fc19145', '844500', null, '英吉沙县', '23', '英吉沙县', '653123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8d95a75487b746de92c71d66f20e9ff7', 'ab1026be2a6249d6970816590fc19145', '844800', null, '泽普县', '24', '泽普县', '653124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8b07afacbdd9467b8ea2103f3a5f8f98', 'ab1026be2a6249d6970816590fc19145', '844700', null, '莎车县', '25', '莎车县', '653125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c86d2b8e444c44729b54832ecd98c2c3', '288c789701ac4bcc8096dd8d85085239', '718100', null, '米脂县', '27', '米脂县', '610827', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b55b8df7fd134bb99558a82c07534ced', '288c789701ac4bcc8096dd8d85085239', '719200', null, '佳县', '28', '佳县', '610828', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('81b2434bf4824426b575d70612bef2bb', '288c789701ac4bcc8096dd8d85085239', '718200', null, '吴堡县', '29', '吴堡县', '610829', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('db9c50b71eb84774a0139241573e5444', '288c789701ac4bcc8096dd8d85085239', '718300', null, '清涧县', '30', '清涧县', '610830', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3beae26427a74a07bb573b9a958be43f', '288c789701ac4bcc8096dd8d85085239', '718400', null, '子洲县', '31', '子洲县', '610831', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fabdd02537674f97b2a9d0d40239bf11', 'b39593a949c4411ebe181f0f397daf3d', '725000', null, '市辖区', '01', '市辖区', '610901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1f0af52c89f240508bc9e173a6d46cbb', 'b39593a949c4411ebe181f0f397daf3d', '725000', null, '汉滨区', '02', '汉滨区', '610902', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('be381628ba5e4aa3808848de43d967c6', 'b39593a949c4411ebe181f0f397daf3d', '725100', null, '汉阴县', '21', '汉阴县', '610921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0f0f75a028ec4cfa82ce158d673fd2be', 'b39593a949c4411ebe181f0f397daf3d', '725200', null, '石泉县', '22', '石泉县', '610922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2aa1c3ee20cb4703a8b7934ca827cc0d', 'b39593a949c4411ebe181f0f397daf3d', '711600', null, '宁陕县', '23', '宁陕县', '610923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d60f3271c6a84d3d8d0266f7a2822f31', 'b39593a949c4411ebe181f0f397daf3d', '725300', null, '紫阳县', '24', '紫阳县', '610924', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d3ae2ca189e8416a9bd83ece56931fe4', 'b39593a949c4411ebe181f0f397daf3d', '725400', null, '岚皋县', '25', '岚皋县', '610925', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('245f1ebe33664d2396c2fd39c75672a3', 'b39593a949c4411ebe181f0f397daf3d', '725500', null, '平利县', '26', '平利县', '610926', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('64aa7d84d8c84e1c9dc4c8068c462a49', 'b39593a949c4411ebe181f0f397daf3d', '725600', null, '镇坪县', '27', '镇坪县', '610927', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('69d9e02f48fb43058be3c5282feba6d8', 'b39593a949c4411ebe181f0f397daf3d', '725700', null, '旬阳县', '28', '旬阳县', '610928', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b3663abccc2b486ab9b5ab116e366bb1', 'b39593a949c4411ebe181f0f397daf3d', '725800', null, '白河县', '29', '白河县', '610929', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('581e81093a954ffbb4b900802bfd8705', '96efc0d8bf4b4484adde54865b3e7c63', '726000', null, '市辖区', '01', '市辖区', '611001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c9a2c686a0c5438e9c43e69ed429f548', '96efc0d8bf4b4484adde54865b3e7c63', '726000', null, '商州区', '02', '商州区', '611002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3323ae95bc7644f9aa2f567adc398a2a', '96efc0d8bf4b4484adde54865b3e7c63', '726100', null, '洛南县', '21', '洛南县', '611021', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fdef9f443c304fe28520d31180f0a6a2', '96efc0d8bf4b4484adde54865b3e7c63', '726200', null, '丹凤县', '22', '丹凤县', '611022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ef02b88149ba46d38bdfad4de478c095', '96efc0d8bf4b4484adde54865b3e7c63', '726300', null, '商南县', '23', '商南县', '611023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('839ebbb1f9ce4d408c6e841edbffe60d', '96efc0d8bf4b4484adde54865b3e7c63', '726400', null, '山阳县', '24', '山阳县', '611024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('88ef59d7e975407f8c2374ce6d3bb4df', '96efc0d8bf4b4484adde54865b3e7c63', '711500', null, '镇安县', '25', '镇安县', '611025', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('038ea5e6e4684b4793a771d08c1a6a8a', '96efc0d8bf4b4484adde54865b3e7c63', '711400', null, '柞水县', '26', '柞水县', '611026', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c665d75b1eca4591882820b50cf12bdc', '5ab6b67e085546caa372b13ec883e55d', '652200', null, '石林彝族自治县', '26', '石林彝族自治县', '530126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f8ffa8815c1947cc9910e94ddcc12819', '5ab6b67e085546caa372b13ec883e55d', '651700', null, '嵩明县', '27', '嵩明县', '530127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8740a5b3fc7f471db8ed62746716b71c', '5ab6b67e085546caa372b13ec883e55d', '651500', null, '禄劝彝族苗族自治县', '28', '禄劝彝族苗族自治县', '530128', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4b3d566df18c49f9ae612061ca8a97d3', '5ab6b67e085546caa372b13ec883e55d', '655200', null, '寻甸回族彝族自治县', '29', '寻甸回族彝族自治县', '530129', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f40fb9d917944cf6b69ec5a01eb52837', '5ab6b67e085546caa372b13ec883e55d', '650300', null, '安宁市', '81', '安宁市', '530181', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('59fdc3fbd4c842f18f5021fe254124f3', '32f1279ae35c4dd4bc2aff7a08755344', '655000', null, '市辖区', '01', '市辖区', '530301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9461936d94e94a18b29834b319ace862', '32f1279ae35c4dd4bc2aff7a08755344', '655000', null, '麒麟区', '02', '麒麟区', '530302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('58ac17a73f784d8c9e919ff87b9b24cb', '32f1279ae35c4dd4bc2aff7a08755344', '655100', null, '马龙县', '21', '马龙县', '530321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f4cd7117c39c49cfa72d5334ae526f60', '32f1279ae35c4dd4bc2aff7a08755344', '655600', null, '陆良县', '22', '陆良县', '530322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e2893cc6c9444f699bd455cd9e9cff5', '32f1279ae35c4dd4bc2aff7a08755344', '655700', null, '师宗县', '23', '师宗县', '530323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('89b6aaec462e40c89416ea03b62838be', '32f1279ae35c4dd4bc2aff7a08755344', '655800', null, '罗平县', '24', '罗平县', '530324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4f4a96631013483fa1128a16fd40efba', '32f1279ae35c4dd4bc2aff7a08755344', '655500', null, '富源县', '25', '富源县', '530325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2beaab65ffd945d6a07353eda5799a62', '32f1279ae35c4dd4bc2aff7a08755344', '654200', null, '会泽县', '26', '会泽县', '530326', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('27309802063f4a229b9ea934053145b6', '32f1279ae35c4dd4bc2aff7a08755344', '655500', null, '沾益县', '28', '沾益县', '530328', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e18d9ea8c5f043f3a5e36c5d3f626f14', '32f1279ae35c4dd4bc2aff7a08755344', '655400', null, '宣威市', '81', '宣威市', '530381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('17741d3ea987489f918925caf5fbdfb3', 'b32eb2d28ea84cacb3190db9a12588db', '653100', null, '市辖区', '01', '市辖区', '530401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d9f78b97af1b4d8a849f0666fa3a67e1', 'b32eb2d28ea84cacb3190db9a12588db', '653100', null, '红塔区', '02', '红塔区', '530402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('04ede894b1b24088b746089d0e847bd4', 'b32eb2d28ea84cacb3190db9a12588db', '652600', null, '江川县', '21', '江川县', '530421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('caedf81be71b4dedbb5fde29128471f0', 'b32eb2d28ea84cacb3190db9a12588db', '652500', null, '澄江县', '22', '澄江县', '530422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('92b5a7fa65d34f7baa875ba4e3a3f379', 'b32eb2d28ea84cacb3190db9a12588db', '652700', null, '通海县', '23', '通海县', '530423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('48ade82add7d4ee3958a367acbc2e533', 'b32eb2d28ea84cacb3190db9a12588db', '652800', null, '华宁县', '24', '华宁县', '530424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c55a3deaf0e84d3794cdae7b50724bb1', 'b32eb2d28ea84cacb3190db9a12588db', '651100', null, '易门县', '25', '易门县', '530425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e67922bbcaa4dd3b8bf0975b154ac8d', 'b32eb2d28ea84cacb3190db9a12588db', '653200', null, '峨山彝族自治县', '26', '峨山彝族自治县', '530426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7d28e3de037d4b949d23e0d158cfde02', 'b32eb2d28ea84cacb3190db9a12588db', '653400', null, '新平彝族傣族自治县', '27', '新平彝族傣族自治县', '530427', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('755a6c47a50b477e8ddf4e090f66b136', 'b32eb2d28ea84cacb3190db9a12588db', '653300', null, '元江哈尼族彝族傣族自治县', '28', '元江哈尼族彝族傣族自治县', '530428', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('db2e5e905c91461e925f1f71c8b787b8', '7f5abf200b664ad595bc1a8c7098b9af', '678000', null, '市辖区', '01', '市辖区', '530501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c153802743540798e2cce148e9bae4f', '7f5abf200b664ad595bc1a8c7098b9af', '678000', null, '隆阳区', '02', '隆阳区', '530502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('acfda7dfd3b9458b9304a7323e39da49', '7f5abf200b664ad595bc1a8c7098b9af', '678200', null, '施甸县', '21', '施甸县', '530521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cca0b6144f58439ab24d93ef012d2606', '7f5abf200b664ad595bc1a8c7098b9af', '679100', null, '腾冲县', '22', '腾冲县', '530522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9552488597c9421dabcc3dee842174c3', '7f5abf200b664ad595bc1a8c7098b9af', '678300', null, '龙陵县', '23', '龙陵县', '530523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('94bfb986b5b94f61b2fd9079ef796bb1', '7f5abf200b664ad595bc1a8c7098b9af', '678100', null, '昌宁县', '24', '昌宁县', '530524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fbd31f52655d43239b53785720f75e0b', '71565bd32ec9492b81bb4ab47436ddf0', '657000', null, '市辖区', '01', '市辖区', '530601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8fc6bfe0f8f6417c83e33be47ab4c84a', '71565bd32ec9492b81bb4ab47436ddf0', '657000', null, '昭阳区', '02', '昭阳区', '530602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('71205e8e237043a5bdb45da1a2e7de2c', '71565bd32ec9492b81bb4ab47436ddf0', '657100', null, '鲁甸县', '21', '鲁甸县', '530621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0daa299acc7a4b0daea7913d14990821', '71565bd32ec9492b81bb4ab47436ddf0', '654600', null, '巧家县', '22', '巧家县', '530622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('090b27880442413bbd60d80c2ad07745', '71565bd32ec9492b81bb4ab47436ddf0', '657500', null, '盐津县', '23', '盐津县', '530623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b30093972839499387d29ae7d24ac167', '71565bd32ec9492b81bb4ab47436ddf0', '657400', null, '大关县', '24', '大关县', '530624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e7e13cb63e7c4258b0b2292049944b16', '71565bd32ec9492b81bb4ab47436ddf0', '657300', null, '永善县', '25', '永善县', '530625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('79c8059a297549bb9ce29e6e2556b1e2', '71565bd32ec9492b81bb4ab47436ddf0', '657700', null, '绥江县', '26', '绥江县', '530626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('146fefbca81442239f023a5aa8966628', '71565bd32ec9492b81bb4ab47436ddf0', '657200', null, '镇雄县', '27', '镇雄县', '530627', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('195da86a51aa4881bc884919a173c0fa', '71565bd32ec9492b81bb4ab47436ddf0', '657600', null, '彝良县', '28', '彝良县', '530628', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('066a751cda4643ea9379f84280a6d436', '6343ca91165140d1bcc25205a1235335', '666500', null, '镇沅彝族哈尼族拉祜族自治县', '25', '镇沅彝族哈尼族拉祜族自治县', '530825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('892dec6f1fb14b18b11f11e84ce8febc', '6343ca91165140d1bcc25205a1235335', '665900', null, '江城哈尼族彝族自治县', '26', '江城哈尼族彝族自治县', '530826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f1bd896275c04d7e83d46a368f898974', '53d713790c804ce1b1c4d65acd66b7a0', '730000', null, '市辖区', '01', '市辖区', '620101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('93d34d1b142e457b970b74dcbf35a7f0', '53d713790c804ce1b1c4d65acd66b7a0', '730030', null, '城关区', '02', '城关区', '620102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e6aebbc39ba94c519fe445e3dad67cc9', '53d713790c804ce1b1c4d65acd66b7a0', '730050', null, '七里河区', '03', '七里河区', '620103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3eabf5c6728944188ec67f011c2939b9', '53d713790c804ce1b1c4d65acd66b7a0', '730060', null, '西固区', '04', '西固区', '620104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d598b60993de473f8efd21c0d986d062', '53d713790c804ce1b1c4d65acd66b7a0', '730070', null, '安宁区', '05', '安宁区', '620105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('668e17d1b79647e3969fce1316c43ed9', '53d713790c804ce1b1c4d65acd66b7a0', '730080', null, '红古区', '11', '红古区', '620111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0b5f0e6def3541cf8213eae68e450f4b', 'd3ac67eb93544b9da681781f1f27fa5d', '675900', null, '凤庆县', '21', '凤庆县', '530921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('89c8b075821447729db26a4f23650584', 'd3ac67eb93544b9da681781f1f27fa5d', '675800', null, '云县', '22', '云县', '530922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('50cfaa464cad428a949794eff12cb461', 'd3ac67eb93544b9da681781f1f27fa5d', '677600', null, '永德县', '23', '永德县', '530923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('16962118778446c3b289667b82205086', 'd3ac67eb93544b9da681781f1f27fa5d', '677700', null, '镇康县', '24', '镇康县', '530924', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7783ae846b344629b451e09b371a7913', 'd3ac67eb93544b9da681781f1f27fa5d', '677300', null, '双江拉祜族佤族布朗族傣族自治县', '25', '双江拉祜族佤族布朗族傣族自治县', '530925', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('caae44f8ea524f2ba6a8705040d1fdd3', 'd3ac67eb93544b9da681781f1f27fa5d', '677500', null, '耿马傣族佤族自治县', '26', '耿马傣族佤族自治县', '530926', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('be728ba47c114977bcf630c5a58dab7f', 'd3ac67eb93544b9da681781f1f27fa5d', '677400', null, '沧源佤族自治县', '27', '沧源佤族自治县', '530927', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d678d0c09788492285d5553a56f4a1d3', 'f9f4657fe4aa48bb8d324167750c9b1c', '675000', null, '楚雄市', '01', '楚雄市', '532301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4d72b0fed23245eeae578512de26178f', 'f9f4657fe4aa48bb8d324167750c9b1c', '675100', null, '双柏县', '22', '双柏县', '532322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f95b4377d3024bd5a0a7ea3723a5ccd9', 'f9f4657fe4aa48bb8d324167750c9b1c', '675500', null, '牟定县', '23', '牟定县', '532323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9accfe75c7ae4fd8b463b7eee85dfc8f', 'f9f4657fe4aa48bb8d324167750c9b1c', '675200', null, '南华县', '24', '南华县', '532324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('586a4c51c45d42308a51377db2d1c0e5', 'f9f4657fe4aa48bb8d324167750c9b1c', '675300', null, '姚安县', '25', '姚安县', '532325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ccaa5b61db9b4f149dfd3c8dc4fbc176', 'f9f4657fe4aa48bb8d324167750c9b1c', '675400', null, '大姚县', '26', '大姚县', '532326', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('966cf6d155454bfea8a05aea666a9744', 'f9f4657fe4aa48bb8d324167750c9b1c', '651400', null, '永仁县', '27', '永仁县', '532327', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f2de8d486869455696e7afed6f71e7d7', 'f9f4657fe4aa48bb8d324167750c9b1c', '651300', null, '元谋县', '28', '元谋县', '532328', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('75b6ab87f7bd4f5da8247759a4fd33aa', 'f9f4657fe4aa48bb8d324167750c9b1c', '651600', null, '武定县', '29', '武定县', '532329', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('95c223a44e0844f0a5bd652cb6bdf5e6', 'ab1026be2a6249d6970816590fc19145', '844900', null, '叶城县', '26', '叶城县', '653126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9535daad003d481294cfea461d8a3c73', 'ab1026be2a6249d6970816590fc19145', '844600', null, '麦盖提县', '27', '麦盖提县', '653127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('69dfe4b7a1f1409391c7d4b7d08c5e42', 'ab1026be2a6249d6970816590fc19145', '844400', null, '岳普湖县', '28', '岳普湖县', '653128', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7e87b436e94e4560a27fff6339862465', 'ab1026be2a6249d6970816590fc19145', '844300', null, '伽师县', '29', '伽师县', '653129', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2de012549b504e6c9f3d0f53e8e17d84', 'ab1026be2a6249d6970816590fc19145', '843800', null, '巴楚县', '30', '巴楚县', '653130', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d237242fd70d43a9af0c2187f0beba35', 'ab1026be2a6249d6970816590fc19145', '845250', null, '塔什库尔干塔吉克自治县', '31', '塔什库尔干塔吉克自治县', '653131', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('db73b61c959f4dffb238755c53c04e77', 'bb8405b610ee45ee9b7aac1f46c2fee3', '848000', null, '和田市', '01', '和田市', '653201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4c0a1f0e074c4cd9a480c2ae2f7a86b3', 'bb8405b610ee45ee9b7aac1f46c2fee3', '848000', null, '和田县', '21', '和田县', '653221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('93b457219d5d42b29fea3f0a93871dc8', 'bb8405b610ee45ee9b7aac1f46c2fee3', '848100', null, '墨玉县', '22', '墨玉县', '653222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('592972bebf74401e9b1ddca27e110c5c', 'bb8405b610ee45ee9b7aac1f46c2fee3', '845150', null, '皮山县', '23', '皮山县', '653223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('93c8476f44974e5cbe601a9fce12ad5d', 'bb8405b610ee45ee9b7aac1f46c2fee3', '848200', null, '洛浦县', '24', '洛浦县', '653224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('80b9464d2d554b899032c6710e6504ce', 'bb8405b610ee45ee9b7aac1f46c2fee3', '848300', null, '策勒县', '25', '策勒县', '653225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f4140757e7ad4a89b3fc2d6076b4663a', 'bb8405b610ee45ee9b7aac1f46c2fee3', '848400', null, '于田县', '26', '于田县', '653226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fd131ae78cbd4368a9bcadfe1a642f4e', 'bb8405b610ee45ee9b7aac1f46c2fee3', '848500', null, '民丰县', '27', '民丰县', '653227', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('68279dd44b904aa19127dcf86470863a', '5af36941bec94e909e006b557150a1d4', '835000', null, '伊宁市', '02', '伊宁市', '654002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cf9c778a402648c0ac42455cd3cfe03a', '5af36941bec94e909e006b557150a1d4', '833200', null, '奎屯市', '03', '奎屯市', '654003', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1f5caf4a96b345b988ad11193dddc56d', '5af36941bec94e909e006b557150a1d4', '835100', null, '伊宁县', '21', '伊宁县', '654021', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b9c2cf8c543e4714aacdaf32c7d3eccf', '5af36941bec94e909e006b557150a1d4', '835300', null, '察布查尔锡伯自治县', '22', '察布查尔锡伯自治县', '654022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('347e1d142ca7449d95cb04b328cf7be1', '5af36941bec94e909e006b557150a1d4', '835200', null, '霍城县', '23', '霍城县', '654023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9f8ccbfc408f427592a037cf9b39d9dc', '5af36941bec94e909e006b557150a1d4', '835400', null, '巩留县', '24', '巩留县', '654024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('43661bda7e0a49f180eb84beb5f2c54c', '5af36941bec94e909e006b557150a1d4', '835800', null, '新源县', '25', '新源县', '654025', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ac3848264433469186322be6f147735a', '5af36941bec94e909e006b557150a1d4', '835600', null, '昭苏县', '26', '昭苏县', '654026', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4906f7f75fbe4728aedd5d0d096e3ede', '7009390a34474afe8e3122be8006dd75', '671400', null, '兰坪白族普米族自治县', '25', '兰坪白族普米族自治县', '533325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5773f03380c3450eaa4dcb863f017663', 'd87d78ea6435473faf023cc21eabb452', '674400', null, '香格里拉县', '21', '香格里拉县', '533421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5da385fcc3e5455981c9cf956b11b97a', 'd87d78ea6435473faf023cc21eabb452', '674500', null, '德钦县', '22', '德钦县', '533422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cad02a60b34e4c09a2122f67c7f1a47c', 'd87d78ea6435473faf023cc21eabb452', '674600', null, '维西傈僳族自治县', '23', '维西傈僳族自治县', '533423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('70508936e4614fc3b06e01ee28c52a39', 'c5b38e0ab90d494dad25c3d85b510cee', '850000', null, '市辖区', '01', '市辖区', '540101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e305a86b1529447bb226742be71c5cb4', 'c5b38e0ab90d494dad25c3d85b510cee', '850000', null, '城关区', '02', '城关区', '540102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6fede8a2d4e043b2aeb8c2a114e2e6f3', 'c5b38e0ab90d494dad25c3d85b510cee', '851600', null, '林周县', '21', '林周县', '540121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fc372c2b07004565a34ad4cdb1b79fc9', 'c5b38e0ab90d494dad25c3d85b510cee', '851500', null, '当雄县', '22', '当雄县', '540122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('24801f3b5e2b4ffe92841e4b4800360f', 'c5b38e0ab90d494dad25c3d85b510cee', '851600', null, '尼木县', '23', '尼木县', '540123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('862c578888c54d98a60335ce88dd2c55', 'c5b38e0ab90d494dad25c3d85b510cee', '850600', null, '曲水县', '24', '曲水县', '540124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aae6de878e8b40309e495cf668ee7a8f', 'c5b38e0ab90d494dad25c3d85b510cee', '851400', null, '堆龙德庆县', '25', '堆龙德庆县', '540125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ec6bb6b0fd2040498010415b1d0ca1ab', 'c5b38e0ab90d494dad25c3d85b510cee', '850100', null, '达孜县', '26', '达孜县', '540126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6dd2ab12a5e64a9388d07075fdc4e623', 'c5b38e0ab90d494dad25c3d85b510cee', '850200', null, '墨竹工卡县', '27', '墨竹工卡县', '540127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1b1a6b3fc3db4d22b840d9efc98c2883', '0f59a76aeef144489eaaf8edd763f507', '854000', null, '昌都县', '21', '昌都县', '542121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a833eb0a66254f758bc6f5cca53ca724', '0f59a76aeef144489eaaf8edd763f507', '854100', null, '江达县', '22', '江达县', '542122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c2482cef4fea4f2abf13450de95e6695', '0f59a76aeef144489eaaf8edd763f507', '854200', null, '贡觉县', '23', '贡觉县', '542123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('314ae484b5b44c74a0f49274659cb1b4', '0f59a76aeef144489eaaf8edd763f507', '855600', null, '类乌齐县', '24', '类乌齐县', '542124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('76fa23e2ee664269aad532678bc14bdb', '0f59a76aeef144489eaaf8edd763f507', '855700', null, '丁青县', '25', '丁青县', '542125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6f05ab8557eb42cf84b98462d739eeb4', '0f59a76aeef144489eaaf8edd763f507', '854300', null, '察雅县', '26', '察雅县', '542126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('227c097be7b748bc9e938e9ce9822358', '0f59a76aeef144489eaaf8edd763f507', '854600', null, '八宿县', '27', '八宿县', '542127', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('85d5aa7212ea425184b76c0acb9df85a', '0f59a76aeef144489eaaf8edd763f507', '854400', null, '左贡县', '28', '左贡县', '542128', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f16d39d9e14e4e639782f5b86dbe63ed', '0f59a76aeef144489eaaf8edd763f507', '854500', null, '芒康县', '29', '芒康县', '542129', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d1050d4e98104085a96759bdd2df5a8d', '0f59a76aeef144489eaaf8edd763f507', '855400', null, '洛隆县', '32', '洛隆县', '542132', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dcd7d09c931e41d29950e6d92a4c87e7', '0f59a76aeef144489eaaf8edd763f507', '855500', null, '边坝县', '33', '边坝县', '542133', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('808387bc15a24dc58e1a6008c6c3c2a4', '0127cc2437fb4b1aab1311ed373da4d5', '856100', null, '乃东县', '21', '乃东县', '542221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('934350f0c6714964a3afb507dc15b83d', '0127cc2437fb4b1aab1311ed373da4d5', '850800', null, '扎囊县', '22', '扎囊县', '542222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e41c735811164bd1ad33da0fb948cf97', '0127cc2437fb4b1aab1311ed373da4d5', '850700', null, '贡嘎县', '23', '贡嘎县', '542223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d2b46dadc37b4ad982db87b2e4dd21da', '0127cc2437fb4b1aab1311ed373da4d5', '856200', null, '桑日县', '24', '桑日县', '542224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c91686ecdd67425b9ba35601c1dba7fe', '0127cc2437fb4b1aab1311ed373da4d5', '856800', null, '琼结县', '25', '琼结县', '542225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6832e5bde5af437aaa8de5115809b251', '0127cc2437fb4b1aab1311ed373da4d5', '856300', null, '曲松县', '26', '曲松县', '542226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c8d8aa78f730469cb2a9800cb3a4186a', '0127cc2437fb4b1aab1311ed373da4d5', '856900', null, '措美县', '27', '措美县', '542227', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('48b320707ca34a89b6183e6c4a2da82d', '0127cc2437fb4b1aab1311ed373da4d5', '851200', null, '洛扎县', '28', '洛扎县', '542228', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3d783790cd194d35a866cfe2056b48b1', '0127cc2437fb4b1aab1311ed373da4d5', '856400', null, '加查县', '29', '加查县', '542229', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2d092e0db5fd46e5aaadf15daa619d96', '0127cc2437fb4b1aab1311ed373da4d5', '856600', null, '隆子县', '31', '隆子县', '542231', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0f2b974fbc3447f9867751d6e7ba4fd6', '0127cc2437fb4b1aab1311ed373da4d5', '856700', null, '错那县', '32', '错那县', '542232', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5fb92e60389343dc8b2dbb49a5902193', '0127cc2437fb4b1aab1311ed373da4d5', '851100', null, '浪卡子县', '33', '浪卡子县', '542233', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a13540742ed844a69a8273391ff5065c', 'f146c88e9f61487e8187bcdc280e2897', '857000', null, '日喀则市', '01', '日喀则市', '542301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('231324dfd4f24bef850bac96165f28b4', 'f146c88e9f61487e8187bcdc280e2897', '857100', null, '南木林县', '22', '南木林县', '542322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('253d844ed4414bcf84ab4bcd652d1d57', 'f146c88e9f61487e8187bcdc280e2897', '857400', null, '江孜县', '23', '江孜县', '542323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aa9a28e2b0af4354bccc19087a28d135', 'f146c88e9f61487e8187bcdc280e2897', '858200', null, '定日县', '24', '定日县', '542324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1487ef3c449a4273a696a428d3b97e91', 'f146c88e9f61487e8187bcdc280e2897', '857800', null, '萨迦县', '25', '萨迦县', '542325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('524d7853aa634bd780cba60432e57a5d', 'f146c88e9f61487e8187bcdc280e2897', '858100', null, '拉孜县', '26', '拉孜县', '542326', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1024592593314c7c8b3a62aeac4694b7', 'f146c88e9f61487e8187bcdc280e2897', '858500', null, '昂仁县', '27', '昂仁县', '542327', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('184f799832e2445785f05b4d2c262899', 'f146c88e9f61487e8187bcdc280e2897', '858900', null, '谢通门县', '28', '谢通门县', '542328', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f070a1bbf21f4b7484337879b377d878', 'f146c88e9f61487e8187bcdc280e2897', '857300', null, '白朗县', '29', '白朗县', '542329', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5b3f24a0e9bc447c88a641327924d5f6', 'f146c88e9f61487e8187bcdc280e2897', '857200', null, '仁布县', '30', '仁布县', '542330', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e2255637084a44ca94365cc54f4b1112', 'f146c88e9f61487e8187bcdc280e2897', '857500', null, '康马县', '31', '康马县', '542331', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('23a86128413f492ea5b4d3c272145482', 'f146c88e9f61487e8187bcdc280e2897', '857900', null, '定结县', '32', '定结县', '542332', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('78029642557c4953b1efbdec4f4ba8ba', 'f146c88e9f61487e8187bcdc280e2897', '858800', null, '仲巴县', '33', '仲巴县', '542333', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('12863c4279264cc98aad4de6f2abeb09', 'f146c88e9f61487e8187bcdc280e2897', '857600', null, '亚东县', '34', '亚东县', '542334', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c635dc17ebcf4ed98d9748a27515f746', 'f146c88e9f61487e8187bcdc280e2897', '858700', null, '吉隆县', '35', '吉隆县', '542335', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b9af35d5df214d578c5ea98ebba38cec', 'f146c88e9f61487e8187bcdc280e2897', '858300', null, '聂拉木县', '36', '聂拉木县', '542336', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('53a6d69f64f8465dab9c49c9fb87b7a1', 'f146c88e9f61487e8187bcdc280e2897', '858600', null, '萨嘎县', '37', '萨嘎县', '542337', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bf4f9a14576a4103a7515435690c1ed1', 'f146c88e9f61487e8187bcdc280e2897', '857700', null, '岗巴县', '38', '岗巴县', '542338', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8ec37055e562421f8a07e912a9031db1', 'ad1a12715fab4d57bf0bfdda2eb9db6a', '852000', null, '那曲县', '21', '那曲县', '542421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b78efa79290e4bdb93a8e67e541b6449', 'ad1a12715fab4d57bf0bfdda2eb9db6a', '852400', null, '嘉黎县', '22', '嘉黎县', '542422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('31b861c9723b431e89eff1134b8a68dd', 'ad1a12715fab4d57bf0bfdda2eb9db6a', '852300', null, '比如县', '23', '比如县', '542423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0464e05d0fb0421eb1958a3ab8c6c5af', 'ad1a12715fab4d57bf0bfdda2eb9db6a', '853500', null, '聂荣县', '24', '聂荣县', '542424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('684e4e8c0fd64574af4eefcb73fdc2ec', 'ad1a12715fab4d57bf0bfdda2eb9db6a', '853400', null, '安多县', '25', '安多县', '542425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ecb73a612d5a4a6fafabd1c3a322cf32', 'ad1a12715fab4d57bf0bfdda2eb9db6a', '853100', null, '申扎县', '26', '申扎县', '542426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d1eee42f6b6847848aad4fad37c389f1', 'ad1a12715fab4d57bf0bfdda2eb9db6a', '852200', null, '索县', '27', '索县', '542427', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('49248203a3fa49d0831d8dcbc2152450', 'ad1a12715fab4d57bf0bfdda2eb9db6a', '852500', null, '班戈县', '28', '班戈县', '542428', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('26f2d73333e94bcda4259a3dcbc22855', 'ad1a12715fab4d57bf0bfdda2eb9db6a', '852100', null, '巴青县', '29', '巴青县', '542429', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('473b1ae212f84407a23a87d061716f43', 'ad1a12715fab4d57bf0bfdda2eb9db6a', '853200', null, '尼玛县', '30', '尼玛县', '542430', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7b4f6a507b3b478ba1ceca368e8c2946', 'be59c52820d04d2c9b5c91d7f4dae34f', '859500', null, '普兰县', '21', '普兰县', '542521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('81ea929060be41d1a036af571654cf55', 'be59c52820d04d2c9b5c91d7f4dae34f', '859600', null, '札达县', '22', '札达县', '542522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0b8808b11e8342abb6a2637be89e2f52', 'be59c52820d04d2c9b5c91d7f4dae34f', '859000', null, '噶尔县', '23', '噶尔县', '542523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8cbbcfd180f14089ba8010e0d08ce85d', 'be59c52820d04d2c9b5c91d7f4dae34f', '859700', null, '日土县', '24', '日土县', '542524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('99d4165b29064be780c058b22988c49b', 'be59c52820d04d2c9b5c91d7f4dae34f', '859100', null, '革吉县', '25', '革吉县', '542525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4a011b5b21ec405ba4b8f3886548e53b', '5af36941bec94e909e006b557150a1d4', '835500', null, '特克斯县', '27', '特克斯县', '654027', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a141733d764845bb8ad409b7fcd99882', '5af36941bec94e909e006b557150a1d4', '835700', null, '尼勒克县', '28', '尼勒克县', '654028', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('573e96be1a774aeda72f79dd2569abd8', '9e7badeaaf6e4b81947d64eee34d696e', '834300', null, '塔城市', '01', '塔城市', '654201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('14538ed0781e4d028dc2cda2061e8166', '9e7badeaaf6e4b81947d64eee34d696e', '833300', null, '乌苏市', '02', '乌苏市', '654202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d7515f3477674737aa36f243495cd275', '9e7badeaaf6e4b81947d64eee34d696e', '834600', null, '额敏县', '21', '额敏县', '654221', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3b659d844ac94ea793a16ac4310c871f', '9e7badeaaf6e4b81947d64eee34d696e', '832100', null, '沙湾县', '23', '沙湾县', '654223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('32c35eb70bfa45b2af72fe21b2b46982', '9e7badeaaf6e4b81947d64eee34d696e', '834500', null, '托里县', '24', '托里县', '654224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4903ee23ddcc4eeab4b1e515c8eee469', '9e7badeaaf6e4b81947d64eee34d696e', '834800', null, '裕民县', '25', '裕民县', '654225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('77590293e3674a689e170be1e137f1fe', '9e7badeaaf6e4b81947d64eee34d696e', '834400', null, '和布克赛尔蒙古自治县', '26', '和布克赛尔蒙古自治县', '654226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0bc05a7eaa80411e87717df87a281889', '9e4de59c90544481a5c5163355474dee', '836500', null, '阿勒泰市', '01', '阿勒泰市', '654301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2600315a9d8d41539f6dd08f9bce6dc4', '9e4de59c90544481a5c5163355474dee', '836600', null, '布尔津县', '21', '布尔津县', '654321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e5c7f9c348ae4ddab0dd5a78d998860f', '9e4de59c90544481a5c5163355474dee', '836100', null, '富蕴县', '22', '富蕴县', '654322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('52fb237f20cc45fe8fc9502eb653151c', '9e4de59c90544481a5c5163355474dee', '836400', null, '福海县', '23', '福海县', '654323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4a6be741380a4b31b179dab74184e6d0', '9e4de59c90544481a5c5163355474dee', '836700', null, '哈巴河县', '24', '哈巴河县', '654324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6305d4cea62148cc897194219766500d', '9e4de59c90544481a5c5163355474dee', '836200', null, '青河县', '25', '青河县', '654325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('65771bcdcec84028b267f6366c8bb921', '9e4de59c90544481a5c5163355474dee', '836800', null, '吉木乃县', '26', '吉木乃县', '654326', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a0431faa2d304e83be350dd7ca7d7f2a', '25a0ad7d58b1411ca8fd5fe2a73bdb6f', '832000', null, '石河子市', '01', '石河子市', '659001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bacb8cc8ba264a81af380833b44e791d', '25a0ad7d58b1411ca8fd5fe2a73bdb6f', '843300', null, '阿拉尔市', '02', '阿拉尔市', '659002', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1abdf95ad28845ce84f54a27cf15b4a9', '25a0ad7d58b1411ca8fd5fe2a73bdb6f', '844000', null, '图木舒克市', '03', '图木舒克市', '659003', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('11708d402f5e47b2991f2eb3387e9be8', '25a0ad7d58b1411ca8fd5fe2a73bdb6f', '831300', null, '五家渠市', '04', '五家渠市', '659004', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('177e1110346a402b9a881ab5cb61c707', '0d92c2dd3d8b4d568f5e4213b994f731', '999077', null, '香港', '81', '香港', '810000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('acd2a0e132cb4c10b6281d6f10190128', 'b071cf5bb5b14629a19e2929bc219029', '999078', null, '澳门', '82', '澳门', '820000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e637742cf7484f85a0bdeccc5505a2a2', 'f46010d30af84774a1f8385753b28a93', '999079', null, '台湾', '71', '台湾', '710000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ccbcefce2e894bf28f1a080a796fb8c4', 'a931713a606b4c92b9279967858d62e1', '563000', null, '汇川区', '03', '汇川区', '520303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('829ef755a6574012b5abe4032fa44260', 'a931713a606b4c92b9279967858d62e1', '563100', null, '遵义县', '21', '遵义县', '520321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('322169770c904314b2e52d5fa67b8fa0', 'a931713a606b4c92b9279967858d62e1', '563200', null, '桐梓县', '22', '桐梓县', '520322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fc62262c0b30415b8914c553d9824e58', 'a931713a606b4c92b9279967858d62e1', '563300', null, '绥阳县', '23', '绥阳县', '520323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9cc01190bf3a46b08cc38b7449fa34aa', 'a931713a606b4c92b9279967858d62e1', '563400', null, '正安县', '24', '正安县', '520324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('af1d79d747694362b03fc6d6d652b6f5', 'a931713a606b4c92b9279967858d62e1', '563500', null, '道真仡佬族苗族自治县', '25', '道真仡佬族苗族自治县', '520325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e15266720cbc4b73bfec329f31850ae6', 'a931713a606b4c92b9279967858d62e1', '564300', null, '务川仡佬族苗族自治县', '26', '务川仡佬族苗族自治县', '520326', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e5a67cd2a87b48aa98dfdb65e96ab5c4', 'a931713a606b4c92b9279967858d62e1', '564200', null, '凤冈县', '27', '凤冈县', '520327', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fa6ec5f4e42e425f9125f3a770a347a6', 'a931713a606b4c92b9279967858d62e1', '564100', null, '湄潭县', '28', '湄潭县', '520328', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6685a2f585734062adf29a6eedef281f', 'a931713a606b4c92b9279967858d62e1', '564400', null, '余庆县', '29', '余庆县', '520329', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2ef5e8a0dbc04b31b1c7301dcf36950f', 'a931713a606b4c92b9279967858d62e1', '564600', null, '习水县', '30', '习水县', '520330', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7bb37e4bc9a3463c91482497368821b6', 'a931713a606b4c92b9279967858d62e1', '564700', null, '赤水市', '81', '赤水市', '520381', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c13cd5ba184a41c3bf8ea94b4eb2955c', 'a931713a606b4c92b9279967858d62e1', '564500', null, '仁怀市', '82', '仁怀市', '520382', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aa1b6931a8854d9bb335ff0052598267', '413d723baf1e4e9a89d84bd05d36ff6c', '561000', null, '市辖区', '01', '市辖区', '520401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('79476f8301dc4b91959c2990d6ac1cba', '413d723baf1e4e9a89d84bd05d36ff6c', '561000', null, '西秀区', '02', '西秀区', '520402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3384e56bdb014e66bca7d1530af80042', '413d723baf1e4e9a89d84bd05d36ff6c', '561100', null, '平坝县', '21', '平坝县', '520421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6ed00c12c5764352bd720e31a1e38506', '413d723baf1e4e9a89d84bd05d36ff6c', '562100', null, '普定县', '22', '普定县', '520422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2f49abc6720a4fa184198e474de2c656', '413d723baf1e4e9a89d84bd05d36ff6c', '561200', null, '镇宁布依族苗族自治县', '23', '镇宁布依族苗族自治县', '520423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('57e65d70f0064083bf0ad11b6f3124ff', '413d723baf1e4e9a89d84bd05d36ff6c', '561300', null, '关岭布依族苗族自治县', '24', '关岭布依族苗族自治县', '520424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('96025766989e423183fa40f18722c636', '53d713790c804ce1b1c4d65acd66b7a0', '730300', null, '永登县', '21', '永登县', '620121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2537659f9a6b4073ad1ba7c4be531c59', '53d713790c804ce1b1c4d65acd66b7a0', '730200', null, '皋兰县', '22', '皋兰县', '620122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dbaa446b4ebd475387f6b987e4062b43', '53d713790c804ce1b1c4d65acd66b7a0', '730100', null, '榆中县', '23', '榆中县', '620123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8cf27c10da084fbbb9070b22d4498bed', 'd3d08413da874670810bc7cb5e0ca7de', '737100', null, '市辖区', '01', '市辖区', '620201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9ec8c0fed52244acb36db7a2098c28bf', 'c4e09846f7cc4ed69c3e6564e1c4d4ad', '737100', null, '市辖区', '01', '市辖区', '620301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0fd4073889814fab9c41ea293331c88d', 'c4e09846f7cc4ed69c3e6564e1c4d4ad', '737100', null, '金川区', '02', '金川区', '620302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bda412e6e6f04bdbbc8435e5e54d6106', 'c4e09846f7cc4ed69c3e6564e1c4d4ad', '737200', null, '永昌县', '21', '永昌县', '620321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c37c9165c794057b8798136d18fd771', '072c6981f53d4706a27a9d05225eafa2', '730900', null, '市辖区', '01', '市辖区', '620401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ffbfb37221b249098097f9f121cf8da2', '072c6981f53d4706a27a9d05225eafa2', '730900', null, '白银区', '02', '白银区', '620402', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2404b7ffe4f6442babc55ebdd0039abc', '072c6981f53d4706a27a9d05225eafa2', '730900', null, '平川区', '03', '平川区', '620403', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('417263fe1396420e9b94748cc9b6f3ad', '072c6981f53d4706a27a9d05225eafa2', '730600', null, '靖远县', '21', '靖远县', '620421', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('72bc09d35c8641f3af4cbc977403d539', '072c6981f53d4706a27a9d05225eafa2', '730700', null, '会宁县', '22', '会宁县', '620422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('da79d9f63c51470cac52780bed19c121', '072c6981f53d4706a27a9d05225eafa2', '730400', null, '景泰县', '23', '景泰县', '620423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('47796f51ff314da9903afc8d261b8085', '2388cbcd7b30404292f8e01ad88e6f8d', '741000', null, '市辖区', '01', '市辖区', '620501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e9ad4ff1afee4122b150379a88cddf71', '2388cbcd7b30404292f8e01ad88e6f8d', '741000', null, '秦城区', '02', '秦城区', '620502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ebdbec376453496095008e64f9764433', '2388cbcd7b30404292f8e01ad88e6f8d', '741000', null, '北道区', '03', '北道区', '620503', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('519fc33524114de2a6ba6db7402de69c', '2388cbcd7b30404292f8e01ad88e6f8d', '741400', null, '清水县', '21', '清水县', '620521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('442de322f06e461a900d59330b42f3af', '2388cbcd7b30404292f8e01ad88e6f8d', '741600', null, '秦安县', '22', '秦安县', '620522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4ebc6de183d94b829cc03ba40d9ebf70', '2388cbcd7b30404292f8e01ad88e6f8d', '741200', null, '甘谷县', '23', '甘谷县', '620523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('652f22a89d1e4fa3b63fdb5d9fcf8656', '2388cbcd7b30404292f8e01ad88e6f8d', '741300', null, '武山县', '24', '武山县', '620524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b14f71ca712e4aea9fdb427384026a76', 'b51c615743e24581bf67975def934d06', null, null, '东莞市', '19', '东莞市', '441900', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b14f71ca712e4aea9fdb427384026a77', 'b51c615743e24581bf67975def934d06', null, null, '中山市', '20', '中山市', '442000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c90928a31ec4f3101337c105d12011d', 'b14f71ca712e4aea9fdb427384026a76', '523000', null, '东莞', '01', '东莞市', '441901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c90928a31ec4f3101337c13f2610123', 'b14f71ca712e4aea9fdb427384026a77', '527000', null, '中山市', '01', '中山市', '442001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a7923b87579546928acbc9367f8e9177', '7009390a34474afe8e3122be8006dd75', '673400', null, '福贡县', '23', '福贡县', '533323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('25884e9fb9f1409388c320b2434a37ed', '7009390a34474afe8e3122be8006dd75', '673500', null, '贡山独龙族怒族自治县', '24', '贡山独龙族怒族自治县', '533324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2678891bd0534816ba17535d349f1f44', '4032edf9271c4bb8868553b88b39f0a8', '742200', null, '礼县', '26', '礼县', '621226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4e602bcd7f1241d7acc2e641d6d783e0', '4032edf9271c4bb8868553b88b39f0a8', '742300', null, '徽县', '27', '徽县', '621227', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('951ddcaf51114ad7974ceb36383400c0', '4032edf9271c4bb8868553b88b39f0a8', '742400', null, '两当县', '28', '两当县', '621228', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5531a6c852f74467b5d3b818a0d60484', '2c655ecb0f154555be84a4fbea473151', '731100', null, '临夏市', '01', '临夏市', '622901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8b4d6e241a0e45669b31ede581e9cb19', '2c655ecb0f154555be84a4fbea473151', '731800', null, '临夏县', '21', '临夏县', '622921', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9284849bb3cf45d7a2434a26e7e46b1d', '2c655ecb0f154555be84a4fbea473151', '731500', null, '康乐县', '22', '康乐县', '622922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3ead8bc3c0cf4b2c93c217f2956dbbae', '2c655ecb0f154555be84a4fbea473151', '731600', null, '永靖县', '23', '永靖县', '622923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('70bbc476ea4c453e84bffdb9824a8e76', '2c655ecb0f154555be84a4fbea473151', '731300', null, '广河县', '24', '广河县', '622924', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('53519cd84be04d51bd53dd5466658aba', '2c655ecb0f154555be84a4fbea473151', '731200', null, '和政县', '25', '和政县', '622925', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3c77a053c69e42519ec52eb61a0128cd', '2c655ecb0f154555be84a4fbea473151', '731400', null, '东乡族自治县', '26', '东乡族自治县', '622926', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('048ed1a93e1942c3972b86bdd7293358', '2c655ecb0f154555be84a4fbea473151', '731700', null, '积石山保安族东乡族撒拉族自治县', '27', '积石山保安族东乡族撒拉族自治县', '622927', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a4d9a489c92e4bee95ff0de97e3cd859', '1357e5dfbbf14671863b4ab27f3a49c5', '747000', null, '合作市', '01', '合作市', '623001', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9dbeacb489444579854baed7baac5866', '1357e5dfbbf14671863b4ab27f3a49c5', '747500', null, '临潭县', '21', '临潭县', '623021', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b7e9f66737194b148c9d4986684675e9', '1357e5dfbbf14671863b4ab27f3a49c5', '747600', null, '卓尼县', '22', '卓尼县', '623022', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1d09265ba6524f74a700895309c67140', '1357e5dfbbf14671863b4ab27f3a49c5', '746300', null, '舟曲县', '23', '舟曲县', '623023', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d33b467a19c94237a25ad335ab19fbb8', '1357e5dfbbf14671863b4ab27f3a49c5', '747400', null, '迭部县', '24', '迭部县', '623024', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d55903f58e55431789fc9826db836d2a', '1357e5dfbbf14671863b4ab27f3a49c5', '747300', null, '玛曲县', '25', '玛曲县', '623025', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4b813711713a48588dc09601560f8a65', '1357e5dfbbf14671863b4ab27f3a49c5', '747200', null, '碌曲县', '26', '碌曲县', '623026', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('07850b24a24a4d31a101a9fb03c71f17', '413d723baf1e4e9a89d84bd05d36ff6c', '550800', null, '紫云苗族布依族自治县', '25', '紫云苗族布依族自治县', '520425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fcfdc2f3b98f44859252f20f701ef71c', '6af6ff6ad30d464c8ab0883b16557eb7', '554300', null, '铜仁市', '01', '铜仁市', '522201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1dd2871f431b44beb6cbfca2c3661f29', '6af6ff6ad30d464c8ab0883b16557eb7', '554400', null, '江口县', '22', '江口县', '522222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1890c3f1dc514717a451bc31ab64441a', '6af6ff6ad30d464c8ab0883b16557eb7', '554000', null, '玉屏侗族自治县', '23', '玉屏侗族自治县', '522223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3144126ae1224eaf961404e869e76c61', '6af6ff6ad30d464c8ab0883b16557eb7', '555100', null, '石阡县', '24', '石阡县', '522224', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7afdf50faceb4455ae16ed67075ca994', '6af6ff6ad30d464c8ab0883b16557eb7', '565100', null, '思南县', '25', '思南县', '522225', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b4c89f328c5e41fab383da50f2da0729', '6af6ff6ad30d464c8ab0883b16557eb7', '555200', null, '印江土家族苗族自治县', '26', '印江土家族苗族自治县', '522226', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('485d22eda4d24c289e7a3d5ecdc9c056', '6af6ff6ad30d464c8ab0883b16557eb7', '565200', null, '德江县', '27', '德江县', '522227', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('853ec301d33a4dcdab98cb6076ab7f04', '6af6ff6ad30d464c8ab0883b16557eb7', '565300', null, '沿河土家族自治县', '28', '沿河土家族自治县', '522228', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b50ae9fb2f844605a00e0080d41f6413', '6af6ff6ad30d464c8ab0883b16557eb7', '554100', null, '松桃苗族自治县', '29', '松桃苗族自治县', '522229', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('21110d5b3114485184139fc732ea6c20', '6af6ff6ad30d464c8ab0883b16557eb7', '554200', null, '万山特区', '30', '万山特区', '522230', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('df846445e8644411b8905a6c6a51dc9a', 'e6c957a7e6764d25ae824740397d1146', '562400', null, '兴义市', '01', '兴义市', '522301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('81e5592014f74724ba3e404cebb774bc', 'e6c957a7e6764d25ae824740397d1146', '562300', null, '兴仁县', '22', '兴仁县', '522322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('85ab4de244ac48089f9190f62064b7e0', 'e6c957a7e6764d25ae824740397d1146', '561500', null, '普安县', '23', '普安县', '522323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d95777a9497843d58f1448e64b71bf64', 'e6c957a7e6764d25ae824740397d1146', '561400', null, '晴隆县', '24', '晴隆县', '522324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('360ba49d2c084982becddedcbe431952', 'e6c957a7e6764d25ae824740397d1146', '562200', null, '贞丰县', '25', '贞丰县', '522325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('314e625877ca40e2aec11393e8e8a7fc', 'e6c957a7e6764d25ae824740397d1146', '552300', null, '望谟县', '26', '望谟县', '522326', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('70845bbe7ce94c72b8e4edddb5b8375e', 'e6c957a7e6764d25ae824740397d1146', '552200', null, '册亨县', '27', '册亨县', '522327', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7ccdb84f92654bf69697997655f504a5', 'e6c957a7e6764d25ae824740397d1146', '552400', null, '安龙县', '28', '安龙县', '522328', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('35e0e679166c43fabf070fcbc8377863', '3bc2acb5a13f41f68fd1926c57a97d79', '551700', null, '毕节市', '01', '毕节市', '522401', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f4d8674a21bb4f6f9bda450d995f91f4', '3bc2acb5a13f41f68fd1926c57a97d79', '551600', null, '大方县', '22', '大方县', '522422', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eb89007f10334107aae3d99562d2351c', '3bc2acb5a13f41f68fd1926c57a97d79', '551500', null, '黔西县', '23', '黔西县', '522423', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('27bb4e3175c84dd9a875f0a8c28bf951', '3bc2acb5a13f41f68fd1926c57a97d79', '551800', null, '金沙县', '24', '金沙县', '522424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dfd99b8fd37f4f9399a14def9c4c58c7', '3bc2acb5a13f41f68fd1926c57a97d79', '552100', null, '织金县', '25', '织金县', '522425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f85b80f333c9430aa52b8ae6ff660727', '3bc2acb5a13f41f68fd1926c57a97d79', '553300', null, '纳雍县', '26', '纳雍县', '522426', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2d617d31c93247dab438828f2725a7c4', '3bc2acb5a13f41f68fd1926c57a97d79', '553100', null, '威宁彝族回族苗族自治县', '27', '威宁彝族回族苗族自治县', '522427', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6e6c537279314fe38d84cf56735004e1', '3bc2acb5a13f41f68fd1926c57a97d79', '553200', null, '赫章县', '28', '赫章县', '522428', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8e6b1ccf14524654aa85e1954c7a001e', 'eb15b91b9ab84251bc78527a6bc9f98a', '556000', null, '凯里市', '01', '凯里市', '522601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('48b5bee049584323bd33a73448b86e5f', 'eb15b91b9ab84251bc78527a6bc9f98a', '556100', null, '黄平县', '22', '黄平县', '522622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ab12a392b67b497ca4754ed3516b40f1', 'eb15b91b9ab84251bc78527a6bc9f98a', '556200', null, '施秉县', '23', '施秉县', '522623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b850acc10d414b749003518564fa1976', 'eb15b91b9ab84251bc78527a6bc9f98a', '556500', null, '三穗县', '24', '三穗县', '522624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fa822f2dbf3f4c7498af85aa7bc3a1ef', 'eb15b91b9ab84251bc78527a6bc9f98a', '557700', null, '镇远县', '25', '镇远县', '522625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1f9bbc3906b243a98efc1a5f04c12275', 'eb15b91b9ab84251bc78527a6bc9f98a', '557800', null, '岑巩县', '26', '岑巩县', '522626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d4f1f94022b14986aed2dd8fd5a6eba3', 'eb15b91b9ab84251bc78527a6bc9f98a', '556600', null, '天柱县', '27', '天柱县', '522627', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('13ac4a6735074f58b47c425c6b91bc77', 'eb15b91b9ab84251bc78527a6bc9f98a', '556700', null, '锦屏县', '28', '锦屏县', '522628', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1601fa6b767a40ba9fc3fe377888bb83', 'eb15b91b9ab84251bc78527a6bc9f98a', '556400', null, '剑河县', '29', '剑河县', '522629', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('056fb37934f64a35b42d3414beaccfc5', 'eb15b91b9ab84251bc78527a6bc9f98a', '556300', null, '台江县', '30', '台江县', '522630', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f10df2c0262648c19544b04b46a1ca2e', 'eb15b91b9ab84251bc78527a6bc9f98a', '557300', null, '黎平县', '31', '黎平县', '522631', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('53dd2dffd7bd41b58e283d7c27959d49', 'eb15b91b9ab84251bc78527a6bc9f98a', '557200', null, '榕江县', '32', '榕江县', '522632', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f9d3e2ddf13d45e5a0677b659c7413fb', 'eb15b91b9ab84251bc78527a6bc9f98a', '557400', null, '从江县', '33', '从江县', '522633', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b999fec263d14ec8ad4100f454f12f54', 'eb15b91b9ab84251bc78527a6bc9f98a', '557100', null, '雷山县', '34', '雷山县', '522634', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c9092e430c133300130ca397f7f00a1', 'bb2c98b3923c431da6a1566bc808c10f', '300000', null, '滨海新区', '16', '滨海新区', '120116', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a5d9ff249d034524a90315f472247034', 'eb15b91b9ab84251bc78527a6bc9f98a', '557600', null, '麻江县', '35', '麻江县', '522635', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('85e176dc8d384e228da1f95b286271bb', 'eb15b91b9ab84251bc78527a6bc9f98a', '557500', null, '丹寨县', '36', '丹寨县', '522636', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('017a1365ad3c4bbe83f1435d336281dc', '61b919f7685248a3bb577513bd98786c', '558000', null, '都匀市', '01', '都匀市', '522701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0df30ce828b147e4927e1432aeb76657', '61b919f7685248a3bb577513bd98786c', '550500', null, '福泉市', '02', '福泉市', '522702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3b9b33fc9b1e468ea94e90ef24115c9d', '61b919f7685248a3bb577513bd98786c', '558400', null, '荔波县', '22', '荔波县', '522722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ba154b993fb249c08259f389b4143975', '61b919f7685248a3bb577513bd98786c', '551300', null, '贵定县', '23', '贵定县', '522723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('74d2300e4a5c4eb383d5875c34eace04', '61b919f7685248a3bb577513bd98786c', '550400', null, '瓮安县', '25', '瓮安县', '522725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dd5419289e97478fa63f4912850accf5', '61b919f7685248a3bb577513bd98786c', '558200', null, '独山县', '26', '独山县', '522726', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('06ef5cae668e4d7498ea1508b2a6d541', '61b919f7685248a3bb577513bd98786c', '558300', null, '平塘县', '27', '平塘县', '522727', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('46beb79766904213b1b05b6f147f3f36', '61b919f7685248a3bb577513bd98786c', '550100', null, '罗甸县', '28', '罗甸县', '522728', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5b89669f6c104646a9d5194e4f720bda', '61b919f7685248a3bb577513bd98786c', '550700', null, '长顺县', '29', '长顺县', '522729', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6c0bcafad32e4c41b76f8be115ffb0b6', '61b919f7685248a3bb577513bd98786c', '551200', null, '龙里县', '30', '龙里县', '522730', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5d4152e338d3445bbefaac9eb136374d', '61b919f7685248a3bb577513bd98786c', '550600', null, '惠水县', '31', '惠水县', '522731', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8c9cdda1b23842fcb28f2b274f0b62b6', '61b919f7685248a3bb577513bd98786c', '558100', null, '三都水族自治县', '32', '三都水族自治县', '522732', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bb43c05e9b1d4aa586b7c1ce58dd7186', '5ab6b67e085546caa372b13ec883e55d', '650000', null, '市辖区', '01', '市辖区', '530101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b5a38637b18e4290a58a881c0122fc49', '5ab6b67e085546caa372b13ec883e55d', '650000', null, '五华区', '02', '五华区', '530102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1afe5616f1a84f87bd69c7faf4533916', '5ab6b67e085546caa372b13ec883e55d', '650000', null, '盘龙区', '03', '盘龙区', '530103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5e5b350c3f2b4bc8a0ae04ef86fc57e5', '5ab6b67e085546caa372b13ec883e55d', '650200', null, '官渡区', '11', '官渡区', '530111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('21cac1a6f7b04849a9423ff1c1a29ee9', '5ab6b67e085546caa372b13ec883e55d', '650100', null, '西山区', '12', '西山区', '530112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bceeee2d723845ada2b43ecfca662097', '5ab6b67e085546caa372b13ec883e55d', '654100', null, '东川区', '13', '东川区', '530113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('15aba932ca1441d5bf7cc4adf360114a', '5ab6b67e085546caa372b13ec883e55d', '650500', null, '呈贡县', '21', '呈贡县', '530121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('28066d2178784bbd833a060e23c49ae8', '5ab6b67e085546caa372b13ec883e55d', '650600', null, '晋宁县', '22', '晋宁县', '530122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8f1c32f72ba44cdda785aad267490351', '5ab6b67e085546caa372b13ec883e55d', '650400', null, '富民县', '24', '富民县', '530124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7a1a0058f44d4489a99067fd79942677', '5ab6b67e085546caa372b13ec883e55d', '652100', null, '宜良县', '25', '宜良县', '530125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c90928a3127bca0013189a8f9003f95', '18f439ed744a48ae89ca7f469af554fd', '150300', null, '阿城区', '12', '阿城区', '230112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c966215efee4442387a2bda983f2255f', '71565bd32ec9492b81bb4ab47436ddf0', '657900', null, '威信县', '29', '威信县', '530629', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('343949dd531740d6b7f28b0accbb7df9', '71565bd32ec9492b81bb4ab47436ddf0', '657800', null, '水富县', '30', '水富县', '530630', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('48a0db09f5404ffeb06f0d87e5901969', '6b376cbe3f17409599ef29acccd2d5f0', '674100', null, '市辖区', '01', '市辖区', '530701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d83e656e190d4a8e90d6f31a2802a2b8', '6b376cbe3f17409599ef29acccd2d5f0', '674100', null, '古城区', '02', '古城区', '530702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f50d36f83f6a4895814622eea822dd5f', '6b376cbe3f17409599ef29acccd2d5f0', '674100', null, '玉龙纳西族自治县', '21', '玉龙纳西族自治县', '530721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b5d07676f473495bb58a507b469dd7c5', '6b376cbe3f17409599ef29acccd2d5f0', '674200', null, '永胜县', '22', '永胜县', '530722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6624c0a2ad7b4be79877b8d26312c0b0', '6b376cbe3f17409599ef29acccd2d5f0', '674800', null, '华坪县', '23', '华坪县', '530723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('455e8ef374a14e799b429143d40539bd', '6b376cbe3f17409599ef29acccd2d5f0', '674300', null, '宁蒗彝族自治县', '24', '宁蒗彝族自治县', '530724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('587279fe026a477ba53d4d2d009f4d40', '6343ca91165140d1bcc25205a1235335', '665000', null, '市辖区', '01', '市辖区', '530801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b77a7f9942314661a212378fe54a44f1', '6343ca91165140d1bcc25205a1235335', '665000', null, '翠云区', '02', '翠云区', '530802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('56cdd6158c7740f8b8d1cdf8de709bf4', '6343ca91165140d1bcc25205a1235335', '665100', null, '普洱哈尼族彝族自治县', '21', '普洱哈尼族彝族自治县', '530821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('92eb8d2e251148369dd9784a6f954158', '6343ca91165140d1bcc25205a1235335', '654800', null, '墨江哈尼族自治县', '22', '墨江哈尼族自治县', '530822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ed31f1801fbf42b38a9c287e26a1fd85', '6343ca91165140d1bcc25205a1235335', '676200', null, '景东彝族自治县', '23', '景东彝族自治县', '530823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ccbb047c951d45f68f640f14d6fa9a63', '6343ca91165140d1bcc25205a1235335', '666400', null, '景谷傣族彝族自治县', '24', '景谷傣族彝族自治县', '530824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2b4b4f58b2b743a3bb56ffc49360a186', 'f9f4657fe4aa48bb8d324167750c9b1c', '651200', null, '禄丰县', '31', '禄丰县', '532331', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('41b307a0950a43cba144dde837763a7a', '4ac9c25b5e964e4cae428ca3b28fd2c5', '661000', null, '个旧市', '01', '个旧市', '532501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('20d482618bb4453a8e0006aec885fbbd', '4ac9c25b5e964e4cae428ca3b28fd2c5', '661600', null, '开远市', '02', '开远市', '532502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('637033d6bdb044f08fbdf6bc3fd322a5', '4ac9c25b5e964e4cae428ca3b28fd2c5', '661100', null, '蒙自县', '22', '蒙自县', '532522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('87e6bcbbdabd466984fa06b8e28f72c5', '4ac9c25b5e964e4cae428ca3b28fd2c5', '661200', null, '屏边苗族自治县', '23', '屏边苗族自治县', '532523', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('acf0bd09432948ec9c9d21820efc2614', '4ac9c25b5e964e4cae428ca3b28fd2c5', '654300', null, '建水县', '24', '建水县', '532524', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bc956477e6bc442799ee47a9a84b3420', '4ac9c25b5e964e4cae428ca3b28fd2c5', '662200', null, '石屏县', '25', '石屏县', '532525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3af6216f43c2455492fa0f637e70e3f2', '4ac9c25b5e964e4cae428ca3b28fd2c5', '652300', null, '弥勒县', '26', '弥勒县', '532526', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6a0c34c5d9c540b0b94d329adf013810', '4ac9c25b5e964e4cae428ca3b28fd2c5', '652400', null, '泸西县', '27', '泸西县', '532527', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('326f7face5e2470cb5298ff520443e22', '4ac9c25b5e964e4cae428ca3b28fd2c5', '662400', null, '元阳县', '28', '元阳县', '532528', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e67d0d64c17746648f5c988cc581f21c', '4ac9c25b5e964e4cae428ca3b28fd2c5', '654400', null, '红河县', '29', '红河县', '532529', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ea093b6405404465a58dbabf5998f08c', '4ac9c25b5e964e4cae428ca3b28fd2c5', '661500', null, '金平苗族瑶族傣族自治县', '30', '金平苗族瑶族傣族自治县', '532530', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8f25a6e4230d49eba04e9db3c2714b9e', '4ac9c25b5e964e4cae428ca3b28fd2c5', '662500', null, '绿春县', '31', '绿春县', '532531', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('78c3c7b6453148bbb4cf8d81a81687f8', '4ac9c25b5e964e4cae428ca3b28fd2c5', '661300', null, '河口瑶族自治县', '32', '河口瑶族自治县', '532532', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1de1b9ac298f4f5c8f32a50d0c89975f', '0a7b3b59379a4bb2a99de96b44f607df', '663000', null, '文山县', '21', '文山县', '532621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b8cb8562f4b3490fa7bc90e48990f71d', '0a7b3b59379a4bb2a99de96b44f607df', '663100', null, '砚山县', '22', '砚山县', '532622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4b21dd8c6c94467eabfe5eeb68171450', '0a7b3b59379a4bb2a99de96b44f607df', '663500', null, '西畴县', '23', '西畴县', '532623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4c1f5007c02441a5b83bb434c4a28e3e', '0a7b3b59379a4bb2a99de96b44f607df', '663600', null, '麻栗坡县', '24', '麻栗坡县', '532624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4723c374d1b0430b8d4f89c29dd4d747', '0a7b3b59379a4bb2a99de96b44f607df', '663700', null, '马关县', '25', '马关县', '532625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b55fb5e1964d42ce887b5fe47ec85767', '0a7b3b59379a4bb2a99de96b44f607df', '663200', null, '丘北县', '26', '丘北县', '532626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('019bb392f8774673a562763aff19c2da', '0a7b3b59379a4bb2a99de96b44f607df', '663300', null, '广南县', '27', '广南县', '532627', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e6e356eeaefd467aaf596cba3e482272', '0a7b3b59379a4bb2a99de96b44f607df', '663400', null, '富宁县', '28', '富宁县', '532628', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c5f1b1cf902540fd95f7a6a9a7ef02b8', 'fe36a09e2995441791c4e76473137fd8', '666100', null, '景洪市', '01', '景洪市', '532801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('628ca26b3e4447c6a7d72c0008c55ee0', 'fe36a09e2995441791c4e76473137fd8', '666200', null, '勐海县', '22', '勐海县', '532822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('724c0ecfd0db416aacac393f709f515f', 'fe36a09e2995441791c4e76473137fd8', '666300', null, '勐腊县', '23', '勐腊县', '532823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d1a92a97ffd045c384b755d20ef2c2fe', '7f890338eab6453e9b4015b33fd8abfc', '671000', null, '大理市', '01', '大理市', '532901', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('520f899c30ef43ab9088bd87d6baab7c', '7f890338eab6453e9b4015b33fd8abfc', '672500', null, '漾濞彝族自治县', '22', '漾濞彝族自治县', '532922', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b3774e7674b54c50aa317e6c032b1632', '7f890338eab6453e9b4015b33fd8abfc', '672100', null, '祥云县', '23', '祥云县', '532923', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e7812fab970f47b485a8ee25273dc85d', '7f890338eab6453e9b4015b33fd8abfc', '671600', null, '宾川县', '24', '宾川县', '532924', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('979f061b958b475186d7efc89ab55d73', '7f890338eab6453e9b4015b33fd8abfc', '675600', null, '弥渡县', '25', '弥渡县', '532925', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0e3fd978ff034a22a2e4b0c2ce46b748', '7f890338eab6453e9b4015b33fd8abfc', '675700', null, '南涧彝族自治县', '26', '南涧彝族自治县', '532926', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8ba8fe9f40d742a8bbb870f4ee216117', '7f890338eab6453e9b4015b33fd8abfc', '672400', null, '巍山彝族回族自治县', '27', '巍山彝族回族自治县', '532927', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('159ee8ecf1344557bc3b0e3a9928b1e1', '7f890338eab6453e9b4015b33fd8abfc', '672600', null, '永平县', '28', '永平县', '532928', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('41f833259b1e4d808c8b941ccabb4f88', '7f890338eab6453e9b4015b33fd8abfc', '672700', null, '云龙县', '29', '云龙县', '532929', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dfa70cf952b248f8adbcc1b319eb6141', '7f890338eab6453e9b4015b33fd8abfc', '671200', null, '洱源县', '30', '洱源县', '532930', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aad9b0f04a8c45f8ac29afae9075dd98', '7f890338eab6453e9b4015b33fd8abfc', '671300', null, '剑川县', '31', '剑川县', '532931', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3f07917cd59440cc9a788300fb52df0f', '7f890338eab6453e9b4015b33fd8abfc', '671500', null, '鹤庆县', '32', '鹤庆县', '532932', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('eaa9b46b1acf465d95ca915f816ebb5b', '45023fee4aae4edfb6a91ea17a0b368f', '678600', null, '瑞丽市', '02', '瑞丽市', '533102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1370bcb990884cc181d157a6769eda30', '45023fee4aae4edfb6a91ea17a0b368f', '678400', null, '潞西市', '03', '潞西市', '533103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('90f054fdbccd474cbe78096c8081de26', '45023fee4aae4edfb6a91ea17a0b368f', '679200', null, '梁河县', '22', '梁河县', '533122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6d02bcd565644d15ae59bd31eefcdd78', '45023fee4aae4edfb6a91ea17a0b368f', '679300', null, '盈江县', '23', '盈江县', '533123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2aae41ca98754a82b27869c4c03bce3c', '45023fee4aae4edfb6a91ea17a0b368f', '678700', null, '陇川县', '24', '陇川县', '533124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4456138cb87e4c5a9963187d0b59c8e5', '7009390a34474afe8e3122be8006dd75', '673200', null, '泸水县', '21', '泸水县', '533321', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('39fa946c040d4082b268b6c2e63f612b', '2388cbcd7b30404292f8e01ad88e6f8d', '733000', null, '张家川回族自治县', '25', '张家川回族自治县', '620525', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('96f70d51df7a49d6a5ad76c44dbee9e1', 'fb52b2008d774fd2b47b94f855cd16ec', '733000', null, '市辖区', '01', '市辖区', '620601', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9b81bb70a6634c36ba5abf8bc8dff51c', 'fb52b2008d774fd2b47b94f855cd16ec', '733000', null, '凉州区', '02', '凉州区', '620602', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ca45e521a5d84e9283d6eef67fd705b6', 'fb52b2008d774fd2b47b94f855cd16ec', '733300', null, '民勤县', '21', '民勤县', '620621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('81eb3dcc74f04b7c8dedc4f4251368bd', 'fb52b2008d774fd2b47b94f855cd16ec', '733100', null, '古浪县', '22', '古浪县', '620622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('87fa13be80ee4280ba1b3dea2e7156fe', 'fb52b2008d774fd2b47b94f855cd16ec', '733200', null, '天祝藏族自治县', '23', '天祝藏族自治县', '620623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f930f4298b1a474aa14af0841c71e200', '1a27e665108d48c09c043c88ff56c67d', '734000', null, '市辖区', '01', '市辖区', '620701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f031b4827c7b4c66929ba86fd1854306', '1a27e665108d48c09c043c88ff56c67d', '734000', null, '甘州区', '02', '甘州区', '620702', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('781094b312a248f3ac9914d53d45bb19', '1a27e665108d48c09c043c88ff56c67d', '734400', null, '肃南裕固族自治县', '21', '肃南裕固族自治县', '620721', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1963d023dcbc4106ac3ebf4e6c3ea656', '1a27e665108d48c09c043c88ff56c67d', '734500', null, '民乐县', '22', '民乐县', '620722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b7c38fc5da2441b2863517b7d549e980', '1a27e665108d48c09c043c88ff56c67d', '734200', null, '临泽县', '23', '临泽县', '620723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7f2729c5b20b401191eb3e5309d73057', '1a27e665108d48c09c043c88ff56c67d', '734300', null, '高台县', '24', '高台县', '620724', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a9413a38cfaa46198d2c1b2dbe5b0f9e', '1a27e665108d48c09c043c88ff56c67d', '734100', null, '山丹县', '25', '山丹县', '620725', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3386c8ef99c24167a3a09f4f5d309a45', '0e2ee1874f68474c938f9443a89fcfb1', '744000', null, '市辖区', '01', '市辖区', '620801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b129b81cd30441418e0355595f55e03a', '0e2ee1874f68474c938f9443a89fcfb1', '744000', null, '崆峒区', '02', '崆峒区', '620802', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e654f56573a84a9a8eaae3c6b640d28e', '0e2ee1874f68474c938f9443a89fcfb1', '744300', null, '泾川县', '21', '泾川县', '620821', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f3ee8949dc124f288a13ff8954ee6220', '0e2ee1874f68474c938f9443a89fcfb1', '744400', null, '灵台县', '22', '灵台县', '620822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('01cf8f3fe85849eaa0c7edcd58b86798', '0e2ee1874f68474c938f9443a89fcfb1', '744200', null, '崇信县', '23', '崇信县', '620823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('33ddbf1bc03f4e6e9c0828643210daf6', '0e2ee1874f68474c938f9443a89fcfb1', '744100', null, '华亭县', '24', '华亭县', '620824', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3920dc68d68f4005b31f9459f0794078', '0e2ee1874f68474c938f9443a89fcfb1', '744600', null, '庄浪县', '25', '庄浪县', '620825', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c41e2ddf4fde4a70934609fa5fb9c4e5', '0e2ee1874f68474c938f9443a89fcfb1', '743400', null, '静宁县', '26', '静宁县', '620826', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('6f239b0884c243aa98409bf4ff86aeff', '48a58b66b9394f1aa364c352ba1da9d3', '756400', null, '泾源县', '24', '泾源县', '640424', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b1d6bb4ec4e14491ae1a838edd4052cb', '48a58b66b9394f1aa364c352ba1da9d3', '756500', null, '彭阳县', '25', '彭阳县', '640425', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d520a3f88bad47c3b4ef77796f5c8e4e', '462784740efd4b7787f04c3ca0411c64', '751700', null, '市辖区', '01', '市辖区', '640501', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('463a5c1ffeda482c94f784c9968f4e65', '462784740efd4b7787f04c3ca0411c64', '751700', null, '沙坡头区', '02', '沙坡头区', '640502', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('fcac9a59209c4c3e9e5a0f9507646a1c', '462784740efd4b7787f04c3ca0411c64', '751200', null, '中宁县', '21', '中宁县', '640521', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1e7ffed91f0a43a595b483b4bbd3b8a5', '462784740efd4b7787f04c3ca0411c64', '751800', null, '海原县', '22', '海原县', '640522', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ada960d4919b4e31974f98e60ab6ad6b', '1bcb916fa3f64e599569392aaaf05b7a', '830000', null, '市辖区', '01', '市辖区', '650101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('9af9ab5574544abd98b7aae9283cfdd2', '1bcb916fa3f64e599569392aaaf05b7a', '830000', null, '天山区', '02', '天山区', '650102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('041b5eab73b74e61b491fd95b012db0b', '1bcb916fa3f64e599569392aaaf05b7a', '830000', null, '沙依巴克区', '03', '沙依巴克区', '650103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5ae346d18e43486baa026944a9699d6b', '1bcb916fa3f64e599569392aaaf05b7a', '830000', null, '新市区', '04', '新市区', '650104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('e9971b02ae9e4d7894d31fcff4302885', '1bcb916fa3f64e599569392aaaf05b7a', '830000', null, '水磨沟区', '05', '水磨沟区', '650105', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('275c8d1669ba4d76804bb53660baaaff', '1bcb916fa3f64e599569392aaaf05b7a', '830000', null, '头屯河区', '06', '头屯河区', '650106', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('42ec3d7675f44219814836b51b8253ee', '1bcb916fa3f64e599569392aaaf05b7a', '830000', null, '达坂城区', '07', '达坂城区', '650107', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a024de9be7004b6a8061949e8734a012', '1bcb916fa3f64e599569392aaaf05b7a', '830000', null, '东山区', '08', '东山区', '650108', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2539b660310a4c02a3deb3a302dd4d96', '1bcb916fa3f64e599569392aaaf05b7a', '830000', null, '乌鲁木齐县', '21', '乌鲁木齐县', '650121', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1281da9e93ca4774a8970251a5761f56', '1a1c0daee49a410abe7540db0be7088a', '834000', null, '市辖区', '01', '市辖区', '650201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ebe60ff05c8549a4aed73757f894b616', '1a1c0daee49a410abe7540db0be7088a', '838600', null, '独山子区', '02', '独山子区', '650202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('661f61a3323a423ca0eab0e3c6bb0470', '1a1c0daee49a410abe7540db0be7088a', '834000', null, '克拉玛依区', '03', '克拉玛依区', '650203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('da63785835e04485b8dd1b0a0c25522f', '1a1c0daee49a410abe7540db0be7088a', '834000', null, '白碱滩区', '04', '白碱滩区', '650204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d5aedba7451045779a87169da7071ebd', '1a1c0daee49a410abe7540db0be7088a', '834000', null, '乌尔禾区', '05', '乌尔禾区', '650205', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('bc9dd0e0b59b430586fdeb27ede90f4d', '3d7c967cb651462cbf8ebf9e1d44676e', '838000', null, '吐鲁番市', '01', '吐鲁番市', '652101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b78254842d554e2fa27edfd059811071', '3d7c967cb651462cbf8ebf9e1d44676e', '838200', null, '鄯善县', '22', '鄯善县', '652122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5372a22653704b4b9188c133c245aa61', '3d7c967cb651462cbf8ebf9e1d44676e', '838100', null, '托克逊县', '23', '托克逊县', '652123', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0cbb7a7eb89444b4bcbcd34e220b9aec', '722028de91e449f9a753de307cdb0d97', '839000', null, '哈密市', '01', '哈密市', '652201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7c2492f86e6d471a9ae2648d31188446', '722028de91e449f9a753de307cdb0d97', '839200', null, '巴里坤哈萨克自治县', '22', '巴里坤哈萨克自治县', '652222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d94ba1ff460345a5b502a231b4b5900b', '722028de91e449f9a753de307cdb0d97', '839300', null, '伊吾县', '23', '伊吾县', '652223', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('026b52173dc740818c362b8bc48e3266', 'abb7d66db87e4d2996304371f67e37a6', '831100', null, '昌吉市', '01', '昌吉市', '652301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('78653fe0a4284ccc9ca7dc68c5ad31ed', 'abb7d66db87e4d2996304371f67e37a6', '831500', null, '阜康市', '02', '阜康市', '652302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('7d35ee0bdfb14100bc96cab4160bdd8e', 'abb7d66db87e4d2996304371f67e37a6', '831400', null, '米泉市', '03', '米泉市', '652303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0340c7bc82014a03a12bb4ebd540cf97', 'abb7d66db87e4d2996304371f67e37a6', '831200', null, '呼图壁县', '23', '呼图壁县', '652323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d5884599b7784ade9758891fd25f96d4', 'abb7d66db87e4d2996304371f67e37a6', '832200', null, '玛纳斯县', '24', '玛纳斯县', '652324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('33863c6a7d9845c8940aae756965eaad', 'abb7d66db87e4d2996304371f67e37a6', '831800', null, '奇台县', '25', '奇台县', '652325', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a8e27352a79f4853bccf2e253b0bc19e', 'abb7d66db87e4d2996304371f67e37a6', '831700', null, '吉木萨尔县', '27', '吉木萨尔县', '652327', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('53574431208a48bf88dec6b8bf8d85ff', 'abb7d66db87e4d2996304371f67e37a6', '831900', null, '木垒哈萨克自治县', '28', '木垒哈萨克自治县', '652328', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('d60a9706eb7b442b948b61c1f693ce4b', 'dfcf7241f1744ba1a5102d7ac628aee8', '833400', null, '博乐市', '01', '博乐市', '652701', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4c637a30133b4eb5943c4d67d8e590ef', 'dfcf7241f1744ba1a5102d7ac628aee8', '833300', null, '精河县', '22', '精河县', '652722', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('262f7ff4fbd54483bea49eb1538a7e6c', 'dfcf7241f1744ba1a5102d7ac628aee8', '833500', null, '温泉县', '23', '温泉县', '652723', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4af475aace064f4bbce38c8643f2a413', 'b9b5bc2ccede4027a1f74f80e6341da6', '841000', null, '库尔勒市', '01', '库尔勒市', '652801', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1f9a78ac9d234b26abe58ee20ed07a4d', 'b9b5bc2ccede4027a1f74f80e6341da6', '841600', null, '轮台县', '22', '轮台县', '652822', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5435477e53a24216986930a2ae1f7942', 'b9b5bc2ccede4027a1f74f80e6341da6', '841500', null, '尉犁县', '23', '尉犁县', '652823', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ded1842c986e497995dc66af0d87398a', 'be59c52820d04d2c9b5c91d7f4dae34f', '859200', null, '改则县', '26', '改则县', '542526', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b37746d1475b4bd6845f29bd04a2b7bc', 'be59c52820d04d2c9b5c91d7f4dae34f', '859300', null, '措勤县', '27', '措勤县', '542527', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('449e32cd89a941e4aa49def22c13ca3b', '83bc76056d074e4c94c5824d81e94650', '860100', null, '林芝县', '21', '林芝县', '542621', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5fb2bd63dec944e08e2534cc93c6e1ce', '83bc76056d074e4c94c5824d81e94650', '860200', null, '工布江达县', '22', '工布江达县', '542622', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8eceeee425ce425daa640b8dd096a217', '83bc76056d074e4c94c5824d81e94650', '860500', null, '米林县', '23', '米林县', '542623', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('dc4c956a438e4107a1bfe0c0433dde73', '83bc76056d074e4c94c5824d81e94650', '860700', null, '墨脱县', '24', '墨脱县', '542624', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('364b773c899a4a848e5c4e35ea6b4af5', '83bc76056d074e4c94c5824d81e94650', '860300', null, '波密县', '25', '波密县', '542625', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('353d6c75aea9465189a16ca7bcd3e775', '83bc76056d074e4c94c5824d81e94650', '860600', null, '察隅县', '26', '察隅县', '542626', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8fbf0edbedc14bf8ac3400151c142638', '83bc76056d074e4c94c5824d81e94650', '860400', null, '朗县', '27', '朗县', '542627', null);
commit;
----prompt 3500 records committed...
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a9b12c094d2449aa89c02f6d7e046b58', '66d88b8406a8414580256a8811834fea', '710000', null, '市辖区', '01', '市辖区', '610101', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('8dc4f38786954e4f9a8d0e90464825a8', '66d88b8406a8414580256a8811834fea', '710000', null, '新城区', '02', '新城区', '610102', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('16c5ce728e1e4c19b92bbef316315ed0', '66d88b8406a8414580256a8811834fea', '710000', null, '碑林区', '03', '碑林区', '610103', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('3fd112e4114041d59c68ce11c329425a', '66d88b8406a8414580256a8811834fea', '710000', null, '莲湖区', '04', '莲湖区', '610104', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('0f527782d868482485c021c421106109', '66d88b8406a8414580256a8811834fea', '710000', null, '灞桥区', '11', '灞桥区', '610111', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('791d8a1398aa481aa154e55131ee0d82', '66d88b8406a8414580256a8811834fea', '710000', null, '未央区', '12', '未央区', '610112', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('aae9f4db0d44496195ab8d6bfe4ca8bf', '66d88b8406a8414580256a8811834fea', '710000', null, '雁塔区', '13', '雁塔区', '610113', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('a817344864464a01ad1c0265276e76e9', '66d88b8406a8414580256a8811834fea', '710000', null, '阎良区', '14', '阎良区', '610114', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('c98912768a2648d7b6a8603a393acb28', '66d88b8406a8414580256a8811834fea', '710600', null, '临潼区', '15', '临潼区', '610115', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('1f09605d94f74f59b121db8401fc0d10', '66d88b8406a8414580256a8811834fea', '710100', null, '长安区', '16', '长安区', '610116', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('f556dad019e646a48d427b8c5788bb14', '66d88b8406a8414580256a8811834fea', '710500', null, '蓝田县', '22', '蓝田县', '610122', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5d699224632b4acbba2f6230ae8b2596', '66d88b8406a8414580256a8811834fea', '710400', null, '周至县', '24', '周至县', '610124', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('49b0a79a81f34b4fb0641dc2b6020847', '66d88b8406a8414580256a8811834fea', '710300', null, '户县', '25', '户县', '610125', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('ba2de7ed62674c80b1cd07e83fce55ff', '66d88b8406a8414580256a8811834fea', '710200', null, '高陵县', '26', '高陵县', '610126', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('10744049cae14d3cab9f5ef1308b6743', 'dc7a159373914f47badac80b9cf2017c', '727000', null, '市辖区', '01', '市辖区', '610201', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('54fe4530b2ac4293beb6891e14aea915', 'dc7a159373914f47badac80b9cf2017c', '727000', null, '王益区', '02', '王益区', '610202', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cfa1b6672a224757b45ca2189cb63033', 'dc7a159373914f47badac80b9cf2017c', '727000', null, '印台区', '03', '印台区', '610203', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('49204d6bda5c4199894cbf6b4233e191', 'dc7a159373914f47badac80b9cf2017c', '727100', null, '耀州区', '04', '耀州区', '610204', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('688189766a1b4688ab1e5e19c35070ea', 'dc7a159373914f47badac80b9cf2017c', '727200', null, '宜君县', '22', '宜君县', '610222', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('4636d819875a42ad8199ddae8b5095ee', '82170bdd8f344d218a4c5ac36f7ecba1', '721000', null, '市辖区', '01', '市辖区', '610301', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b60831fc3e8749798345067aa041a895', '82170bdd8f344d218a4c5ac36f7ecba1', '721000', null, '渭滨区', '02', '渭滨区', '610302', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('761e129703584c21b3a9d8de8a95e5ee', '82170bdd8f344d218a4c5ac36f7ecba1', '721000', null, '金台区', '03', '金台区', '610303', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('5fca70d0160f498d824e96d33f51dcee', '82170bdd8f344d218a4c5ac36f7ecba1', '721300', null, '陈仓区', '04', '陈仓区', '610304', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('cebd313ae9404e0aabf84b2df2abc210', '82170bdd8f344d218a4c5ac36f7ecba1', '721400', null, '凤翔县', '22', '凤翔县', '610322', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('b085bbbd9fe34803b002946c7d0a3da6', '82170bdd8f344d218a4c5ac36f7ecba1', '722400', null, '岐山县', '23', '岐山县', '610323', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('91964c8a8a3c4c7eb85797f71ec3878e', '82170bdd8f344d218a4c5ac36f7ecba1', '722200', null, '扶风县', '24', '扶风县', '610324', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('62309e52cae742e38703dacfe629a941', '82170bdd8f344d218a4c5ac36f7ecba1', '722300', null, '眉县', '26', '眉县', '610326', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c9092e430e90bb50130e9c90e010167', '2c9092e430e90bb50130e9c865110162', '未知', '未知区', '未知区', '00', '未知区', '000000', null);
insert into BASIC_DISTRICT (ID, PARENTID, POSTALCODE, REMARK, NAME, CODE, FULLNAME, IDCARDCODE, TYPE)
values ('2c9092e43263a8df013266254ddf389c', '2388cbcd7b30404292f8e01ad88e6f8d', '741000', null, '秦州区', '02', '秦州区', '620502', null);
commit;
----prompt "webdemo模块:初始化基础数据  end..." 
----prompt "webdemo模块:初始化基础数据  start..." 
INSERT INTO OPER_OPERATOR(ID,LOGINNAME,PASSWORD,USERNAME)
	values('123456','admin','admin','admin');
INSERT INTO OPER_OPERATOR(ID,LOGINNAME,PASSWORD,USERNAME)
	values('123456001','yr','yr','yr');
INSERT INTO OPER_OPERATOR(ID,LOGINNAME,PASSWORD,USERNAME)
	values('123456002','pqy','pqy','pqy');
commit;
--TRUNCATE TABLE OPER_ORGANIZATION;
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values(null,'人员','集团公司','集团公司','1000000','1000000');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('1000000','人员','系统开发部','集团公司_系统开发部','1100000001','1100000001');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('1000000','人员','人力资源部','集团公司_系统开发部','1100000002','1100000002');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('1000000','人员','审计部','集团公司_系统开发部','1100000003','1100000003');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('1000000','人员','市场部','集团公司_市场部','1100000004','1100000004');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('1100000004','人员','销售一科','集团公司_市场部_销售一科','1100000004001','1100000004001');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('1100000004','人员','销售二科','集团公司_市场部_销售二科','1100000004002','1100000004002');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('1100000004001','人员','销售一组','集团公司_市场部_销售一组','1100000004003','1100000004003');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('1000000','人员','分公司A','分公司A','1000001','1000001');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('1000000','人员','分公司B','分公司B','1000002','1000002');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('1000001','人员','分公司网点A','分公司网点A','1000001001','1000001001');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('1000001','人员','分公司网点B','分公司网点B','1000001002','1000001002');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values(null,'人员','合作方公司A','合作方公司A','2000000','2000000');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values(null,'人员','合作方公司B','合作方公司B','3000000','3000000');
insert into OPER_ORGANIZATION(PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values(2000000,'人员','合作方公司B办事处A','合作方公司B办事处A','2000001','2000001');
commit;
insert into OPER_POST(id,parentId,name,organizationId,code,remark)
	values('1000000301',null,'部门经理','1000000',null,'集团公司系统开发部部门经理');
insert into OPER_POST(id,parentId,name,organizationId,code,remark)
	values('100000030101','1000000301','项目经理','1000000',null,'集团公司系统开发部项目经理');
insert into OPER_POST(id,parentId,name,organizationId,code,remark)
	values('100000030102','1000000301','SE','1000000',null,'集团公司系统开发部SE');
insert into OPER_POST(id,parentId,name,organizationId,code,remark)
	values('10000003010101','100000030101','高级软件工程师','1000000',null,'集团公司系统开发部高级软件工程师');
insert into OPER_POST(id,parentId,name,organizationId,code,remark)
	values('10000003010102','100000030101','工程师','1000000',null,'集团公司系统开发部工程师');
insert into OPER_POST(id,parentId,name,organizationId,code,remark)
	values('10000003010103','100000030101','助理工程师','1000000',null,'集团公司系统开发部助理工程师');
commit;
----prompt "webdemo模块:初始化基础数据  end..." 
----prompt "webdemo模块:创建任务job  end..."
----prompt "webdemo模块:创建任务job  end..."

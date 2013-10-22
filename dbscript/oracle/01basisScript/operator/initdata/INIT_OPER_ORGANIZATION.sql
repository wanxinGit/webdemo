--TRUNCATE TABLE OPER_ORGANIZATION;
insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('001',null,'人员','集团公司','集团公司','1000000','1000000');
insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('001','1000000','人员','系统开发部','集团公司_系统开发部','1100000001','1100000001');
insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('001','1000000','人员','人力资源部','集团公司_系统开发部','1100000002','1100000002');
insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('001','1000000','人员','审计部','集团公司_系统开发部','1100000003','1100000003');
insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('001','1000000','人员','市场部','集团公司_市场部','1100000004','1100000004');
insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('001','1100000004','人员','销售一科','集团公司_市场部_销售一科','1100000004001','1100000004001');
insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('001','1100000004','人员','销售二科','集团公司_市场部_销售二科','1100000004002','1100000004002');
insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('001','1100000004001','人员','销售一组','集团公司_市场部_销售一组','1100000004003','1100000004003');

insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('00101','1000000','人员','分公司A','分公司A','1000001','1000001');
insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('00101','1000001','人员','分公司网点A','分公司网点A','1000001001','1000001001');
  
insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('00102','1000000','人员','分公司B','分公司B','1000002','1000002');
insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('00102','1000001','人员','分公司网点B','分公司网点B','1000001002','1000001002');

insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('002',null,'人员','合作方公司A','合作方公司A','2000000','2000000');
insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('003',null,'人员','合作方公司B','合作方公司B','3000000','3000000');
insert into OPER_ORGANIZATION(VCID,PARENTID,CHIEFTYPE,NAME,FULLNAME,ID,CODE)
  values('003',2000000,'人员','合作方公司B办事处A','合作方公司B办事处A','2000001','2000001');
commit;

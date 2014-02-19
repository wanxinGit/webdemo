DROP TABLE OPER_OPERATOR_HIS;
CREATE TABLE OPER_OPERATOR_HIS(
	id varchar(64),
	valid smallint DEFAULT 1 NOT NULL,
	pwdErrCount smallint,
	historyPwd varchar(255),
	organizationId varchar(64),
	password varchar(255),
	invalidDate timestamp,
	lastUpdateDate timestamp not null,
	pwdUpdateDate timestamp not null,
	mainPostId varchar(64),
	userName varchar(64),
	locked smallint default 0 not null,
	createDate timestamp not null,
	examinePwd varchar(255),
	loginName varchar(64)  not null,
	primary key(ID)
);

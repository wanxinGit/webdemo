create table hc_la_loanaccount_detail(
	id varchar(64) NOT NULL,
	loanBillNumber varchar(64),
	status varchar(64),
	createOperatorName varchar(64),
	createDate varchar(64),
	creditProductName varchar(64),
	totalPeriod varchar(64),
	interestRate varchar(64),
	uses varchar(64),
	loanAmount varchar(64),
	maxMonthlyRepayAmount varchar(64),
	spouseName varchar(64),
	spouseWorkUnitPhoneNumber varchar(32),
	spouseTelePhoneNumber varchar(32),
	idCardType varchar(64),
	idCardNumber varchar(64),
	clientName varchar(32),
	hasHouse varchar(32),
	applyDate varchar(32),
	refuseOtherReason varchar(255),
	linkInfo varchar(255),
	districtName varchar(64),
	patchReason varchar(255),
	linkManPhoneNumber1 varchar(32),
	linkManPhoneNumber2 varchar(32),
	linkManPhoneNumber3 varchar(32),
	linkManPhoneNumber4 varchar(32),
	kinPhoneNumber1 varchar(32),
	kinPhoneNumber2 varchar(32),
	kinPhoneNumber3 varchar(32),
	kinPhoneNumber4 varchar(32),
	firstTrialOperator varchar(32),
	firstTrialDate varchar(32),
	finalTrialOperator varchar(32),
	finalTrialDate varchar(32),
	workUnitInfo varchar(255),
	workUnitPhoneNumber varchar(64),
	workUnitIndustry varchar(255),
	workInfo varchar(128),
	refuseReason varchar(255),
	sex varchar(32),
	hasMortgage varchar(32),
	patchDate varchar(32),
	urgent varchar(64),
	housePhoneNumber varchar(32),
	telePhoneNumber varchar(32),
	startLiveDate varchar(32),
	customerServiceOfficer varchar(64),
	customerServiceTeamManager varchar(64),
	customerServiceManager varchar(64),
	serviceClientName varchar(64),
	remark varchar(2000),
	month varchar(32),
	primary key(ID)
);
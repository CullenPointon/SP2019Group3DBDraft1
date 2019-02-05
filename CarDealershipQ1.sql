use CarDealership


 
if(OBJECT_ID('NonMember') is not null)
	drop table NonMember;
if(OBJECT_ID('Member') is not null)
	drop table Member; 
if(OBJECT_ID('Cust_Trans') is not null)
	drop table Cust_Trans; 
if(OBJECT_ID('CustPhone') is not null)
	drop table CustPhone; 
if(OBJECT_ID('Car_Transaction') is not null)
	drop table Car_Transaction; 
if(OBJECT_ID('Trans') is not null)
	drop table Trans; 
if(OBJECT_ID('SalesPerson_Dealership') is not null)
	drop table SalesPerson_Dealership; 
if(OBJECT_ID('EmpDates') is not null)
	drop table EmpDates; 
if(OBJECT_ID('SalesPerson') is not null)
	drop table SalesPerson;
if(OBJECT_ID('Customer') is not null)
	drop table Customer;
if(OBJECT_ID('Dealership') is not null)
	drop table Dealership; 


CREATE TABLE Dealership(
DSID int not null identity(1,1),
DSOpenDate datetime2(7),
DSRev money,
DSLocation nvarchar(1250),
DSOwner nvarchar(150),
DSMan nvarchar(150),
constraint pkDealership primary key(DSID)
);

CREATE TABLE SalesPerson(
SPID int not null identity(800, 1),
SPFirstName nvarchar(200),
SPLastName nvarchar(200),
SPdob datetime2(7),
SPSalesCount int,
SPSalesTotal int,
constraint pkSalesPerson primary key(SPID)
);

CREATE TABLE EmpDates(
SPID int not null,
DSID int not null,
SPStartDate datetime2(7) not null,
SPEndDate datetime2(7),
constraint fkEmpDates foreign key(SPID) references SalesPerson(SPID),
constraint fkEmpDates2 foreign key(DSID) references Dealership(DSID) 
);

CREATE TABLE SalesPerson_Dealership(
SPID int not null,
DSID int not null,
constraint pkSalesPerson_Dealership primary key(SPID, DSID),
constraint fkSalesPerson_Dealership foreign key(SPID) references SalesPerson(SPID)
);

CREATE TABLE Trans(
TransNum int not null identity(100, 1),
TransType nvarchar(200),
TransDate datetime2(7),
TransTime nvarchar(150),
TransAmt int,
TransIntRt nvarchar(75),
TransQty int,
constraint pkTrans primary key(TransNum)
);

CREATE TABLE Car_Transaction(
CarID int not null identity(200, 1),
TransNum int not null,
CarMake nvarchar(200) not null,
CarModel nvarchar(200) not null,
CarType nvarchar(200) not null,
EngType nvarchar(200) not null,
GasType nvarchar(150),
CarYr int not null,
CarMileage int not null,
TireType nvarchar(200),
RimSz nvarchar(10),
TransType nvarchar(150),
TransDate datetime2(7),
TransTime nvarchar(150),
TransAmt int,
TransIntRt nvarchar(75),
TransQty int,
constraint pkCar_Trans primary key(CarID, TransNum),
constraint fkCar_Trans foreign key(TransNum) references Trans(TransNum)
);

CREATE TABLE Customer(
CustID int not null identity(1, 1),
Custdob datetime2(7) not null,
CustFName nvarchar(150) not null,
CustLName nvarchar(150) not null,
CustEmail nvarchar(1000) not null,
CustStName nvarchar(500) not null,
CustStNum int not null,
CustZip int not null,
CustState nvarchar(250) not null,
CustAptNum int,
constraint pkCustomer primary key(CustID)
);

CREATE TABLE CustPhone(
CustPhone nvarchar(20),
CustID int not null,
constraint pkCustPhone primary key(CustID, CustPhone),
constraint fkCustPhone foreign key(CustID) references Customer(CustID),
);

CREATE TABLE Cust_Trans(
TransNum int not null,
CustID int not null,
constraint pkCust_Trans primary key(TransNum, CustID),
constraint fkCustTrans foreign key(TransNum) references Trans(TransNum),
constraint fkCustTrans2 foreign key(CustID) references Customer(CustID)
);

CREATE TABLE Member(
CustID int not null,
MemDiscount money,
constraint pkMember primary key(CustID),
constraint fkMember foreign key(CustID) references Customer(CustID)
);

CREATE TABLE NonMember(
CustID int not null,
NonMemLastVisit datetime2(7)
constraint pkNonMember primary key(CustID),
constraint fkNonMember foreign key(CustID) references Customer(CustID)
);
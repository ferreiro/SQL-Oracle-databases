drop table Publisher cascade constraints;
drop table Publication cascade constraints;
drop table Theme cascade constraints;
drop table Clasification cascade constraints;
drop table Book cascade constraints;
drop table Biblioteca cascade constraints;
drop table Member cascade constraints;
drop table BookCopy cascade constraints;
drop table Journal cascade constraints;
drop table JournalCopy cascade constraints;
drop table Subscription cascade constraints; 

create table Publisher(
	Name varchar(28) PRIMARY KEY NOT NULL, 
	Address varchar(40), 
	Phone number(9, 0)
);

create table Publication(
	ISBN varchar(13) PRIMARY KEY NOT NULL, 
	Title varchar(25), 
	Language varchar(25), 
	NPublisher varchar(28),
	foreign key(NPublisher) references Publisher
);

create table Theme(
	IDTheme varchar(15) PRIMARY KEY NOT NULL,
	Description varchar(140)
);

create table Clasification(
	ISBN varchar(13), 
	IDTheme varchar(15),
	foreign key(IDTheme) references Theme,
	foreign key(ISBN) references Publication,
	constraint ISBN_ID_PK primary key(ISBN, IDTheme)
);

create table Book(
	ISBN varchar(13) primary key not null,
	edition number(2),
	ed_date date,
	foreign key(ISBN) references Publication
);

create table Biblioteca(
	Postal_Code number(5) primary key not null
);

create table Member(
	NMember number primary key,
	Name varchar(20),
	Email varchar(33),
	Postal_Code number(5),
	foreign key(Postal_Code) references Biblioteca /* Relate postal code with Biblioteca*/
);

create table BookCopy(
	ISBN varchar(13),
	PC number(5),
	Num number(2),
	Adq_Date date,
	NMember number null, /* PONER LO DE NULLABLE*/
	BorrowDate date null,

	foreign key(ISBN) references Book,
	foreign key(PC) references Biblioteca,
	foreign key(NMember) references Member,
	constraint ISBN_Postalcode_PK primary key (ISBN, PC) /* Join ISBN and PC as the primary key*/
);

create table Journal(
	ISBN varchar(13) primary key,
	Frecuency number,

	foreign key(ISBN) references Publication
);

create table Subscription(
	ISBN varchar(13),
	PC number(5),
	Sub_Date date NULL,
	foreign key(ISBN) references Journal,
	foreign key(PC) references Biblioteca,
	constraint ISBN_PK primary key(ISBN, PC)
);

create table JournalCopy(
	ISBN varchar(13),
	PostalCode number(5),
	Num number(2),
	NMember number null,
	
	foreign key(ISBN, PostalCode) references Subscription,
	foreign key(NMember) references Member,
	constraint ISBN_PC_Num_PK primary key(ISBN, PostalCode, Num) /* ???: key(ISBN, PostalCode, Num) */
);

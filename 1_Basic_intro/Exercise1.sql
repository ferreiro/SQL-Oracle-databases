DROP TABLE Theme CASCADE constraints;
DROP TABLE Clasification CASCADE constraints;
DROP TABLE Publisher CASCADE constraints;
DROP TABLE Publication CASCADE constraints;

DROP TABLE Book CASCADE constraints;
DROP TABLE Biblioteca CASCADE constraints;
DROP TABLE Journal CASCADE constraints;
DROP TABLE Subscription CASCADE constraints;

DROP TABLE Member CASCADE constraints;
DROP TABLE JournalCopy CASCADE constraints;
DROP TABLE BookCopy CASCADE constraints;

/* 
 * Creatign all neccesary tables for Publication
 * before creating Publication table:
 * - Theme
 * - Clasification
 * - Publisher
 */
CREATE TABLE Theme (
  IdTheme NUMBER, 
  Description VARCHAR(100),
  CONSTRAINT TME_PK PRIMARY KEY(IdTheme)
); 

CREATE TABLE Publisher(
  Name VARCHAR(20),
  Address VARCHAR(30),
  Phone NUMBER(9),
  
  CONSTRAINT pus_PK PRIMARY KEY(Name)
);

CREATE TABLE Publication(
  ISBN VARCHAR(13),
  Title varchar(30),
  Language varchar(20),
  NPublisher varchar(20),
  
  CONSTRAINT pub_PK PRIMARY KEY(ISBN),
  CONSTRAINT pub_FK FOREIGN KEY(NPublisher) REFERENCES Publisher 
);

CREATE TABLE Clasification(
  ISBN VARCHAR(13),
  IDTheme NUMBER,
  
  CONSTRAINT CLA_PK PRIMARY KEY(ISBN, IDTheme),
  CONSTRAINT CLA_FK_ISBN FOREIGN KEY(ISBN) REFERENCES Publication on delete CASCADE,
  CONSTRAINT CLA_FK_Theme FOREIGN KEY(IDTheme) REFERENCES Theme
);

/*
 * Library System
 */

CREATE TABLE Book(
  ISBN VARCHAR(13),
  edition NUMBER(1),
  ed_date DATE,
  
  CONSTRAINT boo_PK PRIMARY KEY(ISBN),
  CONSTRAINT boo_FK FOREIGN KEY(ISBN) REFERENCES Publication
);

CREATE TABLE Biblioteca(
  potal_Code NUMBER(5),
  
  CONSTRAINT bib_PK PRIMARY KEY(potal_Code)
);

CREATE TABLE Journal (
  ISBN VARCHAR(13), 
  Frecuency VARCHAR(10),
  
  CONSTRAINT jou_pk PRIMARY KEY(ISBN),
  CONSTRAINT jou_fk FOREIGN KEY(ISBN) REFERENCES Publication ON DELETE cascade
);

CREATE TABLE Subscription(
  ISBN VARCHAR(13), 
  PC NUMBER(5), 
  Sub_Date DATE,
  
  CONSTRAINT sub_pk_isbn PRIMARY KEY(ISBN, PC),
  CONSTRAINT sub_fk_isbn FOREIGN KEY(ISBN) REFERENCES Journal ON DELETE cascade,
  CONSTRAINT sub_fk_pc FOREIGN KEY(PC) REFERENCES Biblioteca
);

CREATE TABLE Member (
  NMember NUMBER, 
  name VARCHAR(20), 
  email VARCHAR(25), 
  Postal_Code NUMBER(5),
  
  CONSTRAINT mem_pk_nm PRIMARY KEY(NMember),
  CONSTRAINT mem_fk_pc FOREIGN KEY(Postal_Code) REFERENCES Biblioteca ON DELETE SET NULL
);

CREATE TABLE JournalCopy(
  ISBN VARCHAR(13), 
  PostalCode NUMBER(5),
  Num NUMBER(3), 
  NMember NUMBER NULL,
  
  CONSTRAINT jou_pk_ISBNPcNum PRIMARY KEY(ISBN, PostalCode, Num),
  CONSTRAINT jou_fk_ISBNPc FOREIGN KEY(ISBN, PostalCode) REFERENCES Subscription,
  CONSTRAINT jou_fk_NMember FOREIGN KEY(NMember) REFERENCES Member ON DELETE SET NULL
);

CREATE TABLE BookCopy(
  ISBN VARCHAR(13), 
  PC NUMBER(5),
  Num NUMBER(3), 
  Adq_Date DATE,
  NMember NUMBER NOT NULL,
  BorrowDate DATE NOT NULL,
  
  CONSTRAINT bookCopy_pk_ISBNPc PRIMARY KEY(ISBN, PC),
  CONSTRAINT bookCopy_fk_NMember FOREIGN KEY(NMember) REFERENCES Member
);

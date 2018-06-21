create database if not exists dbfinal_10165101137;
use dbfinal_10165101137;

create table if not exists PART
(
  P_PARTKEY int primary key,/*identifier SF*200,000 are populated*/
  P_NAME varchar(55),
  P_MFGR char(25),
  P_BRAND char(10),
  P_TYPE varchar(25),
  P_SIZE int,
  P_CONTAINER char(10),
  P_RETAILPRICE double,
  P_COMMENT varchar(23) 
);
describe PART;

create table if not exists REGION
(
  R_REGIONKEY int  primary key,/*identifier 5 regions are populated*/
  R_NAME char(25),
  R_COMMENT varchar(152)
);
describe REGION;

create table if not exists NATION
(
  N_NATIONKEY int primary key,/*identifier 25 nations are populated*/
  N_NAME char(25),
  N_REGIONKEY int,
  N_COMMENT varchar(152),
  foreign key(N_REGIONKEY) references REGION(R_REGIONKEY) on delete cascade
);
describe NATION;


create table if not exists SUPPLIER
(
  S_SUPPKEY int primary key,
  S_NAME char(25),
  S_ADDRESS varchar(40),
  S_NATIONKEY int,
  S_PHONE char(15),
  S_ACCTBAL double,
  S_COMMENT varchar(101),
  foreign key(S_NATIONKEY) references NATION(N_NATIONKEY) on delete cascade
);
describe SUPPLIER;

create table if not exists PARTSUPP
(
  PS_PARTKEY int,
  PS_SUPPKEY int,
  PS_AVAILQTY int,
  PS_SUPPLYCOST double,
  PS_COMMENT varchar(199),
  primary key(PS_PARTKEY, PS_SUPPKEY),
  foreign key(PS_PARTKEY) references PART(P_PARTKEY) on delete cascade,
  foreign key(PS_SUPPKEY) references SUPPLIER(S_SUPPKEY) on delete cascade
);
describe PARTSUPP;

create table if not exists CUSTOMER
(
  C_CUSTKEY int primary key, /*SF*150,000 are populated*/
  C_NAME varchar(25),
  C_ADDRESS varchar(40),
  C_NATIONKEY int,
  C_PHONE char(15),
  C_ACCTBAL double,
  C_MKTSEGMENT char(10),
  C_COMMENT varchar(117),
  foreign key(C_NATIONKEY) references NATION(N_NATIONKEY) on delete cascade
);
describe CUSTOMER;

/*
Comment: Orders are not present for all customers. In fact, one-third of the customers do not have any order in the database. The orders are assigned at random to two-thirds of the customers
*/
create table if not exists ORDERS
(
  O_ORDERKEY int primary key,/*SF*1,500,000 are sparsely populated*/
  O_CUSTKEY int,
  O_ORDERSTATUS char(1),
  O_TOTALPRICE double,
  O_ORDERDATE date,
  O_ORDERPRIORITY char(15),
  O_CLERK char(15),
  O_SHIPPRIORITY int,
  O_COMMENT varchar(79),
  foreign key(O_CUSTKEY) references CUSTOMER(C_CUSTKEY) on delete cascade
);
describe ORDERS;


create table if not exists LINEITEM
(
  L_ORDERKEY int,
  L_PARTKEY int,
  L_SUPPKEY int,
  L_LINENUMBER int,
  L_QUANTITY double,
  L_EXTENDEDPRICE double,
  L_DISCOUNT double,
  L_TAX double,
  L_RETURNFLAG char(1),
  L_LINESTATUS char(1),
  L_SHIPDATE date,
  L_COMMITDATE date,
  L_RECEIPTDATE date,
  L_SHIPINSTRUCT char(25),
  L_SHIPMODE char(10),
  L_COMMENT varchar(44),
  primary key(L_ORDERKEY, L_LINENUMBER),
  foreign key(L_ORDERKEY) references ORDERS(O_ORDERKEY) on delete cascade,
  foreign key(L_PARTKEY) references PART(P_PARTKEY) on delete cascade,
  foreign key(L_SUPPKEY) references SUPPLIER(S_SUPPKEY) on delete cascade,
  foreign key(L_PARTKEY,L_SUPPKEY) references PARTSUPP(PS_PARTKEY, PS_SUPPKEY) on delete cascade
);
describe LINEITEM;

/*
drop database if exists dbfinal_10165101137;
*/
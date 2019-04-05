drop database snickr;
create database snickr;
use snickr;

create table SnickrUser(
	uid int auto_increment primary key,
	pwd char(40) not null,
	uname varchar(30) unique not null, 
	name varchar(30) not null,
	nickname varchar(30),
	email varchar(30) unique not null,
	joindate datetime,
	lastlogin datetime
);

create table Workspace(
	wid int auto_increment primary key,
	wname varchar(30) not null,
	wcreatorid int not null,
	wtimestamp datetime,
	foreign key (wcreatorid) references SnickrUser(uid)
);

create table WorkspaceUser(
	wid int,
	uid int,
	wauth char(6),
	wutimestamp datetime,
	primary key (wid, uid),
	foreign key (wid) references Workspace(wid),
	foreign key (uid) references SnickrUser(uid)
);

create table Channel(
	cid int auto_increment primary key,
	wid int not null,
	cname varchar(30) not null,
	ctype char(7) not null,
	ccreatorid int not null,
	ctimestamp datetime,
	foreign key (wid) references Workspace(wid),
	foreign key (ccreatorid) references SnickrUser(uid)
);


create table ChannelUser(
	cid int,
	uid int,
	cauth char(6),
	cutimestamp datetime,
	primary key (cid, uid),
	foreign key (cid) references Channel(cid),
	foreign key (uid) references SnickrUser(uid)
);

create table Message(
	msgid int auto_increment primary key,
	cid int,
	uid int,
	content text,
	mtimestamp datetime,
	foreign key (cid) references Channel(cid),
	foreign key (uid) references SnickrUser(uid),
	foreign key (cid, uid) references ChannelUser(cid, uid)
);

create table WorkspaceInvitation(
	wid int,
	uid int,
	witimestamp datetime,
	wistatus char(10),
	wistatuschange datetime,
	primary key (wid, uid, witimestamp),
	foreign key (wid) references Workspace(wid),
	foreign key (uid) references SnickrUser(uid)
);

create table ChannelInvitation(
	cid int,
	uid int,
	citimestamp datetime,
	cistatus char(10),
	cistatuschange datetime,
	primary key (cid, uid, citimestamp),
	foreign key (cid) references Channel(cid),
	foreign key (uid) references SnickrUser(uid)
);


# Insert Schema
Insert into SnickrUser(pwd, uname, name, nickname, email, joindate, lastlogin) values 
("pwd", "userA", "Sam", "Sam", "sam@test.com", "2019-04-05 20:26:00", "2019-06-10 20:26:00"),
("test", "userB", "Kate", "Kate", "kate@test.com", "2019-04-05 20:26:00", "2019-06-10 20:26:00"),
("pet", "userC", "Penny", "Penny", "penny@test.com", "2019-04-05 20:26:00", "2019-06-10 20:26:00"),
("noise", "userD", "Rick", "Rick", "rick@test.com", "2019-04-05 20:26:00", "2019-06-10 20:26:00");

Insert into Workspace(wname,wcreatorid,wtimestamp) values 
("W1", 1, "2019-04-05 20:32:00"), 
("W2", 2, "2019-04-05 20:32:00");

Insert into WorkspaceUser(wid,uid,wauth,wutimestamp) values 
(1, 1, "admin", "2019-04-05 20:35:00"), 
(1, 2, "member", "2019-04-06 09:36:00"),
(2, 1, "member", "2019-04-08 06:36:00"), 
(2, 2, "admin", "2019-04-04 18:37:00"),
(2, 3, "member", "2019-05-08 12:38:00");

Insert into Channel(wid,cname,ctype,ccreatorid,ctimestamp) values 
(1, "C1","direct", 1,"2019-04-05 04:12:00"), 
(2, "C2","public", 1, "2019-04-06 09:36:00"),
(2, "C3", "private", 2, "2019-04-08 19:15:00");

Insert into ChannelUser(cid,uid,cauth,cutimestamp) values 
(1, 1, "admin", "2019-04-05 20:35:00"), 
(1, 2, "member", "2019-04-06 09:36:00"),
(2, 1, "admin", "2019-04-08 06:36:00"), 
(2, 2, "member", "2019-04-04 18:37:00"),
(2, 3, "member", "2019-05-08 12:38:00"),
(3, 1, "member", "2019-04-08 06:36:00"), 
(3, 2, "admin", "2019-04-04 18:37:00");

Insert into Message(cid,uid,content,mtimestamp) values
(1, 1, "Hello", "2019-05-20 20:35:00"),
(1, 2, "Hello", "2019-05-20 20:36:00"),
(1, 1, "test1", "2019-05-20 20:40:00"),
(1, 1, "testing1", "2019-05-21 06:12:00"),
(1, 2, "trying 1", "2019-05-21 12:35:00"),
(2, 1, "Public channel", "2019-05-31 20:35:00"),
(2, 3, "Testing public channel", "2019-06-01 20:35:00"),
(1, 2, "going back to direct", "2019-06-01 21:00:00"),
(2, 3, "public again", "2019-06-02 15:15:00"),
(2, 2, "test private now", "2019-06-03 17:30:00"),
(3, 2, "testing private now", "2019-06-05 20:35:00"),
(3, 1, "ok", "2019-06-05 20:50:00");

Insert into WorkspaceInvitation(wid,uid,witimestamp,wistatus,wistatuschange) values
(2, 4, "2019-05-20 20:35:00", "Pending", null);

Insert into ChannelInvitation(cid,uid,citimestamp,	cistatus,cistatuschange) values
(3, 3, "2019-05-20 20:35:00", "Pending", null)